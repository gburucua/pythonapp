document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("dataForm");
    const messageDiv = document.getElementById("message");

    form.addEventListener("submit", async function (event) {
        event.preventDefault();

        const formData = new FormData(form);
        const data = {
            name: formData.get("name"),
            surname: formData.get("surname"),
            age: formData.get("age"),
            gender: formData.get("gender"),
            comments: formData.get("comments"),
        };

        console.log("Data object:", data); // Log the data object


        try {
            const response = await fetch("/api/data", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(data),
            });

            const result = await response.json();
            messageDiv.textContent = result.message;
        } catch (error) {
            console.error("Error:", error);
            messageDiv.textContent = "An error occurred.";
        }
    });
});
