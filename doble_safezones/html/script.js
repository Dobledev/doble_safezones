window.addEventListener('message', function (event) {
    if (event.data.action === "show") {
        document.getElementById("safeZoneText").style.display = "block";
    } else if (event.data.action === "hide") {
        document.getElementById("safeZoneText").style.display = "none";
    }
});
