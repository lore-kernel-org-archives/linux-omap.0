From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH]OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under DVFS+SR
 operation
Date: Fri, 4 Dec 2009 11:16:04 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9DE3E8952@dnce01.ent.ti.com>
References: <1259918576-31870-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49281 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493AbZLDKQC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 05:16:02 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nB4AG87a014581
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 04:16:08 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nB4AG8mK019306
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 04:16:08 -0600 (CST)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nB4AG7Vv012380
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 04:16:07 -0600 (CST)
Content-Class: urn:content-classes:message
In-Reply-To: <1259918576-31870-1-git-send-email-vishwanath.bs@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Vishwanath,

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Sripathy, Vishwanath
>
>From: Shweta Gulati <shweta.gulati@ti.com>
>
>DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM UCs
>running DSP codec was earlier restricted as DSP crashed.
>The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
>The workaround is:
>       For DPLL2 (DSP) select CORECLK/4 as DPLL2 bypass clock for 3430.
>       Select CORECLK/2 as DPLL2 bypass clock for 3630.
>During DPLL2 relock phase, DSP clock will be 83MHz/200MHz which is always
>OK
>irrespective of Vdd1 voltage.
>
>For DPLL1 (MPU), prior to any DVFS transition to OPP1, select CORECLK/4
>       (CORECLK/2 for 3630) as DPLL1 bypass clock.
>       For other OPPs select CORECLK/2 (CORECLK/1 for 3630) as DPLL1 bypass
>       clock.

I think that you should not rely on the OMAP version to select the correct
bypass freq. Both 3430 and 3630 can support CORECLK/2 at OPP50. CORECLK/4
should be used only if OPP25 is selected. The fact that OPP25 will not be
used on 3630 should not be captured here.
The divider selection should be only based on the OPP. It will work the same
way for all OMAP3 variants.

Regards,
Benoit

>These configurations are typically set in bootloader. However bootloaders
>may
>mess up configuration and kernel with this chang ensures that system is in
>a
>known state.
>
>Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>---
> arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++--
> arch/arm/mach-omap2/pm34xx.c          |   19 +++++++++++++++++++
> arch/arm/mach-omap2/resource34xx.c    |   20 ++++++++++++++++++++
> 3 files changed, 41 insertions(+), 2 deletions(-)
> mode change 100644 => 100755 arch/arm/mach-omap2/cm-regbits-34xx.h
> mode change 100644 => 100755 arch/arm/mach-omap2/pm34xx.c
> mode change 100644 => 100755 arch/arm/mach-omap2/resource34xx.c
>
>diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-
>omap2/cm-regbits-34xx.h
>index 6f2802b..0cf9a5d
>--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
>+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
>@@ -81,7 +81,7 @@
>
> /* CM_CLKSEL1_PLL_IVA2 */
> #define OMAP3430_IVA2_CLK_SRC_SHIFT                   19
>-#define OMAP3430_IVA2_CLK_SRC_MASK                    (0x3 << 19)
>+#define OMAP3430_IVA2_CLK_SRC_MASK                    (0x7 << 19)
> #define OMAP3430_IVA2_DPLL_MULT_SHIFT                 8
> #define OMAP3430_IVA2_DPLL_MULT_MASK                  (0x7ff << 8)
> #define OMAP3430_IVA2_DPLL_DIV_SHIFT                  0
>@@ -126,7 +126,7 @@
>
> /* CM_CLKSEL1_PLL_MPU */
> #define OMAP3430_MPU_CLK_SRC_SHIFT                    19
>-#define OMAP3430_MPU_CLK_SRC_MASK                     (0x3 << 19)
>+#define OMAP3430_MPU_CLK_SRC_MASK                     (0x7 << 19)
> #define OMAP3430_MPU_DPLL_MULT_SHIFT                  8
> #define OMAP3430_MPU_DPLL_MULT_MASK                   (0x7ff << 8)
> #define OMAP3430_MPU_DPLL_DIV_SHIFT                   0
>diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>index c328164..f260072
>--- a/arch/arm/mach-omap2/pm34xx.c
>+++ b/arch/arm/mach-omap2/pm34xx.c
>@@ -802,6 +802,25 @@ static void __init omap3_d2d_idle(void)
>
> static void __init prcm_setup_regs(void)
> {
>+      u32 cm_clksel1_mpu, cm_clksel1_iva2;
>+
>+      /*set Bypass clock dividers for MPU and IVA */
>+      cm_clksel1_mpu = cm_read_mod_reg(MPU_MOD, CM_CLKSEL1);
>+      cm_clksel1_iva2 = cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
>+      if (cpu_is_omap3630()) {
>+              cm_clksel1_iva2 = (cm_clksel1_iva2 &
>~(OMAP3430_IVA2_CLK_SRC_MASK)) |
>+                                      (0x2 << OMAP3430_IVA2_CLK_SRC_SHIFT);
>+              cm_clksel1_mpu = (cm_clksel1_mpu &
>~(OMAP3430_MPU_CLK_SRC_MASK)) |
>+                                      (0x1 << OMAP3430_MPU_CLK_SRC_SHIFT);
>+      } else if (cpu_is_omap34xx()) {
>+              cm_clksel1_iva2 = (cm_clksel1_iva2 &
>~(OMAP3430_IVA2_CLK_SRC_MASK)) |
>+                                      (0x4 << OMAP3430_IVA2_CLK_SRC_SHIFT);
>+              cm_clksel1_mpu = (cm_clksel1_mpu &
>~(OMAP3430_MPU_CLK_SRC_MASK)) |
>+                                      (0x2 << OMAP3430_MPU_CLK_SRC_SHIFT);
>+              }
>+      cm_write_mod_reg(cm_clksel1_iva2, OMAP3430_IVA2_MOD, CM_CLKSEL1);
>+      cm_write_mod_reg(cm_clksel1_mpu, MPU_MOD, CM_CLKSEL1);
>+
>       /* XXX Reset all wkdeps. This should be done when initializing
>        * powerdomains */
>       prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
>diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-
>omap2/resource34xx.c
>index 04be4d2..8c3f2b3
>--- a/arch/arm/mach-omap2/resource34xx.c
>+++ b/arch/arm/mach-omap2/resource34xx.c
>@@ -242,9 +242,29 @@ static int program_opp_freq(int res, int target_level,
>int current_level)
> {
>       int ret = 0, l3_div;
>       int *curr_opp;
>+      u32 cm_clksel1_mpu;
>
>       lock_scratchpad_sem();
>       if (res == VDD1_OPP) {
>+              if (target_level == VDD1_OPP1) {
>+                      cm_clksel1_mpu = cm_read_mod_reg(MPU_MOD, CM_CLKSEL1);
>+                      if (cpu_is_omap3630())
>+                              cm_clksel1_mpu = (cm_clksel1_mpu &
>~(OMAP3430_MPU_CLK_SRC_MASK)) |
>+                                                      (0x2 <<
>OMAP3430_MPU_CLK_SRC_SHIFT);
>+                      else if (cpu_is_omap34xx())
>+                              cm_clksel1_mpu = (cm_clksel1_mpu &
>~(OMAP3430_MPU_CLK_SRC_MASK)) |
>+                                                      (0x4 <<
>OMAP3430_MPU_CLK_SRC_SHIFT);
>+                      cm_write_mod_reg(cm_clksel1_mpu, MPU_MOD, CM_CLKSEL1);
>+              } else if ((current_level == VDD1_OPP1) && (target_level !=
>VDD1_OPP1)) {
>+                      cm_clksel1_mpu = cm_read_mod_reg(MPU_MOD, CM_CLKSEL1);
>+                      if (cpu_is_omap3630())
>+                              cm_clksel1_mpu = (cm_clksel1_mpu &
>~(OMAP3430_MPU_CLK_SRC_MASK)) |
>+                                                      (0x1 <<
>OMAP3430_MPU_CLK_SRC_SHIFT);
>+                      else if (cpu_is_omap34xx())
>+                              cm_clksel1_mpu = (cm_clksel1_mpu &
>~(OMAP3430_MPU_CLK_SRC_MASK)) |
>+                                                      (0x2 <<
>OMAP3430_MPU_CLK_SRC_SHIFT);
>+                      cm_write_mod_reg(cm_clksel1_mpu, MPU_MOD, CM_CLKSEL1);
>+              }
>               curr_opp = &curr_vdd1_opp;
>               clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
>               clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
>--
>1.5.6.3
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



