defmodule CasServer do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def tgt(server) do
    GenServer.call(server, {:tgt, time_now()})
  end

  def st(server, service) do
    GenServer.call(server, {:st, service, time_now()})
  end

  def init(:ok) do
    {:ok, [{:tgt, 0, ""}, HashDict.new]}
  end

  def handle_call({:st, service, now}, _from, [{:tgt, tgt_expires_at, current_tgt}, sts]) do
    new_st = evaluate_st(service, HashDict.get(sts, service), now)

    {:reply, elem(new_st, 0), [{:tgt, tgt_expires_at, current_tgt}, HashDict.put(sts, service, new_st)]}
  end

  def handle_call({:tgt, now}, _from, [{:tgt, expires_at, _current_tgt}, sts]) when now > expires_at do
    :timer.sleep(1000)
    tgt = "TGT-SOMETHING-#{time_now()}"

    {:reply, tgt, [{:tgt, time_now() + 6, tgt}, sts]}
  end

  def handle_call({:tgt, _}, _from, [{:tgt, expires_at, current_tgt}, sts]) do
    {:reply, current_tgt, [{:tgt, expires_at, current_tgt}, sts]}
  end

  defp evaluate_st(_, {st, expires_at}, now) when now < expires_at do
    {st, expires_at}
  end

  defp evaluate_st(service, _, _) do
    :timer.sleep(1000)

    {"ST-#{service}-#{time_now()}", time_now() + 6}
  end

  defp time_now do
    :calendar.datetime_to_gregorian_seconds(:calendar.local_time)
  end
end

defmodule CasSupport do
  defmacro __using__(opts \\ []) do
    quote bind_quoted: [opts: opts] do
      @name opts[:process_name] || :CasServer

      def start_link do
        case CasServer.start_link(@name) do
          {:ok, pid} -> {:ok, pid}
          {:error, {:already_started, pid}} -> {:ok, pid}
          other -> other
        end
      end

      def tgt do
        CasServer.tgt(@name)
      end

      def st(service) do
        CasServer.st(@name, service)
      end
    end
  end
end

defmodule Cas do
  use CasSupport
end
