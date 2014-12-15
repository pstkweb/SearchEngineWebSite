var dbpedia = new function(){
	this.base = "http://fr.dbpedia.org/";

	// Récupère l'abstract, l'image et lien vers wiki de la ressource selon sont uri du type (<http//:fr.dbpedia.org/resource/nom_de_la_ressource>)
	this.getInfoRessource = function(resource,callback,parameter){
		var query = [
			"SELECT ?label ?abstract ?thumbnail",
			"WHERE {",
				"<"+this.base+"resource/"+resource+"> rdfs:label ?label .",
				"<"+this.base+"resource/"+resource+"> dbpedia-owl:abstract ?abstract .",
				"FILTER (lang(?abstract) = 'fr').",
				"OPTIONAL {",
          			"<"+this.base+"resource/"+resource+"> dbpedia-owl:thumbnail ?thumbnail .",
      			"}",
    		"} LIMIT 1",
 		].join(" ");

 		this.execQuery(query,callback,parameter);
	};

    // Execute une requête en sparql
    // $query requête sparql
    // callback function appeler une fois la requête terminé
    // parameter parametre a transmettre à la fonction de callback
	this.execQuery = function(query,callback,parameter){
		// console.log(query);
		var queryUrl =  this.base+"sparql?query="+ encodeURIComponent(query) +"&format=json";
		$.ajax({
	        dataType: "jsonp",
	        url: queryUrl,
	        success: function( _data ) {
	            var results = _data.results.bindings;
	           	callback(results,parameter);
	        }
    	});
	}
}