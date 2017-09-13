<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>代码模板管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate();
		});
	</script>
</head>
<body>
<div class="wrapper wrapper-content animated fadeInRight">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/gen/genTemplate/">代码模板列表</a></li>
		<li class="active"><a href="${ctx}/gen/genTemplate/form?id=${genTemplate.id}">代码模板<shiro:hasPermission name="gen:genTemplate:edit">${not empty genTemplate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="gen:genTemplate:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="genTemplate" action="${ctx}/gen/genTemplate/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">名称:</label>
			<div class="col-sm-3">
				<form:input path="name" htmlEscape="false" maxlength="200" class="required form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属分类:</label>
			<div class="col-sm-6"><%--
				<form:select path="category" class="required">
					<form:option value=""></form:option>
					<form:options items="${fns:getDictList('gen_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select> --%>
				<form:checkboxes items="${fns:getDictList('gen_category')}" path="categoryList" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">生成路径:</label>
			<div class="col-sm-7">
				<form:input path="filePath" htmlEscape="false" maxlength="500" class="required form-control"/>
				<br/>
				<span class="help-inline">
					示例如下：<br/>
					java：src/main/java/\${packageName}/\${moduleName}/entity/\${subModuleName}<br/>
					view：src/main/webapp/WEB-INF/views/\${lastPackageName}/${moduleName}/\${subModuleName}<br/>
					mapper:/src/main/resources/mappings/\${dbType}/\${lastPackageName}/\${moduleName}/\${subModuleName}
				</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">生成文件名:</label>
			<div class="col-sm-3">
				<form:input path="fileName" htmlEscape="false" maxlength="500" class="required form-control"/>
				<br/>
				<span class="help-inline">
					示例如下：<br/>
					java：\${ClassName}Entity.jsp<br/>
					view：\${className}List.jsp
				</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">内容:</label>
			<div class="col-sm-6">
				<form:textarea id="content" htmlEscape="true" path="content" rows="25" class="required" style="width:90%;" wrap="off" />
				<script type="text/javascript">
			        /*------selection operations-------*/
			        function insertAtCursor(obj, txt) {
			            obj.focus();
			            //IE support
			            if (document.selection) {
			                sel = document.selection.createRange();
			                sel.text = txt;
			            }
			            //MOZILLA/NETSCAPE support
			            else {
			                var startPos = obj.selectionStart;
			                var scrollTop = obj.scrollTop;
			                var endPos = obj.selectionEnd;
			                obj.value = obj.value.substring(0, startPos) + txt + obj.value.substring(endPos, obj.value.length);
			                startPos += txt.length;
			                obj.setSelectionRange(startPos, startPos);
			                obj.scrollTop = scrollTop;
			            }
			        }
			        function getCaretPos(ctrl) {
			            var caretPos = 0;
			            if (document.selection) {
			                // IE Support
			                var range = document.selection.createRange();
			                // We'll use this as a 'dummy'
			                var stored_range = range.duplicate();
			                // Select all text
			                stored_range.moveToElementText(ctrl);
			                // Now move 'dummy' end point to end point of original range
			                stored_range.setEndPoint('EndToEnd', range);
			                // Now we can calculate start and end points
			                ctrl.selectionStart = stored_range.text.length - range.text.length;
			                ctrl.selectionEnd = ctrl.selectionStart + range.text.length;
			                caretPos = ctrl.selectionStart;
			            } else if (ctrl.selectionStart || ctrl.selectionStart == '0')
			            	// Firefox support
			                caretPos = ctrl.selectionStart;
			            return (caretPos);
			        }
			        function getCurrentLineBlanks(obj) {
			            var pos = getCaretPos(obj);
			            var str = obj.value;
			            var i = pos - 1;
			            while (i >= 0) {
			                if (str.charAt(i) == '\n')
			                    break;
			                i--;
			            }
			            i++;
			            var blanks = "";
			            while (i < str.length) {
			                var c = str.charAt(i);
			                if (c == ' ' || c == '\t')
			                    blanks += c;
			                else
			                    break;
			                i++;
			            }
			            return blanks;
			        }
		            /* set all the tab indent for all the text areas */
		            $("textarea").each(function() {
		                $(this).keydown(function(eve) {
		                    if (eve.target != this) return;
		                    if (eve.keyCode == 13)
		                        last_blanks = getCurrentLineBlanks(this);
		                    else if (eve.keyCode == 9) {
		                        eve.preventDefault();
		                        insertAtCursor(this, "\t");
		                        this.returnValue = false;
		                    }
		                }).keyup(function(eve) {
		                    if (eve.target == this && eve.keyCode == 13)
		                        insertAtCursor(this, last_blanks);
		                });
		            });
				</script>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注:</label>
			<div class="col-sm-6">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
	<div class="hr-line-dashed"></div>
	<div class="form-group">
		<div class="col-sm-4 col-sm-offset-2">
			<shiro:hasPermission name="gen:genTemplate:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
	</div>
</body>
</html>