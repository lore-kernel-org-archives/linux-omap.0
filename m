From: "Chandra shekhar" <x0044955@ti.com>
Subject: [RFC/PATCH  4/4] McBSP support  for 34XX
Date: Mon, 16 Jun 2008 17:51:07 +0530
Message-ID: <003e01c8cfab$7476a930$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52825 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588AbYFPMVc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jun 2008 08:21:32 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5GCL877020128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 07:21:21 -0500
Received: from a0875540 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5GCL3G3023696
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 17:51:07 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: chandra shekhar <x0044955@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c       |  187 ++++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/mcbsp.h |   79 ++++++++++++++++
 2 files changed, 266 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/mcbsp.c	2008-06-16 16:10:03.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c	2008-06-16 16:12:43.061346294 +0530
@@ -24,6 +24,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/mcbsp.h>
 
+struct omap_mcbsp_reg_cfg mcbsp_cfg = {0};
 struct mcbsp_internal_clk {
 	struct clk clk;
 	struct clk **childs;
@@ -217,6 +218,192 @@
 	if (mcbsp_dma_tx->tx_callback != NULL)
 		mcbsp_dma_tx->tx_callback(ch_status, mcbsp_dma_tx->tx_cb_arg);
 }
+
+/*
+ * Set McBSP recv parameters
+ * id           : McBSP interface ID
+ * mcbsp_cfg    : McBSP register configuration
+ * rp           : McBSP recv parameters
+ */
+void omap2_mcbsp_set_recv_param(unsigned int id,
+				struct omap_mcbsp_reg_cfg *mcbsp_cfg,
+					struct omap_mcbsp_cfg_param *rp)
+{
+	u32 io_base;
+	io_base = mcbsp[id].io_base;
+
+	mcbsp_cfg->spcr1 = RJUST(rp->justification);
+	mcbsp_cfg->rcr2 = RCOMPAND(rp->reverse_compand) |
+				RDATDLY(rp->data_delay);
+	if (rp->phase == OMAP_MCBSP_FRAME_SINGLEPHASE)
+		mcbsp_cfg->rcr2 = mcbsp_cfg->rcr2 & ~(RPHASE);
+	else
+		mcbsp_cfg->rcr2 = mcbsp_cfg->rcr2  | (RPHASE) |
+			RWDLEN2(rp->word_length2) | RFRLEN2(rp->frame_length2);
+	mcbsp_cfg->rcr1 = RWDLEN1(rp->word_length1) |
+				RFRLEN1(rp->frame_length1);
+	if (rp->fsync_src == OMAP_MCBSP_RXFSYNC_INTERNAL)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | FSRM;
+	if (rp->clk_mode == OMAP_MCBSP_CLKRXSRC_INTERNAL)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | CLKRM;
+	if (rp->clk_polarity == OMAP_MCBSP_CLKR_POLARITY_RISING)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | CLKRP;
+	if (rp->fs_polarity == OMAP_MCBSP_FS_ACTIVE_LOW)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | FSRP;
+	return;
+
+}
+
+/*
+ * Set McBSP transmit parameters
+ * id		: McBSP interface ID
+ * mcbsp_cfg	: McBSP register configuration
+ * tp		: McBSP transmit parameters
+ */
+
+void omap2_mcbsp_set_trans_param(unsigned int id,
+				struct omap_mcbsp_reg_cfg *mcbsp_cfg,
+				struct omap_mcbsp_cfg_param *tp)
+{
+	mcbsp_cfg->xcr2 = XCOMPAND(tp->reverse_compand) |
+					XDATDLY(tp->data_delay);
+	if (tp->phase == OMAP_MCBSP_FRAME_SINGLEPHASE)
+		mcbsp_cfg->xcr2 = mcbsp_cfg->xcr2 & ~(XPHASE);
+	else
+		mcbsp_cfg->xcr2 = mcbsp_cfg->xcr2 | (XPHASE) |
+			RWDLEN2(tp->word_length2) | RFRLEN2(tp->frame_length2);
+	mcbsp_cfg->xcr1 = XWDLEN1(tp->word_length1) |
+				XFRLEN1(tp->frame_length1);
+	if (tp->fs_polarity == OMAP_MCBSP_FS_ACTIVE_LOW)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | FSXP;
+	if (tp->fsync_src == OMAP_MCBSP_TXFSYNC_INTERNAL)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | FSXM;
+	if (tp->clk_mode == OMAP_MCBSP_CLKTXSRC_INTERNAL)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | CLKXM;
+	if (tp->clk_polarity == OMAP_MCBSP_CLKX_POLARITY_FALLING)
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 | CLKXP;
+	return;
+
+}
+
+ /*
+ * Set McBSP SRG configuration
+ * id			: McBSP interface ID
+ * mcbsp_cfg		: McBSP register configuration
+ * interface_mode	: Master/Slave
+ * param		: McBSP SRG and FSG configuration
+ */
+
+void omap2_mcbsp_set_srg_cfg_param(unsigned int id, int interface_mode,
+					struct omap_mcbsp_reg_cfg *mcbsp_cfg,
+					struct omap_mcbsp_srg_fsg_cfg *param)
+{
+	u32 io_base;
+	u32 clk_rate, clkgdv;
+	io_base = mcbsp[id].io_base;
+
+	mcbsp[id].interface_mode = interface_mode;
+	mcbsp_cfg->srgr1 = FWID(param->pulse_width);
+
+	if (interface_mode == OMAP_MCBSP_MASTER) {
+		/* clk_rate = clk_get_rate(omap_mcbsp_clk[id].fck); */
+		clk_rate = 96000000;
+		clkgdv = clk_rate / (param->sample_rate *
+				(param->bits_per_sample - 1));
+		mcbsp_cfg->srgr1 = mcbsp_cfg->srgr1 | CLKGDV(clkgdv);
+	}
+	if (param->dlb)
+		mcbsp_cfg->spcr1 = mcbsp_cfg->spcr1 & ~(ALB);
+
+	if (param->sync_mode == OMAP_MCBSP_SRG_FREERUNNING)
+		mcbsp_cfg->spcr2 = mcbsp_cfg->spcr2 | FREE;
+	mcbsp_cfg->srgr2 = FPER(param->period)|(param->fsgm? FSGM : 0);
+
+	switch (param->srg_src) {
+
+	case OMAP_MCBSP_SRGCLKSRC_CLKS:
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 & ~(SCLKME);
+		mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2 & ~(CLKSM);
+		/*
+		 * McBSP master operation at low voltage is only possible if
+		 * CLKSP=0 In Master mode, if client driver tries to configiure
+		 * input clock polarity as falling edge, we force it to Rising
+		 */
+
+		if ((param->polarity == OMAP_MCBSP_CLKS_POLARITY_RISING) ||
+					(interface_mode == OMAP_MCBSP_MASTER))
+			mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2  & ~(CLKSP);
+		else
+			mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2  |  (CLKSP);
+		break;
+
+
+	case OMAP_MCBSP_SRGCLKSRC_FCLK:
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0 & ~(SCLKME);
+		mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2 | (CLKSM);
+
+		break;
+
+	case OMAP_MCBSP_SRGCLKSRC_CLKR:
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0   | (SCLKME);
+		mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2 & ~(CLKSM);
+		if (param->polarity == OMAP_MCBSP_CLKR_POLARITY_FALLING)
+			mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0  & ~(CLKRP);
+		else
+			mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0  | (CLKRP);
+
+		break;
+
+	case OMAP_MCBSP_SRGCLKSRC_CLKX:
+		mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0   | (SCLKME);
+		mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2 | (CLKSM);
+
+		if (param->polarity == OMAP_MCBSP_CLKX_POLARITY_RISING)
+			mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0  & ~(CLKXP);
+		else
+			mcbsp_cfg->pcr0 = mcbsp_cfg->pcr0  | (CLKXP);
+		break;
+
+	}
+	if (param->sync_mode == OMAP_MCBSP_SRG_FREERUNNING)
+		mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2 & ~(GSYNC);
+	else if (param->sync_mode == OMAP_MCBSP_SRG_RUNNING)
+		mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2 | (GSYNC);
+
+	mcbsp_cfg->xccr = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_XCCR);
+	if (param->dlb)
+		mcbsp_cfg->xccr = mcbsp_cfg->xccr | (DILB);
+	mcbsp_cfg->rccr = omap_mcbsp_read(io_base, OMAP_MCBSP_REG_RCCR);
+
+	return;
+}
+
+/*
+ * configure the McBSP registers
+ * id			: McBSP interface ID
+ * interface_mode	: Master/Slave
+ * rp			: McBSP recv parameters
+ * tp			: McBSP transmit parameters
+ * param		: McBSP SRG and FSG configuration
+ */
+int omap2_mcbsp_params_cfg(unsigned int id, int interface_mode,
+				struct omap_mcbsp_cfg_param *rp,
+				struct omap_mcbsp_cfg_param *tp,
+				struct omap_mcbsp_srg_fsg_cfg *param)
+{
+	if (rp)
+		omap2_mcbsp_set_recv_param(id, &mcbsp_cfg, rp);
+	if (tp)
+		omap2_mcbsp_set_trans_param(id, &mcbsp_cfg, tp);
+	if (param)
+		omap2_mcbsp_set_srg_cfg_param(id,
+					interface_mode, &mcbsp_cfg, param);
+	omap_mcbsp_config(id, &mcbsp_cfg);
+
+	return (0);
+}
+EXPORT_SYMBOL(omap2_mcbsp_params_cfg);
+
 /*
  * Enable/Disable the sample rate generator
  * id		: McBSP interface ID
Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-06-16 16:05:49.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-06-16 16:11:51.119021130 +0530
@@ -277,6 +277,81 @@
 #define OMAP_MCBSP_XRST_DISABLE			0
 #define OMAP_MCBSP_XRST_ENABLE			1
 
+#define OMAP_MCBSP_FRAME_SINGLEPHASE		1
+
+/* Sample Rate Generator Clock source */
+#define OMAP_MCBSP_SRGCLKSRC_CLKS		1
+#define OMAP_MCBSP_SRGCLKSRC_FCLK		2
+#define OMAP_MCBSP_SRGCLKSRC_CLKR		3
+#define OMAP_MCBSP_SRGCLKSRC_CLKX		4
+
+/* SRG input clock polarity */
+#define OMAP_MCBSP_CLKS_POLARITY_RISING		1
+#define OMAP_MCBSP_CLKS_POLARITY_FALLING	2
+
+#define OMAP_MCBSP_CLKX_POLARITY_RISING		1
+#define OMAP_MCBSP_CLKX_POLARITY_FALLING	2
+
+#define OMAP_MCBSP_CLKR_POLARITY_RISING		1
+#define OMAP_MCBSP_CLKR_POLARITY_FALLING	2
+
+/* SRG Clock synchronization mode */
+#define OMAP_MCBSP_SRG_FREERUNNING		1
+#define OMAP_MCBSP_SRG_RUNNING			2
+
+/* Frame Sync Source */
+#define OMAP_MCBSP_TXFSYNC_EXTERNAL		0
+#define OMAP_MCBSP_TXFSYNC_INTERNAL		1
+
+#define OMAP_MCBSP_RXFSYNC_EXTERNAL		0
+#define OMAP_MCBSP_RXFSYNC_INTERNAL		1
+
+#define OMAP_MCBSP_CLKRXSRC_EXTERNAL		1
+#define OMAP_MCBSP_CLKRXSRC_INTERNAL		2
+
+#define OMAP_MCBSP_CLKTXSRC_EXTERNAL		1
+#define OMAP_MCBSP_CLKTXSRC_INTERNAL		2
+
+/* Justification */
+#define OMAP_MCBSP_RJUST_ZEROMSB		0
+#define OMAP_MCBSP_RJUST_SIGNMSB		1
+#define OMAP_MCBSP_LJUST_ZEROLSB		2
+
+#define OMAP_MCBSP_DATADELAY0			0
+#define OMAP_MCBSP_DATADELAY1			1
+#define OMAP_MCBSP_DATADELAY2			2
+
+/* Reverse mode for 243X and 34XX */
+#define OMAP_MCBSP_MSBFIRST			0
+#define OMAP_MCBSP_LSBFIRST			1
+
+struct omap_mcbsp_cfg_param {
+	u8 fsync_src;
+	u8 fs_polarity;
+	u8 clk_polarity;
+	u8 clk_mode;
+	u8 frame_length1;
+	u8 frame_length2;
+	u8 word_length1;
+	u8 word_length2;
+	u8 justification;
+	u8 reverse_compand;
+	u8 phase;
+	u8 data_delay;
+};
+
+struct omap_mcbsp_srg_fsg_cfg {
+	u32 period;	/* Frame period */
+	u32 pulse_width; /* Frame width */
+	u8 fsgm;
+	u32 sample_rate;
+	u32 bits_per_sample;
+	u32 srg_src;
+	u8 sync_mode;	/* SRG free running mode */
+	u8 polarity;
+	u8 dlb;		/* digital loopback mode */
+};
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u32 spcr2;
@@ -476,4 +551,8 @@
 int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
 				dma_addr_t buf_start_addr, u32 buf_size);
 
+int omap2_mcbsp_params_cfg(unsigned int id, int interface_mode,
+				struct omap_mcbsp_cfg_param *rp,
+				struct omap_mcbsp_cfg_param  *tp,
+				struct  omap_mcbsp_srg_fsg_cfg *param);
 #endif

