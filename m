From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/22] OMAP: hwmod: Replace WARN by pr_warning for clockdomain
	check
Date: Tue, 18 May 2010 20:18:50 -0600
Message-ID: <20100519021848.19716.50002.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39798 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab0ESCVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:21:00 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Most of the clock nodes belong to a clock domain, but it is perfectly valid
to have clock without clock domain.
Root clocks for example does not belong to any clock domain.
Keep the warning but reduce the verbosity.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


