Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795505223;
	b=JnWRsWHMCC1UrrHr9et0yNAeAnyyNVr8JyP7uHE69y6qnxEBHNvP/6gJToq1Yda7zt04
	 kELy79v36r0GNYF0wCiebR+xS+ckmawF7rfS7Z83ib7ty44vqSaMTlQzuhTOHcqmQctLx
	 aqhlVskkmim2o3sXOb5UrbMtENryMOk+NPPCU1rqyaN2qZgL5fxo7aqYjvJueJEYEr172
	 YzDDAxpDSi2ZzmQpABUhP+TGLjY3lJqmEgaRKQ3MEs3xwuWmcc97A+oizbH1oZ/ZXNtvR
	 lcYselnJFAryhFyYF4wy/oqlkSNflfg5Ty8vAsc7XzcON3gB+WsCh4yTn/tj4jAQx0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505223;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d/XWg+z+3driH60oKg1jDoiUHNLVCm4AplbKyR0sUbM=;
	b=hWWoA5sy+tvu7jJl+NGEGSmIy0hlgX5TfS4NxRztnhvBW17yjAYXSFnho2aYV77sudnI
	 lc2O5VcHLvEaOycs6abNhuZ2ba4WaQ465KM2qiwZ029psPryS9CGQd2N9m5ooWAJmLQq1
	 Lp8kEwKaKRCDsK0Q7KTuCNPreXWvp+z84n/vt5GilJ+Y9HQlH9aaA0bHDl/iEH8BBoJqb
	 dKb859DcGCBxa92WSMw2zKkosekgSmmEg7e8SWkmHFXfNBf3wbdCCYYXW3EX0VdsQsuCl
	 +uqDardhArqW/z9UihOcnt5fQzGThFnLWMK9dpfdEiktj0osTzXKnJZj8NRidHyA2yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EBSkkM5y;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6IXrjucF;
	arc=fail smtp.remote-ip=81.169.146.177
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DD606A33C;
	Tue, 24 Nov 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B1DD606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EBSkkM5y;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6IXrjucF
ARC-Seal: i=1; a=rsa-sha256; t=1795505186; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AS9oXN5tsyXXd3U9WEVXr3jzIoOIwhGyA+Z5/H/QsuJvocdfDLuNXt+lF4dw5TOo6f
    3oU+qAlrpxFceh8q5rI3/8HKdKKzMmwTxzQqxsP6lbpMrQHfROrfOkdFQkAx+KU6yYQq
    HsruygDtVofAZIZLz+aBLt+0BC9du+UlPNOITeVBWb69McMV8679NdJl5h8br8Ulvmgq
    yxeJ4nw8Vq9KrkptCchbQ6aABrJdDpZM3ETLE0K8bEZToAl0yBYpLT6NClQkCN9kPI9y
    H+Hl0P5aXv/Yu9CEypS80Rla0aQji6t/IN4kgKEnLUDtQ9ZxKVuzVteE2F0G8XDnYoSP
    geFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505186;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=d/XWg+z+3driH60oKg1jDoiUHNLVCm4AplbKyR0sUbM=;
    b=C7GFpg4fmQ8v+KL0rIqMa6Nisk74GQZFmY6acThHF1MMiutn8d7c4+ULnreDYGGIJj
    TvRLC2rpFyAliI1p8RlaMr5RqQoDPxRNjoyloJZ2aUFFfm3r3PpopvEjKFPo9cIt9GlW
    AgmkbwGOGxOSTSTk8fBXE68ELTDNoeEyC0rjhWaEQw7IjFH5TOFyI/gG+biUJsxrQV7H
    uqrYguv7f39dbC/TIIMKfqxoMMLHT9/u4co/2wvODDFUSQMkCa4MOmFej0Oizb1o5fO+
    pIpbQg6KwlyewCpxDk4olHujyDtuUH+v4kz0s5qqqrVDIX/07qeYvMNu4TApf86VC9TX
    l6Lg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505186;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=d/XWg+z+3driH60oKg1jDoiUHNLVCm4AplbKyR0sUbM=;
    b=EBSkkM5yKvYGwF2v1DFNuZHwdJwTR9rFIneuFbamTLUnlgeVnphMAmt6XWXTUNrEe3
    Z1zR7NSAt4ZnzG4L83roOk/IT0OlwIUu+fkR2xO74KzNUDO3t2JEZyaL89vtXNMfqCWl
    m8Uxoy9uc29ryTZcK9Rfq8MFCRTWUvGUMdJIUG+deKrw4Zj/ZBjTeMXzHhaodV2hMBDL
    ayzgKzYnsJA3Q1BAfHdaLfOpalg5oJ8yktV5WPtE79DXaEcUjJyXGtTvoHHlSG5BjdOD
    xedjmZ5ScSNtg/sBVgwJXRmY8lOVqQExHW9ytB5AR0viCqy45lzPSltq2V8bNeiiZErQ
    1uRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505186;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=d/XWg+z+3driH60oKg1jDoiUHNLVCm4AplbKyR0sUbM=;
    b=6IXrjucF3IPHUcmaUIJSpxa5icjMafAAhdlobGZrizciH/X1yYPtp+Xu5LzOElTpA/
    RszQ9kCHh4ZnvWZvHIBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7QO1HX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:24 +0100 (CET)
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
Subject: [PATCH v2 19/20] backlight: Remove legacy Pandora driver
Date: Tue, 24 Nov 2026 08:25:59 +0100
Message-ID: <41a3bded8cc0a65d90c7ca6f41438f5c78ee3586.1795505160.git.hns@goldelico.com>
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
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit

Remove the Pandora-specific backlight platform driver after its
functionality has been replaced by the TWL4030 PWM provider and the
generic pwm-backlight driver described in the device tree.

Remove its Kconfig and Makefile entries and the obsolete
omap2plus_defconfig selection.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Daniel Thompson gave Reviewed-by for the V1 removal of
      pandora_bl. V2 additionally removes the stale defconfig option;
      the old Reviewed-by is documented here, not carried as a tag.
    - Explain replacement by generic pwm-backlight and removal of the defconfig selection.
    - Commit-message review assisted by ChatGPT.

 arch/arm/configs/omap2plus_defconfig |   1 -
 drivers/video/backlight/Kconfig      |   7 --
 drivers/video/backlight/Makefile     |   1 -
 drivers/video/backlight/pandora_bl.c | 159 ---------------------------
 4 files changed, 168 deletions(-)
 delete mode 100644 drivers/video/backlight/pandora_bl.c

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5791953b75fff..ef5e8d1bf9da1 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -517,7 +517,6 @@ CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=m
-CONFIG_BACKLIGHT_PANDORA=m
 CONFIG_BACKLIGHT_GPIO=m
 CONFIG_BACKLIGHT_LED=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index dbf4ca23a9b6d..040e6cc7e5a29 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -459,13 +459,6 @@ config BACKLIGHT_MP3309C
 	  To compile this driver as a module, choose M here: the module will
 	  be called mp3309c.
 
-config BACKLIGHT_PANDORA
-	tristate "Backlight driver for Pandora console"
-	depends on TWL4030_CORE
-	help
-	  If you have a Pandora console, say Y to enable the
-	  backlight driver.
-
 config BACKLIGHT_SKY81452
 	tristate "Backlight driver for SKY81452"
 	depends on MFD_SKY81452
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 34469711c6cd9..c62c920e64b96 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
 obj-$(CONFIG_BACKLIGHT_MP3309C)		+= mp3309c.o
 obj-$(CONFIG_BACKLIGHT_MT6370)		+= mt6370-backlight.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
-obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
 obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
 obj-$(CONFIG_BACKLIGHT_RT4831)		+= rt4831-backlight.o
diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
deleted file mode 100644
index e6889e2ac55e1..0000000000000
--- a/drivers/video/backlight/pandora_bl.c
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Backlight driver for Pandora handheld.
- * Pandora uses TWL4030 PWM0 -> TPS61161 combo for control backlight.
- * Based on pwm_bl.c
- *
- * Copyright 2009,2012 Gražvydas Ignotas <notasas@gmail.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/backlight.h>
-#include <linux/mfd/twl.h>
-#include <linux/err.h>
-
-#define TWL_PWM0_ON		0x00
-#define TWL_PWM0_OFF		0x01
-
-#define TWL_INTBR_GPBR1		0x0c
-#define TWL_INTBR_PMBR1		0x0d
-
-#define TWL_PMBR1_PWM0_MUXMASK	0x0c
-#define TWL_PMBR1_PWM0		0x04
-#define PWM0_CLK_ENABLE		BIT(0)
-#define PWM0_ENABLE		BIT(2)
-
-/* range accepted by hardware */
-#define MIN_VALUE 9
-#define MAX_VALUE 63
-#define MAX_USER_VALUE (MAX_VALUE - MIN_VALUE)
-
-struct pandora_private {
-	unsigned old_state;
-#define PANDORABL_WAS_OFF 1
-};
-
-static int pandora_backlight_update_status(struct backlight_device *bl)
-{
-	int brightness = bl->props.brightness;
-	struct pandora_private *priv = bl_get_data(bl);
-	u8 r;
-
-	if (bl->props.power != BACKLIGHT_POWER_ON)
-		brightness = 0;
-	if (bl->props.state & BL_CORE_FBBLANK)
-		brightness = 0;
-	if (bl->props.state & BL_CORE_SUSPENDED)
-		brightness = 0;
-
-	if ((unsigned int)brightness > MAX_USER_VALUE)
-		brightness = MAX_USER_VALUE;
-
-	if (brightness == 0) {
-		if (priv->old_state == PANDORABL_WAS_OFF)
-			goto done;
-
-		/* first disable PWM0 output, then clock */
-		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_GPBR1);
-		r &= ~PWM0_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-		r &= ~PWM0_CLK_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-
-		goto done;
-	}
-
-	if (priv->old_state == PANDORABL_WAS_OFF) {
-		/*
-		 * set PWM duty cycle to max. TPS61161 seems to use this
-		 * to calibrate it's PWM sensitivity when it starts.
-		 */
-		twl_i2c_write_u8(TWL_MODULE_PWM, MAX_VALUE, TWL_PWM0_OFF);
-
-		/* first enable clock, then PWM0 out */
-		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_GPBR1);
-		r &= ~PWM0_ENABLE;
-		r |= PWM0_CLK_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-		r |= PWM0_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-
-		/*
-		 * TI made it very easy to enable digital control, so easy that
-		 * it often triggers unintentionally and disabes PWM control,
-		 * so wait until 1 wire mode detection window ends.
-		 */
-		usleep_range(2000, 10000);
-	}
-
-	twl_i2c_write_u8(TWL_MODULE_PWM, MIN_VALUE + brightness, TWL_PWM0_OFF);
-
-done:
-	if (brightness != 0)
-		priv->old_state = 0;
-	else
-		priv->old_state = PANDORABL_WAS_OFF;
-
-	return 0;
-}
-
-static const struct backlight_ops pandora_backlight_ops = {
-	.options	= BL_CORE_SUSPENDRESUME,
-	.update_status	= pandora_backlight_update_status,
-};
-
-static int pandora_backlight_probe(struct platform_device *pdev)
-{
-	struct backlight_properties props;
-	struct backlight_device *bl;
-	struct pandora_private *priv;
-	u8 r;
-
-	priv = devm_kmalloc_obj(&pdev->dev, *priv);
-	if (!priv)
-		return -ENOMEM;
-
-	memset(&props, 0, sizeof(props));
-	props.max_brightness = MAX_USER_VALUE;
-	props.type = BACKLIGHT_RAW;
-	bl = devm_backlight_device_register(&pdev->dev, pdev->name, &pdev->dev,
-					priv, &pandora_backlight_ops, &props);
-	if (IS_ERR(bl)) {
-		dev_err(&pdev->dev, "failed to register backlight\n");
-		return PTR_ERR(bl);
-	}
-
-	platform_set_drvdata(pdev, bl);
-
-	/* 64 cycle period, ON position 0 */
-	twl_i2c_write_u8(TWL_MODULE_PWM, 0x80, TWL_PWM0_ON);
-
-	priv->old_state = PANDORABL_WAS_OFF;
-	bl->props.brightness = MAX_USER_VALUE;
-	backlight_update_status(bl);
-
-	/* enable PWM function in pin mux */
-	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_PMBR1);
-	r &= ~TWL_PMBR1_PWM0_MUXMASK;
-	r |= TWL_PMBR1_PWM0;
-	twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_PMBR1);
-
-	return 0;
-}
-
-static struct platform_driver pandora_backlight_driver = {
-	.driver		= {
-		.name	= "pandora-backlight",
-	},
-	.probe		= pandora_backlight_probe,
-};
-
-module_platform_driver(pandora_backlight_driver);
-
-MODULE_AUTHOR("Gražvydas Ignotas <notasas@gmail.com>");
-MODULE_DESCRIPTION("Pandora Backlight Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pandora-backlight");
-- 
2.56.0

