From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 17/23] OMAP2/3 clock: every clock must have a clkdm
Date: Sun, 04 Jan 2009 19:34:58 -0700
Message-ID: <20090105023457.12661.3791.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36222 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbZAEDXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:23:00 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Every OMAP2/3 clock must now have an assigned clockdomain, so we can
remove the checks from clk_enable()/clk_disable().  Instead, verify
that the clockdomain is present only at clock init time via the
arch_clock clk_register() hook.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5f54e7e..1979d5f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -200,11 +200,6 @@ void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
 
-	if (!clk->clkdm.name) {
-		pr_err("clock: %s: missing clockdomain", clk->name);
-		return;
-	}
-
 	clkdm = clkdm_lookup(clk->clkdm.name);
 	if (clkdm) {
 		pr_debug("clock: associated clk %s to clkdm %s\n",
@@ -481,8 +476,7 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
-		if (clk->clkdm.ptr)
-			omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
+		omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
 
 	}
 }
@@ -500,14 +494,12 @@ int omap2_clk_enable(struct clk *clk)
 			return ret;
 		}
 
-		if (clk->clkdm.ptr)
-			omap2_clkdm_clk_enable(clk->clkdm.ptr, clk);
+		omap2_clkdm_clk_enable(clk->clkdm.ptr, clk);
 
 		ret = _omap2_clk_enable(clk);
 
 		if (ret != 0) {
-			if (clk->clkdm.ptr)
-				omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
+			omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
 
 			if (clk->parent) {
 				omap2_clk_disable(clk->parent);
@@ -1088,6 +1080,12 @@ void omap2_clk_disable_unused(struct clk *clk)
 
 int omap2_clk_register(struct clk *clk)
 {
+	if (!clk->clkdm.name) {
+		pr_debug("clock: %s: missing clockdomain", clk->name);
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	omap2_init_clk_clkdm(clk);
 	return 0;
 }


