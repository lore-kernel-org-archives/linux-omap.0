From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 5/9] ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code
Date: Mon, 13 Aug 2012 17:22:44 +0300
Message-ID: <1344867768-26335-6-git-send-email-peter.ujfalusi@ti.com>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48345 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553Ab2HMOXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 10:23:20 -0400
Received: by obbtb18 with SMTP id tb18so9588712obb.21
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 07:22:48 -0700 (PDT)
In-Reply-To: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Remove the feature to configure the CLKR/FSR mux on McBSP port with 6pin
configuration.
When moving to devicetree these callback can no longer be used in a clean
way anymore.
If a board require to change the 6pin port to work in 4pin setup it needs
to set up the mux in the board file.
For OMAP2/3:
u32 devconf0;

/* McBSP1 CLKR/FSR signal to be connected to CLKX/FSX pin */
devconf0 = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
devconf0 |=  OMAP2_MCBSP1_CLKR_MASK | OMAP2_MCBSP1_FSR_MASK;
omap_ctrl_writel(devconf0, OMAP2_CONTROL_DEVCONF0);

For OMAP4:
u32 mcbsp_pad;

/* McBSP4 CLKR/FSR signal to be connected to CLKX/FSX pin */
mcbsp_pad = omap4_ctrl_pad_readl(OMAP2_CONTROL_DEVCONF0);
mcbsp_pad |=  ((1 << 31) | (1 << 30));
omap4_ctrl_pad_writel(mcbsp_pad, OMAP2_CONTROL_DEVCONF0);

In case when the kernel is booted with DT blob the pinctrl-single will be
provided as soon as it is enabled on the platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   77 -------------------------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 -
 sound/soc/omap/mcbsp.c                  |   31 ------------
 sound/soc/omap/mcbsp.h                  |    3 -
 sound/soc/omap/omap-mcbsp.c             |   32 +------------
 sound/soc/omap/omap-mcbsp.h             |    4 --
 6 files changed, 3 insertions(+), 145 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 6e046e1..660e00b 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -25,8 +25,6 @@
 #include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
 
-#include "control.h"
-
 /*
  * FIXME: Find a mechanism to enable/disable runtime the McBSP ICLK autoidle.
  * Sidetone needs non-gated ICLK and sidetone autoidle is broken.
@@ -34,73 +32,6 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
-/* McBSP1 internal signal muxing function for OMAP2/3 */
-static int omap2_mcbsp1_mux_rx_clk(struct device *dev, const char *signal,
-				   const char *src)
-{
-	u32 v;
-
-	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-
-	if (!strcmp(signal, "clkr")) {
-		if (!strcmp(src, "clkr"))
-			v &= ~OMAP2_MCBSP1_CLKR_MASK;
-		else if (!strcmp(src, "clkx"))
-			v |= OMAP2_MCBSP1_CLKR_MASK;
-		else
-			return -EINVAL;
-	} else if (!strcmp(signal, "fsr")) {
-		if (!strcmp(src, "fsr"))
-			v &= ~OMAP2_MCBSP1_FSR_MASK;
-		else if (!strcmp(src, "fsx"))
-			v |= OMAP2_MCBSP1_FSR_MASK;
-		else
-			return -EINVAL;
-	} else {
-		return -EINVAL;
-	}
-
-	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-
-	return 0;
-}
-
-/* McBSP4 internal signal muxing function for OMAP4 */
-#define OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_FSX	(1 << 31)
-#define OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_CLKX	(1 << 30)
-static int omap4_mcbsp4_mux_rx_clk(struct device *dev, const char *signal,
-				   const char *src)
-{
-	u32 v;
-
-	/*
-	 * In CONTROL_MCBSPLP register only bit 30 (CLKR mux), and bit 31 (FSR
-	 * mux) is used */
-	v = omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP);
-
-	if (!strcmp(signal, "clkr")) {
-		if (!strcmp(src, "clkr"))
-			v &= ~OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_CLKX;
-		else if (!strcmp(src, "clkx"))
-			v |= OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_CLKX;
-		else
-			return -EINVAL;
-	} else if (!strcmp(signal, "fsr")) {
-		if (!strcmp(src, "fsr"))
-			v &= ~OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_FSX;
-		else if (!strcmp(src, "fsx"))
-			v |= OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_FSX;
-		else
-			return -EINVAL;
-	} else {
-		return -EINVAL;
-	}
-
-	omap4_ctrl_pad_writel(v, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP);
-
-	return 0;
-}
-
 static int omap3_enable_st_clock(unsigned int id, bool enable)
 {
 	unsigned int w;
@@ -143,14 +74,6 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		pdata->has_ccr = true;
 	}
 
-	/* On OMAP2/3 the McBSP1 port has 6 pin configuration */
-	if (id == 1 && oh->class->rev < MCBSP_CONFIG_TYPE4)
-		pdata->mux_signal = omap2_mcbsp1_mux_rx_clk;
-
-	/* On OMAP4 the McBSP4 port has 6 pin configuration */
-	if (id == 4 && oh->class->rev == MCBSP_CONFIG_TYPE4)
-		pdata->mux_signal = omap4_mcbsp4_mux_rx_clk;
-
 	if (oh->class->rev == MCBSP_CONFIG_TYPE2) {
 		/* The FIFO has 128 locations */
 		pdata->buffer_size = 0x80;
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 0a7d5ca..c78d90b 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -47,7 +47,6 @@ struct omap_mcbsp_platform_data {
 	bool has_wakeup; /* Wakeup capability */
 	bool has_ccr; /* Transceiver has configuration control registers */
 	int (*enable_st_clock)(unsigned int, bool);
-	int (*mux_signal)(struct device *dev, const char *signal, const char *src);
 };
 
 /**
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index d901fc0..c870023 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -762,37 +762,6 @@ int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 
 }
 
-int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
-{
-	const char *signal, *src;
-
-	if (!mcbsp->pdata->mux_signal)
-		return -EINVAL;
-
-	switch (mux) {
-	case CLKR_SRC_CLKR:
-		signal = "clkr";
-		src = "clkr";
-		break;
-	case CLKR_SRC_CLKX:
-		signal = "clkr";
-		src = "clkx";
-		break;
-	case FSR_SRC_FSR:
-		signal = "fsr";
-		src = "fsr";
-		break;
-	case FSR_SRC_FSX:
-		signal = "fsr";
-		src = "fsx";
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return mcbsp->pdata->mux_signal(mcbsp->dev, signal, src);
-}
-
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
 #define THRESHOLD_PROP_BUILDER(prop)					\
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 262a615..49a6725 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -334,9 +334,6 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx);
 /* McBSP functional clock source changing function */
 int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id);
 
-/* McBSP signal muxing API */
-int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux);
-
 /* Sidetone specific API */
 int omap_st_set_chgain(struct omap_mcbsp *mcbsp, int channel, s16 chgain);
 int omap_st_get_chgain(struct omap_mcbsp *mcbsp, int channel, s16 *chgain);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 1046083..5061594 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -516,21 +516,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			return -EBUSY;
 	}
 
-	if (clk_id == OMAP_MCBSP_SYSCLK_CLK ||
-	    clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK ||
-	    clk_id == OMAP_MCBSP_SYSCLK_CLKS_EXT ||
-	    clk_id == OMAP_MCBSP_SYSCLK_CLKX_EXT ||
-	    clk_id == OMAP_MCBSP_SYSCLK_CLKR_EXT) {
-		mcbsp->in_freq = freq;
-		regs->srgr2	&= ~CLKSM;
-		regs->pcr0	&= ~SCLKME;
-	} else if (cpu_class_is_omap1()) {
-		/*
-		 * McBSP CLKR/FSR signal muxing functions are only available on
-		 * OMAP2 or newer versions
-		 */
-		return -EINVAL;
-	}
+	mcbsp->in_freq = freq;
+	regs->srgr2 &= ~CLKSM;
+	regs->pcr0 &= ~SCLKME;
 
 	switch (clk_id) {
 	case OMAP_MCBSP_SYSCLK_CLK:
@@ -558,20 +546,6 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
 		regs->pcr0	|= SCLKME;
 		break;
-
-
-	case OMAP_MCBSP_CLKR_SRC_CLKR:
-		err = omap_mcbsp_6pin_src_mux(mcbsp, CLKR_SRC_CLKR);
-		break;
-	case OMAP_MCBSP_CLKR_SRC_CLKX:
-		err = omap_mcbsp_6pin_src_mux(mcbsp, CLKR_SRC_CLKX);
-		break;
-	case OMAP_MCBSP_FSR_SRC_FSR:
-		err = omap_mcbsp_6pin_src_mux(mcbsp, FSR_SRC_FSR);
-		break;
-	case OMAP_MCBSP_FSR_SRC_FSX:
-		err = omap_mcbsp_6pin_src_mux(mcbsp, FSR_SRC_FSX);
-		break;
 	default:
 		err = -ENODEV;
 	}
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index f877b16..baebcee 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -32,10 +32,6 @@ enum omap_mcbsp_clksrg_clk {
 	OMAP_MCBSP_SYSCLK_CLK,		/* Internal ICLK */
 	OMAP_MCBSP_SYSCLK_CLKX_EXT,	/* External CLKX pin */
 	OMAP_MCBSP_SYSCLK_CLKR_EXT,	/* External CLKR pin */
-	OMAP_MCBSP_CLKR_SRC_CLKR,	/* CLKR from CLKR pin */
-	OMAP_MCBSP_CLKR_SRC_CLKX,	/* CLKR from CLKX pin */
-	OMAP_MCBSP_FSR_SRC_FSR,		/* FSR from FSR pin */
-	OMAP_MCBSP_FSR_SRC_FSX,		/* FSR from FSX pin */
 };
 
 /* McBSP dividers */
-- 
1.7.8.6

