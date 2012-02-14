From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/6] arm: omap3: set autoidle flags for a few clocks
Date: Tue, 14 Feb 2012 18:36:41 +0200
Message-ID: <1329237402-26008-6-git-send-email-t-kristo@ti.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49334 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756718Ab2BNQug (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 11:50:36 -0500
In-Reply-To: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

dpll3, dpll4 and sdrc_ick are controlled automatically by hardware.
Thus, reflect this with the autoidle flags, the clocks will no longer
show as active in usecount dumps and will allow the voltdm->sleep /
wakeup calls to work properly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d75e5f6..f3ee983 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -432,6 +432,7 @@ static struct clk dpll3_ck = {
 	.round_rate	= &omap2_dpll_round_rate,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_dpll_recalc,
+	.autoidle	= true,
 };
 
 /*
@@ -615,6 +616,7 @@ static struct clk dpll4_ck = {
 	.set_rate	= &omap3_dpll4_set_rate,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_dpll_recalc,
+	.autoidle	= true,
 };
 
 /*
@@ -1744,6 +1746,7 @@ static struct clk sdrc_ick = {
 	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
+	.autoidle	= true,
 };
 
 static struct clk gpmc_fck = {
-- 
1.7.4.1

