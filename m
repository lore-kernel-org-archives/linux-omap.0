From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 10/10] OMAP: hwmod: Replace WARN by pr_warning for clockdomain check
Date: Fri,  7 May 2010 17:44:15 +0200
Message-ID: <1273247055-15165-11-git-send-email-b-cousson@ti.com>
References: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54205 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0EGPoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 11:44:32 -0400
In-Reply-To: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Most of the clock nodes belong to a clock domain, but it is perfectly valid
to have clock without clock domain.
Root clocks for example does not belong to any clock domain.
Keep the warning but reduce the verbosity.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b6031e4..2fff39f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -404,21 +404,20 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  */
 static int _init_main_clk(struct omap_hwmod *oh)
 {
-	struct clk *c;
 	int ret = 0;
 
 	if (!oh->main_clk)
 		return 0;
 
-	c = omap_clk_get_by_name(oh->main_clk);
-	if (!c)
+	oh->_clk = omap_clk_get_by_name(oh->main_clk);
+	if (!oh->_clk)
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
-		ret = -EINVAL;
-	oh->_clk = c;
+		return -EINVAL;
 
-	WARN(!c->clkdm, "omap_hwmod: %s: missing clockdomain for %s.\n",
-	     oh->main_clk, c->name);
+	if (!oh->_clk->clkdm)
+		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
+			   oh->main_clk, oh->_clk->name);
 
 	return ret;
 }
-- 
1.6.1.3

