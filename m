From: Ashwin Bihari <ashwin.bihari@logicpd.com>
Subject: [PATCH 1/2] Add MSUB support for the LogicPD OMAP3530 DevKits
Date: Mon, 7 May 2012 15:21:19 -0400
Message-ID: <1336418480-32635-2-git-send-email-ashwin.bihari@logicpd.com>
References: <1336418480-32635-1-git-send-email-ashwin.bihari@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.logicpd.com ([174.46.170.145]:45101 "HELO
	barracuda.logicpd.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757608Ab2EGThl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 15:37:41 -0400
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by barracuda.logicpd.com with ESMTP id vZKX6GlEQSdLzi1c (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 14:21:33 -0500 (CDT)
In-Reply-To: <1336418480-32635-1-git-send-email-ashwin.bihari@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ashwin Bihari <ashwin.bihari@logicpd.com>

Add support for the OMAP3 MUSB OTG controller to the LogicPD
OMAP3530 SOM-LV[1] and Torpedo[2] DevKits

[1] - www.logicpd.com/products/system-on-modules/omap35x-som-lv/
[2] - www.logicpd.com/products/system-on-modules/omap35x-torpedo-som/

Signed-off-by: Ashwin Bihari <ashwin.bihari@logicpd.com>
---
 arch/arm/mach-omap2/board-omap3logic.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 9b3c141..c008bf8 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -4,8 +4,9 @@
  * Copyright (C) 2010 Li-Pro.Net
  * Stephan Linz <linz@li-pro.net>
  *
- * Copyright (C) 2010 Logic Product Development, Inc.
+ * Copyright (C) 2010-2012 Logic Product Development, Inc.
  * Peter Barada <peter.barada@logicpd.com>
+ * Ashwin BIhari <ashwin.bihari@logicpd.com>
  *
  * Modified from Beagle, EVM, and RX51
  *
@@ -45,6 +46,7 @@
 #include <plat/gpmc-smsc911x.h>
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
+#include <plat/usb.h>
 
 #define OMAP3LOGIC_SMSC911X_CS			1
 
@@ -85,6 +87,11 @@ static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
 			| BIT(13) | BIT(15) | BIT(16) | BIT(17),
 };
 
+static struct twl4030_usb_data omap3logic_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
+
 static struct twl4030_platform_data omap3logic_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -92,6 +99,7 @@ static struct twl4030_platform_data omap3logic_twldata = {
 	/* platform_data for children goes here */
 	.gpio		= &omap3logic_gpio_data,
 	.vmmc1		= &omap3logic_vmmc1,
+	.usb		= &omap3logic_usb_data,
 };
 
 static int __init omap3logic_i2c_init(void)
@@ -185,6 +193,20 @@ static inline void __init board_smsc911x_init(void)
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* mUSB */
+	OMAP3_MUX(HSUSB0_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_STP, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(HSUSB0_DIR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_NXT, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #endif
@@ -205,6 +227,8 @@ static void __init omap3logic_init(void)
 	board_mmc_init();
 	board_smsc911x_init();
 
+	usb_musb_init(NULL);
+
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-- 
1.7.1

