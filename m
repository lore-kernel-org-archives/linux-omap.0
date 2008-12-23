From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 18/22] OMAP2/3 clock: omap2_clk_enable(): fix bugs in
	clockdomain handling
Date: Mon, 22 Dec 2008 23:38:43 -0700
Message-ID: <20081223063842.8542.20173.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52909 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbYLWGjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:51 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

omap2_clk_enable() should enable a clock's clockdomain before
attempting to enable its parent clock's clockdomain.  Similarly, in
the unlikely event that the parent clock enable fails, the clockdomain
should be disabled.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ab133b2..6a4bb39 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -494,16 +494,17 @@ int omap2_clk_enable(struct clk *clk)
 	if (++clk->usecount > 1)
 		return 0;
 
+	omap2_clkdm_clk_enable(clk->clkdm.ptr, clk);
+
 	if (clk->parent)
 		ret = omap2_clk_enable(clk->parent);
 
 	if (ret != 0) {
 		clk->usecount--;
+		omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
 		return ret;
 	}
 
-	omap2_clkdm_clk_enable(clk->clkdm.ptr, clk);
-
 	ret = _omap2_clk_enable(clk);
 
 	if (ret != 0) {


