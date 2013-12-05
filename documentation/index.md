<h1>Ti.Safari.ReadingList</h1>

This module provides the ability to add items to the Safari Reading List

<h2>Before you start</h2>
* This is an iOS module only
* You need Titanium SDK 3.1.3.GA or greater
* You need iOS 7 or greater
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.

<h2>Download the compiled release</h2>

Download the platform you wish to use:

* [iOS Dist](https://github.com/benbahrenburg/Ti.Safari.ReadingList/tree/master/dist)

<h2>Building from source?</h2>

If you are building from source you will need to do the following:

Import the project into Xcode:

* Modify the titanium.xcconfig file with the path to your Titanium installation


<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the Utterance module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<h2>Importing the module using require</h2>
<pre><code>
var readinglist = require('bencoding.reading.list');
</code></pre>

<h2>Methods</h2>
This module provides the following methods to work with the Safari Reading List

<h3>isSupported</h3>

The isSupported method, will return true if the devices supports the Safari Reading List module or false if this functionality is not available.

<h4>Parameters</h4> 

<b>None</b> 

<b>Example</b>
<pre><code>
	if(!readinglist.isSupported()){
		alert("Sorry your device doesn't support this functionality");
	}
</code></pre>


<h3>add</h3>

This method continues reading any speech that has been paused.

<h4>Parameters</h4> 

The add method takes a dictionary with the following properties.


<b>url</b>

This <b>required</b> property contains the URL of the item to be added to the Safari Reading List. This can be any valid URL.

<b>title</b>

This <b>required</b> property contains the description Title for the item once added to the Safari Reading List.

<b>previewText</b>

This <i>optional</i> property contains the description text for the item once added to the Safari Reading List.

<h4>Return</h4> 

A dictionary is returned with the following properties.

<b>success</b>

True/False boolean indicator if the item was successfully added to the Safari Reading List.

<b>message</b>

If the method failed, the <b>message</b> property will contain information regarding the reason for failure.

<b>url</b>

The url added to the Safari Reading List

<b>title</b>

The title of the Safari Reading List item added.

<b>previewText</b>

The preview text of the Safari Reading List item added.

<b>Example</b>
<pre><code>
	var result = readinglist.add({
		url:"http://bbc.com",
		title:"BBC News",
		previewText:"An Example"
	});

	Ti.API.info(JSON.stringify(result));
	
	if(result.success){
		alert("Successfully added to your reading list");
	}else{
		alert("Something went wrong " + result.message);
	}
</code></pre>


<h2>Learn More</h2>

<h3>Examples</h3>
Please check the module's example folder or [here](https://github.com/benbahrenburg/Ti.Safari.ReadingList/tree/master/example) for samples on how to use this project.

<h3>Twitter</h3>

Please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates 
and more about Titanium.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).

<h2>License</h2>
Utterance is available under the Apache 2.0 license.

Copyright 2013 Benjamin Bahrenburg

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
