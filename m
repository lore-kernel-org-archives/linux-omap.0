From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH][pm-2.6.29] OMAP: PM: Fix MUSB power domain association
Date: Fri,  7 Aug 2009 18:42:00 -0500
Message-ID: <1249688520-22946-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52939 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757175AbZHGXnM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Aug 2009 19:43:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

MUSB lies in CORE power domain.
Current code wrongly associates MUSB with USBHOST domain.
USBHOST domain is for EHCI/OHCI controller.

Correct the association of MUSB to CORE power domain.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/omapdev3xxx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omapdev3xxx.h b/arch/arm/mach-omap2/omapdev3xxx.h
index d2772c4..fd29129 100644
--- a/arch/arm/mach-omap2/omapdev3xxx.h
+++ b/arch/arm/mach-omap2/omapdev3xxx.h
@@ -663,7 +663,7 @@ static struct omapdev usbhost_3xxx_omapdev = {
 
 static struct omapdev usbotg_3xxx_omapdev = {
 	.name		= "usbotg_omapdev",
-	.pwrdm		= { .name = "usbhost_pwrdm" },
+	.pwrdm		= { .name = "core_pwrdm" },
 	.pdev_name	= "musb_hdrc",
 	.pdev_id	= -1,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-- 
1.6.3.3.334.g916e1

