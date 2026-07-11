Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561713CBE6D
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788517; cv=none; b=DuNN0OXiytd/TEFi6j5Hs7H7gNAg/bZd218t1Rj3p2JiNQwwyVHR7vPYyTAy2pOcL8vIB8hK5a4l2O1+505A1C0fnuit5uUEPKYFC0rcd36e7cF3D0lZEMVV0A4meXtNgeiD4WZSmAWnShuA1TFNiW1BtkVUhfy3HNhQ9Fc6JRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788517; c=relaxed/simple;
	bh=JGx8vLrxPA3/wNpjLIcKZMzqlLOJCUnCsboNlS4acXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y61w9nWu5ubJ2a5QF0OC5P1IdOjickFkIpQZOICp8oe1cQlAWolFI/2QJ8z7+8aRiDMpxaqJxF9ecl3RK/P0I4dkHNUxdRtxNJ9qYnPtzJqotl8pOh7dfYOFAuYOhst7Fmn2HqHh806cAlkyCvqg2CGAKXqQGQbOkGsX4zpHjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paI+YSnz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paI+YSnz"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47df440fcd5so972506f8f.3
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783788513; x=1784393313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uUs89C+zAejcNnfDQ8q3Fa2LOUmGMmgh0ewi2+CW7gM=;
        b=paI+YSnzvxO6qXWcN2dEKfVPxgsTfvj7Re/364vviv+kbHEn1yP2wlFM1gxxGW0lra
         AfUp6Nz3evreCrBppbvWzcFKpblYGfr6JgIZtYpKa/jzMxGIDkKqvZHjrLi4EFb2PAow
         mKlUeCyIV4FXDdnSl91k4iJl6VDKgvg6+Y3wE4EnMf9trJC+AKl3ByDMHvyyqXmR9EJ3
         u/RmBy8Vt877ilmRfC/lauV7KSdZArqrpXanP6OeU77DB4ghfi0Tktw/sJmoVYYnWWo7
         wXNq1fRX8Aq9UI/g3vGd858RbOrFjvR7GS73JfWmbrV7idDdQUaK/wbJbrSMu3NqLbe2
         NDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788513; x=1784393313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uUs89C+zAejcNnfDQ8q3Fa2LOUmGMmgh0ewi2+CW7gM=;
        b=cjb7lgAcPzqvXO2V/PiANksP3LXZcwxdkzE4ekTKhP10R4A8QxKpMHpbpu1FEJvf3m
         gkxnOiplc/HgEHRadEIAcJx1RmWxr166oPSuY8NH1hjWdeMU1vZsebswMBaBi2jtCQxR
         RmuMEq4a/bfVNie1+58q/gEXaz3UAyPxTfcxwhW0lB7QlrDdWmg5Cg7Pzot+b6s2dnJT
         nRRUEQLPj5KyAGk3D5Ar/tUglEBpbQ5yeJUMKrslLarLLNTkcHBuCLzzxSbT5qeY0Xym
         6mBBu0zknE5srAkDf7VXybt/mKdVElS1FBAMELSR+fvWQdJ1b0ISX3hwTOrHlsjKlQlF
         +Ozg==
X-Forwarded-Encrypted: i=1; AHgh+RqUWfezoNMgWK5oTbpMpJmBAXNrMpoYJfOhjZUIfXKM+VBvQ9OHLzD+SwOVsouJYJv2FJwfWZBAV2/J@vger.kernel.org
X-Gm-Message-State: AOJu0YwA9Otli6swP5kQkcQGXgxcuIWikYSW+BwK4xXByEWT5iqGBD7a
	1P3K/beB94h4tCmJ2LnQz4Y7BG39Yot5yyn/AZc+cdeyoSLuboNcv9sp
X-Gm-Gg: AfdE7ckhSOFGZrA18AkPU85y1KsUjYhzkVHqLXd9PWY32V4qHCVzXk9uGFK8nVMxitm
	cAvXq4kQWrW8Bpdt018L9/uJgkMhlE4UqLoBJuQKW1RuPDmSqjhNuf0iJqquKFDwrDxD/TIrSV8
	zmyeh8Jx3sbIGOGkRHp2VfwJIDKWLkB2SpX+f8VuwAAgqRuolUwGHRBPwxuBc+6cQ72tvMkzdl9
	nLUy9tMdrSm4298G1NzWMPL/dOzllvDcicNPDYNk2yvKUXAmIgq79gjPklCGQVc4txfBZG1lDIg
	dWq0Pjbcco5aDDDe6hfc9jnx+vKY21oKFGAo30rB7Fi+juCMFm81vVaQlUccC8oHefNl0ztH1d1
	kzxLwcKyzunYCKeEXFyk8IkkjH4gGHqSIyNeUAMR3DVslfY2vtQhDB3tA324otZJnE4VWCwYXJV
	o8c6IqlH2aZK7UNn0uIgj12HEAA2XPWvhpKg==
X-Received: by 2002:a5d:5887:0:b0:474:b860:b7b1 with SMTP id ffacd0b85a97d-47f2dca82dcmr3244640f8f.9.1783788512502;
        Sat, 11 Jul 2026 09:48:32 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm69152875f8f.13.2026.07.11.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:31 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v4 4/6] phy: cpcap-usb: add extcon support
Date: Sat, 11 Jul 2026 19:47:52 +0300
Message-Id: <20260711164754.185565-5-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711164754.185565-1-ivo.g.dimitrov.75@gmail.com>
References: <20260711164754.185565-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register an Extcon device and report the detected cable state.

The driver already determines the type of cable attached during USB cable
detection. Export the detected state through the Extcon framework so
other drivers can consume it using a standard kernel interface.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index d4eb8086b600..8f9bea1d8a21 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/extcon-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -123,6 +124,7 @@ struct cpcap_phy_ddata {
 	struct regmap *reg;
 	struct device *dev;
 	struct usb_phy phy;
+	struct extcon_dev *edev;
 	struct delayed_work detect_work;
 	struct pinctrl *pins;
 	struct pinctrl_state *pins_ulpi;
@@ -135,12 +137,23 @@ struct cpcap_phy_ddata {
 	struct regulator *vusb;
 	atomic_t active;
 	enum cpcap_mode mode;
+	int cable;
 };
 
 static bool cpcap_enable_uart;
 module_param_named(enable_uart, cpcap_enable_uart, bool, 0644);
 MODULE_PARM_DESC(enable_uart,
 		 "Enable UART on the USB connector while idle (increases power consumption)");
+
+/* List of detectable cables */
+static const unsigned int cpcap_extcon_cables[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_CHG_USB_DCP,
+	EXTCON_NONE,
+};
+
 static bool cpcap_usb_vbus_valid(struct cpcap_phy_ddata *ddata)
 {
 	int error, value = 0;
@@ -226,6 +239,46 @@ static void cpcap_usb_try_musb_mailbox(struct cpcap_phy_ddata *ddata,
 		__func__, error);
 }
 
+static void cpcap_usb_set_extcon(struct cpcap_phy_ddata *ddata)
+{
+	int cable;
+
+	switch (ddata->mode) {
+	case CPCAP_CHARGER:
+		cable = EXTCON_CHG_USB_DCP;
+		break;
+	case CPCAP_USB:
+		cable = EXTCON_CHG_USB_SDP;
+		break;
+	case CPCAP_USB_HOST:
+	case CPCAP_DOCK:
+		cable = EXTCON_USB_HOST;
+		break;
+	case CPCAP_IDLE:
+		cable = EXTCON_NONE;
+		break;
+	case CPCAP_UNKNOWN:
+		dev_warn_once(ddata->dev, "called with unknown PHY mode\n");
+		return;
+	}
+
+	if (cable == ddata->cable)
+		return;
+
+	if (ddata->cable == EXTCON_CHG_USB_SDP)
+		extcon_set_state_sync(ddata->edev, EXTCON_USB, false);
+	else if (cable == EXTCON_CHG_USB_SDP)
+		extcon_set_state_sync(ddata->edev, EXTCON_USB, true);
+
+	if (ddata->cable != EXTCON_NONE)
+		extcon_set_state_sync(ddata->edev, ddata->cable, false);
+
+	if (cable != EXTCON_NONE)
+		extcon_set_state_sync(ddata->edev, cable, true);
+
+	ddata->cable = cable;
+}
+
 static void cpcap_usb_detect(struct work_struct *work)
 {
 	struct cpcap_phy_ddata *ddata;
@@ -275,6 +328,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 		ddata->mode = CPCAP_DOCK;
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
+		cpcap_usb_set_extcon(ddata);
 
 		/*
 		 * Force check state again after musb has reoriented,
@@ -303,6 +357,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 		ddata->mode = CPCAP_USB_HOST;
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
+		cpcap_usb_set_extcon(ddata);
 
 		return;
 	}
@@ -341,6 +396,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 		if (ddata->mode == CPCAP_USB)
 			cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_VALID);
 
+		cpcap_usb_set_extcon(ddata);
+
 		return;
 	}
 
@@ -359,6 +416,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 	ddata->mode = CPCAP_IDLE;
 	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
+	cpcap_usb_set_extcon(ddata);
 
 	return;
 
@@ -781,7 +839,18 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 	if (!otg)
 		return -ENOMEM;
 
+	ddata->edev = devm_extcon_dev_allocate(&pdev->dev, cpcap_extcon_cables);
+	if (IS_ERR(ddata->edev)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(ddata->edev),
+				     "failed to allocate extcon device\n");
+	}
+
+	error = devm_extcon_dev_register(&pdev->dev, ddata->edev);
+	if (error < 0)
+		return error;
+
 	ddata->mode = CPCAP_UNKNOWN;
+	ddata->cable = EXTCON_NONE;
 	ddata->dev = &pdev->dev;
 	ddata->phy.dev = ddata->dev;
 	ddata->phy.label = "cpcap_usb_phy";
-- 
2.39.5

