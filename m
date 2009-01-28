From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH F 07/12] OMAP2/3 clock: omap2_clk_enable(): refactor usecount
	check
Date: Wed, 28 Jan 2009 12:35:19 -0700
Message-ID: <20090128193515.2396.44218.stgit@localhost.localdomain>
References: <20090128193326.2396.9437.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47836 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbZA1UcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:32:19 -0500
In-Reply-To: <20090128193326.2396.9437.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Clean up omap2_clk_enable() by moving most of the function body out of
the usecount check.  Should result in no functional change.

linux-omap source commit is 18d4ecba1c1afc52379d5395766f442948822fc0.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 600b2f4..6ab9de3 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -483,26 +483,27 @@ int omap2_clk_enable(struct clk *clk)
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
 


