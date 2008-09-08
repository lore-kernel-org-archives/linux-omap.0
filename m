From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/12] OMAP3 clock: remove duplicate call to
	omap2_init_clk_clkdm()
Date: Mon, 08 Sep 2008 10:57:49 -0600
Message-ID: <20080908165748.2540.77745.stgit@localhost.localdomain>
References: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49069 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbYIIIVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:21:01 -0400
In-Reply-To: <20080908164444.2540.98619.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

The OMAP3 arch clock init code already calls omap2_init_clk_clkdm(), so there
is no reason to call it again in the per-clock init.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 8fe87e3..65568c3 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1337,7 +1337,6 @@ static struct clk gfx_l3_ick = {
 static struct clk gfx_cg1_ck = {
 	.name		= "gfx_cg1_ck",
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_2D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
@@ -1348,7 +1347,6 @@ static struct clk gfx_cg1_ck = {
 static struct clk gfx_cg2_ck = {
 	.name		= "gfx_cg2_ck",
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_3D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
@@ -1392,7 +1390,6 @@ static struct clk sgx_fck = {
 static struct clk sgx_ick = {
 	.name		= "sgx_ick",
 	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -1405,7 +1402,6 @@ static struct clk sgx_ick = {
 static struct clk d2d_26m_fck = {
 	.name		= "d2d_26m_fck",
 	.parent		= &sys_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_D2D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
@@ -1768,7 +1764,6 @@ static struct clk ssi_sst_fck = {
 static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
 	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l3_clkdm" },
@@ -1830,7 +1825,6 @@ static struct clk pka_ick = {
 static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
@@ -2230,7 +2224,6 @@ static struct clk dss1_alwon_fck = {
 static struct clk dss_tv_fck = {
 	.name		= "dss_tv_fck",
 	.parent		= &omap_54m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2241,7 +2234,6 @@ static struct clk dss_tv_fck = {
 static struct clk dss_96m_fck = {
 	.name		= "dss_96m_fck",
 	.parent		= &omap_96m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2252,7 +2244,6 @@ static struct clk dss_96m_fck = {
 static struct clk dss2_alwon_fck = {
 	.name		= "dss2_alwon_fck",
 	.parent		= &sys_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_DSS2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2264,7 +2255,6 @@ static struct clk dss_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2298,7 +2288,6 @@ static struct clk cam_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "cam_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2322,7 +2311,6 @@ static struct clk csi2_96m_fck = {
 static struct clk usbhost_120m_fck = {
 	.name		= "usbhost_120m_fck",
 	.parent		= &omap_120m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST2_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -2333,7 +2321,6 @@ static struct clk usbhost_120m_fck = {
 static struct clk usbhost_48m_fck = {
 	.name		= "usbhost_48m_fck",
 	.parent		= &omap_48m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST1_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -2345,7 +2332,6 @@ static struct clk usbhost_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "usbhost_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -2408,7 +2394,6 @@ static struct clk gpt1_fck = {
 
 static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
-	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
@@ -2522,7 +2507,6 @@ static struct clk gpt1_ick = {
 static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "per_clkdm" },
@@ -2532,7 +2516,6 @@ static struct clk per_96m_fck = {
 static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
 	.parent		= &omap_48m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "per_clkdm" },


