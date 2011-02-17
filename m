From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] OMAP2xxx: clock: fix parents for L3-derived clocks
Date: Wed, 16 Feb 2011 21:17:51 -0700
Message-ID: <20110217041749.16009.43307.stgit@twilight.localdomain>
References: <20110217041437.16009.52336.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55843 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab1BQES3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 23:18:29 -0500
In-Reply-To: <20110217041437.16009.52336.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Several clocks are listed as having the core L4 clock as their parent,
when they are actually derived from the L3 clock.  Fix these.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 68c0369..693a0a8 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1614,7 +1614,7 @@ static struct clk sdma_fck = {
 static struct clk sdma_ick = {
 	.name		= "sdma_ick",
 	.ops		= &clkops_omap2_iclk_idle_only,
-	.parent		= &l4_ck,
+	.parent		= &core_l3_ck,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP24XX_AUTO_SDMA_SHIFT,
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 34daed9..f00f52e 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1652,7 +1652,7 @@ static struct clk sdma_fck = {
 static struct clk sdma_ick = {
 	.name		= "sdma_ick",
 	.ops		= &clkops_omap2_iclk_idle_only,
-	.parent		= &l4_ck,
+	.parent		= &core_l3_ck,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP24XX_AUTO_SDMA_SHIFT,
@@ -1662,9 +1662,9 @@ static struct clk sdma_ick = {
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.ops		= &clkops_omap2_iclk_idle_only,
-	.parent		= &l4_ck,
+	.parent		= &core_l3_ck,
 	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l4_clkdm",
+	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
 	.recalc		= &followparent_recalc,


