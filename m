Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35A2DA768;
	Sat, 11 Jul 2026 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749768; cv=pass; b=ArVYasvBu/1Fc36xpvd8IjDl2GZl8GlMUAP8pHvEbybZzA1vm9WACJGVMr6T7rsl0DJHkrSuS22oiN/zp9TCx0zLC5JNg+Z19oXGZL71s73LSTEgFgM8Z29msDCo7EHSpn5x7rltTOctL92GWbie29AId9i1fM36bxXL7JdbAOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749768; c=relaxed/simple;
	bh=8U83B9LRk1dKj2Jnju2tX3sgdInfkKSVyP3e6vEm7A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vsg7ok2oya7ic8zckEXPcrBllGPBkXZ8ugu26Ead58mQi/z5s/3Cqv6qa+xhShv6ys3wtfLLnYsOQ/aMJPvTK+dAVWHzmnSSJXCLZiZVmnlgFvvrMyvVECqbhdaVh0cPFghwq3OraunQH06SeLPej8EzC7s7KtdSYiLXH0PHn/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=H0E6fUOI; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=o0YSAyo+; arc=pass smtp.client-ip=81.169.146.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="H0E6fUOI";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="o0YSAyo+"
ARC-Seal: i=1; a=rsa-sha256; t=1783749746; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g9M4gqJl1SHWv2ddnj27JmqGZPXr91e/K/2pnJNAEchnkCkPExHpVQbpPBr5hRQ3g8
    qDuN4k5maOCku7toQYWBo2QVzxOA+YZfM72g+2P0xzZtUcvR3YUHFAXrVfUmc6JMRfG3
    IuIM/Kehz89pN9CWDPSVVXQgxzS7m8dAPmawcyfonIwhV451+MtVxPLmtoHjFe01NwEs
    qibE+4iPhbm0R4HVd4pCw5ccdtYqGo/f59KKFGPh65gpg1arm8BfHk3QPfH4/4HKGomF
    JNz4hiKa9fUn5bQL8iQBbjN+iQEnIs4RMO9c+iiiU7e1joKaaSMrKBSiEhttavkXjUMh
    CPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749746;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7pA0TFC7UkEDXI5FUk59zdzYhP+mOINP0O+fHg17PO8=;
    b=FozWwp/sAiNBb0Vi3waIgup6pPUUKBANGqkq1yFyQATClVwnivdeT+iujS+w41DceP
    KmcbvodJ8dz085DHhYjYmLFmEoPj0/H42iM1pHoNSPh1R8G7ZbZ+yRItLikSL2MfhGff
    1Rhy8/5f3T1e5TxT1iuDyo9zQkm+KxA4nWqkPGiXeQd/P9QbOXCbO/pRBs/towBV62FH
    d55CLgTFTB1JqL2NRuXJIApZX2F7dSRuU/jZG1RFTYPKU6Ua9VkCeyaA8NEU90du6kJc
    nikb4byzkE2gxIG0DNwaEVpBfMczzxJIpg62ag8yBeWvPNGnAcdcwLv6hAlhatjtISa5
    PmiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749746;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7pA0TFC7UkEDXI5FUk59zdzYhP+mOINP0O+fHg17PO8=;
    b=H0E6fUOI+kXtvl2A2BrQrKmQMA7wJAlkBsexcdVWxwz2btf0WN9fY+v+U2YaSltr2W
    XLMTszlt7IJ3CY4YmdBUAyrJI/zz18XDsb7IddVY6Kn3lHm9JnFsDj50UB982jC/7HAr
    xCe2Wrp5bVtJD1BIn+z4wJLeQrBWihUu+p7LvCOUr2OlpBVZyr/VnacHDLUbkca7px/r
    9sBZdwK/vaSRmNEQrbWzLgVW+AKObAWBooN5BaNpBZfLaJnQvPJBouuOV35cdp94iXuG
    QaaqBiHzhakev6bvUronTMahQDRfBdXXMDfMCPY6MFEOIMIuWg1Ve45pbkAAdmqLQkD7
    CWgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749746;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7pA0TFC7UkEDXI5FUk59zdzYhP+mOINP0O+fHg17PO8=;
    b=o0YSAyo+ZlRrYAUyXkQ2aUg8Awuw7E4YNwmC7YQ62b8sLgqlZ/QhLRRf48RMtbtKsg
    43T3NehK34SoQdLmktBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62PGi1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:25 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>,
	Stefan Leichter <sle85276@gmx.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com,
	mfd@lists.linux.dev
Subject: [PATCH 15/16] backlight: remove pandora_bl
Date: Sat, 11 Jul 2026 08:02:02 +0200
Message-ID: <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit

Retire the platform specific pandora backlight driver since
it can now be replaced by twl_pm and device tree.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/video/backlight/Kconfig      |   7 --
 drivers/video/backlight/Makefile     |   1 -
 drivers/video/backlight/pandora_bl.c | 159 ---------------------------
 3 files changed, 167 deletions(-)
 delete mode 100644 drivers/video/backlight/pandora_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7aa1c4b21111f..a250b3edc152c 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -451,13 +451,6 @@ config BACKLIGHT_MP3309C
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
index 21c8313cfb121..f97ab8ba85807 100644
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
index 8a63ded0fa90f..0000000000000
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
-	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
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
2.50.1 (Apple Git-155)

