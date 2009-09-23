From: Koen Kooi <koen.kooi@gmail.com>
Subject: [PATCH] ARM: OMAP: Fix beagleboard EHCI setup
Date: Wed, 23 Sep 2009 10:23:29 +0200
Message-ID: <1253694209-55128-1-git-send-email-k.kooi@student.utwente.nl>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34482 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbZIWIXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 04:23:31 -0400
Received: by fxm18 with SMTP id 18so390937fxm.17
        for <linux-omap@vger.kernel.org>; Wed, 23 Sep 2009 01:23:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@beagleboard.org>

From: Koen Kooi <koen@beagleboard.org>

The EHCI configuration in the beagleboard board file was copy/pasted
from the sdp one and hence wrong. The beagleboard only used one port
and lacks a charge pump.

Tested on revision C1D and C3 boards

Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 496b4a0..aa403e6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -406,10 +406,10 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
-	.chargepump = true,
+	.chargepump = false,
 	.phy_reset  = true,
-	.reset_gpio_port[0]  = 57,
-	.reset_gpio_port[1]  = 61,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = 147,
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-- 
1.6.2.4

