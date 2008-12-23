From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 17/22] OMAP2/3 clock: omap2_clk_enable(): refactor usecount
	check
Date: Mon, 22 Dec 2008 23:38:42 -0700
Message-ID: <20081223063841.8542.22498.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52928 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbYLWGj4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:56 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Clean up omap2_clk_enable() by moving most of the function body out of
the usecount check.  Should result in no functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index cdad2ae..ab133b2 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -491,26 +491,27 @@ int omap2_clk_enable(struct clk *clk)
 {
 	int ret = 0;
 
-	if (clk->usecount++ == 0) {
-		if (clk->parent)
-			ret = omap2_clk_enable(clk->parent);
+	if (++clk->usecount > 1)
+		return 0;
 
-		if (ret != 0) {
-			clk->usecount--;
-			return ret;
-		}
+	if (clk->parent)
+		ret = omap2_clk_enable(clk->parent);
+
+	if (ret != 0) {
+		clk->usecount--;
+		return ret;
+	}
 
-		omap2_clkdm_clk_enable(clk->clkdm.ptr, clk);
+	omap2_clkdm_clk_enable(clk->clkdm.ptr, clk);
 
-		ret = _omap2_clk_enable(clk);
+	ret = _omap2_clk_enable(clk);
 
-		if (ret != 0) {
-			omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
+	if (ret != 0) {
+		omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
 
-			if (clk->parent) {
-				omap2_clk_disable(clk->parent);
-				clk->usecount--;
-			}
+		if (clk->parent) {
+			omap2_clk_disable(clk->parent);
+			clk->usecount--;
 		}
 	}
 


