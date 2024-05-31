import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image"
export default class extends Controller {
  // input image change
  connect() {
    this.element.addEventListener("change", () => {
      this.element.form.requestSubmit()
    })
  }
}
