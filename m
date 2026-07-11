Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396D31D372
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802575; cv=none; b=SQptQtK/6UU5O4u1SutJn/3v6dLjIVzf4Fo7hMGE6hPVWLIJLh510L5MiPBK0NsrxHCGXMawoCOhk0lUmVAYPmXyk+djEh104BhrDdkv72xrXuEAyasbwFU3W4esFPVwvYwBltkWBJalk2K25w606qNcEz2o6cbRoM25s9tdSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802575; c=relaxed/simple;
	bh=UP73jtLlN1AuLWDQgF7AftXRUzG4kZ1AeeUPGQ4oI3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjgbsHjHaEVGcBgKjfaG3mkxNhSwgrfMBtdAxj+SQ0aptrT162OclWYjpJEiH5gqJCAlljt9HGiecf26w7y+tR4hTQUELxK29wMqivTMeN/wL29xV7BFBIqoDf8N0vkslk2x0gevC0PUgarAsfdFPAANEl25iOKxhMyl3JhsWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smLPTRQ2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smLPTRQ2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so14016635e9.1
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802566; x=1784407366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5lKBZDbQ54EDG3mIoiRjOcv2/ppN6VDq89EVU7M3vL0=;
        b=smLPTRQ2SlfQ5Bq+4WcD1744gRSDa8Wq25Mk2TLdkGLiePLYGESgq8e7XvNJon0RBc
         lUGh5T+Bg10edjbTTvXQw51Htd2NU5hnzT+ErObMMFF7CKXKoZ0JS7FFlF7pkU0sGe7s
         2vWOPyjFNjXd10AzzIULTpnlorIc3RLKgF3Z+bXt6JHls7rSMbWA/S7T00BPAWY40vW9
         Ujaw3waUi1pO9n57+FDxcjWMQmF3JMwGeSIbI67t3iYe5EYreHjCymOyceGtw+pBw8qF
         D1I0dqW/YvX/lsAaVHsg4Or4YwTylaw0caQ6eFOH6xFLLSzdXU9IMxYw63jMXUxNvcmk
         Np8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802566; x=1784407366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5lKBZDbQ54EDG3mIoiRjOcv2/ppN6VDq89EVU7M3vL0=;
        b=WNXS0Qz8UF0AypK+zDdFUoY5vudMt8Ptve7NxrgFQjiVmmXI6pqBWwnHuBkQhlHvU0
         Ex4V7BK4lMYlxx1mnl+6uPpaJt6ohQi29K3yjjKF/1bZzffUM9ksnsP7hLqL9yxPv1yl
         hb3Ba77P+CiXD0SCJc2Ys893PKa8he8LkYotHKLynSxTX0xIJy5lbdfoitocRqfb9ohF
         Th3yChrJ16V17ZFQO8Or1ynpeWZeQOBFWewAK4uv1R0gMJy/kJmIgPXUcZiCxBUV2lQr
         dpuj6HAnhHNEftiA+fuXQ7mdd4VftdG4ck++R4AtQoZj2/1HYhAlU+ct5kjR9pSMiOMC
         yAOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqx63/eNeg9x7IdSiO8m2OKTcTTn6ZoP1wsaS/+EjazcVy8CPduV5UnA9Z9vz5z1QVebjYFvCj4Oqxe@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBPn1dWgksIBCp/DTQWEfB7Ih3MoiQi+GL6hDE3odcDa980IN
	CAsW+Zz7VeLmuQ8V2FHA5hF4YLLDUmOyASBtuO5iZJ1Ywt3+SAKHn6Zi
X-Gm-Gg: AfdE7cncJ4LvroCncaQWPxqH7YEmDhj4uPYfK4fg60wBTp0fvhcrMgdD7ohKF7hHwr+
	9B8fLKz91iQEFrRLcyd+4lxy4TgzV7+imLDcKOvpwX5cg6Cd52JV3z2URex9iDVMIPAnKtq0N9l
	QrVSVD+0RIbbgGFjicHmrsf5YKphi6FEmrimNLlQKOTpJLmiVG3Q+RCYKFuLklTOeoIC+KUXigi
	XUkQUbpEbRGrlM3/e/xk4N0orFGYjeUrEzgnZB/EVHOtBteG5UcQx2s1BXgX79kgHBD10sk9TmL
	PiCVOYCwhx3rMTxy01E+30XySGXLO5OWCo2i+mQW+N5kNZ8AGCTL6t2OdpO7E1S87fU6yHTkNtK
	23wcp2VpDffStqTgQNpvm7FtZONuVAPPWve5TCyXrfIQpi4Q2MWwUL9f/dZdvA5l+/uotvBgfAP
	ZduCe73DwdinBu5HF5xxow2y4dJ6+zoji7TA==
X-Received: by 2002:a05:600c:64c5:b0:493:bc31:b2ae with SMTP id 5b1f17b1804b1-493f87e48a6mr34836835e9.10.1783802566328;
        Sat, 11 Jul 2026 13:42:46 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm172704725e9.2.2026.07.11.13.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:42:45 -0700 (PDT)
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
Subject: [PATCH v5 4/7] phy: cpcap-usb: add DCP detection and make UART idle mode optional
Date: Sat, 11 Jul 2026 23:42:07 +0300
Message-Id: <20260711204210.197144-5-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle DCP separately from USB host connections using CPCAP charger
detection status.

Make the existing idle UART mode optional via the "enable_uart" module
parameter. When disabled (default), the PHY remains in its USB/charger
detection configuration while idle.

Also initialize the PHY into the baseline configuration required for
reliable charger detection during probe.

Use the optional "safe" pinctrl state before switching between modes to
avoid glitches on USB or UART lines.

Note: Enabling UART idle mode increases idle power consumption (by 25mW
on droid4).

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

# Conflicts:
#	drivers/phy/motorola/phy-cpcap-usb.c
---
 drivers/phy/motorola/phy-cpcap-usb.c | 301 +++++++++++++++++++++------
 1 file changed, 238 insertions(+), 63 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 741145c89e5b..2d770ff19e93 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -110,6 +110,15 @@ enum cpcap_gpio_mode {
 	CPCAP_OTG_DM_DP,
 };
 
+enum cpcap_mode {
+	CPCAP_UNKNOWN,
+	CPCAP_IDLE,
+	CPCAP_CHARGER,
+	CPCAP_USB,
+	CPCAP_USB_HOST,
+	CPCAP_DOCK,
+};
+
 struct cpcap_phy_ddata {
 	struct regmap *reg;
 	struct device *dev;
@@ -119,15 +128,19 @@ struct cpcap_phy_ddata {
 	struct pinctrl_state *pins_ulpi;
 	struct pinctrl_state *pins_utmi;
 	struct pinctrl_state *pins_uart;
+	struct pinctrl_state *pins_safe;
 	struct gpio_desc *gpio[2];
 	struct iio_channel *vbus;
 	struct iio_channel *id;
 	struct regulator *vusb;
 	atomic_t active;
-	unsigned int vbus_provider:1;
-	unsigned int docked:1;
+	enum cpcap_mode mode;
 };
 
+static bool cpcap_enable_uart;
+module_param_named(enable_uart, cpcap_enable_uart, bool, 0644);
+MODULE_PARM_DESC(enable_uart,
+		 "Enable UART on the USB connector while idle (increases power consumption)");
 static bool cpcap_usb_vbus_valid(struct cpcap_phy_ddata *ddata)
 {
 	int error, value = 0;
@@ -196,8 +209,9 @@ static int cpcap_phy_get_ints_state(struct cpcap_phy_ddata *ddata,
 	return 0;
 }
 
-static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata);
+static int cpcap_usb_set_idle_mode(struct cpcap_phy_ddata *ddata);
 static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata);
+static int cpcap_usb_set_dcp_mode(struct cpcap_phy_ddata *ddata);
 
 static void cpcap_usb_try_musb_mailbox(struct cpcap_phy_ddata *ddata,
 				       enum musb_vbus_id_status status)
@@ -228,7 +242,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 	vbus = cpcap_usb_vbus_valid(ddata);
 
 	/* We need to kick the VBUS as USB A-host */
-	if (s.id_ground && ddata->vbus_provider) {
+	if (s.id_ground && ddata->mode == CPCAP_USB_HOST) {
 		dev_dbg(ddata->dev, "still in USB A-host mode, kicking VBUS\n");
 
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
@@ -243,7 +257,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 		return;
 	}
 
-	if (vbus && s.id_ground && ddata->docked) {
+	if (vbus && s.id_ground && ddata->mode == CPCAP_DOCK) {
 		dev_dbg(ddata->dev, "still docked as A-host, signal ID down\n");
 
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
@@ -252,15 +266,14 @@ static void cpcap_usb_detect(struct work_struct *work)
 	}
 
 	/* No VBUS needed with docks */
-	if (vbus && s.id_ground && !ddata->vbus_provider) {
+	if (vbus && s.id_ground && ddata->mode != CPCAP_USB_HOST) {
 		dev_dbg(ddata->dev, "connected to a dock\n");
 
-		ddata->docked = true;
-
 		error = cpcap_usb_set_usb_mode(ddata);
 		if (error)
 			goto out_err;
 
+		ddata->mode = CPCAP_DOCK;
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
 
 		/*
@@ -274,17 +287,13 @@ static void cpcap_usb_detect(struct work_struct *work)
 		return;
 	}
 
-	if (s.id_ground && !ddata->docked) {
+	if (s.id_ground && ddata->mode != CPCAP_DOCK) {
 		dev_dbg(ddata->dev, "id ground, USB host mode\n");
 
-		ddata->vbus_provider = true;
-
 		error = cpcap_usb_set_usb_mode(ddata);
 		if (error)
 			goto out_err;
 
-		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
-
 		error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
 					   CPCAP_BIT_VBUSSTBY_EN |
 					   CPCAP_BIT_VBUSEN_SPI,
@@ -292,38 +301,74 @@ static void cpcap_usb_detect(struct work_struct *work)
 		if (error)
 			goto out_err;
 
+		ddata->mode = CPCAP_USB_HOST;
+		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
+
 		return;
 	}
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
-				   CPCAP_BIT_VBUSSTBY_EN |
-				   CPCAP_BIT_VBUSEN_SPI, 0);
-	if (error)
-		goto out_err;
-
 	vbus = cpcap_usb_vbus_valid(ddata);
 
-	/* Otherwise assume we're connected to a USB host */
-	if (vbus) {
-		dev_dbg(ddata->dev, "connected to USB host\n");
-		error = cpcap_usb_set_usb_mode(ddata);
+	/* Check if we're connected to a USB host or charger */
+	if (vbus && ddata->mode != CPCAP_USB_HOST) {
+		enum cpcap_mode new_mode;
+
+		if (s.se1)
+			new_mode = CPCAP_CHARGER;
+		else if (!s.dm && !s.dp)
+			new_mode = CPCAP_USB;
+		else {
+			error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
+						   CPCAP_BIT_USBXCVREN |
+						   CPCAP_BIT_UARTMUX0 |
+						   CPCAP_BIT_EMUMODE0, 0);
+			if (error)
+				goto out_err;
+
+			schedule_delayed_work(&ddata->detect_work,
+					      msecs_to_jiffies(100));
+			return;
+		}
+
+		dev_dbg(ddata->dev, "connected to %s\n",
+			s.se1 ? "DCP" : "USB host");
+
+		error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
+					   CPCAP_BIT_VBUSSTBY_EN |
+					   CPCAP_BIT_VBUSEN_SPI, 0);
 		if (error)
 			goto out_err;
-		cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_VALID);
+
+		if (new_mode == CPCAP_CHARGER)
+			error = cpcap_usb_set_dcp_mode(ddata);
+		else
+			error = cpcap_usb_set_usb_mode(ddata);
+
+		if (error)
+			goto out_err;
+
+		ddata->mode = new_mode;
+		if (ddata->mode == CPCAP_USB)
+			cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_VALID);
 
 		return;
 	}
 
-	ddata->vbus_provider = false;
-	ddata->docked = false;
-	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
+	if (ddata->mode == CPCAP_IDLE)
+		return;
 
-	/* Default to debug UART mode */
-	error = cpcap_usb_set_uart_mode(ddata);
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
+				   CPCAP_BIT_VBUSSTBY_EN |
+				   CPCAP_BIT_VBUSEN_SPI, 0);
+	if (error)
+		goto out_err;
+
+	error = cpcap_usb_set_idle_mode(ddata);
 	if (error)
 		goto out_err;
 
-	dev_dbg(ddata->dev, "set UART mode\n");
+	ddata->mode = CPCAP_IDLE;
+	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
 
 	return;
 
@@ -424,43 +469,84 @@ static int cpcap_usb_gpio_set_mode(struct cpcap_phy_ddata *ddata,
 	return 0;
 }
 
-static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
+static int cpcap_usb_set_safe_mode(struct cpcap_phy_ddata *ddata)
 {
 	int error;
 
 	/* Disable lines to prevent glitches from waking up mdm6600 */
 	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
 	if (error)
-		goto out_err;
+		return error;
 
-	if (ddata->pins_uart) {
-		error = pinctrl_select_state(ddata->pins, ddata->pins_uart);
-		if (error)
-			goto out_err;
+	if (ddata->pins_safe) {
+		error = pinctrl_select_state(ddata->pins, ddata->pins_safe);
+		if (error) {
+			dev_err(ddata->dev, "could not set safe mode: %i\n",
+				error);
+		}
 	}
 
+	return error;
+}
+
+static int cpcap_usb_set_idle_mode(struct cpcap_phy_ddata *ddata)
+{
+	int error;
+	unsigned int val;
+	bool enable_uart = cpcap_enable_uart;
+
+	error = cpcap_usb_set_safe_mode(ddata);
+	if (error)
+		return error;
+
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC1,
+				   CPCAP_BIT_DP150KPU |
+				   CPCAP_BIT_DP1K5PU |
+				   CPCAP_BIT_DM1K5PU |
+				   CPCAP_BIT_DPPD |
+				   CPCAP_BIT_DMPD |
 				   CPCAP_BIT_VBUSPD,
+				   CPCAP_BIT_DP150KPU |
 				   CPCAP_BIT_VBUSPD);
 	if (error)
 		goto out_err;
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
-				   0xffff, CPCAP_BIT_UARTMUX0 |
-				   CPCAP_BIT_EMUMODE0);
+	val = CPCAP_BIT_USBSUSPEND;
+
+	if (enable_uart)
+		val |= (CPCAP_BIT_UARTMUX0 | CPCAP_BIT_EMUMODE0);
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2, 0xffff, val);
 	if (error)
 		goto out_err;
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3, 0x7fff,
-				   CPCAP_BIT_IDPU_SPI);
+	val = CPCAP_BIT_VBUSSTBY_EN |
+	      CPCAP_BIT_VBUSPD_SPI |
+	      CPCAP_BIT_DMPD_SPI |
+	      CPCAP_BIT_DPPD_SPI |
+	      CPCAP_BIT_PU_SPI |
+	      CPCAP_BIT_IDPU_SPI |
+	      CPCAP_BIT_ULPI_SPI_SEL;
+
+	if (!enable_uart)
+		val |= CPCAP_BIT_SUSPEND_SPI;
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3, 0x7fff, val);
 	if (error)
 		goto out_err;
 
-	/* Enable UART mode */
 	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
 	if (error)
 		goto out_err;
 
+	if (enable_uart && ddata->pins_uart) {
+		error = pinctrl_select_state(ddata->pins,  ddata->pins_uart);
+		if (error)
+			goto out_err;
+	}
+
+	dev_dbg(ddata->dev, "set %s mode\n", enable_uart ? "UART" : "IDLE");
+
 	return 0;
 
 out_err:
@@ -473,21 +559,10 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 {
 	int error;
 
-	/* Disable lines to prevent glitches from waking up mdm6600 */
-	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
+	error = cpcap_usb_set_safe_mode(ddata);
 	if (error)
 		return error;
 
-	if (ddata->pins_utmi) {
-		error = pinctrl_select_state(ddata->pins, ddata->pins_utmi);
-		if (error) {
-			dev_err(ddata->dev, "could not set usb mode: %i\n",
-				error);
-
-			return error;
-		}
-	}
-
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC1,
 				   CPCAP_BIT_VBUSPD, 0);
 	if (error)
@@ -503,11 +578,23 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 		goto out_err;
 
 	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
-				   CPCAP_BIT_USBXCVREN,
+				   CPCAP_BIT_USBXCVREN |
+				   CPCAP_BIT_UARTMUX0 |
+				   CPCAP_BIT_EMUMODE0,
 				   CPCAP_BIT_USBXCVREN);
 	if (error)
 		goto out_err;
 
+	if (ddata->pins_utmi) {
+		error = pinctrl_select_state(ddata->pins, ddata->pins_utmi);
+		if (error) {
+			dev_err(ddata->dev, "could not set usb mode: %i\n",
+				error);
+
+			return error;
+		}
+	}
+
 	/* Enable USB mode */
 	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_OTG_DM_DP);
 	if (error)
@@ -521,6 +608,38 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 	return error;
 }
 
+static int cpcap_usb_set_dcp_mode(struct cpcap_phy_ddata *ddata)
+{
+	int error;
+
+	error = cpcap_usb_set_safe_mode(ddata);
+	if (error)
+		return error;
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
+				   CPCAP_BIT_USBXCVREN |
+				   CPCAP_BIT_UARTMUX0 |
+				   CPCAP_BIT_EMUMODE0, 0);
+	if (error)
+		goto out_err;
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
+				   CPCAP_BIT_SUSPEND_SPI, 0);
+	if (error)
+		goto out_err;
+
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
+	if (error)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
+
+	return error;
+}
+
 static int cpcap_usb_init_optional_pins(struct cpcap_phy_ddata *ddata)
 {
 	ddata->pins = devm_pinctrl_get(ddata->dev);
@@ -550,8 +669,11 @@ static int cpcap_usb_init_optional_pins(struct cpcap_phy_ddata *ddata)
 		ddata->pins_uart = NULL;
 	}
 
-	if (ddata->pins_uart)
-		return pinctrl_select_state(ddata->pins, ddata->pins_uart);
+	ddata->pins_safe = pinctrl_lookup_state(ddata->pins, "safe");
+	if (IS_ERR(ddata->pins_safe)) {
+		dev_info(ddata->dev, "safe pins not configured\n");
+		ddata->pins_safe = NULL;
+	}
 
 	return 0;
 }
@@ -605,6 +727,59 @@ static int cpcap_usb_init_iio(struct cpcap_phy_ddata *ddata)
 	return error;
 }
 
+static int cpcap_usb_init_usb(struct cpcap_phy_ddata *ddata)
+{
+	struct cpcap_usb_ints_state s;
+	int error;
+	int mask;
+
+	error = cpcap_phy_get_ints_state(ddata, &s);
+	if (error)
+		return error;
+
+	error = cpcap_usb_set_safe_mode(ddata);
+	if (error)
+		return error;
+
+	/*
+	 * Do not touch DM/DP PD as this will break charger detection if charger
+	 * is connected before we detect it.
+	 */
+	if (s.se1) {
+		mask = CPCAP_BIT_VBUSEN_SPI | CPCAP_BIT_VBUSPU_SPI |
+		       CPCAP_BIT_SUSPEND_SPI | CPCAP_BIT_ULPI_SPI_SEL;
+	} else {
+		mask = CPCAP_BIT_VBUSEN_SPI | CPCAP_BIT_VBUSPU_SPI |
+		       CPCAP_BIT_DMPD_SPI | CPCAP_BIT_DPPD_SPI |
+		       CPCAP_BIT_SUSPEND_SPI | CPCAP_BIT_PU_SPI |
+		       CPCAP_BIT_ULPI_SPI_SEL;
+	}
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3, mask,
+				   CPCAP_BIT_ULPI_SPI_SEL);
+	if (error)
+		return error;
+
+	/*
+	 * Configure safe DP/DM termination state.
+	 *
+	 * Vendor kernel uses:
+	 *   DP150KPU = enabled
+	 *   all USB pullups/pulldowns = disabled
+	 */
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC1,
+				   CPCAP_BIT_DP150KPU |
+				   CPCAP_BIT_DP1K5PU |
+				   CPCAP_BIT_DM1K5PU |
+				   CPCAP_BIT_DPPD |
+				   CPCAP_BIT_DMPD,
+				   CPCAP_BIT_DP150KPU);
+	if (error)
+		return error;
+
+	return cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id cpcap_usb_phy_id_table[] = {
 	{
@@ -638,6 +813,7 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 	if (!otg)
 		return -ENOMEM;
 
+	ddata->mode = CPCAP_UNKNOWN;
 	ddata->dev = &pdev->dev;
 	ddata->phy.dev = ddata->dev;
 	ddata->phy.label = "cpcap_usb_phy";
@@ -682,6 +858,10 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 	if (error)
 		goto out_reg_disable;
 
+	error = cpcap_usb_init_usb(ddata);
+	if (error)
+		goto out_reg_disable;
+
 	error = cpcap_usb_init_interrupts(pdev, ddata);
 	if (error)
 		goto out_reg_disable;
@@ -701,17 +881,12 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 static void cpcap_usb_phy_remove(struct platform_device *pdev)
 {
 	struct cpcap_phy_ddata *ddata = platform_get_drvdata(pdev);
-	int error;
 
 	atomic_set(&ddata->active, 0);
 	cpcap_usb_fini_interrupts(pdev, ddata);
 	cancel_delayed_work_sync(&ddata->detect_work);
-	error = cpcap_usb_set_uart_mode(ddata);
-	if (error)
-		dev_err(ddata->dev, "could not set UART mode\n");
-
+	cpcap_usb_set_idle_mode(ddata);
 	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
-
 	usb_remove_phy(&ddata->phy);
 	regulator_disable(ddata->vusb);
 }
-- 
2.39.5

