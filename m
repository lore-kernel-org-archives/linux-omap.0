From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 12/12] OMAP2/3 clock: warn if clock is missing clockdomain
Date: Wed, 10 Sep 2008 10:48:10 -0600
Message-ID: <20080910164807.17024.60748.stgit@localhost.localdomain>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58287 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYIJQtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 12:49:00 -0400
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

At this point, all OMAP2/3 clocks should be associated with a clockdomain.
Warn in clk_register() if any are missing a clockdomain

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 88c8ef4..eee5511 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -78,8 +78,10 @@ void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
 
-	if (!clk->clkdm.name)
+	if (!clk->clkdm.name) {
+		pr_err("clock: %s: missing clockdomain", clk->name);
 		return;
+	}
 
 	clkdm = clkdm_lookup(clk->clkdm.name);
 	if (clkdm) {
@@ -87,8 +89,8 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 clk->name, clk->clkdm.name);
 		clk->clkdm.ptr = clkdm;
 	} else {
-		pr_debug("clock: could not associate clk %s to "
-			 "clkdm %s\n", clk->name, clk->clkdm.name);
+		pr_err("clock: %s: could not associate to clkdm %s\n",
+		       clk->name, clk->clkdm.name);
 	}
 }
 


