
/* =========================
   LIMO Pipeline Simulator
   Dark Mode Controller
   ========================= */

const themeToggle = document.getElementById("theme-toggle");

// Get the saved theme
function getSavedTheme() {
    try {
        const savedTheme = localStorage.getItem("limo-theme");

        if (savedTheme === "dark" || savedTheme === "light") {
            return savedTheme;
        }
    } catch (error) {
        console.warn("Could not access local storage:", error);
    }

    return "light";
}

// Apply the selected theme
function applyTheme(theme) {

    // Update the document theme
    document.documentElement.setAttribute("data-theme", theme);

    // Update the toggle button
    if (theme === "dark") {
        themeToggle.textContent = "☀️ Light Mode";
        themeToggle.setAttribute("aria-label", "Switch to light mode");
        themeToggle.setAttribute("aria-pressed", "true");
    } else {
        themeToggle.textContent = "🌙 Dark Mode";
        themeToggle.setAttribute("aria-label", "Switch to dark mode");
        themeToggle.setAttribute("aria-pressed", "false");
    }

    // Remember the user's selection
    try {
        localStorage.setItem("limo-theme", theme);
    } catch (error) {
        console.warn("Could not save theme preference:", error);
    }
}

// Load the previously selected theme
let currentTheme = getSavedTheme();

applyTheme(currentTheme);

// Listen for theme button clicks
themeToggle.addEventListener("click", function () {

    // Switch between light and dark
    currentTheme =
        currentTheme === "light" ? "dark" : "light";

    // Apply the new theme
    applyTheme(currentTheme);
});
