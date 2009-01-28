From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH F 10/12] OMAP2/3 clock: omap2_clk_enable(): fix logic
Date: Wed, 28 Jan 2009 12:35:28 -0700
Message-ID: <20090128193525.2396.11744.stgit@localhost.localdomain>
References: <20090128193326.2396.9437.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47890 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546AbZA1UcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:32:24 -0500
In-Reply-To: <20090128193326.2396.9437.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Rearrange the parent clock enable status check code so it actually makes
sense.  No functional change.

linux-omap source commit is 8f0680aff352906b81c49b0450172ffa690b03bb.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5f17a2c..72e3db8 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -481,20 +481,23 @@ void omap2_clk_disable(struct clk *clk)
 
 int omap2_clk_enable(struct clk *clk)
 {
-	int ret = 0;
+	int ret;
 
 	if (++clk->usecount > 1)
 		return 0;
 
 	omap2_clkdm_clk_enable(clk->clkdm.ptr, clk);
 
-	if (clk->parent)
-		ret = omap2_clk_enable(clk->parent);
+	if (clk->parent) {
+		int parent_ret;
 
-	if (ret != 0) {
-		clk->usecount--;
-		omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
-		return ret;
+		parent_ret = omap2_clk_enable(clk->parent);
+
+		if (parent_ret != 0) {
+			clk->usecount--;
+			omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
+			return parent_ret;
+		}
 	}
 
 	ret = _omap2_clk_enable(clk);


