defmodule ServerTestAdapter do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def tgt(server) do
    GenServer.call(server, {:tgt})
  end

  def init(:ok) do
    {:ok, {:tgt, ""}}
  end

  def handle_call({:tgt}, _from, {:tgt, ""}) do
    :timer.sleep(1000)
    tgt = "TGT-SOMETHING-adasdasd"
    {:reply, tgt, {:tgt, tgt}}
  end

  def handle_call({:tgt}, _from, {:tgt, tgt} = args) do
    {:reply, tgt, args}
  end
end

defmodule ServerTest do
  defmacro __using__(opts \\ []) do
    quote bind_quoted: [opts: opts] do
      @name :ServerTest

      def start_link do
        ServerTestAdapter.start_link(@name)
      end

      def tgt do
        ServerTestAdapter.tgt(@name)
      end
    end
  end
end
