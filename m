From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] OMAP2xxx: clock: fix clockdomains on gpt7_ick,
	2430 mmchs2_fck clocks
Date: Fri, 25 Feb 2011 17:20:09 -0700
Message-ID: <20110226002007.28142.46162.stgit@twilight.localdomain>
References: <20110226001601.28142.46636.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46819 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab1BZAUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 19:20:49 -0500
In-Reply-To: <20110226001601.28142.46636.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add a clockdomain to the GPTIMER7 interface and 2430 HSMMC2 functional
clocks - both were previously missing them.

Also, the 2430 mmchs1_fck is in core_l3_clkdm, but should be in
core_l4_clkdm; fix this.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    1 +
 arch/arm/mach-omap2/clock2430_data.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 53bd999..5e80d3d 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -987,6 +987,7 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
 	.parent		= &l4_ck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 36dde26..8957fc6 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -975,6 +975,7 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
 	.parent		= &l4_ck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1747,7 +1748,7 @@ static struct clk mmchs1_fck = {
 	.name		= "mmchs1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l3_clkdm",
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1767,6 +1768,7 @@ static struct clk mmchs2_fck = {
 	.name		= "mmchs2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,


