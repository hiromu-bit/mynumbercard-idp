<#import "template.ftl" as layout>
<#assign termsofServiceFileName>${msg("termsofServiceFileName")}</#assign>
<#assign privacyPolicyFileName>${msg("privacyPolicyFileName")}</#assign>
<#assign personalDataProtectionPolicyFileName>${msg("personalDataProtectionPolicyFileName")}</#assign>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <script>
            function onClickActionButton(event) {
                <#if (debug!'false') == 'true'>
                   submitWhenDebugMode(event);
                </#if>
                let action_url = "${url.loginAction}";
                action_url = action_url.replace(/\&amp;/gi,'&');
                action_url = encodeURIComponent(action_url);
            
                let app_url;
                switch (getMobileOS()) {
                    case 'Android':
                        app_uri = '${(androidAppUri!'')}';
                        break;
                    case 'iOS':
                        app_uri = '${(iosAppUri!'')}';
                        break;
                    default:
                        app_uri = '${(otherAppUri!'')}';
                }
                if (app_uri == '') {
                    return;
                }
            
                let mode = event.currentTarget.name;
                app_uri += '?' + 'action_url=' + action_url + '&nonce=${(nonce!'')}' + '&mode=' + mode;

                let refreshUrl = '${refreshUrl}';
                let initialView = '${(initialView!'')}';
                if (initialView != null) {
                    refreshUrl += '&initialView=' + initialView;
                }
                refreshUrl = encodeURIComponent(refreshUrl);
                app_uri += '&error_url=' + refreshUrl;
            
                location.href = app_uri;
            }

            window.addEventListener('DOMContentLoaded', (event) => {
                <#if (debug!'false') == 'true'>
                enableDebugMode("${nonce!''}");
                </#if>
                addEventListeners();
                if ('${(initialView!'')}' == 'registration') {
                    document.querySelector('input[name="openRegistration"][type="button"]').click();
                }
            });
        </script>
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <div id="userLogin" style="display: block;">
                <#if (debug!'false') == 'true'>
                <div name="debug-form-block">
                    <div class="${properties.kcFormGroupClass!}">
                        <label for="privkey" class="${properties.kcLabelClass!}">${msg("[DEBUG] X509 privkey file (.pem, .key)")}</label>
                        <input tabindex="2" name="x509PrivFileName" id="x509PrivFileName" type="file" accept=".pem, .key" />
                        <input type="hidden" name="applicantData" />
                        <input type="hidden" name="sign" />
                    </div>
                    <div class="${properties.kcFormGroupClass!}">
                        <label for="x509upload" class="${properties.kcLabelClass!}">${msg("[DEBUG] X509 certificate file (.der, .cer, .crt, .pem)")}</label>
                        <input tabindex="2" name="x509FileName" id="x509_upload" type="file" accept=".der, .cer, .crt, .pem" />
                        <input id="certificate" type="hidden" name="certificate" />
                    </div>
                </div>
                </#if>
                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                    <input type="hidden" name="mode" />
                    <label for="login" class="${properties.kcLabelClass!}">${msg("loginLabel")}</label>
                    <input type="hidden" id="login-error-url-hidden-input" name="error_url" value="${refreshUrl}&initialView=registration"/>
                    <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="button" value="${msg("doLogIn")}"/>
                    <label for="openRegistration" class="${properties.kcLabelClass!}">${msg("registrationLabel")}</label>
                    <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="openRegistration" id="kc-openRegistration" type="button" value="${msg("doRegistration")}"/>
                    <label for="replacement" class="${properties.kcLabelClass!}">${msg("replacementLabel")}</label>
                    <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="replacement" id="kc-replacement" type="button" value="${msg("doReplacement")}"/>
                </div>
            </div>
            <div id="userRegistration" style="display: none;">
                <div id="kc-form-options">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <a href="#" name="go-back">${msg("back")}</a></span>
                    </div>
                </div>
                <div class="${properties.kcFormHeaderClass!}">
                    <label class="pf-c-form__label">${msg("registration")}</label>
                </div>
                <label class="${properties.kcLabelClass!}">${msg("registrationExplanation")}</label>
                <div id="user-registration">
                    <div id="terms-of-service" class="${properties.kcLabelWrapperClass!} terms-of-service">
                        <input type="checkbox" id="${paramAgreeTos!'agree-tos'}" name="${paramAgreeTos!'agree-tos'}" />
                        <label for="agree-tos" class="pf-c-form__label-text terms-of-service">${msg("agreePhraseBefore")}<a href="${termsOfUseDirUrl}${termsofServiceFileName}" target="_blank">${msg("displayTextTos")}</a>${msg("agreePhraseAfter")}</label>
                    </div>
                    <div id="privacy-policy" class="${properties.kcLabelWrapperClass!} privacy-policy kc-terms-text">
                        <input type="checkbox" id="${paramAgreePp!'agree-pp'}" name="${paramAgreePp!'agree-pp'}" />
                        <label for="agree-pp" class="pf-c-form__label-text privacy-policy">${msg("agreePhraseBefore")}<a href="${privacyPolicyDirUrl}${privacyPolicyFileName}" target="_blank">${msg("displayTextPp")}</a>${msg("agreePhraseAfter")}</label>
                    </div>
                    <div id="kc-form-registration-button" class="kc-form-buttons">
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="registration" type="button" value="${msg("doUserRegistration")}"/>
                    </div>
                </div>
            </div>
        </form>
      </div>
    </div>
    <#elseif section = "info" >
        <span><a href="${termsOfUseDirUrl}${termsofServiceFileName}" target="_blank">${msg("displayTextTos")}</a></span>
        <span><a href="${privacyPolicyDirUrl}${privacyPolicyFileName}" target="_blank">${msg("displayTextPp")}</a></span>
        <span><a href="${personalDataProtectionPolicyDirUrl}${personalDataProtectionPolicyFileName}" target="_blank">${msg("displayTextPdpp")}</a></span>
    </#if>

</@layout.registrationLayout>