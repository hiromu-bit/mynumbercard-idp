package com.example.mynumbercardidp.keycloak.network;

import com.example.mynumbercardidp.keycloak.core.network.platform.CertificateType;
import com.example.mynumbercardidp.keycloak.core.network.UserRequestModelWithApplicantDataImpl;
import com.example.mynumbercardidp.keycloak.util.StringUtil;

import java.util.Objects;

/**
 * Keycloakを利用してログインするユーザーが送信したHTTPリクエスト内容の構造体を表すクラスです。
 */
public class UserRequestModel implements UserRequestModelWithApplicantDataImpl {

    private CertificateType certificateType;
    private String certificate;
    private String applicantData;
    private String sign;
    private String actionMode;

    public CertificateType getCertificateType() {
        return this.certificateType;
    }

    public String getCertificate() {
        return this.certificate;
    }

    public String getApplicantData() {
        return this.applicantData;
    }

    public String getSign() {
        return this.sign;
    }

    public UserRequestModel setCertificateType(final CertificateType certificateType) {
        this.certificateType = certificateType;
        return this;
    }

    public UserRequestModel setCertificate(final String certificate) {
        this.certificate = certificate;
        return this;
    }

    public UserRequestModel setApplicantData(final String applicantData) {
        this.applicantData = applicantData;
        return this;
    }

    public UserRequestModel setSign(final String sign) {
        this.sign = sign;
        return this;
    }

    public final String getActionMode() {
        return this.actionMode;
    }

    public void ensureHasValues() {
        if (Objects.isNull(this.certificateType) ||
            StringUtil.isEmpty(this.actionMode) ||
            StringUtil.isEmpty(this.certificate) ||
            StringUtil.isEmpty(this.applicantData) ||
            StringUtil.isEmpty(this.sign)) {
            throw new IllegalStateException("One or more values were not set.");
        }
    }

    public final void setActionMode(final String mode) {
        this.actionMode = mode;
    }

    public static enum Filed {
        ACTION_MODE("mode"),
        USER_AUTHENTICATION_CERTIFICATE(CertificateType.USER_AUTHENTICATION.getName()),
        ENCRYPTED_DIGITAL_SIGNATURE_CERTIFICATE(CertificateType.ENCRYPTED_DIGITAL_SIGNATURE.getName()),
        APPLICANT_DATA("applicantData"),
        SIGN("sign");

        private String name;

        private Filed(final String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }
    }
}
