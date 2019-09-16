// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

const Hooks = {}

function getTextPath() {
  return document.getElementById('thetext')
}

function getCurCharNum(){
  const map = document.querySelector('div.map')
  return +map.getAttribute('data-current-char')
}

Hooks.CurrentText = {
  adjustRotation() {
    const textPath = getTextPath()
    const currentCharNum = getCurCharNum()
    const point = textPath.getStartPositionOfChar(currentCharNum)
    const charRotation = textPath.getRotationOfChar(currentCharNum)
    const mapTransform = document.getElementById('Layer_1')
      .transform
      .baseVal
      .getItem(1)

    this.pushEvent('adjust_rotation', {
      currentCharPoint: {
        x: point.x, y: point.y
      },
      currentCharRotation: charRotation,
      mapAngle: mapTransform.angle
    })
  },
  updated() {
    this.adjustRotation()
  },
  mounted() {
    this.adjustRotation()
  }
}

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks })
liveSocket.connect()
