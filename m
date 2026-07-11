Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA913C7E13
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788518; cv=none; b=EMngORB4hBAbpEZxxn7h8J7skysftBkmxsOLio4FZITTB8uH5WaJSgABswJUWj5xUz9cXjp7vQV64KUaSiIaMXasRrDiEa3mDJK6POzcPrVEhpCgiTC5bbivOHiKYGiQQD+9Mwx+aUJTl2uB6n8sgf9WRslTfKYWwO/2bxM2XRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788518; c=relaxed/simple;
	bh=7M2d5+hUcFNQfvU1ANkHFdGWgfJi+MrQuPo0yxaPCrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6XOPWhMZxhV+1/c8ZV6U4utLnQVgS5n4E0HBOW+E8fjWg7Ksbp0PCQ5u0UdecpUpQO8nZEteZ3UTfrfEdUMe5CnnkyDlzfh2fOW0cZFwFmkok2FKs83tX+hBgKBd9nhOqCmaIZaCTAmo1mo6HtY/X1uG51j6yU8fUNTP4Fonbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR+YOp8C; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR+YOp8C"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-470174001a0so1125364f8f.0
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783788511; x=1784393311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyZWZlyaOYWp5czHM4iq7SfeFCjsKYeLefKXNqvyu9Q=;
        b=gR+YOp8CXlQRIfRTqWXHQo6tuDID4njAcHffH5ircS1Oj2j+rZZwfyTuCncei2lVY+
         eTqtkYC0mej4s9RlOC6Uqv35pbS4BPAcTQU5oKebMEp0yZoSvljFt+47gp8NzG50gfLG
         W5qvRLdvkYBOzVnrcdZ9gV/aQ1cPLttXPT9kM+5oaVysO6zHnyWjqrCMnXxL+ZldNWyO
         6OxmoFV+PQ1h3TckDgSN7hPC2I6A34dJihCWxz2FYRvzX1T9jPmkfFddGp65BJstnXXJ
         gosCeLjiYhlzZvL6vAUPpa2224FQ39NKYp/TVQTB94WMK1fpRtplt2SNjukQROfCtvhq
         5Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788511; x=1784393311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KyZWZlyaOYWp5czHM4iq7SfeFCjsKYeLefKXNqvyu9Q=;
        b=VmoLQj3QpefvklPXxfCYY5f+B41r9Y+yUt0gEo+VI9/pn0e8iSZHgXMmKJYxvOEMkn
         z77MDwAPh/1OBYpsUXQbZQzW+f8o8zsGPuOG7L5rOg9wKIC35oJ94eKUvaS9MeGTYtlM
         +zux+ZbxcsL0F3hn4p3ZVKjjJAlIrbV6Kd9PBGytvrJx3gEFGjvyFxAVBe9ntIcJFNOO
         tND2dkdH07Twm3x9wZAOsSQRSO78at2v3CbPhDEWdu82shbhUjT4ms+dLYDh+ysgj56u
         qZJgw+TSF+Zf7qrsRM1iStEDfvgWIWoaaLtu8bvEcuXWFmMz1Wd8sXfwS+5YJMvpukEr
         KgXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/HTfqkKqcztXamiyVUO+m4cCp66K1OewhralWRKwS6QHMioT4qU2QZOAuPtylLvmdLUNrTEw49wxZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUUaARs5XxwH6WCGfw+s4jkqw4Fz00YPgk2xPgTUK3eZUeGip
	P4JOlfUTaTEasV/zqEFuub9Qt0sQ1CyTaImaOm+Cy9tM6u6v9Jtd+4AS
X-Gm-Gg: AfdE7ck0YdIakV0OC/QXm4XpcYZAypMwID5eWkg3bMDmt5sTKwN0QxeCLESkHDMqRbu
	qO2TP6GpPbyILsuyN6g61VsPvOp4WZAdtUCtT9V/NV9SLAavxcpY9i2OUcd8RrJY72HU2rjRTFQ
	GutX+Cx9RsFeKZVtgijG56eeudo8zy3wDnXxHtoEbfD+I+xzeazPp6Fc2XkvXVkOIc10Xa9HfOd
	PtqWJ5qxGzacPkLOHuBqw3AWX4BiejXJuAOaWwH7AkTQI1NpnIIG6Kwk43tn0Zc5mBqXJY0yzv3
	l6r6BW6Oy71JuM7mDCsFdDRW7LvDRd0m7D6gyFS8pyYi5b01prgbrCb99VmQmgyWicDII0G1oYm
	jt+dWryZDooo6yvDqK0N45PGPpSWGaySfNkWg8yFPW0sB745kr7Jx94eLShp/yIYMjEn1crxOv0
	kUju1dOFYV7q1HVDed+m+pfL10rT70ux0kTA==
X-Received: by 2002:a05:6000:471c:b0:479:e6a8:c0f1 with SMTP id ffacd0b85a97d-47f2dc8d79fmr3046520f8f.9.1783788510827;
        Sat, 11 Jul 2026 09:48:30 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm69152875f8f.13.2026.07.11.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:30 -0700 (PDT)
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
Subject: [PATCH v4 3/6] phy: cpcap-usb: add DCP detection and make UART idle mode optional
Date: Sat, 11 Jul 2026 19:47:51 +0300
Message-Id: <20260711164754.185565-4-ivo.g.dimitrov.75@gmail.com>
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

Handle DCP separately from USB host connections using CPCAP charger
detection status.

Make the existing idle UART mode optional via the "enable_uart" module
parameter. When disabled (default), the PHY remains in its USB/charger
detection configuration while idle.

Also initialize the PHY into the baseline configuration required for
reliable charger detection during probe.

Use the optional "safe" pinctrl state before switching between modes to
avoid glitches on USB or UART lines.

Fix a possible race between idle mode setup in cpcap_usb_phy_remove() and
cpcap_usb_detect().

Note: Enabling UART idle mode increases idle power consumption (by 25mW
on droid4).

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 281 +++++++++++++++++++++------
 1 file changed, 219 insertions(+), 62 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 7cb020dd3423..d4eb8086b600 100644
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
@@ -292,38 +301,64 @@ static void cpcap_usb_detect(struct work_struct *work)
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
+		else
+			return;
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
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
+				   CPCAP_BIT_VBUSSTBY_EN |
+				   CPCAP_BIT_VBUSEN_SPI, 0);
+	if (error)
+		goto out_err;
 
-	/* Default to debug UART mode */
-	error = cpcap_usb_set_uart_mode(ddata);
+	error = cpcap_usb_set_idle_mode(ddata);
 	if (error)
 		goto out_err;
 
-	dev_dbg(ddata->dev, "set UART mode\n");
+	ddata->mode = CPCAP_IDLE;
+	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
 
 	return;
 
@@ -411,43 +446,84 @@ static int cpcap_usb_gpio_set_mode(struct cpcap_phy_ddata *ddata,
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
@@ -460,21 +536,10 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
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
@@ -495,6 +560,16 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
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
@@ -508,6 +583,31 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
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
@@ -537,8 +637,11 @@ static int cpcap_usb_init_optional_pins(struct cpcap_phy_ddata *ddata)
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
@@ -592,6 +695,59 @@ static int cpcap_usb_init_iio(struct cpcap_phy_ddata *ddata)
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
@@ -625,6 +781,7 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 	if (!otg)
 		return -ENOMEM;
 
+	ddata->mode = CPCAP_UNKNOWN;
 	ddata->dev = &pdev->dev;
 	ddata->phy.dev = ddata->dev;
 	ddata->phy.label = "cpcap_usb_phy";
@@ -669,6 +826,10 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 	if (error)
 		goto out_reg_disable;
 
+	error = cpcap_usb_init_usb(ddata);
+	if (error)
+		goto out_reg_disable;
+
 	error = cpcap_usb_init_interrupts(pdev, ddata);
 	if (error)
 		goto out_reg_disable;
@@ -688,17 +849,13 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 static void cpcap_usb_phy_remove(struct platform_device *pdev)
 {
 	struct cpcap_phy_ddata *ddata = platform_get_drvdata(pdev);
-	int error;
 
 	atomic_set(&ddata->active, 0);
-	error = cpcap_usb_set_uart_mode(ddata);
-	if (error)
-		dev_err(ddata->dev, "could not set UART mode\n");
-
+	cancel_delayed_work_sync(&ddata->detect_work);
+	cpcap_usb_set_idle_mode(ddata);
 	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
 
 	usb_remove_phy(&ddata->phy);
-	cancel_delayed_work_sync(&ddata->detect_work);
 	regulator_disable(ddata->vusb);
 }
 
-- 
2.39.5

