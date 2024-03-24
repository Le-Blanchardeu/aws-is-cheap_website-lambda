# Generating a basic contact form that will call a backend Lambda function
resource "local_file" "contactform_html" {
  filename = "${path.module}/contactform_example.html"
  content  = <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Contact Form</title>
    <style>
        .container label,
        .container input,
        .container textarea {
            display: block;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <form id="contactForm" action="${aws_lambda_function_url.test_latest.function_url}" method="post">

        <label for="name">Name</label>
        <input type="text" id="name" name="name" placeholder="Your name..">

        <label for="subject">Subject</label>
        <textarea id="subject" name="subject" placeholder="Write message here.." style="height:200px"></textarea>

        <input type="submit" value="Submit">

    </form>

    <!-- This div will display the response from the server -->
    <div id="response"></div>
</div>

<script>
    document.getElementById("contactForm").addEventListener("submit", function(event) {
        event.preventDefault();

        var formData = new FormData(this);
        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    document.getElementById("response").textContent = "Data processed successfully. Response: " + xhr.responseText;
                } else {
                    document.getElementById("response").textContent = "An error occurred. Please try again later.";
                }
            }
        };

        xhr.open("POST", this.action, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send(new URLSearchParams(formData).toString());
    });
</script>

</body>
</html>

EOF
}