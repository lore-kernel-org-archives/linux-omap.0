From: janboe <janboe.ye@gmail.com>
Subject: [PATCH] omap: gpio: omap3_gpio_pads_init current only works for
 omap3
Date: Tue, 13 Jul 2010 22:59:53 +0800
Message-ID: <20100713145953.GA17852@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55314 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850Ab0GMPMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jul 2010 11:12:50 -0400
Received: by pzk26 with SMTP id 26so1352297pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Jul 2010 08:12:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Since omap4 gpio pad config offset is different with omap3, so
omap3_gpio_pads_init only works for omap3, and this will break
omap4 build.

This patch fix this.

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/plat-omap/gpio.c |  112 ++++++++++++++++++++++----------------------
 1 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 0838c72..bae2649 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -379,6 +379,62 @@ struct gpio_pad {
 
 static struct gpio_pad *gpio_pads;
 static u16 gpio_pad_map[OMAP34XX_GPIO_AMT];
+
+/*
+ * Following pad init code in addition to the context / restore hooks are
+ * needed to fix glitches in GPIO outputs during off-mode. See OMAP3
+ * errate section 1.158
+ */
+static int __init omap3_gpio_pads_init(void)
+{
+	int i, j, min, max, gpio_amt;
+	u16 offset;
+
+	gpio_amt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_pads_config); i++) {
+		min = gpio_pads_config[i].min;
+		max = gpio_pads_config[i].max;
+		offset = gpio_pads_config[i].offset;
+
+		for (j = min; j <= max; j++) {
+			/*
+			 * Check if pad has been configured as GPIO
+			 * (mux mode 4.)
+			 */
+			if ((omap_ctrl_readw(offset) & 0x7) == 4) {
+				gpio_pad_map[j] = offset;
+				if (j > 31)
+					gpio_amt++;
+			}
+			offset += 2;
+		}
+	}
+	gpio_pads = kmalloc(sizeof(struct gpio_pad) * (gpio_amt + 1),
+		GFP_KERNEL);
+
+	if (gpio_pads == NULL) {
+		printk(KERN_ERR "FATAL: Failed to allocate gpio_pads\n");
+		return -ENOMEM;
+	}
+
+	gpio_amt = 0;
+	for (i = 0; i < OMAP34XX_GPIO_AMT; i++) {
+		/*
+		 * First module (gpio 0...31) is ignored as it is
+		 * in wakeup domain and does not need special
+		 * handling during off mode.
+		 */
+		if (gpio_pad_map[i] && i > 31) {
+			gpio_pads[gpio_amt].gpio = i;
+			gpio_pads[gpio_amt].offset = gpio_pad_map[i];
+			gpio_amt++;
+		}
+	}
+	gpio_pads[gpio_amt].gpio = -1;
+	return 0;
+}
+late_initcall(omap3_gpio_pads_init);
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -1750,62 +1806,6 @@ static struct clk * gpio5_fck;
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
-
-/*
- * Following pad init code in addition to the context / restore hooks are
- * needed to fix glitches in GPIO outputs during off-mode. See OMAP3
- * errate section 1.158
- */
-static int __init omap3_gpio_pads_init(void)
-{
-	int i, j, min, max, gpio_amt;
-	u16 offset;
-
-	gpio_amt = 0;
-
-	for (i = 0; i < ARRAY_SIZE(gpio_pads_config); i++) {
-		min = gpio_pads_config[i].min;
-		max = gpio_pads_config[i].max;
-		offset = gpio_pads_config[i].offset;
-
-		for (j = min; j <= max; j++) {
-			/*
-			 * Check if pad has been configured as GPIO 
-			 * (mux mode 4.)
-			 */
-			if ((omap_ctrl_readw(offset) & 0x7) == 4) {
-				gpio_pad_map[j] = offset;
-				if (j > 31)
-					gpio_amt++;
-			}
-			offset += 2;
-		}
-	}
-	gpio_pads = kmalloc(sizeof(struct gpio_pad) * (gpio_amt + 1),
-		GFP_KERNEL);
-
-	if (gpio_pads == NULL) {
-		printk(KERN_ERR "FATAL: Failed to allocate gpio_pads\n");
-		return -ENOMEM;
-	}
-
-	gpio_amt = 0;
-	for (i = 0; i < OMAP34XX_GPIO_AMT; i++) {
-		/*
-		 * First module (gpio 0...31) is ignored as it is
-		 * in wakeup domain and does not need special
-		 * handling during off mode.
-		 */
-		if (gpio_pad_map[i] && i > 31) {
-			gpio_pads[gpio_amt].gpio = i;
-			gpio_pads[gpio_amt].offset = gpio_pad_map[i];
-			gpio_amt++;
-		}
-	}
-	gpio_pads[gpio_amt].gpio = -1;
-	return 0;
-}
-late_initcall(omap3_gpio_pads_init);
 #endif
 
 static void __init omap_gpio_show_rev(void)
-- 
1.7.1

