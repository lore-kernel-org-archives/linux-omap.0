Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505235;
	b=0mRXsm2c5VdgwP7H77Qh0yKDL4su27OX0GCEFLx5YuBacnqKRPReNCxLUKVjMPDIgDT+
	 Zb8femhqzsN/41tiy2z4fZc5Tap66cWuhYWYE1yXTG+2h/SfZ55mMPPQupaHu2MCNtoop
	 JjqBUaLwP0FSyl7UG9Bt/nnl6uUl8/5KsP+Pxh0VvENJjW0rbHUB1Lnc06C+HxiWfb5pD
	 sCHFaeSdMukLy/FBttEoWXVplUiDtsmChc4Hp4FeLYErlGo3w8+taHWN1dF+2PIKTJofy
	 iB5krrPHkC3uouptWquS3svD0Q8cOEDXhEytcpxtZkHp6vi5I1kuPpj04sLPWXfQBxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505235;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=67aLzPuaMmDFfWDyNoWW5TsjU4yXJ/VPq9hnhXSFy/w=;
	b=zaUtiJ3NHbxn5FChpSZvyUVlS1+DMDIRSEm4oB5fEFs5bu32SyxZNAtcc0V0v545VjBY
	 KVby7NciE6S3Z8XkL1btbjDhm/DvUQNm3e5tAYDqYlsTvf0dHQsRtQo3eTupbJfOhJBqL
	 ZDL/pjZ/zqZ3r6wnBZVvUFxWO1HQqPsw435AXIyODF+hCboFcIeHRwI7ffZSxf1vImcOX
	 mzs/EIIa3HBLJhQ2nEyF/t358eV3qf+SC8YILKoNRbK2d+fErpFdb0gXSgKq3z1V76s81
	 CmrwHRZ0nrvIb7ZXYLtjn6y156buZxMOaInI4IMfLXPiIWIq/3G11K7hLM78X1rOnAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AOeNipam;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7SG8wQ+y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.175
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166360A6F70;
	Tue, 24 Nov 2026 07:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A166360A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AOeNipam;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7SG8wQ+y
ARC-Seal: i=1; a=rsa-sha256; t=1795505167; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RkMBEtRV76ezBsZ3HhSHbzoHzbBEvZGpa18c+YXemkGc6KKy+4UQeIH2wUBQY9trPL
    xMmvVvcY2r1W9RSJvoDyW5lCetbr5gRjlX0Ao/JwK+q4mL8lcAzKp8jXhmJjeMULJyEO
    6Dv1MlLzkGGvpIqWmIEURgGI4OKzjwy1k+cJ7m0Nm2sxxnkaGL4RqXSqlyu0UTHBLgLF
    Fiofc/HoiTQP/EpX9tQA6ZkyvJGL0SjHqNuQLkVsWyQIvc6G9u3a9vU/5mCSjFirlkUs
    SiaVj5WWcobAJqWGAMe4jEeZ2nqYjbZNSymw47EIYhOu2F7Uk0c2IkMhQvDbRNONBiLV
    hHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505167;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=67aLzPuaMmDFfWDyNoWW5TsjU4yXJ/VPq9hnhXSFy/w=;
    b=g5nAowB9p9JGk50H8nmJpjiJztoCjdrDUdQ4QTXrj4ohV4N0Oowp7MSJsg8lOSB0AM
    1PBa0EphO7qORhxzcyiq1jsqnper93a4hwXrVdgLKpY+uN6B3d1FY1AIzCnm8M7CNuRN
    /Xckh6RbUcDiq0/KkSVVRT5nfGa3oWJ2ED5piusqMudYBJhoer8AyXgiQKQ/i8tGKL9w
    RI373Mk10wKRHLlio7YSNnYfFijwAjORtTzxyaZDcwCKVs5RxiRsGrkesinopA7ctZZy
    /wQjM7bMzfTcgKGWggIxvd9vHN5f0oD64x4o6/OyZepCl29RQYsaT/tdb7mF2OLVu10S
    1FpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505167;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=67aLzPuaMmDFfWDyNoWW5TsjU4yXJ/VPq9hnhXSFy/w=;
    b=AOeNipamJ3BL9FZyoAF5T+AR3h9v2fQizmfp/dNC6lrP/haFiVTMtwzn5uDMthpb8y
    5+q8Khz7igyxMZgCSI4mmwDSlI4de3t9yPghojSiLd8/6VbsgZcMvbe3v0L99DD1QN1G
    VFY40cEwKAk4iENu4ZfNYRWrfgCspK9v2o6Ebj1mtIoiehr8pttqi3H3lbTm0vTV67j+
    Q2dBmRaYgWMMGyx7pSfQBGcUgMvbvPKbb0rkOcAlk6BxXIzOeP8EQuXpcqr5An//WANh
    w2optfo94JRCSzeh7O4bT3Rs8dyiHtIyWctUaSMEddGGBkf6p3npBMVqU1rIXIzw7XUa
    LHng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505167;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=67aLzPuaMmDFfWDyNoWW5TsjU4yXJ/VPq9hnhXSFy/w=;
    b=7SG8wQ+ykXZjieAA/6BXSEfGAuFRUlotUxnogLT/+FWGwFG37+fbBHOoEEbuw4jYb9
    AJwCWO62V9p2NKot56Ag==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7Q61HD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:06 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 02/20] gpio: twl4030: Support REGEN GPIO
Date: Tue, 24 Nov 2026 08:25:42 +0100
Message-ID: <5fe8b5155067e0b1fc9b34c53e3b89a40e53234c.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Allow the TWL4030 GPIO controller to expose REGEN as an additional,
output-only GPIO when enabled by the ti,use-regen device tree property.

Unlike the ordinary GPIO lines, REGEN is controlled through the TWL4030
power-management registers. Keep it optional so that existing users of
the GPIO controller retain their GPIO numbering and behaviour.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Follow Mark Brown's V1 review of the regulator implementation:
      REGEN is a control signal, not a voltage regulator.
    - Clarify that REGEN is controlled by power-management registers and
      does not require enabling the GPIO module.
    - Use WARN_ON_ONCE(true) for the impossible GPIO offset and clarify
      that LED and REGEN outputs cannot be inputs.
    - Expand the commit message to describe the opt-in output-only GPIO.
    - Reject unavailable LED offsets when only REGEN extends ngpio;
      do not report a successful GPIO request for reserved lines.
    - Address checkpatch style findings (braces, wrapping and alignment).
    - Ignore the checkpatch recommendation to use EOPNOTSUPP instead of
      ENOTSUPP in the GPIO set_config callback. Gpiolib treats ENOTSUPP
      as an unsupported optional configuration; EOPNOTSUPP propagates
      as an error and prevents fixed-regulator GPIO setup on Pandora.
    - Code and commit-message review assisted by ChatGPT.

 drivers/gpio/gpio-twl4030.c | 185 ++++++++++++++++++++++++++++++++----
 include/linux/mfd/twl.h     |   3 +
 2 files changed, 169 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 3e06ef9e22336..30ac6f7e0e56a 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -37,6 +37,20 @@
  * There are also two LED pins used sometimes as output-only GPIOs.
  */
 
+#define TWL4030_GPIO_LED_A		TWL4030_GPIO_MAX
+#define TWL4030_GPIO_LED_B		(TWL4030_GPIO_MAX + 1)
+#define TWL4030_GPIO_REGEN		(TWL4030_GPIO_MAX + 2)
+
+/* PM_RECEIVER: REGEN_DEV_GRP */
+#define TWL4030_REGEN_DEV_GRP		0x7f
+#define TWL4030_REGEN_DEV_GRP_P1	BIT(5)
+#define TWL4030_REGEN_DEV_GRP_P2	BIT(6)
+#define TWL4030_REGEN_DEV_GRP_P3	BIT(7)
+
+/* POWERPM_RECEIVER: DC/DC_GLOBAL_CFG */
+#define TWL4030_DC_DC_GLOBAL_CFG	0x06
+#define TWL4030_REGEN_PU_DISABLE	BIT(5)
+
 /* genirq interfaces are not available to modules */
 #ifdef MODULE
 #define is_module()	true
@@ -136,6 +150,79 @@ static int twl4030_led_set_value(int led, int value)
 				TWL4030_LED_LEDEN_REG);
 }
 
+static int twl4030_regen_get(void)
+{
+	u8 value;
+	int ret;
+
+	ret = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &value,
+			      TWL4030_REGEN_DEV_GRP);
+	if (ret < 0)
+		return ret;
+
+	return !!(value & TWL4030_REGEN_DEV_GRP_P1);
+}
+
+static int twl4030_regen_set(int value)
+{
+	u8 reg;
+	int ret;
+
+	ret = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &reg,
+			      TWL4030_REGEN_DEV_GRP);
+	if (ret < 0)
+		return ret;
+
+	if (value)
+		reg |= TWL4030_REGEN_DEV_GRP_P1;
+	else
+		reg &= ~(TWL4030_REGEN_DEV_GRP_P1 |
+			 TWL4030_REGEN_DEV_GRP_P2 |
+			 TWL4030_REGEN_DEV_GRP_P3);
+
+	return twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, reg,
+				TWL4030_REGEN_DEV_GRP);
+}
+
+static int twl4030_regen_set_pullup(bool enable)
+{
+	u8 value;
+	int ret;
+
+	ret = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &value,
+			      TWL4030_DC_DC_GLOBAL_CFG);
+	if (ret < 0)
+		return ret;
+
+	if (enable)
+		value &= ~TWL4030_REGEN_PU_DISABLE;
+	else
+		value |= TWL4030_REGEN_PU_DISABLE;
+
+	return twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, value,
+				TWL4030_DC_DC_GLOBAL_CFG);
+}
+
+static int twl4030_set_config(struct gpio_chip *chip,
+			      unsigned int offset, unsigned long config)
+{
+	unsigned int param;
+
+	if (offset != TWL4030_GPIO_REGEN)
+		return -ENOTSUPP;
+
+	param = pinconf_to_config_param(config);
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return twl4030_regen_set_pullup(true);
+	case PIN_CONFIG_BIAS_DISABLE:
+		return twl4030_regen_set_pullup(false);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
 static int twl4030_set_gpio_direction(int gpio, int is_input)
 {
 	u8 d_bnk = gpio >> 3;
@@ -144,6 +231,9 @@ static int twl4030_set_gpio_direction(int gpio, int is_input)
 	u8 base = REG_GPIODATADIR1 + d_bnk;
 	int ret = 0;
 
+	if (gpio >= TWL4030_GPIO_MAX)
+		return -EINVAL;
+
 	ret = gpio_twl4030_read(base);
 	if (ret >= 0) {
 		if (is_input)
@@ -211,8 +301,16 @@ static int twl_request(struct gpio_chip *chip, unsigned offset)
 
 	mutex_lock(&priv->mutex);
 
+	/*
+	 * REGEN is controlled through the power-management registers
+	 * and does not require enabling the GPIO module.
+	 */
+	if (offset == TWL4030_GPIO_REGEN)
+		goto done;
+
 	/* Support the two LED outputs as output-only GPIOs. */
-	if (offset >= TWL4030_GPIO_MAX) {
+	if (offset >= TWL4030_GPIO_LED_A &&
+	    offset <= TWL4030_GPIO_LED_B) {
 		u8	ledclr_mask = LEDEN_LEDAON | LEDEN_LEDAEXT
 				| LEDEN_LEDAPWM | LEDEN_PWM_LENGTHA;
 		u8	reg = TWL4030_PWMAON_REG;
@@ -249,6 +347,15 @@ static int twl_request(struct gpio_chip *chip, unsigned offset)
 		goto done;
 	}
 
+	/*
+	 * Offsets 18/19 are reserved for the optional LEDs.  If the LEDs
+	 * aren't enabled, they must not be treated as LED GPIOs.
+	 */
+	if (offset >= TWL4030_GPIO_MAX) {
+		status = -EINVAL;
+		goto done;
+	}
+
 	/* on first use, turn GPIO module "on" */
 	if (!priv->usage_count) {
 		struct twl4030_gpio_platform_data *pdata;
@@ -277,8 +384,18 @@ static void twl_free(struct gpio_chip *chip, unsigned offset)
 	struct gpio_twl4030_priv *priv = gpiochip_get_data(chip);
 
 	mutex_lock(&priv->mutex);
+	if (offset == TWL4030_GPIO_REGEN)
+		goto out;
+
+	if (offset >= TWL4030_GPIO_LED_A &&
+	    offset <= TWL4030_GPIO_LED_B) {
+		WARN_ON_ONCE(twl4030_led_set_value(offset -
+				TWL4030_GPIO_LED_A, 1));
+		goto out;
+	}
+
 	if (offset >= TWL4030_GPIO_MAX) {
-		WARN_ON_ONCE(twl4030_led_set_value(offset - TWL4030_GPIO_MAX, 1));
+		WARN_ON_ONCE(true);
 		goto out;
 	}
 
@@ -301,7 +418,7 @@ static int twl_direction_in(struct gpio_chip *chip, unsigned offset)
 	if (offset < TWL4030_GPIO_MAX)
 		ret = twl4030_set_gpio_direction(offset, 1);
 	else
-		ret = -EINVAL;	/* LED outputs can't be set as input */
+		ret = -EINVAL; /* LED and REGEN outputs cannot be inputs */
 
 	if (!ret)
 		priv->direction &= ~BIT(offset);
@@ -323,10 +440,14 @@ static int twl_get(struct gpio_chip *chip, unsigned offset)
 		goto out;
 	}
 
-	if (priv->direction & BIT(offset))
+	if (offset == TWL4030_GPIO_REGEN)
+		status = twl4030_regen_get();
+	else if (priv->direction & BIT(offset))
 		status = priv->out_state & BIT(offset);
-	else
+	else if (offset < TWL4030_GPIO_MAX)
 		status = twl4030_get_gpio_datain(offset);
+	else
+		status = -EINVAL;
 
 	ret = (status < 0) ? status : !!status;
 out:
@@ -342,13 +463,20 @@ static int twl_set(struct gpio_chip *chip, unsigned int offset, int value)
 	mutex_lock(&priv->mutex);
 	if (offset < TWL4030_GPIO_MAX)
 		ret = twl4030_set_gpio_dataout(offset, value);
+	else if (offset >= TWL4030_GPIO_LED_A &&
+		 offset <= TWL4030_GPIO_LED_B)
+		ret = twl4030_led_set_value(offset - TWL4030_GPIO_LED_A, value);
+	else if (offset == TWL4030_GPIO_REGEN)
+		ret = twl4030_regen_set(value);
 	else
-		ret = twl4030_led_set_value(offset - TWL4030_GPIO_MAX, value);
+		ret = -EINVAL;
 
-	if (value)
-		priv->out_state |= BIT(offset);
-	else
-		priv->out_state &= ~BIT(offset);
+	if (!ret) {
+		if (value)
+			priv->out_state |= BIT(offset);
+		else
+			priv->out_state &= ~BIT(offset);
+	}
 
 	mutex_unlock(&priv->mutex);
 
@@ -361,21 +489,29 @@ static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
 	int ret = 0;
 
 	mutex_lock(&priv->mutex);
+
 	if (offset < TWL4030_GPIO_MAX) {
 		ret = twl4030_set_gpio_direction(offset, 0);
-		if (ret) {
-			mutex_unlock(&priv->mutex);
-			return ret;
-		}
+		if (ret)
+			goto out;
+	} else if (offset == TWL4030_GPIO_REGEN) {
+		/* REGEN is an output-only signal. */
+	} else if (offset >= TWL4030_GPIO_LED_A &&
+		   offset <= TWL4030_GPIO_LED_B) {
+		/* LED GPIOs are output-only. */
+	} else {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	/*
-	 *  LED gpios i.e. offset >= TWL4030_GPIO_MAX are always output
-	 */
-
 	priv->direction |= BIT(offset);
+
+out:
 	mutex_unlock(&priv->mutex);
 
+	if (ret)
+		return ret;
+
 	return twl_set(chip, offset, value);
 }
 
@@ -395,7 +531,14 @@ static int twl_get_direction(struct gpio_chip *chip, unsigned offset)
 			mutex_unlock(&priv->mutex);
 			return ret;
 		}
+	} else if (offset == TWL4030_GPIO_REGEN ||
+		   (offset >= TWL4030_GPIO_LED_A &&
+		    offset <= TWL4030_GPIO_LED_B)) {
+		ret = GPIO_LINE_DIRECTION_OUT;
+	} else {
+		ret = -EINVAL;
 	}
+
 	mutex_unlock(&priv->mutex);
 
 	return ret;
@@ -420,6 +563,7 @@ static const struct gpio_chip template_chip = {
 	.get_direction		= twl_get_direction,
 	.get			= twl_get,
 	.set			= twl_set,
+	.set_config		= twl4030_set_config,
 	.to_irq			= twl_to_irq,
 	.can_sleep		= true,
 };
@@ -478,6 +622,7 @@ static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
 
 	omap_twl_info->use_leds = of_property_read_bool(dev->of_node,
 			"ti,use-leds");
+	omap_twl_info->use_regen = of_property_read_bool(dev->of_node, "ti,use-regen");
 
 	of_property_read_u32(dev->of_node, "ti,debounce",
 			     &omap_twl_info->debounce);
@@ -567,7 +712,9 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 	 * is (still) clear if use_leds is set.
 	 */
 	if (pdata->use_leds)
-		priv->gpio_chip.ngpio += 2;
+		priv->gpio_chip.ngpio = TWL4030_GPIO_LED_B + 1;
+	if (pdata->use_regen)
+		priv->gpio_chip.ngpio = TWL4030_GPIO_REGEN + 1;
 
 	ret = devm_gpiochip_add_data(&pdev->dev, &priv->gpio_chip, priv);
 	if (ret < 0) {
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index 238d9dcefc358..9cceb4fe6c12e 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -560,6 +560,9 @@ struct twl4030_gpio_platform_data {
 	/* package the two LED signals as output-only GPIOs? */
 	bool		use_leds;
 
+	/* Expose the REGEN signal as an output-only GPIO. */
+	bool		use_regen;
+
 	/* gpio-n should control VMMC(n+1) if BIT(n) in mmc_cd is set */
 	u8		mmc_cd;
 
-- 
2.56.0

