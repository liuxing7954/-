<%--
  Created by IntelliJ IDEA.
  User: wutianwei
  Date: 14-7-9
  Time: 下午5:10
  Title: 临时用户信息查看
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" isErrorPage="false" errorPage="../../../exception.jsp" %>
<%@include file="../main/base_service.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>私募市场网 - 会员注册查看</title>
    <%--导入公共res--%>
    <jsp:include page="../main/res.jsp"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/otc/css/theme/reg.css"/>
    <script type='text/javascript' src="<%=basePath%>res/script/validateCommon.js"></script>
</head>
<%
    //临时用户登录校验
    Boolean tempUserIsLogin = (Boolean) request.getSession().getAttribute("tempUserIsLogin");
    if (tempUserIsLogin == null || !tempUserIsLogin) {
        response.sendRedirect(helper.toURL("user", "tempLoginView"));
        return;
    }

    //临时用户信息查询
    DataEntity params = new DataEntity();
    params.put("ZZJGDM", (String) request.getSession().getAttribute("tempUsername"));

    DataList tempUserInfoList = wsQuery("cxrOTC_LSZHXX", params);
    request.setAttribute("isSuccess", tempUserInfoList.isSuccess());
    request.setAttribute("tempUserInfoList", tempUserInfoList);

    //个人证件类别
    Map grzjlbMap = getXtdm("OTC_ZJLB");
    request.setAttribute("grzjlbMap", grzjlbMap);
%>
<body>
<!--头部开始-->
<jsp:include page="tempUserHead.jsp"/>
<!--头部结束-->
<!--主体开始-->
<div class="mainBox" id="tempUserRegisterContainer">
    <div class="main">
        <%--导航--%>
        <jsp:include page="tempUserNav.jsp">
            <jsp:param name="nav" value="2"/>
        </jsp:include>

        <c:choose>
        <c:when test="${isSuccess && fn:length(tempUserInfoList) > 0}">
        <c:set var="item" value="${tempUserInfoList[0]}"/>
        <div class="mt10">
            <div style="margin-top: 12px;" class="scTit1">
                    <span class="scTitText ml10">
                        <em>&nbsp;</em>会员注册查看
                    </span>
            </div>
            <div class="zhsqPage" STEPCODE="fyzcxx">
                <div class="itemTit3 mt10">
                    <span>临时用户基本信息</span>
                    <div style="float: right">
                        <a class="btn" id="xgBtn"><span>修改</span></a>
                        <a class="btn" id="bcBtn" style="display: none;"><span>保存</span></a>
                    </div>
                </div>
                <input type="hidden" name="ID" value="${item.ID}"/>
                <table class="noneborderTable" border="0" cellSpacing="0" cellPadding="0" class="mt10">
                    <tr>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>机构全称(中文)：</label>
                        </th>
                        <td colspan="3">
                            <input type="text" name="ZCMC" class="input vCenter" style="width: 300px;" maxlength="50"
                                   showName="机构全称(中文)"
                                   value="${empty item.ZCMC ? '无' : item.ZCMC}" disabled="disabled"/>
                            <span name="ZCMC_MSG" style="display: none;"></span>
                        </td>
                    </tr>
                    <tr>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>组织机构代码：</label>
                        </th>
                        <td>
                            <input type="text" name="ZZJGDM" class="input vCenter" style="width: 147px;" maxlength="10"
                                   showName="组织机构代码"
                                   value="${empty item.ZZJGDM ? '无' : item.ZZJGDM}" disabled="disabled"/>
                            <span name="ZZJGDM_MSG" style="display: none;"></span>
                        </td>
                        <th width="130" class="right">
                            <span style="color: #ff0000;">*</span><label>统一社会信用代码</label>
                        </th>
                        <td>
                            <input type="text" name="TYSHXYDM" class="input vCenter" style="width: 147px;"
                                   maxlength="18" showName="统一社会信用代码"
                                   value="${empty item.TYSHXYDM ? '无' : item.TYSHXYDM}" disabled="disabled"/>
                            <span name="TYSHXYDM_MSG" style="display: none;"></span>
                        </td>
                    </tr>
                    <tr>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>法定代表人：</label>
                        </th>
                        <td width="340">
                            <input type="text" name="FDDBR" class="input vCenter" style="width: 147px;" maxlength="25"
                                   showName="法定代表人"
                                   value="${empty item.FDDBR ? '无' : item.FDDBR}" disabled="disabled"/>
                            <span name="FDDBR_MSG" style="display: none;"></span>
                        </td>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>联系人姓名：</label>
                        </th>
                        <td>
                            <input type="text" name="XTLLRXM" class="input vCenter" style="width: 147px;" maxlength="30"
                                   showName="联系人姓名"
                                   value="${empty item.XTLLRXM ? '无' : item.XTLLRXM}" disabled="disabled"/>
                            <span name="XTLLRXM_MSG" style="display: none;"></span>
                        </td>
                    </tr>
                    <tr>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>证件类型：</label>
                        </th>
                        <td width="340">
                            <c:if test="${grzjlbMap.success and not empty grzjlbMap.datalist}">
                                <select name="ZJLB" class="input select" style="width: 155px;" disabled="disabled">
                                    <c:forEach items="${grzjlbMap.datalist}" var="grzjlbItem" varStatus="i">
                                        <option value="${grzjlbItem.VALUE}"
                                                <c:if test="${grzjlbItem.VALUE == item.ZJLB}">selected="selected"</c:if>>${grzjlbItem.NAME}</option>
                                    </c:forEach>
                                </select>
                            </c:if>
                        </td>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>证件号码：</label>
                        </th>
                        <td>
                            <input type="text" name="SFZH" class="input vCenter" style="width: 147px;" maxlength="50"
                                   showName="证件号码"
                                   value="${empty item.SFZH ? '无' : item.SFZH}" disabled="disabled"/>
                            <span name="SFZH_MSG" style="display: none;"></span>
                        </td>
                    </tr>
                    <tr>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>办公电话：</label>
                        </th>
                        <td width="340">
                            <input type="text" name="XTBGDH" class="input vCenter" style="width: 147px;" maxlength="15"
                                   showName="办公电话"
                                   value="${empty item.XTBGDH ? '无' : item.XTBGDH}" disabled="disabled"
                                   onkeyup="this.value=this.value.replace(/\D/g,'')"/>
                            <span name="XTBGDH_MSG" style="display: none;"></span>
                        </td>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>移动电话：</label>
                        </th>
                        <td>
                            <input type="text" name="XTYDDH" class="input vCenter" style="width: 147px;" maxlength="11"
                                   showName="移动电话"
                                   value="${empty item.XTYDDH ? '无' : item.XTYDDH}" disabled="disabled"
                                   onkeyup="this.value=this.value.replace(/\D/g,'')"/>
                            <span name="XTYDDH_MSG" style="display: none;"></span>
                        </td>
                    </tr>
                    <tr>
                        <th width="130" class="right">
                            <label><span style="color: #ff0000;">*</span>电子邮箱：</label>
                        </th>
                        <td width="340">
                            <input type="text" name="XTDZYX" class="input vCenter" style="width: 147px;" maxlength="30"
                                   showName="电子邮箱"
                                   value="${empty item.XTDZYX ? '无' : item.XTDZYX}" disabled="disabled"/>
                            <span name="XTDZYX_MSG" style="display: none;"></span>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="clear"></div>
            </c:when>
            <c:otherwise>
                <div class="tab2content nobd nobg">
                    <div align="center" class="center" style="padding: 30px 0px;">
                        <div><span class="red2  strong font18px">查询临时用户信息失败，请联系管理员！</span></div>
                    </div>
                </div>
            </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
<!--主体结束-->

<!--尾部开始-->
<jsp:include page="tempUserFoot.jsp"/>
<!--尾部结束-->
<script type="text/javascript">
    $(function () {
        var container = $("#tempUserRegisterContainer");
        $("#xgBtn", container).click(function () {
            $(this).hide();
            $("#bcBtn", container).show();
            $("[class*='input']", container).removeAttr("disabled");
        });
        $("#bcBtn", container).click(function () {
            submit();
        });


        //input失去焦点、获取焦点事件
        $("input[name][showName],textarea[name][showName]", container).blur(function () {
            var name = $(this).attr("name");
            var showName = $(this).attr("showName");
            doBlur($(this), $("span[name='" + name + "_MSG']", container), showName);
        }).focus(function () {
            var name = $(this).attr("name");
            var showName = $(this).attr("showName");
            doFocus($(this), $("span[name='" + name + "_MSG']", container), showName);
        });

//        $('input[name="ZZJGDM"]').change(function () {
//            $('input[name="TYSHXYDM"]').val($(this).val());
//        });
        var newZZJGDM = '';

        function doBlur(textarea, msgSpan, title) {
            var val = $.trim(textarea.val());
            msgSpan.empty();
            if (val == "" || val == "请输入...") {
                if (title != "统一社会信用代码") {
                    msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '不能为空</span>').show();
                } else {
                    msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '不能为空，若无，请输入组织机构代码!</span>').show();
                }
                (title == "用户密码" || title == "确认密码") ? textarea.val("") : textarea.val("请输入...");
            } else if (title == "移动电话" && !isMobile(val)) {
                msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '格式不正确</span>').show();
            } else if ((title == "办公电话" || title == "传真") && !isPhone(val)) {
                msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '格式不正确</span>').show();
            } else if (title == "电子邮箱" && !isEmail(val)) {
                msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '格式不正确</span>').show();
            } else if (title == "证件号码" && $("select[name='ZJLB']", container).val() == 0 && !isIdno(val).success) {
                msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '格式不正确</span>').show();
            } else if (title == "统一社会信用代码") {
                var zzjgdmExp = /^\w{18}$/;
                var zzjgdm = "${item.ZZJGDM}";
                if (zzjgdmExp.test(val)) {
                    if (zzjgdm.length > 8) {
                        val = val.substring(8, 17);//+"-"+val.substring(16,17);
                    } else {
                        val = val.substring(8, 16);
                    }
                    if (val == zzjgdm.replace('-', '') || val == newZZJGDM.replace('-', '')) {
                        msgSpan.append('<span class="rightIco"></span>').show();
                    } else {
                        msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;统一社会信用代码格式不正确，若无，请输入组织机构代码! </span>').show();
                    }
                } else {
                    var tyxydmExp = /^\w{8,8}-\w{1}$/;
                    if ("${tempUsername}" == val || val == newZZJGDM/* || (tyxydmExp.test(val) && zzjgdm.length == 8)*/) {
                        val = val.substring(0, 8);
                        zzjgdm = zzjgdm.substring(0, 8);
                        if (zzjgdm == val) {
                            msgSpan.append('<span class="rightIco"></span>').show();
                        } else {
                            msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '格式不正确，若无，请输入组织机构代码!</span>').show();
                        }
                    } else {
                        msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '格式不正确，若无，请输入组织机构代码!</span>').show();
                    }
                }
            } else if (title === '组织机构代码') {
                var zzjgdmExp = /^\w{8,8}-\w{1}$/;
                if (zzjgdmExp.test(val)) {
                    var result = doZjjgdmOnly(val);
                    if (parseInt(result['code']) > 0 || val === "${tempUsername}") {
                        newZZJGDM = val;
                        msgSpan.append('<span class="rightIco"></span>').show();
                    } else {
                        msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + result['msg'] + '</span>').show();
                    }
                } else {
                    msgSpan.append('<span class="errorIco"></span><span class="red">&nbsp;' + title + '格式不正确</span>').show();
                }
            }
            else {
                msgSpan.append('<span class="rightIco"></span>').show();
            }
        }

        function doFocus(textarea, msgSpan, title) {
            var val = $.trim(textarea.val());
            msgSpan.empty();
            if (val == "" || val == "请输入...") {
                textarea.val("");
                if (title == "办公电话" || title == "传真") {
                    msgSpan.append('<span class="infoIco"></span><span>&nbsp;格式：区号-电话号码</span>').show();
                } else if (title == "电子邮箱") {
                    msgSpan.append('<span class="infoIco"></span><span>&nbsp;格式：xxx@xx.com</span>').show();
                } else {
                    msgSpan.append('<span class="infoIco"></span><span>&nbsp;请输入' + title + '</span>').show();
                }
            }
        }

        //组织机构代码前8位 唯一性校验
        function doZjjgdmOnly(val) {
            var result = {"code": 1, "msg": ""};
            var params = {mod: 'ZZJGDM_ONLY', SQHY: val, ID: "${item.ID}"};
            if (val == "${tempUsername}") {
                return {
                    'code': 1,
                    'msg': '成功',
                };
            }
            $.ajax({
                url: '<%=helper.toURL("user", "cyrjh_zcxx_service")%>',
                type: 'post',
                dataType: 'json',
                data: params,
                async: false,
                success: function (ret) {
                    if (ret && ret['code'] && parseInt(ret['code']) > 0) {
                        result['code'] = ret['code'];
                    } else {
                        result['code'] = ret['code'];
                        result['msg'] = ret['msg'];
                    }
                },
                error: function (ret) {
                    result['code'] = ret['code'];
                    result['msg'] = ret['msg'];
                }
            });

            return result;
        }

        function submit() {
            //输入框校验
            $("input[type='text'][name],textarea[name][showName]", container).blur();
            if ($(".errorIco", container).length > 0) {
                return false;
            }

            var params = {mod: 'TEMP_XGJB'};
            $.each($("input[name],textarea[name],select[name]", container), function (i, n) {
                params[$(n).attr("name")] = encodeURIComponent($.trim($(n).val()));
            });

            if (params['TYSHXYDM'].length === 18) {
                //第9~17位组代同步修改
                var arr = params['TYSHXYDM'].split('');
                arr.splice(8, 9, params['ZZJGDM'].replace('-', ''));
                params['TYSHXYDM'] = arr.join('');
            } else {
                params['TYSHXYDM'] = params['ZZJGDM'];
            }

            console.log(params);
            $("#bcBtn", container).hide();
            $("[class*='input']", container).attr("disabled", "true");

            function ajaxSubmit() {
                $.ajax({
                    url: '<%=helper.toURL("user", "cyrjh_zcxx_service")%>?t=' + new Date().getTime(),
                    type: 'post',
                    dataType: 'json',
                    data: params,
                    success: function (ret) {
                        if (ret && parseInt(ret["code"]) > 0) {
                            Alert("修改成功,请重新登录!", function () {
                                $("#xgBtn", container).show();
                                $("a[name='tempUserLogout']").click();
                            });
                        } else {
                            Alert(ret["msg"], function () {
                                $("#bcBtn", container).show();
                                $("[class*='input']", container).removeAttr("disabled");
                            });
                        }
                    },
                    error: function (ret) {
                        Alert(ret["msg"], function () {
                            $("#bcBtn", container).show();
                            $("[class*='input']", container).removeAttr("disabled");
                        });
                    }
                });
            }

            if (newZZJGDM != "${tempUsername}")
                Confirm("确认修改组织机构代码吗？这将是您以后的登录账号，请牢记！", function (yes) {
                    if (yes) {
                        ajaxSubmit();
                    }
                });
            else
                ajaxSubmit();

        }
    });
</script>
</body>
</html>