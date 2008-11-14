From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] HSMMC: Add MMC configuration for pandora
Date: Fri, 14 Nov 2008 21:45:17 +0200
Message-ID: <1226691917-6577-2-git-send-email-notasas@gmail.com>
References: <1226691917-6577-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:9848 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbYKNTpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 14:45:35 -0500
Received: by nf-out-0910.google.com with SMTP id d3so780822nfc.21
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 11:45:33 -0800 (PST)
In-Reply-To: <1226691917-6577-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

This patch enables both SD slots with support of card detect and
write protect switch on OMAP3 Pandora.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   41 ++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 48f7d26..69517a5 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -144,14 +144,44 @@ static void __init omap3pandora_flash_init(void)
 	}
 }
 
+static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= 126,
+		.ext_clock	= 0,
+	},
+	{
+		.mmc		= 2,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= 127,
+		.ext_clock	= 1,
+	},
+	{}	/* Terminator */
+};
+
 static struct omap_uart_config omap3pandora_uart_config __initdata = {
 	.enabled_uarts	= (1 << 2), /* UART3 */
 };
 
+static int omap3pandora_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
+	omap3pandora_mmc[0].gpio_cd = gpio + 0;
+	omap3pandora_mmc[1].gpio_cd = gpio + 1;
+	hsmmc_init(omap3pandora_mmc);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.setup		= omap3pandora_twl_gpio_setup,
 };
 
 static struct twl4030_usb_data omap3pandora_usb_data = {
@@ -257,16 +287,6 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&omap3pandora_lcd_device,
 };
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{}	/* Terminator */
-};
-
 static void __init omap3pandora_init(void)
 {
 	omap3pandora_i2c_init();
@@ -277,7 +297,6 @@ static void __init omap3pandora_init(void)
 	omap_serial_init();
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
-	hsmmc_init(mmc);
 	usb_musb_init();
 	usb_ehci_init();
 	omap3pandora_flash_init();
-- 
1.5.4.3

