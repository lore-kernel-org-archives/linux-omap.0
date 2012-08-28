From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 4/5] arm: omap: n8x0: add i2c-cbus platform data
Date: Wed, 29 Aug 2012 00:34:26 +0300
Message-ID: <1346189667-32330-5-git-send-email-aaro.koskinen@iki.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:43302 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2H1VfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Aug 2012 17:35:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id 885B219B7DC
	for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 00:34:28 +0300 (EEST)
Received: from smtp6.welho.com ([213.243.153.40])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id xUqIbrCD8zh9 for <linux-omap@vger.kernel.org>;
	Wed, 29 Aug 2012 00:34:28 +0300 (EEST)
Received: from blackmetal.bb.dnainternet.fi (212-149-209-232.bb.dnainternet.fi [212.149.209.232])
	by smtp6.welho.com (Postfix) with ESMTP id 496595BC005
	for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 00:34:28 +0300 (EEST)
In-Reply-To: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add platform data to enable i2c-cbus on N8x0. It will be I2C bus #3.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-n8x0.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 677357f..8ea0dea 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/stddef.h>
 #include <linux/i2c.h>
+#include <linux/i2c-cbus.h>
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
 #include <sound/tlv320aic3x.h>
@@ -42,6 +43,31 @@
 #define TUSB6010_GPIO_ENABLE	0
 #define TUSB6010_DMACHAN	0x3f
 
+#if defined(CONFIG_I2C_CBUS) || defined(CONFIG_I2C_CBUS_MODULE)
+static struct i2c_cbus_platform_data n8x0_cbus_data = {
+	.clk_gpio = 66,
+	.dat_gpio = 65,
+	.sel_gpio = 64,
+};
+
+static struct platform_device n8x0_cbus_device = {
+	.name	= "i2c-cbus",
+	.id	= 3,
+	.dev	= {
+		.platform_data = &n8x0_cbus_data,
+	},
+};
+
+static void __init n8x0_cbus_init(void)
+{
+	platform_device_register(&n8x0_cbus_device);
+}
+#else /* CONFIG_I2C_CBUS */
+static void __init n8x0_cbus_init(void)
+{
+}
+#endif /* CONFIG_I2C_CBUS */
+
 #if defined(CONFIG_USB_MUSB_TUSB6010) || defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
 /*
  * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
@@ -681,6 +707,7 @@ static void __init n8x0_init_machine(void)
 	gpmc_onenand_init(board_onenand_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
+	n8x0_cbus_init();
 }
 
 MACHINE_START(NOKIA_N800, "Nokia N800")
-- 
1.7.2.5

