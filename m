From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/11] omap: musb: Add USB support to 4430 SDP board file
Date: Fri, 19 Feb 2010 15:30:38 -0800
Message-ID: <20100219233038.10559.52038.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52415 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab0BSX3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:50 -0500
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Maulik Mankad <x0082077@ti.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <david-b@pacbell.net>, Olof Johansson <olof@lixom.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Maulik Mankad <x0082077@ti.com>

This patch adds support for Mentor USB to 4430 SDP board
file.

It also defines the base address for HS USB OTG controller
in OMAP4.

Also updates platform specfic structure with base address
and IRQ details.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c        |   10 ++++++++++
 arch/arm/mach-omap2/usb-musb.c             |    9 +++++++--
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 793ce8f..86b240e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -27,6 +28,7 @@
 #include <plat/common.h>
 #include <plat/control.h>
 #include <plat/timer-gp.h>
+#include <plat/usb.h>
 #include <asm/hardware/gic.h>
 
 static struct platform_device sdp4430_lcd_device = {
@@ -73,11 +75,19 @@ static void __init omap_4430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_UTMI,
+	.mode			= MUSB_PERIPHERAL,
+	.power			= 100,
+};
 
 static void __init omap_4430sdp_init(void)
 {
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
+	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
+	usb_nop_xceiv_register();
+	usb_musb_init(&musb_board_data);
 }
 
 static void __init omap_4430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 85feb60..53a9638 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -87,10 +87,15 @@ static struct platform_device musb_device = {
 
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
-	if (cpu_is_omap243x())
+	if (cpu_is_omap243x()) {
 		musb_resources[0].start = OMAP243X_HS_BASE;
-	else
+	} else if (cpu_is_omap34xx()) {
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
+	} else if (cpu_is_omap44xx()) {
+		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
+		musb_resources[1].start = INT_44XX_HS_USB_MC;
+		musb_resources[2].start = INT_44XX_HS_USB_DMA;
+	}
 	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
 	/*
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 2068b39..8fc15d3 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -45,6 +45,7 @@
 #define OMAP44XX_MCPDM_L3_BASE		0x49032000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
+#define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
 
 #endif /* __ASM_ARCH_OMAP44XX_H */
 

