$(document).ready(function() {

	$("#tweet").submit(function(event) {

		event.preventDefault();

		debugger

		$("#tweet input[type='submit']").attr("disabled", "disabled");
		$("#loading").show();

		$.ajax({
			url: $(this).attr("action"),
			method: "post",
			data: $(this).serialize(),
			success: function() {
				alert("tweet successful");
				$("#loading").hide();
				$("#tweet input[type='submit']").removeAttr("disabled");
			},
			error: function() {
				alert("something went wrong");
				$("#loading").hide();
				$("#tweet input[type='submit']").removeAttr("disabled");
			}
		});
	});

});
