From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: OMAP: Fix board data to support device only, host only and OTG roles.
Date: Thu, 20 May 2010 18:39:26 +0530
Message-ID: <1274360966-9974-1-git-send-email-x0082077@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fix board data to support device only, host only and OTG roles.

The board data hardcodes the mode to OTG or Peripheral.
This fix will allow to use Peripheral, Host and OTG
roles independently.

Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
Based on top of today's mainline.
Applies cleanly on linux-omap master also.

 arch/arm/mach-omap2/board-2430sdp.c          |    6 ++++++
 arch/arm/mach-omap2/board-3430sdp.c          |    6 ++++++
 arch/arm/mach-omap2/board-4430sdp.c          |    6 ++++++
 arch/arm/mach-omap2/board-cm-t35.c           |    6 ++++++
 arch/arm/mach-omap2/board-devkit8000.c       |    6 ++++++
 arch/arm/mach-omap2/board-igep0020.c         |    6 ++++++
 arch/arm/mach-omap2/board-ldp.c              |    6 ++++++
 arch/arm/mach-omap2/board-omap3beagle.c      |    6 ++++++
 arch/arm/mach-omap2/board-omap3evm.c         |    6 ++++++
 arch/arm/mach-omap2/board-omap3pandora.c     |    6 ++++++
 arch/arm/mach-omap2/board-omap3touchbook.c   |    6 ++++++
 arch/arm/mach-omap2/board-overo.c            |    6 ++++++
 arch/arm/mach-omap2/board-rx51.c             |    6 ++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++++
 14 files changed, 84 insertions(+)

Index: mainline/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-2430sdp.c
+++ mainline/arch/arm/mach-omap2/board-2430sdp.c
@@ -195,7 +195,13 @@ static struct omap2_hsmmc_info mmc[] __i
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-ldp.c
+++ mainline/arch/arm/mach-omap2/board-ldp.c
@@ -385,7 +385,13 @@ static struct omap_board_mux board_mux[]
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-omap3beagle.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-omap3beagle.c
+++ mainline/arch/arm/mach-omap2/board-omap3beagle.c
@@ -432,7 +432,13 @@ static struct omap_board_mux board_mux[]
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-overo.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-overo.c
+++ mainline/arch/arm/mach-omap2/board-overo.c
@@ -415,7 +415,13 @@ static struct omap_board_mux board_mux[]
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ mainline/arch/arm/mach-omap2/board-3430sdp.c
@@ -778,7 +778,13 @@ static struct flash_partitions sdp_flash
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-omap3pandora.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-omap3pandora.c
+++ mainline/arch/arm/mach-omap2/board-omap3pandora.c
@@ -567,7 +567,13 @@ static struct omap_board_mux board_mux[]
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ mainline/arch/arm/mach-omap2/board-4430sdp.c
@@ -107,7 +107,13 @@ static void __init omap_4430sdp_init_irq
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-cm-t35.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-cm-t35.c
+++ mainline/arch/arm/mach-omap2/board-cm-t35.c
@@ -813,7 +813,13 @@ static struct omap_board_mux board_mux[]
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-omap3evm.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-omap3evm.c
+++ mainline/arch/arm/mach-omap2/board-omap3evm.c
@@ -664,7 +664,13 @@ static struct omap_board_mux board_mux[]
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-rx51.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-rx51.c
+++ mainline/arch/arm/mach-omap2/board-rx51.c
@@ -122,7 +122,13 @@ static struct omap_board_mux board_mux[]
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 0,
 };
 
Index: mainline/arch/arm/mach-omap2/board-devkit8000.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-devkit8000.c
+++ mainline/arch/arm/mach-omap2/board-devkit8000.c
@@ -617,7 +617,13 @@ static void __init devkit8000_flash_init
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-igep0020.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-igep0020.c
+++ mainline/arch/arm/mach-omap2/board-igep0020.c
@@ -453,7 +453,13 @@ static int __init igep2_i2c_init(void)
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-omap3touchbook.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-omap3touchbook.c
+++ mainline/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -529,7 +529,13 @@ early_param("tbr", early_touchbook_revis
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
Index: mainline/arch/arm/mach-omap2/board-zoom-peripherals.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ mainline/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -266,7 +266,13 @@ static int __init omap_i2c_init(void)
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
 	.mode			= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode			= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode			= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
