From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/12] OMAP2xxx clock: fix dss2_fck recalc to use clksel
Date: Mon, 13 Dec 2010 23:34:51 -0700
Message-ID: <20101214063450.21555.2723.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50287 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab0LNGf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:35:27 -0500
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

dss2_fck is a clksel clock, and therefore its rate should be recalculated
with the clksel mechanism.  This was working in early 2009, but was one of
the casualties of the big OMAP clock merge between 2.6.29 and 2.6.30.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 831e25c..7cfa186 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -812,7 +812,7 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
 	.clksel		= dss2_fck_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index a9c60b7..3bd437a 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -800,7 +800,7 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
 	.clksel		= dss2_fck_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */


