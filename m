From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/9] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
Date: Thu, 30 Aug 2012 17:52:30 -0700
Message-ID: <20120831005230.28732.1131.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17230 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab2HaAwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 20:52:36 -0400
In-Reply-To: <20120831004828.28732.902.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
the hardcoded gpio_base with twl_gpiochip.base after it's been
allocated.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    3 ---
 arch/arm/mach-omap2/board-3430sdp.c          |    3 ---
 arch/arm/mach-omap2/board-4430sdp.c          |    1 -
 arch/arm/mach-omap2/board-cm-t35.c           |    3 ---
 arch/arm/mach-omap2/board-devkit8000.c       |    3 ---
 arch/arm/mach-omap2/board-igep0020.c         |    3 ---
 arch/arm/mach-omap2/board-ldp.c              |    3 ---
 arch/arm/mach-omap2/board-omap3beagle.c      |    3 ---
 arch/arm/mach-omap2/board-omap3evm.c         |    3 ---
 arch/arm/mach-omap2/board-omap3logic.c       |    3 ---
 arch/arm/mach-omap2/board-omap3pandora.c     |    3 ---
 arch/arm/mach-omap2/board-omap3stalker.c     |    3 ---
 arch/arm/mach-omap2/board-omap3touchbook.c   |    3 ---
 arch/arm/mach-omap2/board-omap4panda.c       |    1 -
 arch/arm/mach-omap2/board-overo.c            |    3 ---
 arch/arm/mach-omap2/board-rm680.c            |    3 ---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    3 ---
 drivers/gpio/gpio-twl4030.c                  |   15 ++++++++++-----
 include/linux/i2c/twl.h                      |    3 ---
 include/linux/mfd/twl6040.h                  |    2 --
 21 files changed, 10 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 36eee4b..cacc498 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -211,9 +211,6 @@ static struct regulator_init_data sdp2430_vmmc1 = {
 };
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 };
 
 static struct twl4030_platform_data sdp2430_twldata = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index dac5cdf..5fd3934 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -229,9 +229,6 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(16) | BIT(17),
 	.setup		= sdp3430_twl_gpio_setup,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 04e8574..ee82604 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -543,7 +543,6 @@ static struct twl6040_platform_data twl6040_data = {
 	.codec		= &twl6040_codec,
 	.vibra		= &twl6040_vibra,
 	.audpwron_gpio	= 127,
-	.irq_base	= TWL6040_CODEC_IRQ_BASE,
 };
 
 static struct twl4030_platform_data sdp4430_twldata = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 6e20b82..ad83654 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -469,9 +469,6 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 }
 
 static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup          = cm_t35_twl_gpio_setup,
 };
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 214be52..d96eab5 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -235,9 +235,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pulldowns	= BIT(1) | BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 7a3e536..0b9677b 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -424,9 +424,6 @@ static int igep_twl_gpio_setup(struct device *dev,
 };
 
 static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= igep_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index dc41435..e85323c86 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -274,9 +274,6 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 }
 
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= ldp_twl_gpio_setup,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index d74eb37..b259713 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -296,9 +296,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data beagle_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pullups	= BIT(1),
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 64245bf..0470d44 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -387,9 +387,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= omap3evm_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index a63a49d..8fe7f0c 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -77,9 +77,6 @@ static struct regulator_init_data omap3logic_vmmc1 = {
 };
 
 static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pullups	= BIT(1),
 	.pulldowns	= BIT(2)  | BIT(6)  | BIT(7)  | BIT(8)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index d14b0cd..93c6109 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -320,9 +320,6 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= omap3pandora_twl_gpio_setup,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 2ec4802..465ee22 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -278,9 +278,6 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data omap3stalker_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= omap3stalker_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index b0516ec..ba657cd 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -138,9 +138,6 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data touchbook_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pullups	= BIT(1),
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 3911c13..e37ee67 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -262,7 +262,6 @@ static struct twl6040_codec_data twl6040_codec = {
 static struct twl6040_platform_data twl6040_data = {
 	.codec		= &twl6040_codec,
 	.audpwron_gpio	= 127,
-	.irq_base	= TWL6040_CODEC_IRQ_BASE,
 };
 
 /* Panda board uses the common PMIC configuration */
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 3aaf4af..ec42d6c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -398,9 +398,6 @@ static int overo_twl_gpio_setup(struct device *dev,
 }
 
 static struct twl4030_gpio_platform_data overo_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= overo_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index bbfbe56..4c45109 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -72,9 +72,6 @@ static struct platform_device *rm680_peripherals_devices[] __initdata = {
 
 /* TWL */
 static struct twl4030_gpio_platform_data rm680_gpio_data = {
-	.gpio_base		= OMAP_MAX_GPIO_LINES,
-	.irq_base		= TWL4030_GPIO_IRQ_BASE,
-	.irq_end		= TWL4030_GPIO_IRQ_END,
 	.pullups		= BIT(0),
 	.pulldowns		= BIT(1) | BIT(2) | BIT(8) | BIT(15),
 };
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 4be0552..06e44e4 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -773,9 +773,6 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 }
 
 static struct twl4030_gpio_platform_data rx51_gpio_data = {
-	.gpio_base		= OMAP_MAX_GPIO_LINES,
-	.irq_base		= TWL4030_GPIO_IRQ_BASE,
-	.irq_end		= TWL4030_GPIO_IRQ_END,
 	.pulldowns		= BIT(0) | BIT(1) | BIT(2) | BIT(3)
 				| BIT(4) | BIT(5)
 				| BIT(8) | BIT(9) | BIT(10) | BIT(11)
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index b797cb2..00f73b7 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -251,9 +251,6 @@ static void zoom2_set_hs_extmute(int mute)
 }
 
 static struct twl4030_gpio_platform_data zoom_gpio_data = {
-	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= zoom_twl_gpio_setup,
 };
 
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 94256fe..f030880 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -51,6 +51,7 @@
 
 
 static struct gpio_chip twl_gpiochip;
+static int twl4030_gpio_base;
 static int twl4030_gpio_irq_base;
 
 /* genirq interfaces are not available to modules */
@@ -428,8 +429,6 @@ no_irqs:
 	twl_gpiochip.dev = &pdev->dev;
 
 	if (pdata) {
-		twl_gpiochip.base = pdata->gpio_base;
-
 		/*
 		 * NOTE:  boards may waste power if they don't set pullups
 		 * and pulldowns correctly ... default for non-ULPI pins is
@@ -461,15 +460,21 @@ no_irqs:
 		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
 		twl_gpiochip.ngpio = 0;
 		gpio_twl4030_remove(pdev);
-	} else if (pdata && pdata->setup) {
+		goto out;
+	}
+
+	twl4030_gpio_base = twl_gpiochip.base;
+
+	if (pdata && pdata->setup) {
 		int status;
 
 		status = pdata->setup(&pdev->dev,
-				pdata->gpio_base, TWL4030_GPIO_MAX);
+				twl4030_gpio_base, TWL4030_GPIO_MAX);
 		if (status)
 			dev_dbg(&pdev->dev, "setup --> %d\n", status);
 	}
 
+out:
 	return ret;
 }
 
@@ -481,7 +486,7 @@ static int gpio_twl4030_remove(struct platform_device *pdev)
 
 	if (pdata && pdata->teardown) {
 		status = pdata->teardown(&pdev->dev,
-				pdata->gpio_base, TWL4030_GPIO_MAX);
+				twl4030_gpio_base, TWL4030_GPIO_MAX);
 		if (status) {
 			dev_dbg(&pdev->dev, "teardown --> %d\n", status);
 			return status;
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 7ea898c..a12a381 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -561,9 +561,6 @@ struct twl4030_bci_platform_data {
 
 /* TWL4030_GPIO_MAX (18) GPIOs, with interrupts */
 struct twl4030_gpio_platform_data {
-	int		gpio_base;
-	unsigned	irq_base, irq_end;
-
 	/* package the two LED signals as output-only GPIOs? */
 	bool		use_leds;
 
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index eaad49f..55b77b3 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -194,7 +194,6 @@ struct twl6040_vibra_data {
 
 struct twl6040_platform_data {
 	int audpwron_gpio;	/* audio power-on gpio */
-	unsigned int irq_base;
 
 	struct twl6040_codec_data *codec;
 	struct twl6040_vibra_data *vibra;
@@ -222,7 +221,6 @@ struct twl6040 {
 	unsigned int mclk;
 
 	unsigned int irq;
-	unsigned int irq_base;
 	u8 irq_masks_cur;
 	u8 irq_masks_cache;
 };

