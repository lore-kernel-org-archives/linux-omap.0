From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/13] OMAP3: PM: Ensure MUSB block can idle when driver not loaded
Date: Wed, 20 May 2009 16:19:33 -0700
Message-ID: <1242861576-13008-11-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-6-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-7-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-8-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-9-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-10-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:43119 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411AbZETXUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:20:04 -0400
Received: by mail-px0-f171.google.com with SMTP id 1so365239pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:20:06 -0700 (PDT)
In-Reply-To: <1242861576-13008-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Otherwise, bootloaders may leave MUSB in a state which prevents
retention.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile          |    2 --
 arch/arm/mach-omap2/usb-musb.c        |   20 ++++++++++++++++++++
 arch/arm/plat-omap/include/mach/usb.h |    6 ------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c8f1505..201214f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -60,9 +60,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   mmc-twl4030.o
 
 # Platform specific device init code
-ifeq ($(CONFIG_USB_MUSB_SOC),y)
 obj-y					+= usb-musb.o
-endif
 
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 215d463..d85296d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -31,6 +31,17 @@
 #include <mach/mux.h>
 #include <mach/usb.h>
 
+#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
+
+static void __init usb_musb_pm_init(void)
+{
+	/* Ensure force-idle mode for OTG controller */
+	if (cpu_is_omap34xx())
+		omap_writel(0, OTG_SYSCONFIG);
+}
+
+#ifdef CONFIG_USB_MUSB_SOC
+
 static struct resource musb_resources[] = {
 	[0] = { /* start and end set dynamically */
 		.flags	= IORESOURCE_MEM,
@@ -183,4 +194,13 @@ void __init usb_musb_init(void)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
 	}
+
+	usb_musb_pm_init();
+}
+
+#else
+void __init usb_musb_init(void)
+{
+	usb_musb_pm_init();
 }
+#endif /* CONFIG_USB_MUSB_SOC */
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index 69f0cee..f337e17 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -27,13 +27,7 @@
 #define UDC_BASE			OMAP2_UDC_BASE
 #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
 
-#ifdef CONFIG_USB_MUSB_SOC
 extern void usb_musb_init(void);
-#else
-static inline void usb_musb_init(void)
-{
-}
-#endif
 
 #endif
 
-- 
1.6.2.2

