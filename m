From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/2] OMAP: hwmod: Fix the missing braces
Date: Mon, 24 May 2010 23:23:13 +0200
Message-ID: <1274736194-30652-2-git-send-email-b-cousson@ti.com>
References: <1274736194-30652-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57644 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020Ab0EXVXW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 May 2010 17:23:22 -0400
In-Reply-To: <1274736194-30652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

As reported by Sergei, a couple of braces were missing after
the WARM removal patch.

[07/22] OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed

https://patchwork.kernel.org/patch/100756/

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 95c9a5f..b7a4133 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -409,10 +409,11 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return 0;
 
 	oh->_clk = omap_clk_get_by_name(oh->main_clk);
-	if (!oh->_clk)
+	if (!oh->_clk) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
 		return -EINVAL;
+	}
 
 	if (!oh->_clk->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
@@ -444,10 +445,11 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 			continue;
 
 		c = omap_clk_get_by_name(os->clk);
-		if (!c)
+		if (!c) {
 			pr_warning("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
 				   oh->name, os->clk);
 			ret = -EINVAL;
+		}
 		os->_clk = c;
 	}
 
@@ -470,10 +472,11 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
 		c = omap_clk_get_by_name(oc->clk);
-		if (!c)
+		if (!c) {
 			pr_warning("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
 				   oh->name, oc->clk);
 			ret = -EINVAL;
+		}
 		oc->_clk = c;
 	}
 
-- 
1.6.1.3

