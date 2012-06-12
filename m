From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk function
Date: Tue, 12 Jun 2012 20:36:21 +0300
Message-ID: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48592 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab2FLRgY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 13:36:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com

If the clocks are enabled and we want to enable them again
omap4430_phy_set_clk disables them.

Fix this - so now if we try to enable already enabled clocks
it works correctly.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 4c90477..0196683 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int on)
 		clk_enable(clk48m);
 		clk_enable(clk32k);
 		state = 1;
-	} else if (state) {
+	} else if (!on && state) {
 		/* Disable the phy clocks */
 		clk_disable(phyclk);
 		clk_disable(clk48m);
-- 
1.7.1

