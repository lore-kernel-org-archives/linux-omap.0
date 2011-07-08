From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/6] OMAP4: PRCM: OMAP4460 specific PRM and CM
 register bitshifts
Date: Fri, 8 Jul 2011 03:51:15 -0700
Message-ID: <20110708105115.GV5783@atomide.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
 <1309573826-10615-2-git-send-email-rnayak@ti.com>
 <1309573826-10615-3-git-send-email-rnayak@ti.com>
 <1309573826-10615-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1107080029550.24181@utopia.booyaka.com>
 <4E16AB3C.7020007@ti.com>
 <alpine.DEB.2.00.1107080133470.24181@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62417 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751604Ab1GHKvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 06:51:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107080133470.24181@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

* Paul Walmsley <paul@pwsan.com> [110708 00:29]:
> On Fri, 8 Jul 2011, Rajendra Nayak wrote:
> 
> > Hi Paul,
> > 
> > On 7/7/2011 11:30 PM, Paul Walmsley wrote:
> > > Hi Rajendra
> > > 
> > > On Sat, 2 Jul 2011, Rajendra Nayak wrote:
> > > 
> > > > This patch adds additional register bitshifts for
> > > > registers added in OMAP4460 platform.
> > > > 
> > > > Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> > > > Signed-off-by: Nishanth Menon<nm@ti.com>
> > > > Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> > > > Reviewed-by: Kevin Hilman<khilman@ti.com>
> > > 
> > > Does this data come from the autogenerator scripts?
> > 
> > Yes, it does. But the patch is created by manually
> > diffing the 4430 and 4460 autogen script outputs.
> > That's because the autogen scripts cannot generate
> > data for multiple SoC's at once.
> 
> Okay.  So then, 
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Here's this one updated.

Tony


From: Rajendra Nayak <rnayak@ti.com>
Date: Sat, 2 Jul 2011 08:00:23 +0530
Subject: [PATCH] OMAP4: PRCM: OMAP4460 specific PRM and CM register bitshifts

This patch adds additional register bitshifts for
registers added in OMAP4460 platform.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
[tony@atomide.com: updated to apply on cleanup patches]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/cm-regbits-44xx.h b/arch/arm/mach-omap2/cm-regbits-44xx.h
index 9d47a05..28e20d3 100644
--- a/arch/arm/mach-omap2/cm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-44xx.h
@@ -106,6 +106,10 @@
 #define OMAP4430_CLKACTIVITY_CORE_DPLL_EMU_CLK_SHIFT		9
 #define OMAP4430_CLKACTIVITY_CORE_DPLL_EMU_CLK_MASK		(1 << 9)
 
+/* Used by CM_L4CFG_CLKSTCTRL */
+#define OMAP4460_CLKACTIVITY_CORE_TS_GFCLK_SHIFT		9
+#define OMAP4460_CLKACTIVITY_CORE_TS_GFCLK_MASK			(1 << 9)
+
 /* Used by CM_CEFUSE_CLKSTCTRL */
 #define OMAP4430_CLKACTIVITY_CUST_EFUSE_SYS_CLK_SHIFT		9
 #define OMAP4430_CLKACTIVITY_CUST_EFUSE_SYS_CLK_MASK		(1 << 9)
@@ -418,6 +422,10 @@
 #define OMAP4430_CLKACTIVITY_WKUP_32K_GFCLK_SHIFT		11
 #define OMAP4430_CLKACTIVITY_WKUP_32K_GFCLK_MASK		(1 << 11)
 
+/* Used by CM_WKUP_CLKSTCTRL */
+#define OMAP4460_CLKACTIVITY_WKUP_TS_GFCLK_SHIFT		13
+#define OMAP4460_CLKACTIVITY_WKUP_TS_GFCLK_MASK			(1 << 13)
+
 /*
  * Used by CM1_ABE_TIMER5_CLKCTRL, CM1_ABE_TIMER6_CLKCTRL,
  * CM1_ABE_TIMER7_CLKCTRL, CM1_ABE_TIMER8_CLKCTRL, CM_L3INIT_MMC1_CLKCTRL,
@@ -449,6 +457,10 @@
 #define OMAP4430_CLKSEL_60M_SHIFT				24
 #define OMAP4430_CLKSEL_60M_MASK				(1 << 24)
 
+/* Used by CM_MPU_MPU_CLKCTRL */
+#define OMAP4460_CLKSEL_ABE_DIV_MODE_SHIFT			25
+#define OMAP4460_CLKSEL_ABE_DIV_MODE_MASK			(1 << 25)
+
 /* Used by CM1_ABE_AESS_CLKCTRL */
 #define OMAP4430_CLKSEL_AESS_FCLK_SHIFT				24
 #define OMAP4430_CLKSEL_AESS_FCLK_MASK				(1 << 24)
@@ -468,6 +480,10 @@
 #define OMAP4430_CLKSEL_DIV_SHIFT				24
 #define OMAP4430_CLKSEL_DIV_MASK				(1 << 24)
 
+/* Used by CM_MPU_MPU_CLKCTRL */
+#define OMAP4460_CLKSEL_EMIF_DIV_MODE_SHIFT			24
+#define OMAP4460_CLKSEL_EMIF_DIV_MODE_MASK			(1 << 24)
+
 /* Used by CM_CAM_FDIF_CLKCTRL */
 #define OMAP4430_CLKSEL_FCLK_SHIFT				24
 #define OMAP4430_CLKSEL_FCLK_MASK				(0x3 << 24)
@@ -572,6 +588,14 @@
 #define OMAP4430_D2D_STATDEP_SHIFT				18
 #define OMAP4430_D2D_STATDEP_MASK				(1 << 18)
 
+/* Used by CM_CLKSEL_DPLL_MPU */
+#define OMAP4460_DCC_COUNT_MAX_SHIFT				24
+#define OMAP4460_DCC_COUNT_MAX_MASK				(0xff << 24)
+
+/* Used by CM_CLKSEL_DPLL_MPU */
+#define OMAP4460_DCC_EN_SHIFT					22
+#define OMAP4460_DCC_EN_MASK					(1 << 22)
+
 /*
  * Used by CM_SSC_DELTAMSTEP_DPLL_ABE, CM_SSC_DELTAMSTEP_DPLL_CORE,
  * CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE, CM_SSC_DELTAMSTEP_DPLL_DDRPHY,
@@ -582,6 +606,10 @@
 #define OMAP4430_DELTAMSTEP_SHIFT				0
 #define OMAP4430_DELTAMSTEP_MASK				(0xfffff << 0)
 
+/* Renamed from DELTAMSTEP Used by CM_SSC_DELTAMSTEP_DPLL_USB */
+#define OMAP4460_DELTAMSTEP_0_20_SHIFT				0
+#define OMAP4460_DELTAMSTEP_0_20_MASK				(0x1fffff << 0)
+
 /* Used by CM_SHADOW_FREQ_CONFIG1, CM_SHADOW_FREQ_CONFIG1_RESTORE */
 #define OMAP4430_DLL_OVERRIDE_SHIFT				2
 #define OMAP4430_DLL_OVERRIDE_MASK				(1 << 2)
@@ -1204,6 +1232,10 @@
 #define OMAP4430_MODULEMODE_SHIFT				0
 #define OMAP4430_MODULEMODE_MASK				(0x3 << 0)
 
+/* Used by CM_L4CFG_DYNAMICDEP */
+#define OMAP4460_MPU_DYNDEP_SHIFT				19
+#define OMAP4460_MPU_DYNDEP_MASK				(1 << 19)
+
 /* Used by CM_DSS_DSS_CLKCTRL */
 #define OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT			9
 #define OMAP4430_OPTFCLKEN_48MHZ_CLK_MASK			(1 << 9)
@@ -1298,6 +1330,10 @@
 #define OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT			10
 #define OMAP4430_OPTFCLKEN_SYS_CLK_MASK				(1 << 10)
 
+/* Used by CM_WKUP_BANDGAP_CLKCTRL */
+#define OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT			8
+#define OMAP4460_OPTFCLKEN_TS_FCLK_MASK				(1 << 8)
+
 /* Used by CM_DSS_DSS_CLKCTRL */
 #define OMAP4430_OPTFCLKEN_TV_CLK_SHIFT				11
 #define OMAP4430_OPTFCLKEN_TV_CLK_MASK				(1 << 11)
diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
index 6d2776f..3cb247b 100644
--- a/arch/arm/mach-omap2/prm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
@@ -283,6 +283,14 @@
 #define OMAP4430_DUCATI_UNICACHE_STATEST_SHIFT				10
 #define OMAP4430_DUCATI_UNICACHE_STATEST_MASK				(0x3 << 10)
 
+/* Used by PRM_DEVICE_OFF_CTRL */
+#define OMAP4460_EMIF1_OFFWKUP_DISABLE_SHIFT				8
+#define OMAP4460_EMIF1_OFFWKUP_DISABLE_MASK				(1 << 8)
+
+/* Used by PRM_DEVICE_OFF_CTRL */
+#define OMAP4460_EMIF2_OFFWKUP_DISABLE_SHIFT				9
+#define OMAP4460_EMIF2_OFFWKUP_DISABLE_MASK				(1 << 9)
+
 /* Used by RM_MPU_RSTST */
 #define OMAP4430_EMULATION_RST_SHIFT					0
 #define OMAP4430_EMULATION_RST_MASK					(1 << 0)
