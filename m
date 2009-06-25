From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH -pm v5] OMAP3: PM: reset USB OTG module on boot
Date: Thu, 25 Jun 2009 07:55:50 -0700
Message-ID: <1245941750-10831-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:23417 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZFYOzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 10:55:50 -0400
Received: by wf-out-1314.google.com with SMTP id 26so546051wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 07:55:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Rather than simply setting force-idle mode on boot, do a reset of the
OTG module.  This really ensures that any bootloader/bootstrap code
that leaves it active will not prevent future retention.  After reset,
OTG module will be in force-idle, force-standby mode.

Problem reported by Mike Chan <mikechan@google.com>

Tested-by: Mike Chan <mikechan@google.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
I decided to drop clock stuff from this patch as the current
code is not doing it either.  This simply replaces the 
force-idle with a soft reset, and uses ioremap instead of
omap_write().  

This will only be a temporary patch in the pm branch until
omap_hwmod is integrated and is doing the full module reset.

 arch/arm/mach-omap2/usb-musb.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index d85296d..3efa19c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -26,18 +26,32 @@
 
 #include <linux/usb/musb.h>
 
+#include <asm/sizes.h>
+
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
 
-#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
+#define OTG_SYSCONFIG	   0x404
+#define OTG_SYSC_SOFTRESET BIT(1)
 
 static void __init usb_musb_pm_init(void)
 {
-	/* Ensure force-idle mode for OTG controller */
-	if (cpu_is_omap34xx())
-		omap_writel(0, OTG_SYSCONFIG);
+	void __iomem *otg_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
+	if (WARN_ON(!otg_base))
+		return;
+
+	/* Reset OTG controller.  After reset, it will be in
+	 * force-idle, force-standby mode. */
+	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
+
+	iounmap(otg_base);
 }
 
 #ifdef CONFIG_USB_MUSB_SOC
-- 
1.6.3.2

