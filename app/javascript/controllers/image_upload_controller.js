import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "errorMessage", "results"]
  connect() {
    this.formTarget.addEventListener('click', () => {
      this.inputTarget.click()
    })
    this.inputTarget.addEventListener("change", () => {
      this.formTarget.requestSubmit()
      const dataUrl = URL.createObjectURL(this.inputTarget.files[0])
      window.Turbo.renderStreamMessage(`
        <turbo-stream action="update" target="input"><template>
          <img class="w-full" src="${dataUrl}" />
        </template></turbo-stream>
        <turbo-stream action="update" target="output"><template>
          <div class="h-80 flex items-center justify-center">
            <p>Processing...</p>
          </div>
        </template></turbo-stream>`
      )
    })
  }


}
