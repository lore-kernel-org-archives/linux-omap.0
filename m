Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362F39C015
	for <linux-omap@vger.kernel.org>; Sat,  4 Jul 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783150779; cv=none; b=cdVwqTKkhs5GGEPbKbcTsyOrFdjw/i9qsi8XGlP0sQmnB5hUCrq9iYUad/lpvyJpslvF3G7MuMKlP69YEEoVCUlq093f7TvodqSlGQ2AsBZpBGnAmedtKBkncoU6jKF3kJEZj0vrKInf9nZNSJoxuS/i8fDFh4EJo4M1q47/y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783150779; c=relaxed/simple;
	bh=b4iUr65hHHCVaSWsSZyZa4GjL3PiNleLinM59ZwAh08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pWkrk40VMe6aCl4Lnr4WmdkUiIuMjloqD7qiUqNyfTEH/ESRcgaDynXBANMa3BcHmIh18stxjkeeRbhBaqSly+MRs81VVUlDTpHg+fEFfU5tu7zlePBXO4YiwsUTM0V9LfB5JeMzUsJg1dRSqIuAOqG1pASAxDLAFWsP6rdwPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfkEtWfM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfkEtWfM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c2b3dc8bso8238585e9.2
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2026 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783150763; x=1783755563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzRzJB6u7MYAPuTB3vZnPlGmNDCrN8auNwAuOBFkv0c=;
        b=pfkEtWfMdWOZ4rgCiLjwkzLdw9CwciDYT9ggt3HuEpmidlqDOqQkEad+ZDTtmKUA3/
         SvLay/yqTBRIwHpkxkVTLrmgUInhGKvaMw+k2IzYfo+j4Njh0o31cL7LG8xVNJt6RiE9
         M26cLLOUH8VrbL4Xi5mnULrb0STBC5wuPw0zs8y6Q7ceN8tRovCf1/xiCQxn6vu9fxlU
         uJWfEKkpKccImwIdRazm2T7Fsb5dzIWmui5MLQEiW1w6ubsesPr9Uv+Df0xCjWV+oe/Y
         7xE/Ff+UnmeuZfQCeRmt+PAL4VZGXcXwbO/Y0s8ysPyTXKjBoI0MTth0CqKTB5Yei2B2
         IntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783150763; x=1783755563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OzRzJB6u7MYAPuTB3vZnPlGmNDCrN8auNwAuOBFkv0c=;
        b=mSHvOP+BozWJuqAhIPuUn795R2QqVNP7UcZyusPoMqhQEHbkFFmY+RQzbJMtXjOSZz
         lvcg3olMOvRuEZdhG4ZoiMAJZJbhOK/C+v7ko8SbTJumBLs73inlvrYXbh0gumkdsFbz
         peTMtG0P02OzGOfkkQ79kB+nzysMq1VdX0h0N6NkMtUbuwjiv+5cSqPvHdp9XpqsOtEG
         pCavzYowTG1XjnvsVj7CF5jKl/d85pCRA+C4tVunwIAOKWawFbq64QrfJsCL7zHxDbyj
         QWAVVh68sZodRlgkWe1xd6RUnDbnGndgfkxt0UHgKGQxEv6QwLJkK8T6O9ot9QtEX8ky
         4mgA==
X-Forwarded-Encrypted: i=1; AFNElJ9V3j695HORyzOoFwI9qpnsfkg3Im0bL0KaWRkl1CwS7vx3UPUQBfNkVKANeisVOR1/sXdmWho/hH2E@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPQ8PXfDtowV/sVPNvokaX1b7lQeaEnMR2H1YEtyGF9C+ebp/
	ODDSw9DuJrZqh6VzLwKsl/U8wB9nuf7KbaypfB4cvL2wlZmIx+XNGAUr
X-Gm-Gg: AfdE7cl04cOwZrKaEXvU9njdgWEKpTuhzXyFeyfQAMFWh72o6a0USecBjC4ekPhh/ar
	KXGI812kej8CfX3QaWd0qx0/reoEkSr8htNK5fBWIX6LQ/WmGgMvLmDs6pyelbj+dDpmYYRDWG3
	facBroKAUhuyVt+jcQiptfMFnm+TOydrNs4bhJL/LNeYd/fvDIQR1AOWVLtWN1/82E+Eyd64yw0
	eZQEm/M8q89m7zA9Cd5FtNUtQPbtrhI5iF5X8wFBHZwga4fWwH+XMVuZzunRdYisrty6SGzawMn
	uLH0r3SpcBoDKJD1UFl6RljWil3CFC+QBG33nUMBLTdTq95a5qH5apuCpO4W5vie1hGtaKQhVgo
	Gg0C0p/slA1fOH3k5KDyt4Z0J7fYH5LmUGp8KqKLgcisF7/Lky0zySAorWdwKigIjV/jYHgMWRI
	jzRMhXtAQSsGarANCL+ogSIH0qf7XThnTTsg==
X-Received: by 2002:a05:600c:314f:b0:493:b2c1:b2f9 with SMTP id 5b1f17b1804b1-493d11cf274mr24679345e9.8.1783150762899;
        Sat, 04 Jul 2026 00:39:22 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm6565488f8f.7.2026.07.04.00.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 00:39:22 -0700 (PDT)
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
Subject: [PATCH 5/5] phy: cpcap-usb: add extcon support
Date: Sat,  4 Jul 2026 10:38:43 +0300
Message-Id: <20260704073843.1750458-6-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260704073843.1750458-1-ivo.g.dimitrov.75@gmail.com>
References: <20260704073843.1750458-1-ivo.g.dimitrov.75@gmail.com>
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
 drivers/phy/motorola/phy-cpcap-usb.c | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 3be2b3afaaf4..8978a95c1c19 100644
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
@@ -226,6 +239,43 @@ static void cpcap_usb_try_musb_mailbox(struct cpcap_phy_ddata *ddata,
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
+	}
+
+	if (cable == ddata->cable)
+		return;
+
+	if (ddata->cable == EXTCON_CHG_USB_SDP)
+		extcon_set_state(ddata->edev, EXTCON_USB, false);
+	else if (cable == EXTCON_CHG_USB_SDP)
+		extcon_set_state(ddata->edev, EXTCON_USB, true);
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
@@ -276,6 +326,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 			goto out_err;
 
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
+		cpcap_usb_set_extcon(ddata);
 
 		/*
 		 * Force check state again after musb has reoriented,
@@ -306,6 +357,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 		if (error)
 			goto out_err;
 
+		cpcap_usb_set_extcon(ddata);
+
 		return;
 	}
 
@@ -343,6 +396,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 		if (ddata->mode == CPCAP_USB)
 			cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_VALID);
 
+		cpcap_usb_set_extcon(ddata);
+
 		return;
 	}
 
@@ -356,6 +411,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 	if (error)
 		goto out_err;
 
+	cpcap_usb_set_extcon(ddata);
+
 	return;
 
 out_err:
@@ -781,11 +838,22 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
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
 	ddata->dev = &pdev->dev;
 	ddata->phy.dev = ddata->dev;
 	ddata->phy.label = "cpcap_usb_phy";
 	ddata->phy.otg = otg;
 	ddata->phy.type = USB_PHY_TYPE_USB2;
+	ddata->cable = EXTCON_NONE;
 	otg->set_host = cpcap_usb_phy_set_host;
 	otg->set_peripheral = cpcap_usb_phy_set_peripheral;
 	otg->usb_phy = &ddata->phy;
-- 
2.25.1

