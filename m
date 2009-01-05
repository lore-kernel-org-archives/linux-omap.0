From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 19/23] OMAP2/3 clock: omap2_clk_enable(): fix bugs in
	clockdomain handling
Date: Sun, 04 Jan 2009 19:34:59 -0700
Message-ID: <20090105023459.12661.19476.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42910 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbZAEDW5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:57 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
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
index 3f8354d..55f43d0 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -488,16 +488,17 @@ int omap2_clk_enable(struct clk *clk)
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


