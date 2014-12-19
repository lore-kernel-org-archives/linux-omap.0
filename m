From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: print error if wait_target_ready() failed
Date: Fri, 19 Dec 2014 18:04:50 +0530
Message-ID: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbaLSMgk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2014 07:36:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com, rogerq@ti.com, nsekhar@ti.com, lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org

Fixed pr_debug to pr_err when hwmod returns an error when enabling
a module.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbb908d..06157af 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2155,8 +2155,8 @@ static int _enable(struct omap_hwmod *oh)
 		if (soc_ops.disable_module)
 			soc_ops.disable_module(oh);
 		_disable_clocks(oh);
-		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
-			 oh->name, r);
+		pr_err("omap_hwmod: %s: _wait_target_ready failed: %d\n",
+		       oh->name, r);
 
 		if (oh->clkdm)
 			clkdm_hwmod_disable(oh->clkdm, oh);
-- 
1.9.1

