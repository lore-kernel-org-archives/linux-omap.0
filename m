From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH F 09/12] OMAP2/3 clock: omap2_clk_enable(): fix usecount
	decrement bug
Date: Wed, 28 Jan 2009 12:35:25 -0700
Message-ID: <20090128193522.2396.53732.stgit@localhost.localdomain>
References: <20090128193326.2396.9437.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47877 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbZA1UcX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:32:23 -0500
In-Reply-To: <20090128193326.2396.9437.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

If _omap2_clk_enable() fails, the clock's usecount must be decremented by
one no matter whether the clock has a parent or not.

linux-omap source commit is 75fc235fe0f671b56873a75994513df5e665b053.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index adbb928..5f17a2c 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -500,12 +500,10 @@ int omap2_clk_enable(struct clk *clk)
 	ret = _omap2_clk_enable(clk);
 
 	if (ret != 0) {
+		clk->usecount--;
 		omap2_clkdm_clk_disable(clk->clkdm.ptr, clk);
-
-		if (clk->parent) {
+		if (clk->parent)
 			omap2_clk_disable(clk->parent);
-			clk->usecount--;
-		}
 	}
 
 	return ret;


