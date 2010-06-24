From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 04/13] OMAP: hwmod: Fix the missing braces
Date: Thu, 24 Jun 2010 16:44:35 -0700
Message-ID: <1277423084-25528-5-git-send-email-khilman@deeprootsystems.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57989 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0FXXox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:44:53 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so2080998pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:44:53 -0700 (PDT)
In-Reply-To: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

From: Benoit Cousson <b-cousson@ti.com>

As reported by Sergei, a couple of braces were missing after
the WARM removal patch.

[07/22] OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed

https://patchwork.kernel.org/patch/100756/

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ac75407..3d11523 100644
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
1.7.0.2

