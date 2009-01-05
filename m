From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 21/23] OMAP2/3 clock: omap2_clk_enable(): fix logic
Date: Sun, 04 Jan 2009 19:35:01 -0700
Message-ID: <20090105023500.12661.37451.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36223 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZAEDXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:23:01 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Rearrange the parent clock enable status check code so it actually makes
sense.  No functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index a9a2bbf..413fb68 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -483,20 +483,23 @@ void omap2_clk_disable(struct clk *clk)
 
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


