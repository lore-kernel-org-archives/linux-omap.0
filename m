From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 2/2] ARM : OMAP4 : MUSB : Add USB support to 4430 SDP board file
Date: Thu, 31 Dec 2009 18:53:02 +0530
Message-ID: <1262265782-17672-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ARM : OMAP4 : Add USB support to 4430 SDP board file

This patch adds support for Mentor USB to 4430 SDP board
file.

It also defines the base address for HS USB OTG controller
in OMAP4.

Also updates platform specfic structure with base address
and IRQ details.

Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---
 arch/arm/mach-omap2/board-4430sdp.c        |   10 ++++++++++
 arch/arm/mach-omap2/usb-musb.c             |    9 +++++++--
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

Index: felipe_musb/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- felipe_musb.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ felipe_musb/arch/arm/mach-omap2/board-4430sdp.c
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
@@ -73,11 +75,19 @@ static void __init omap_4430sdp_init_irq
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
Index: felipe_musb/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- felipe_musb.orig/arch/arm/mach-omap2/usb-musb.c
+++ felipe_musb/arch/arm/mach-omap2/usb-musb.c
@@ -77,10 +77,15 @@ static struct platform_device musb_devic
 
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
Index: felipe_musb/arch/arm/plat-omap/include/plat/omap44xx.h
===================================================================
--- felipe_musb.orig/arch/arm/plat-omap/include/plat/omap44xx.h
+++ felipe_musb/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -43,6 +43,7 @@
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
+#define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
 
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
