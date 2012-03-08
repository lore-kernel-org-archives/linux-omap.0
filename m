From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/3] ASoC: omap-mcbsp: Single function CLKR/FSR source mux configuration
Date: Thu,  8 Mar 2012 11:22:17 +0200
Message-ID: <1331198537-13469-4-git-send-email-peter.ujfalusi@ti.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47453 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756120Ab2CHJWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 04:22:34 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so336501lah.5
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 01:22:32 -0800 (PST)
In-Reply-To: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Use single function for the CLKR/FSR mux configuration.
OMAP2/3 has 6 pin configuration on McBSP1 instance, while on OMAP4
McBSP4 instance have the 6 pin configuration so the omap2_mcbsp1_mux_* is
not correct name for all support OMAP versions

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/mcbsp.c      |   48 +++++++++++++++++++-----------------------
 sound/soc/omap/mcbsp.h      |   15 +++++--------
 sound/soc/omap/omap-mcbsp.c |    8 +++---
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index c3e31de..95413a1 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -687,40 +687,36 @@ int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 		return -EINVAL;
 }
 
-void omap2_mcbsp1_mux_clkr_src(struct omap_mcbsp *mcbsp, u8 mux)
+int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
 {
-	const char *src;
-
-	if (mcbsp->id != 1)
-		return;
+	const char *signal, *src;
+	int ret = 0;
 
-	if (mux == CLKR_SRC_CLKR)
+	switch (mux) {
+	case CLKR_SRC_CLKR:
+		signal = "clkr";
 		src = "clkr";
-	else if (mux == CLKR_SRC_CLKX)
+		break;
+	case CLKR_SRC_CLKX:
+		signal = "clkr";
 		src = "clkx";
-	else
-		return;
-
-	if (mcbsp->pdata->mux_signal)
-		mcbsp->pdata->mux_signal(mcbsp->dev, "clkr", src);
-}
-
-void omap2_mcbsp1_mux_fsr_src(struct omap_mcbsp *mcbsp, u8 mux)
-{
-	const char *src;
-
-	if (mcbsp->id != 1)
-		return;
-
-	if (mux == FSR_SRC_FSR)
+		break;
+	case FSR_SRC_FSR:
+		signal = "fsr";
 		src = "fsr";
-	else if (mux == FSR_SRC_FSX)
+		break;
+	case FSR_SRC_FSX:
+		signal = "fsr";
 		src = "fsx";
-	else
-		return;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	if (mcbsp->pdata->mux_signal)
-		mcbsp->pdata->mux_signal(mcbsp->dev, "fsr", src);
+		ret = mcbsp->pdata->mux_signal(mcbsp->dev, signal, src);
+
+	return ret;
 }
 
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index acc9470..a944fcc 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -230,13 +230,11 @@ enum {
 #define XRDYEN			BIT(10)
 #define XEMPTYEOFEN		BIT(14)
 
-/* CLKR signal muxing options */
-#define CLKR_SRC_CLKR		0
-#define CLKR_SRC_CLKX		1
-
-/* FSR signal muxing options */
-#define FSR_SRC_FSR		0
-#define FSR_SRC_FSX		1
+/* Clock signal muxing options */
+#define CLKR_SRC_CLKR		0 /* CLKR signal is from the CLKR pin */
+#define CLKR_SRC_CLKX		1 /* CLKR signal is from the CLKX pin */
+#define FSR_SRC_FSR		2 /* FSR signal is from the FSR pin */
+#define FSR_SRC_FSX		3 /* FSR signal is from the FSX pin */
 
 /* McBSP functional clock sources */
 #define MCBSP_CLKS_PRCM_SRC	0
@@ -333,8 +331,7 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx);
 int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id);
 
 /* McBSP signal muxing API */
-void omap2_mcbsp1_mux_clkr_src(struct omap_mcbsp *mcbsp, u8 mux);
-void omap2_mcbsp1_mux_fsr_src(struct omap_mcbsp *mcbsp, u8 mux);
+int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux);
 
 /* Sidetone specific API */
 int omap_st_set_chgain(struct omap_mcbsp *mcbsp, int channel, s16 chgain);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 10eb645..d8409b0 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -554,22 +554,22 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case OMAP_MCBSP_CLKR_SRC_CLKR:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_clkr_src(mcbsp, CLKR_SRC_CLKR);
+		err = omap_mcbsp_6pin_src_mux(mcbsp, CLKR_SRC_CLKR);
 		break;
 	case OMAP_MCBSP_CLKR_SRC_CLKX:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_clkr_src(mcbsp, CLKR_SRC_CLKX);
+		err = omap_mcbsp_6pin_src_mux(mcbsp, CLKR_SRC_CLKX);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSR:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_fsr_src(mcbsp, FSR_SRC_FSR);
+		err = omap_mcbsp_6pin_src_mux(mcbsp, FSR_SRC_FSR);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSX:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_fsr_src(mcbsp, FSR_SRC_FSX);
+		err = omap_mcbsp_6pin_src_mux(mcbsp, FSR_SRC_FSX);
 		break;
 	default:
 		err = -ENODEV;
-- 
1.7.8.5

