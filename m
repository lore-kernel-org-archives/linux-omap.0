From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 38/45] ARM: OMAP2+: omap_device: use dev pointer to optimize code
Date: Thu, 29 Aug 2013 16:16:30 +0300
Message-ID: <1377782197-10611-39-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49160 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab3H2NSl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:41 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

_add_clkdev uses &od->pdev->dev for all reference of device struct.

Simplify the usage with a variable.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index f99f68e..070d17b 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -47,31 +47,29 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 {
 	struct clk *r;
 	struct clk_lookup *l;
+	struct device *dev = &od->pdev->dev;
 
 	if (!clk_alias || !clk_name)
 		return;
 
-	dev_dbg(&od->pdev->dev, "Creating %s -> %s\n", clk_alias, clk_name);
+	dev_dbg(dev, "Creating %s -> %s\n", clk_alias, clk_name);
 
-	r = clk_get_sys(dev_name(&od->pdev->dev), clk_alias);
+	r = clk_get_sys(dev_name(dev), clk_alias);
 	if (!IS_ERR(r)) {
-		dev_warn(&od->pdev->dev,
-			 "alias %s already exists\n", clk_alias);
+		dev_warn(dev, "alias %s already exists\n", clk_alias);
 		clk_put(r);
 		return;
 	}
 
 	r = clk_get(NULL, clk_name);
 	if (IS_ERR(r)) {
-		dev_err(&od->pdev->dev,
-			"clk_get for %s failed\n", clk_name);
+		dev_err(dev, "clk_get for %s failed\n", clk_name);
 		return;
 	}
 
-	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev->dev));
+	l = clkdev_alloc(r, clk_alias, dev_name(dev));
 	if (!l) {
-		dev_err(&od->pdev->dev,
-			"clkdev_alloc for %s failed\n", clk_alias);
+		dev_err(dev, "clkdev_alloc for %s failed\n", clk_alias);
 		return;
 	}
 
-- 
1.7.9.5

