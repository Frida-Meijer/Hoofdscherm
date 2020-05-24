
 
var acc = document.getElementsByClassName("accordion-control");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
}







/*
(function()){
	var soort = document.getElementById ('activiteit');
	var buiten = 
	{buitenspelen: 'buiten spelen',
	 fietsen: 'fietsen'};
   var binnen =
   {knutselen: 'knutselen' };	

   addEvent(type, 'hange', function(){
	   if (this.value === 'choose'){model.innerHTML = '<option>choose </option>';
				return;)
}*/