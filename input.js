"use strict";
const backgroundBlur = document.querySelector(".display-blur-effect");
const popUpDisplay = document.querySelector(".power-data-display");
const exitButton = document.querySelector(".exit");
const hidden = document.querySelector(".hidden");
const box1 = document.querySelector(".box-1");
const text = document.querySelector("power-data");

box1.addEventListener("click", function () {
  popUpDisplay.classList.remove("hidden");
  backgroundBlur.classList.remove("hidden");
});

exitButton.addEventListener("click", function () {
  popUpDisplay.classList.add("hidden");
  backgroundBlur.classList.add("hidden");
});
