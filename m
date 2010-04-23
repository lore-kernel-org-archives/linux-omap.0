From: Ambresh K <ambresh@ti.com>
Subject: [PATCH] OMAP3: CLK: FIX: warning SR fclk clk domain not found
Date: Fri, 23 Apr 2010 11:11:28 +0530
Message-ID: <1272001288-6981-1-git-send-email-ambresh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41373 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799Ab0DWFjx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Apr 2010 01:39:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Added clock domain name to sr[1,2] clk structure to fix warning
while initialising sr hwmod during boot-up.

Signed-off-by: Ambresh K <ambresh@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..8a49d8a 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3100,6 +3100,7 @@ static struct clk sr1_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -3110,6 +3111,7 @@ static struct clk sr2_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.6.0.4

