From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] OMAP: mcbsp: Signle function for CLKR/FSR source mux configuration
Date: Thu, 22 Dec 2011 19:31:43 +0200
Message-ID: <1324575106-17172-3-git-send-email-peter.ujfalusi@ti.com>
References: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:33638 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753226Ab1LVRb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:31:57 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id j13so2924520lah.25
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:31:55 -0800 (PST)
In-Reply-To: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Use single function to configure the CLKR/FSR mux configuration.
OMAP2/3 has 6 pin configuration on McBSP1 instance, while on OMAP4
McBSP4 instance have the 6 pin configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |   13 +++++------
 arch/arm/plat-omap/mcbsp.c              |   35 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 8fa74e2..7f9a745 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -242,13 +242,11 @@ enum {
 #define RFSREN			0x0002
 #define RSYNCERREN		0x0001
 
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
@@ -381,6 +379,7 @@ extern int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id);
 /* McBSP signal muxing API */
 void omap2_mcbsp1_mux_clkr_src(u8 mux);
 void omap2_mcbsp1_mux_fsr_src(u8 mux);
+int omap_mcbsp_6pin_src_mux(unsigned int id, u8 mux);
 
 int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream);
 int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f2eb1bb..501c6d1 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -957,6 +957,41 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 }
 EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
 
+int omap_mcbsp_6pin_src_mux(unsigned int id, u8 mux)
+{
+	struct omap_mcbsp *mcbsp;
+	const char *signal, *src;
+	int ret = 0;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -EINVAL;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	if (mux == CLKR_SRC_CLKR) {
+		signal = "clkr";
+		src = "clkr";
+	} else if (mux == CLKR_SRC_CLKX) {
+		signal = "clkr";
+		src = "clkx";
+	} else if (mux == FSR_SRC_FSR) {
+		signal = "fsr";
+		src = "fsr";
+	} else if (mux == FSR_SRC_FSX) {
+		signal = "fsr";
+		src = "fsx";
+	} else
+		return -EINVAL;
+
+	if (mcbsp->pdata->mux_signal)
+		ret = mcbsp->pdata->mux_signal(mcbsp->dev, signal, src);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_mcbsp_6pin_src_mux);
+
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
 #define THRESHOLD_PROP_BUILDER(prop)					\
-- 
1.7.8.1

