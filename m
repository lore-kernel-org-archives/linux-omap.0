From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/11] OMAP3: PM: Ensure MUSB block can idle when driver not loaded
Date: Fri, 15 May 2009 11:40:48 -0700
Message-ID: <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-3-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-4-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-5-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-6-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com>
 <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:38335 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbZEOSlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:41:24 -0400
Received: by wa-out-1112.google.com with SMTP id j5so746788wah.21
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:41:26 -0700 (PDT)
In-Reply-To: <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Otherwise, bootloaders may leave MUSB in a state which prevents
retention.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/usb-musb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 215d463..57e857e 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -31,6 +31,8 @@
 #include <mach/mux.h>
 #include <mach/usb.h>
 
+#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
+
 static struct resource musb_resources[] = {
 	[0] = { /* start and end set dynamically */
 		.flags	= IORESOURCE_MEM,
@@ -183,4 +185,8 @@ void __init usb_musb_init(void)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
 	}
+
+	/* Ensure force-idle mode for OTG controller */
+	if (cpu_is_omap34xx())
+		omap_writel(0, OTG_SYSCONFIG);
 }
-- 
1.6.2.2

