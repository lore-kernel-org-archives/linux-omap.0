From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/12] OMAP2/3 clock: warn if clock is missing clockdomain
Date: Mon, 08 Sep 2008 10:57:50 -0600
Message-ID: <20080908165749.2540.54261.stgit@localhost.localdomain>
References: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49074 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbYIIIVE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:21:04 -0400
In-Reply-To: <20080908164444.2540.98619.stgit@localhost.localdomain>
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
index be5c616..b134ca9 100644
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
 


