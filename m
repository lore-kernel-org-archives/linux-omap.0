From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH F 08/12] OMAP2/3 clock: omap2_clk_enable(): fix bugs in
	clockdomain handling
Date: Wed, 28 Jan 2009 12:35:22 -0700
Message-ID: <20090128193519.2396.80753.stgit@localhost.localdomain>
References: <20090128193326.2396.9437.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47821 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474AbZA1UcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:32:16 -0500
In-Reply-To: <20090128193326.2396.9437.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

omap2_clk_enable() should enable a clock's clockdomain before
attempting to enable its parent clock's clockdomain.  Similarly, in
the unlikely event that the parent clock enable fails, the clockdomain
should be disabled.

linux-omap source commit is 6d6e285e5a7912b1ea68fadac387304c914aaba8.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6ab9de3..adbb928 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -486,16 +486,17 @@ int omap2_clk_enable(struct clk *clk)
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


