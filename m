From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 04/24] ARM: omap: hwmod: get rid of all omap_clk_get_by_name usage
Date: Fri, 1 Jun 2012 17:37:45 +0530
Message-ID: <1338552485-31325-5-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54038 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759493Ab2FAMI1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:08:27 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Moving to COMMON clk for OMAP would mean we no longer use
internal lookup mechanism like omap_clk_get_by_name().
get rid of all its usage mostly from hwmod and omap_device
code.

Also use IS_ERR_OR_NULL() for error checking.

Based on original changes from Mike Turquette.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   12 ++++++------
 arch/arm/plat-omap/omap_device.c |    6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7aa73f8..6c7c322 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -559,8 +559,8 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	if (!oh->main_clk)
 		return 0;
 
-	oh->_clk = omap_clk_get_by_name(oh->main_clk);
-	if (!oh->_clk) {
+	oh->_clk = clk_get(NULL, oh->main_clk);
+	if (IS_ERR_OR_NULL(oh->_clk)) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
 		return -EINVAL;
@@ -595,8 +595,8 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 		if (!os->clk)
 			continue;
 
-		c = omap_clk_get_by_name(os->clk);
-		if (!c) {
+		c = clk_get(NULL, os->clk);
+		if (IS_ERR_OR_NULL(c)) {
 			pr_warning("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
 				   oh->name, os->clk);
 			ret = -EINVAL;
@@ -622,8 +622,8 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 	int ret = 0;
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
-		c = omap_clk_get_by_name(oc->clk);
-		if (!c) {
+		c = clk_get(NULL, oc->clk);
+		if (IS_ERR_OR_NULL(c)) {
 			pr_warning("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
 				   oh->name, oc->clk);
 			ret = -EINVAL;
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d50cbc6..16bcace 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -266,10 +266,10 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		return;
 	}
 
-	r = omap_clk_get_by_name(clk_name);
-	if (IS_ERR(r)) {
+	r = clk_get(NULL, clk_name);
+	if (IS_ERR_OR_NULL(r)) {
 		dev_err(&od->pdev->dev,
-			"omap_clk_get_by_name for %s failed\n", clk_name);
+			"clk_get for %s failed\n", clk_name);
 		return;
 	}
 
-- 
1.7.1

