
/**
 * easyUI 通用方法
 */
//ajax获取后端数据
	function getJsonDataByAjax(url,flag,obj){
		var jsonData = "";
		var json = {};
		json["" + flag] = JSON.stringify(obj);
		$.ajax({
			url:url,
			type:"post",
			async:false,
			data:json,
			success:function(data){
				jsonData = data;
			}
		});
		return jsonData; 
	}
//ajax获取后端数据并执行相应操作
function callbackByAjax(url,flag,object,callback){
	$.ajax({
		url:url,
		type:"post",
		async:false,
		data:{
			flag:JSON.stringify(object)
		},
		success:function(data){
			callback();
		},error:function(XMLHttpRequest, textStatus, errorThrown){
	
		}
	});	
}

//easyUI 分页
function paging(id,total,url,flag,obj){
	var pager = $(id).datagrid("getPager"); 
	pager.pagination({ 
		total:total, 
	  	displayMsg:'当前显示从第{from}条到{to}条 共{total}条记录',
	    onSelectPage:function (pageNo, pageSize) {	
			obj["pageNumber"] = pageNo;
			obj["pageSize"] = pageSize;
			var json = getJsonDataByAjax(url,flag,obj);
			var total = JSON.parse(json)[0].total;
			var data = JSON.parse(json)[0].data;
			$(id).datagrid('loadData',data);
			var pager = $(id).datagrid("getPager"); 
			pager.pagination('refresh', { 
				total:total, 
    			pageNumber:pageNo
			});
	    }
	});
}


//easyUI 消息框显示

//基础消息框
function center(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			right:'',
			bottom:''
		}
	});
}

//
function topLeft(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			right:'',
			left:0,
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:''
		}
	});
}
function topCenter(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			right:'',
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:''
		}
	});
}
function topRight(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			left:'',
			right:0,
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:''
		}
	});
}
function centerLeft(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			left:0,
			right:'',
			bottom:''
		}
	});
}
function center(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			right:'',
			bottom:''
		}
	});
}
function centerRight(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			left:'',
			right:0,
			bottom:''
		}
	});
}
function bottomLeft(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			left:0,
			right:'',
			top:'',
			bottom:-document.body.scrollTop-document.documentElement.scrollTop
		}
	});
}
function bottomCenter(title,msg,showType){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
		style:{
			right:'',
			top:'',
			bottom:-document.body.scrollTop-document.documentElement.scrollTop
		}
	});
}
function bottomRight(){
	$.messager.show({
		title:title,
		msg:msg,
		showType:showType,
	});
}

//交互式消息框
function confirm(title,question,callback){
	$.messager.confirm(title, question, function(r){
		console.log(r);
		callback(r);
	});
}
function prompt1(title,prompt,callback){
	$.messager.prompt(title, prompt, function(r){
		cakkback(r);
	});
}

//提示消息
function alert(title,msg,type){
	$.messager.alert(title,msg,type);
}