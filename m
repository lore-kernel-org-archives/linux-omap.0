Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8E36B044
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246292; cv=none; b=uCmHd+r9JaHd6gYLPvuzdX/YNC6K68p+87e9PgHR0m6GBPnwshHato5m22rbxghGu8LW6G02HfmqQXymip86Q/azKFDdnvkX8bTgv3hu+m4emwlQeWYXyeEy+1DKDYXlV4Rdj5zk1gVZpKeH6sB4Jv2NiVK5WF9J8cDwBzzBWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246292; c=relaxed/simple;
	bh=IEmSU/by2VzFwJwSteAX1qEHitxDHjCToChDeMiGOtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IbENPf6F3SnKrYuWZCrSAFWgsEDJNYbqyLfuwoGHOAgOv6ZZ69NgYwX8LnXXgsyMrWrIfqNVt6UOlJjZQNDk9cEH83l6N/+10Ux0jGyqvn421MHi2ey9IBdzaC+QaSksOkm0Y21RRbYzIeT79/oEbdoj0qMbeykY/BLfUA4NiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z394v9XR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z394v9XR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so791995e9.2
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783246288; x=1783851088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMf0EghcO1wU7SDI12QaKU3M5UeL2s+v1847s1Xy9Ew=;
        b=Z394v9XRdQ8NWpUu0n6MohPys3M07cbQ9CydneUv0xl6sNauWiCYxDLIBuZ1ThIUZq
         qxvW+0vcSUKSPBKdXbiTFEKEmI1mHSqDb5hb4GKzu55dkFKy+jo6ys7H4ejLjfx6quZw
         sifIsUeBpUzWdh8Y7vHcWt5j2T6V8xi4hUDJk7J1CFyujyBsoqPxRl2hp+el/Cy9XKSB
         a2vxFVVBwDfKz8uTwZ9iNV3zW0Q9E4WTANSSaXW+J4QZ6N0lTOS6CLpZHmBJcCwwVsrf
         WWTIRD6E+TZTjpiyT8hQri74y2mFGtCfhU0fzjXDxtl8S0I0YLzvFex9XuvP54OGDJnK
         PlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783246288; x=1783851088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMf0EghcO1wU7SDI12QaKU3M5UeL2s+v1847s1Xy9Ew=;
        b=qCTeygfefTQ22IRFN+zCjbf6oIq6oami+9+j7wl9TxuO+qo7mnCa1XyVbZotBuW8+a
         lhL8XZ1JGR8N+NplAiXxKN8077YBJegihR/x/lV5g9B23e4BDGBLbr/dxbicKHPB/ZNh
         ZLIRGrP/s8XzNGCJzRark+AI+M1u7OHtzcc1uGYj5wHz+fGajcR8+OBZ5SgtkJMY1KY2
         ERGzS6rv2u8+qFRhTA4ibb2qE7L85wr3j3csFDSjCShYP+zB4vhe+1+cLcXsxZGliR2y
         azE8VdTDhVYRouEOleR/EY0N70/fMl91Rk6jxYvnjp3/DHvY1YjKrfmETB24CIgmu8Wo
         u3/w==
X-Forwarded-Encrypted: i=1; AFNElJ/lEa4oSHyPW3YCwX5mh5IwebIgILw8ZGfPxHk/ZR7KJlLxb+b0RRWMoiD3SV0hqkySVuRuhhiKJ9B9@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTCRRUQUPTrPaFsqquo6ouOvzDJ92LGGJHrH6+e2TYVNUsljT
	sdAN4qTdN3/VVIsNnT6ubG+9G1R/aivR6HRxVEuj0p0BuF80KcXKFGLK
X-Gm-Gg: AfdE7cn1mBKrFYGFtGW8JW30DOCQGo9kYwsl7m02VX2mfvomik8w24jFPD1wNXOJ4mF
	hsmES8ajlC60lDSWcL47LMRwLVgRTt4GPZy07rvThYvNMrYLUnsrSNIQYhSRjY/Q8boFsocf7px
	wtlfT1BXNYi82B4CpQonttj2GjyujiYzyyz7TXvZAWCQF7wwpZeP+dvq25PUYv4dVRs7H1WlLit
	Nmb3UVphjy5RzcQhuHIq55ozej5ZXQW1lntl38+jmWPO2ty+9wsA3SBlUBh9nb91xBuKLByIfyo
	rJVI7CYCq1t1uRmUptPzuz+0OrQC6V/TLiPIbT1X2e5sQEa+1jICrDQxAtgcUv/HSmOvM+AEa3n
	WhMSXX1FA3RfyYybZ/idMheTd6Gxz8DJ612shwWMAS/X+hlLb+AlAYjKD/jMKfYbUgBCpSSuW8z
	Uo5+ROGfl4oHojVglCUyulnj0XqvtLz66mN32WA7Fa32sE
X-Received: by 2002:a05:600d:844f:10b0:493:c1bc:79bd with SMTP id 5b1f17b1804b1-493d11f03acmr45744445e9.20.1783246288368;
        Sun, 05 Jul 2026 03:11:28 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm261382715e9.6.2026.07.05.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 03:11:27 -0700 (PDT)
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
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v3 4/4] phy: cpcap-usb: add extcon support
Date: Sun,  5 Jul 2026 13:11:05 +0300
Message-Id: <20260705101105.1798069-5-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
References: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
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
index 78bb1773e537..ba36d110df41 100644
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
@@ -134,12 +136,23 @@ struct cpcap_phy_ddata {
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
@@ -346,6 +401,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 		if (ddata->mode == CPCAP_USB)
 			cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_VALID);
 
+		cpcap_usb_set_extcon(ddata);
+
 		return;
 	}
 
@@ -358,6 +415,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 	ddata->mode = CPCAP_IDLE;
 	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
+	cpcap_usb_set_extcon(ddata);
 
 	return;
 
@@ -777,7 +835,18 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
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

