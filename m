From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/22] OMAP2/3 clock: every clock must have a clkdm
Date: Mon, 22 Dec 2008 23:38:41 -0700
Message-ID: <20081223063840.8542.92681.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52919 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYLWGjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:55 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Every OMAP2/3 clock must now have an assigned clockdomain, so we can
remove the checks from clk_enable()/clk_disable().

Ideally we would verify that the clockdomain is present during
clk_register(), but this is kind of a pain since OMAP1 doesn't have
the clkdm union in its struct clk.  In the future we should extend
arch_clocks to take architecture-specific clk_register() and
clk_unregister() functions to handle this kind of situation.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0946a5a..cdad2ae 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -202,6 +202,7 @@ void omap2_init_clk_clkdm(struct clk *clk)
 
 	if (!clk->clkdm.name) {
 		pr_err("clock: %s: missing clockdomain", clk->name);
+		WARN_ON(1);
 		return;
 	}
 
@@ -481,8 +482,7 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
-		if (clk->clkdm.ptr)
-			omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
+		omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
 
 	}
 }
@@ -500,14 +500,12 @@ int omap2_clk_enable(struct clk *clk)
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


