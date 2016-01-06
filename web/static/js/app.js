import {Socket} from "phoenix"

let socket = new Socket("/ticket_socket")
socket.connect()

let ticketsContainer = $("#tickets-container")
let announcementsContainer = $("#announcement")

let chan = socket.chan("tickets:ricardo.ruiz", {})

chan.on("ticket_content", payload => {
  ticketsContainer.html(payload.body)
})

chan.join().receive("ok", chan => {
  console.log("Logged to ticket socket")
})

let announcementChannel = socket.chan("announcements", {})

announcementChannel.on("announcement", payload => {
  console.log(payload)
  let div = $(`
    <div class="ls-alert-box ls-alert-box-${payload.category} ls-dismissable">
      <header class="ls-info-header">
        <span data-ls-module="dismiss" class="ls-dismiss">&times;</span>
        <h2 class="ls-title-3">${payload.title}</h2>
        <p>${payload.subtitle}</p>
      </header>
      <p>${payload.content}</p>
    </div>
  `)

  announcementsContainer.append(div)
})

announcementChannel.join().receive("ok", chan => {
  console.log("Logged to announcements socket")
})


let App = {
}

export default App
