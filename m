From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/9] omap1: Add omap7xx USB support
Date: Tue, 08 Dec 2009 16:50:58 -0800
Message-ID: <20091209005058.5944.43488.stgit@localhost>
References: <20091209004630.5944.40334.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52926 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967037AbZLIAuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:50:52 -0500
In-Reply-To: <20091209004630.5944.40334.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

From: Cory Maccarrone <darkstar6262@gmail.com>

This change implements USB client side support into the HTC
Herald board configuration.  It uses a similar, but updated
algorithm to initialize the USB as is used in the linwizard
project.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-htcherald.c |   64 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/mux.c             |    4 ++
 arch/arm/plat-omap/include/plat/mux.h |    2 +
 arch/arm/plat-omap/usb.c              |    8 ++++
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 5f28a5c..e36639f 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -39,6 +39,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/keypad.h>
+#include <plat/usb.h>
 
 #include <mach/irqs.h>
 
@@ -140,6 +141,15 @@ static struct platform_device kp_device = {
 	.resource	= kp_resources,
 };
 
+/* USB Device */
+static struct omap_usb_config htcherald_usb_config __initdata = {
+	.otg = 0,
+	.register_host = 0,
+	.register_dev  = 1,
+	.hmc_mode = 4,
+	.pins[0] = 2,
+};
+
 /* LCD Device resources */
 static struct platform_device lcd_device = {
 	.name           = "lcd_htcherald",
@@ -214,6 +224,57 @@ static void __init htcherald_disable_watchdog(void)
 	}
 }
 
+#define HTCHERALD_GPIO_USB_EN1 33
+#define HTCHERALD_GPIO_USB_EN2 73
+#define HTCHERALD_GPIO_USB_DM  35
+#define HTCHERALD_GPIO_USB_DP  36
+
+static void __init htcherald_usb_enable(void)
+{
+	unsigned int tries = 20;
+	unsigned int value = 0;
+
+	/* Request the GPIOs we need to control here */
+	if (gpio_request(HTCHERALD_GPIO_USB_EN1, "herald_usb") < 0)
+		goto err1;
+
+	if (gpio_request(HTCHERALD_GPIO_USB_EN2, "herald_usb") < 0)
+		goto err2;
+
+	if (gpio_request(HTCHERALD_GPIO_USB_DM, "herald_usb") < 0)
+		goto err3;
+
+	if (gpio_request(HTCHERALD_GPIO_USB_DP, "herald_usb") < 0)
+		goto err4;
+
+	/* force USB_EN GPIO to 0 */
+	do {
+		/* output low */
+		gpio_direction_output(HTCHERALD_GPIO_USB_EN1, 0);
+	} while ((value = gpio_get_value(HTCHERALD_GPIO_USB_EN1)) == 1 &&
+			--tries);
+
+	if (value == 1)
+		printk(KERN_WARNING "Unable to reset USB, trying to continue\n");
+
+	gpio_direction_output(HTCHERALD_GPIO_USB_EN2, 0); /* output low */
+	gpio_direction_input(HTCHERALD_GPIO_USB_DM); /* input */
+	gpio_direction_input(HTCHERALD_GPIO_USB_DP); /* input */
+
+	goto done;
+
+err4:
+	gpio_free(HTCHERALD_GPIO_USB_DM);
+err3:
+	gpio_free(HTCHERALD_GPIO_USB_EN2);
+err2:
+	gpio_free(HTCHERALD_GPIO_USB_EN1);
+err1:
+	printk(KERN_ERR "Unabled to request GPIO for USB\n");
+done:
+	printk(KERN_INFO "USB setup complete.\n");
+}
+
 static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
@@ -225,6 +286,9 @@ static void __init htcherald_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	htcherald_disable_watchdog();
+
+	htcherald_usb_enable();
+	omap_usb_init(&htcherald_usb_config);
 }
 
 static void __init htcherald_init_irq(void)
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 785371e..5e183cd 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -50,7 +50,9 @@ MUX_CFG_7XX("E3_7XX_KBC4",        13,   25,    0,   24,   1, 0)
 
 MUX_CFG_7XX("AA17_7XX_USB_DM",     2,   21,    0,   20,   0, 0)
 MUX_CFG_7XX("W16_7XX_USB_PU_EN",   2,   25,    0,   24,   0, 0)
-MUX_CFG_7XX("W17_7XX_USB_VBUSI",   2,   29,    0,   28,   0, 0)
+MUX_CFG_7XX("W17_7XX_USB_VBUSI",   2,   29,    6,   28,   1, 0)
+MUX_CFG_7XX("W18_7XX_USB_DMCK_OUT",3,    3,    1,    2,   0, 0)
+MUX_CFG_7XX("W19_7XX_USB_DCRST",   3,    7,    1,    6,   0, 0)
 
 /* MMC Pins */
 MUX_CFG_7XX("MMC_7XX_CMD",         2,    9,    0,    8,   1, 0)
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index 6067cf7..8ed5f25 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -172,6 +172,8 @@ enum omap7xx_index {
 	AA17_7XX_USB_DM,
 	W16_7XX_USB_PU_EN,
 	W17_7XX_USB_VBUSI,
+	W18_7XX_USB_DMCK_OUT,
+	W19_7XX_USB_DCRST,
 
 	/* MMC */
 	MMC_7XX_CMD,
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 51033a4..d3bf17c 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -137,7 +137,13 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 	if (is_device) {
 		if (cpu_is_omap24xx())
 			omap_cfg_reg(J20_24XX_USB0_PUEN);
-		else
+		else if (cpu_is_omap7xx()) {
+			omap_cfg_reg(AA17_7XX_USB_DM);
+			omap_cfg_reg(W16_7XX_USB_PU_EN);
+			omap_cfg_reg(W17_7XX_USB_VBUSI);
+			omap_cfg_reg(W18_7XX_USB_DMCK_OUT);
+			omap_cfg_reg(W19_7XX_USB_DCRST);
+		} else
 			omap_cfg_reg(W4_USB_PUEN);
 	}
 

