import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // debugger
    console.log(this.element)
    // this.element.requestSubmit()
  }
}
