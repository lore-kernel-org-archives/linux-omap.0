From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/11] OMAP3: PM: reset USB OTG module on boot
Date: Thu, 25 Jun 2009 09:42:01 -0700
Message-ID: <1245948124-24111-9-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-3-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-4-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-5-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-6-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-7-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:35146 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886AbZFYQn0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:43:26 -0400
Received: by mail-pz0-f189.google.com with SMTP id 27so1461235pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:43:29 -0700 (PDT)
In-Reply-To: <1245948124-24111-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Rather than simply setting force-idle mode on boot, do a reset of the
OTG module.  This really ensures that any bootloader/bootstrap code
that leaves it active will not prevent future retention.  After reset,
OTG module will be in force-idle, force-standby mode.

Problem reported by Mike Chan <mikechan@google.com>

Tested-by: Mike Chan <mikechan@google.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
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

