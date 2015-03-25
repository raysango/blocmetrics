<h1>Blocmetrics..</h1>

<h2>APP URL : https://rayblocmetrics.herokuapp.com</h2>

To track pageviews, add this snippet of code to any page you want to track:
```
<script>
 var blocmetrics = function(app_name, email){
    var _bm_event = {
     event:{
      app_name: app_name,
      email: email
      }
    }

    var _bm_request = new XMLHttpRequest();
    _bm_request.open("POST", "http://localhost:3000/events", true);
    _bm_request.setRequestHeader('Content-Type', 'application/json');
    _bm_request.onreadystatechange = function() {
    // this function runs when the Ajax request changes state
    };
   _bm_request.send(JSON.stringify(_bm_event));

 };

blocmetrics('app_name', 'email')
</script>
```
The only code you must customize is the second to last line of code. For example, if you wanted to track pageviews for your website named Blocmetrics, that line of code would look like this:

blocmetrics('Blocmetrics', 'youremail@example.com')

Before you can start tracking data, you need to create a profile on Blocmetrics (using the email you customized the code above with). You can then log in to Blocmetrics to see the pageviews for your app.
