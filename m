From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 40/45] ARM: OMAP2+: omap_device: use dt aware clk_get to lookup clk
Date: Thu, 29 Aug 2013 16:16:32 +0300
Message-ID: <1377782197-10611-41-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50744 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925Ab3H2NS6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:58 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

clk_get does a check to find nodes on DT prior to trying clk_get_sys.

To make omap_device dt clock node aware, use clk_get instead of
clk_get_sys.

As part of this, add warnings for device node entries which do not
declare their own clock nodes for the expected aliases.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 7c796e2..9946900 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -48,19 +48,25 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 	int ret;
 	struct clk *r;
 	struct device *dev = &od->pdev->dev;
+	struct device_node *node = dev->of_node;
 
 	if (!clk_alias || !clk_name)
 		return;
 
 	dev_dbg(dev, "Creating %s -> %s\n", clk_alias, clk_name);
 
-	r = clk_get_sys(dev_name(dev), clk_alias);
+	r = clk_get(dev, clk_alias);
 	if (!IS_ERR(r)) {
-		dev_warn(dev, "alias %s already exists\n", clk_alias);
+		if (!node)
+			dev_warn(dev, "alias '%s' already exists\n", clk_alias);
 		clk_put(r);
 		return;
 	}
 
+	if (node)
+		dev_err(dev, "FIXME: clock-name '%s' DOES NOT exist in dt!\n",
+			clk_alias);
+
 	ret = clk_add_alias(clk_alias, dev_name(dev), (char *)clk_name, dev);
 	if (ret)
 		dev_err(dev, "Failed to alias %s to %s: %d\n", clk_alias,
-- 
1.7.9.5

