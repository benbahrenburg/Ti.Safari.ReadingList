
var readinglist = require('bencoding.reading.list');
Ti.API.info("module is => " + readinglist);

var win = Ti.UI.createWindow({
	backgroundColor:'#fff', layout:'vertical'
});

var lazyHelpers = {
	getLabel : function(title){
		return Ti.UI.createLabel({
			text:title,top:25,left:7,backgroundColor:'#999', color:'#fff',left:7, right:7, textAlign:'left',
			font:{
				fontWeight:'bold'
			}
		});
	}	
};

win.add(Ti.UI.createLabel({
	text:'Reading List Demo',top:25,
	font:{
		fontSize:32, fontWeight:'bold'
	}
}));

win.add(lazyHelpers.getLabel('Enter Url'));

var txtUrl = Ti.UI.createTextField({
	value:"http://bbc.com",height:35, left:7, right:7, borderStyle:	Ti.UI.INPUT_BORDERSTYLE_BEZEL, borderColor:'#000'
});
win.add(txtUrl);

win.add(lazyHelpers.getLabel('Enter Title'));

var txtTitle = Ti.UI.createTextField({
	value:"BBC News",height:35, left:7, right:7, borderStyle:Ti.UI.INPUT_BORDERSTYLE_BEZEL, borderColor:'#000'
});
win.add(txtTitle);

win.add(lazyHelpers.getLabel('Add Option Preview Text'));

var txtPreview = Ti.UI.createTextField({
	hintText:'preview text',height:35, left:7, right:7, borderStyle:Ti.UI.INPUT_BORDERSTYLE_BEZEL, borderColor:'#000'	
});
win.add(txtPreview);

var btnAdd = Ti.UI.createButton({
	top:45, title:'Add To Reading List', left:7, right:7,borderColor:'#000', height:45
});
win.add(btnAdd);

btnAdd.addEventListener('click',function(d){

	//Create the base reading list item
	var item = {
		url:txtUrl.value, title:txtTitle.value		
	};
	
	//Since the Preview text is optional, add it if provided 
	if(txtPreview.value.length > 0){
		item.previewText = txtPreview.value;
	}
	
	//Add the item to the reading list
	var result = readinglist.add(item);
	//Print the output
	Ti.API.info(JSON.stringify(result));
	
	if(result.success){
		var msg = Ti.UI.createAlertDialog({
			title:'Reading List Item Successfully Added',
			message:'Open Safari to check it out?',
			buttonNames:['No','Yes']
		});
		msg.addEventListener('click',function(b){
			if(b.index===1){
				Ti.Platform.openURL(txtUrl.value);
			}
		});
		msg.show();
	}else{
		alert("Something went wrong " + result.message);
	}
});

win.open();
