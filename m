From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 05/11] OMAP3 clock: remove superfluous calls to
	omap2_init_clk_clkdm
Date: Tue, 18 Aug 2009 14:56:26 +0300
Message-ID: <20090818115625.14171.61952.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090818115147.14171.55785.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

omap2_init_clk_clkdm() is called as part of the chip architecture-specific
initialization code, so calling it again from the struct clk init pointer
just wastes cycles.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/clock34xx.h |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 9a823c3..c811978 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1156,7 +1156,6 @@ static struct clk gfx_cg1_ck = {
 	.name		= "gfx_cg1_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_2D_SHIFT,
 	.clkdm_name	= "gfx_3430es1_clkdm",
@@ -1167,7 +1166,6 @@ static struct clk gfx_cg2_ck = {
 	.name		= "gfx_cg2_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_3D_SHIFT,
 	.clkdm_name	= "gfx_3430es1_clkdm",
@@ -1211,7 +1209,6 @@ static struct clk sgx_ick = {
 	.name		= "sgx_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT,
 	.clkdm_name	= "sgx_clkdm",
@@ -1224,7 +1221,6 @@ static struct clk d2d_26m_fck = {
 	.name		= "d2d_26m_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_D2D_SHIFT,
 	.clkdm_name	= "d2d_clkdm",
@@ -1235,7 +1231,6 @@ static struct clk modem_fck = {
 	.name		= "modem_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MODEM_SHIFT,
 	.clkdm_name	= "d2d_clkdm",
@@ -1623,7 +1618,6 @@ static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1692,7 +1686,6 @@ static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2090,7 +2083,6 @@ static struct clk dss_tv_fck = {
 	.name		= "dss_tv_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_54m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.clkdm_name	= "dss_clkdm",
@@ -2101,7 +2093,6 @@ static struct clk dss_96m_fck = {
 	.name		= "dss_96m_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_96m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.clkdm_name	= "dss_clkdm",
@@ -2112,7 +2103,6 @@ static struct clk dss2_alwon_fck = {
 	.name		= "dss2_alwon_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_DSS2_SHIFT,
 	.clkdm_name	= "dss_clkdm",
@@ -2124,7 +2114,6 @@ static struct clk dss_ick_3430es1 = {
 	.name		= "dss_ick",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
 	.clkdm_name	= "dss_clkdm",
@@ -2136,7 +2125,6 @@ static struct clk dss_ick_3430es2 = {
 	.name		= "dss_ick",
 	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
 	.clkdm_name	= "dss_clkdm",
@@ -2160,7 +2148,6 @@ static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.clkdm_name	= "cam_clkdm",
@@ -2171,7 +2158,6 @@ static struct clk csi2_96m_fck = {
 	.name		= "csi2_96m_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_96m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
 	.clkdm_name	= "cam_clkdm",
@@ -2184,7 +2170,6 @@ static struct clk usbhost_120m_fck = {
 	.name		= "usbhost_120m_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &dpll5_m2_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST2_SHIFT,
 	.clkdm_name	= "usbhost_clkdm",
@@ -2195,7 +2180,6 @@ static struct clk usbhost_48m_fck = {
 	.name		= "usbhost_48m_fck",
 	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
 	.parent		= &omap_48m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST1_SHIFT,
 	.clkdm_name	= "usbhost_clkdm",
@@ -2207,7 +2191,6 @@ static struct clk usbhost_ick = {
 	.name		= "usbhost_ick",
 	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
 	.clkdm_name	= "usbhost_clkdm",
@@ -2269,7 +2252,6 @@ static struct clk gpt1_fck = {
 static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
 	.ops		= &clkops_null,
-	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
@@ -2384,7 +2366,6 @@ static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2393,7 +2374,6 @@ static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };


--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
