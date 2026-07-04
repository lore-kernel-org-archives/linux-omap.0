Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA83328FC
	for <linux-omap@vger.kernel.org>; Sat,  4 Jul 2026 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783150773; cv=none; b=KBCFCARBFVYOLWx9A1k56RKZccC01rxPIM48bImNaIZE5j0momO9ffXOK/hpvglL+Kavjr+bHnPwiupb5GgPMhAdcMKALP+dvg0w1/GKQFvawFWSyGt8RejNkRK0CD77bqsOAbXFTZI6z6NGUs1weVrVOS/j2ejQA5fJEhF54es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783150773; c=relaxed/simple;
	bh=0kG8zJoFlebNZqDXA0kJ2xcKe1B5umzBWyApBAR/c4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYw4wTZCgsC74aqjPAa5etEUVsL9b9zi4p9QJMrxQOIXB3Z6qEnGOn4CGCAi5EjeTIjfMrgjA/OXCbtVFV94bL6guVkscsgPaujOLBj6p3bNEZYvRyJKKnMzKJtng2pGsroXWC1V0o969L/2uDf/mY6bzpupWuKwKz/qtmCZn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIT7kfnC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIT7kfnC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c733f15aso12489405e9.0
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2026 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783150758; x=1783755558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQKO9bqpFCzv41g7UYTqgpDpXTiS0DtpcAW+BBuDTlY=;
        b=TIT7kfnCF5vBzzBfCA0eiZ/DCi8nfhU+Wa29m/SiFf7QDMX4NeJOrF2zfVkuUwq4iS
         A32pgW5MGpdo/2NX+fLBetSVZFWhDylx4L1XjWawrH9fzz67JERl6OXhqHXlekhLfY/v
         hjocT/qFfEtDOv9JCcYsnVYVxOofJtADVvUlmU7v+Rh6k3gsrnr3DmQzu4+ZTSOAUr6Z
         pArDMRekGMiEEdmX65E1WDCIY8FXlbLFjtg/gKTjTusNO3ii2ErAXQSP6fx1o9rNxgz0
         hsxr3qkFIZxXbpp1vzamScFJKwVD0HWWorODM2/0sju1GR4x4FeriY9teyjS82jIMIAT
         lSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783150758; x=1783755558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQKO9bqpFCzv41g7UYTqgpDpXTiS0DtpcAW+BBuDTlY=;
        b=RXkBd/46XG3wZ8cGbb1c/Ml3IY7NPloj46VYlvg9dfTdv+DVzMPSERIWzySJsu5sN/
         jdGwWobKYFi009UWAoLg2ekVAjyAu9vQ8d827Tpb3Jn95piDxAcUNvlF4+mkBhlrO5d5
         cEQiMt+AKmbIC+q9xagrdVJmBK9KJPefhsKJRnfQ6z4T1S2gjQ3dFwCr3sQoPcrzTGKJ
         1jv/lK+Pc9wZzHB9eit/Tr+6zZG078GMYz5tJe4pTM50xpOVM2W6RG73a54v8Md5OoMx
         tOPV/Xnxf//e3pc+qA9yGquQ21Yt+vlCTti8UGPFITEpjYHR+wxJYf1jg8ABasqn0GJx
         1h4w==
X-Forwarded-Encrypted: i=1; AFNElJ/9AsbdgNiWa4vf85El8wkVoLnIsJB8a7I+JJFCtoBfWzJIyzFG/1pjF5lZ4AMKsuq6NAY9agClFqUB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Atjt7r4xPx6ZSHycET+N46JJnVrbbVHSz+vW7+3fobWt74k0
	adUSNTIWOV/ECZGK5Yi8WLnMoriP6HoCGNoV+OxsOVQF7HJZr846xGVx
X-Gm-Gg: AfdE7ckR2/rDiV+dGvP8r5OwFmUfJfRXniadvF/9XR7ax/Lj14nVkcQ9Xb76GMkMGI3
	jHflGgXbh3Py6aW9VEPe9VPDIFQzvSjchIHPgaO7MPUQAURX60uHJMdUIeDbN52CHlqC/K411DA
	KJcdphRHm5EJra5meJm4YBB/A4J/fgJFZ6SFXSaLKX9XIEaNOgoGIYuWOTYP0AgVxkeErJKQKd1
	TLlUQSXv6WtH9qD2xltD9GIV6IiefEOOKTt0j5owVfe6loYc/zqL2Rl2brURMtGFwLpKJ7Wbmgn
	HjKhLkFHDB8/SY7/vF7GGcAtwUjqFPs+NneLBsysFUVEWqficNteIdQAkJgHkE9XFMlP8rwSAdX
	N0g5gcoX5pQjmUTEXaG1rGCVzKN1KGc1YNW3IIur+F/4Dxde+E9YHF7cdu8ysG4NlfT4km4/7Ov
	KtwHjXDi4mwgul2yTXKgLeFaNxA0UgguUpIg==
X-Received: by 2002:a05:600c:4e8e:b0:493:b783:ad59 with SMTP id 5b1f17b1804b1-493d313d048mr9738845e9.14.1783150758313;
        Sat, 04 Jul 2026 00:39:18 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm6565488f8f.7.2026.07.04.00.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 00:39:17 -0700 (PDT)
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
Subject: [PATCH 2/5] phy: cpcap-usb: add DCP detection and make UART idle mode optional
Date: Sat,  4 Jul 2026 10:38:40 +0300
Message-Id: <20260704073843.1750458-3-ivo.g.dimitrov.75@gmail.com>
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

Handle DCP separately from USB host connections based on CPCAP charger
detection status.

Make the existing idle UART mode optional via the "enable_uart" module
parameter. When disabled, the PHY remains in its USB/charger detection
configuration while idle. This reduces power usage in idle by 25mW.

Also initialize the PHY into the baseline configuration required for
reliable charger detection during probe.

Note: Enabling UART idle mode increases idle power consumption.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 235 ++++++++++++++++++++++-----
 1 file changed, 191 insertions(+), 44 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index c6cc8fce6940..3be2b3afaaf4 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -111,6 +111,14 @@ enum cpcap_gpio_mode {
 	CPCAP_OTG_DM_DP,
 };
 
+enum cpcap_mode {
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
@@ -125,10 +133,13 @@ struct cpcap_phy_ddata {
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
@@ -176,6 +187,7 @@ static int cpcap_phy_get_ints_state(struct cpcap_phy_ddata *ddata,
 
 	s->id_ground = val & BIT(15);
 	s->id_float = val & BIT(14);
+	s->chrg_det = val & BIT(13);
 	s->vbusov = val & BIT(11);
 
 	error = regmap_read(ddata->reg, CPCAP_REG_INTS2, &val);
@@ -197,8 +209,9 @@ static int cpcap_phy_get_ints_state(struct cpcap_phy_ddata *ddata,
 	return 0;
 }
 
-static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata);
+static int cpcap_usb_set_idle_mode(struct cpcap_phy_ddata *ddata);
 static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata);
+static int cpcap_usb_set_dcp_mode(struct cpcap_phy_ddata *ddata);
 
 static void cpcap_usb_try_musb_mailbox(struct cpcap_phy_ddata *ddata,
 				       enum musb_vbus_id_status status)
@@ -229,7 +242,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 	vbus = cpcap_usb_vbus_valid(ddata);
 
 	/* We need to kick the VBUS as USB A-host */
-	if (s.id_ground && ddata->vbus_provider) {
+	if (s.id_ground && ddata->mode == CPCAP_USB_HOST) {
 		dev_dbg(ddata->dev, "still in USB A-host mode, kicking VBUS\n");
 
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
@@ -244,7 +257,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 		return;
 	}
 
-	if (vbus && s.id_ground && ddata->docked) {
+	if (vbus && s.id_ground && ddata->mode == CPCAP_DOCK) {
 		dev_dbg(ddata->dev, "still docked as A-host, signal ID down\n");
 
 		cpcap_usb_try_musb_mailbox(ddata, MUSB_ID_GROUND);
@@ -253,10 +266,10 @@ static void cpcap_usb_detect(struct work_struct *work)
 	}
 
 	/* No VBUS needed with docks */
-	if (vbus && s.id_ground && !ddata->vbus_provider) {
+	if (vbus && s.id_ground && ddata->mode != CPCAP_USB_HOST) {
 		dev_dbg(ddata->dev, "connected to a dock\n");
 
-		ddata->docked = true;
+		ddata->mode = CPCAP_DOCK;
 
 		error = cpcap_usb_set_usb_mode(ddata);
 		if (error)
@@ -275,10 +288,10 @@ static void cpcap_usb_detect(struct work_struct *work)
 		return;
 	}
 
-	if (s.id_ground && !ddata->docked) {
+	if (s.id_ground && ddata->mode != CPCAP_DOCK) {
 		dev_dbg(ddata->dev, "id ground, USB host mode\n");
 
-		ddata->vbus_provider = true;
+		ddata->mode = CPCAP_USB_HOST;
 
 		error = cpcap_usb_set_usb_mode(ddata);
 		if (error)
@@ -296,36 +309,53 @@ static void cpcap_usb_detect(struct work_struct *work)
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
+	/* Check if we're connected to a USB host */
+	if (vbus && ddata->mode != CPCAP_USB_HOST) {
+		if (!s.chrg_det || !s.sessvld || ddata->mode != CPCAP_IDLE)
+			return;
+
+		if (s.se1)
+			ddata->mode = CPCAP_CHARGER;
+		else if (!s.dm && !s.dp)
+			ddata->mode = CPCAP_USB;
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
+		if (ddata->mode == CPCAP_CHARGER)
+			error = cpcap_usb_set_dcp_mode(ddata);
+		else
+			error = cpcap_usb_set_usb_mode(ddata);
+
+		if (error)
+			goto out_err;
+
+		if (ddata->mode == CPCAP_USB)
+			cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_VALID);
 
 		return;
 	}
 
-	ddata->vbus_provider = false;
-	ddata->docked = false;
+	if (ddata->mode == CPCAP_IDLE)
+		return;
+
+	ddata->mode = CPCAP_IDLE;
 	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
 
-	/* Default to debug UART mode */
-	error = cpcap_usb_set_uart_mode(ddata);
+	error = cpcap_usb_set_idle_mode(ddata);
 	if (error)
 		goto out_err;
 
-	dev_dbg(ddata->dev, "set UART mode\n");
-
 	return;
 
 out_err:
@@ -374,7 +404,7 @@ static const char * const cpcap_phy_irqs[] = {
 	"id_ground", "id_float",
 
 	/* REG_INT1 */
-	"se0conn", "vbusvld", "sessvld", "sessend", "se1",
+	"se0conn", "vbusvld", "sessvld", "sessend", "chrg_det",
 
 	/* REG_INT_3 */
 	"dm", "dp",
@@ -412,9 +442,10 @@ static int cpcap_usb_gpio_set_mode(struct cpcap_phy_ddata *ddata,
 	return 0;
 }
 
-static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
+static int cpcap_usb_set_idle_mode(struct cpcap_phy_ddata *ddata)
 {
 	int sysrq, error;
+	unsigned int val;
 
 	/* Disable sysrq to prevent random sysrq events on line glitches */
 	sysrq = sysrq_mask();
@@ -426,30 +457,52 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 	if (error)
 		goto out_err;
 
-	if (ddata->pins_uart) {
-		error = pinctrl_select_state(ddata->pins, ddata->pins_uart);
+	if (cpcap_enable_uart && ddata->pins_uart) {
+		error = pinctrl_select_state(ddata->pins,  ddata->pins_uart);
+		if (error)
+			goto out_err;
+	} else if (!cpcap_enable_uart && ddata->pins_ulpi) {
+		error = pinctrl_select_state(ddata->pins, ddata->pins_ulpi);
 		if (error)
 			goto out_err;
 	}
 
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
+	if (cpcap_enable_uart)
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
+	if (!cpcap_enable_uart)
+		val |= CPCAP_BIT_SUSPEND_SPI;
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3, 0x7fff, val);
 	if (error)
 		goto out_err;
 
-	/* Enable UART mode */
 	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
 	if (error)
 		goto out_err;
@@ -457,6 +510,8 @@ static int cpcap_usb_set_uart_mode(struct cpcap_phy_ddata *ddata)
 	if (sysrq & 1)
 		sysrq_toggle_support(sysrq);
 
+	dev_dbg(ddata->dev, "set %s mode\n", cpcap_enable_uart ? "UART" : "IDLE");
+
 	return 0;
 
 out_err:
@@ -517,6 +572,42 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
 	return error;
 }
 
+static int cpcap_usb_set_dcp_mode(struct cpcap_phy_ddata *ddata)
+{
+	int error = 0;
+
+	/* Disable lines to prevent glitches from waking up mdm6600 */
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
+	if (error)
+		return error;
+
+	if (ddata->pins_ulpi) {
+		error = pinctrl_select_state(ddata->pins, ddata->pins_ulpi);
+		if (error) {
+			dev_err(ddata->dev, "could not set usb mode: %i\n",
+				error);
+
+			return error;
+		}
+	}
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
@@ -546,9 +637,6 @@ static int cpcap_usb_init_optional_pins(struct cpcap_phy_ddata *ddata)
 		ddata->pins_uart = NULL;
 	}
 
-	if (ddata->pins_uart)
-		return pinctrl_select_state(ddata->pins, ddata->pins_uart);
-
 	return 0;
 }
 
@@ -601,6 +689,65 @@ static int cpcap_usb_init_iio(struct cpcap_phy_ddata *ddata)
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
+	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
+	if (error)
+		return error;
+
+	if (ddata->pins_ulpi) {
+		error = pinctrl_select_state(ddata->pins, ddata->pins_ulpi);
+		if (error)
+			return error;
+	}
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
@@ -678,6 +825,10 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 	if (error)
 		goto out_reg_disable;
 
+	error = cpcap_usb_init_usb(ddata);
+	if (error)
+		goto out_reg_disable;
+
 	error = cpcap_usb_init_interrupts(pdev, ddata);
 	if (error)
 		goto out_reg_disable;
@@ -697,13 +848,9 @@ static int cpcap_usb_phy_probe(struct platform_device *pdev)
 static void cpcap_usb_phy_remove(struct platform_device *pdev)
 {
 	struct cpcap_phy_ddata *ddata = platform_get_drvdata(pdev);
-	int error;
 
 	atomic_set(&ddata->active, 0);
-	error = cpcap_usb_set_uart_mode(ddata);
-	if (error)
-		dev_err(ddata->dev, "could not set UART mode\n");
-
+	cpcap_usb_set_idle_mode(ddata);
 	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
 
 	usb_remove_phy(&ddata->phy);
-- 
2.25.1

