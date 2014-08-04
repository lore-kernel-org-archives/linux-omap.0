From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] ARM: OMAP2+: omap_device: remove warning that clk alias already exists
Date: Mon,  4 Aug 2014 14:54:04 +0200
Message-ID: <1407156844-21548-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40505 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaHDMyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2014 08:54:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

When an alias for a clock already exists the warning is printed. For
every module with a main_clk defined, a clk alias for fck is added.
There are some components that have the same main_clk defined, so this
is a really normal situation.

For example the am33xx edma device has 4 components using the same main
clock. So there are three warnings in the boot log for this already
existing clock alias:
	platform 49000000.edma: alias fck already exists
	platform 49000000.edma: alias fck already exists
	platform 49000000.edma: alias fck already exists

As this is only interesting for developers, this patch changes the
message to a debug message.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-omap2/omap_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 01ef59def44b..d22c30d3ccfa 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -56,7 +56,7 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 
 	r = clk_get_sys(dev_name(&od->pdev->dev), clk_alias);
 	if (!IS_ERR(r)) {
-		dev_warn(&od->pdev->dev,
+		dev_dbg(&od->pdev->dev,
 			 "alias %s already exists\n", clk_alias);
 		clk_put(r);
 		return;
-- 
2.0.1

