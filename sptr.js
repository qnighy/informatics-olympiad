head.js("jquery-1.5.1.min.js", function() {
  $("#go1-go").click(function() {
    $(".if-go1").removeAttr("disabled");
  });
  $("#go1-dontgo").click(function() {
    $(".if-go1").attr("disabled", "disabled");
  });
});

/* head.js("jquery-1.5.1.min.js", "jquery.selection-min.js", function() {
  $("pre").click(function() {
    console.log("clicked");
    var len = $(this).text().length;

    $(this).setCaretPos({start:0, end:len});
    $(this).select();
    $(this).focus();
    console.log(len);
    console.log($(this).getCaretPos());
  });
}); */


var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-5840991-4']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
