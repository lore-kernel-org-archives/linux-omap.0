From: "Chandra shekhar" <x0044955@ti.com>
Subject: [RFC/PATCH  1/1] McBSP support for 2430/34XX
Date: Thu, 20 Dec 2007 20:43:20 +0530
Message-ID: <200712201513.lBKFDK2G024768@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

This patch adds support for McBSP on 2430/34XX.  It has been verified in digital loopback mode for 2430/34XX.
Some McBSP dma lines have been hardcoded, as there is a discussion going on in linux-omap about Cleanup of DMA Request Lines.
Since 2430 onwards registers are 32 bit, all the instances of omap24xx which were relevant to only 2420 has been changed to
omap2420.

The patch includes the following features.

1. Supporting all the LP features.
2. Support of DMA chaining mode and one time configuration for entire transfer to improve performance.
3. Independent configurations and transfer of Rx and Tx
4. MCBSP data transfer in 8, 16 and 32 bit mode. 

Signed-off-by: chandra shekhar <x0044955@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    2 
 arch/arm/plat-omap/mcbsp.c              | 1111 ++++++++++++++++++++++++++++++--
 include/asm-arm/arch-omap/mcbsp.h       |  300 +++++++-
 3 files changed, 1326 insertions(+), 87 deletions(-)

Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-12-18 22:03:11.000000000 +0530
+++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig	2007-12-20 19:53:14.670970306 +0530
@@ -155,7 +155,7 @@
 CONFIG_OMAP_MUX=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
-# CONFIG_OMAP_MCBSP is not set
+CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MMU_FWK is not set
 # CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
Index: linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2007-12-18 22:03:11.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2007-12-20 20:36:32.558786368 +0530
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2004 Nokia Corporation
  * Author: Samuel Ortiz <samuel.ortiz@nokia.com>
- *
+ * Added DMA chaining support for 2430/34XX
+ * by chandra shekhar <x0044955@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -38,30 +39,46 @@
 #endif
 
 struct omap_mcbsp {
-	u32                          io_base;
-	u8                           id;
-	u8                           free;
-	omap_mcbsp_word_length       rx_word_length;
-	omap_mcbsp_word_length       tx_word_length;
+	u32				io_base;
+	u8				id;
+	u8				free;
+	omap_mcbsp_word_length		rx_word_length;
+	omap_mcbsp_word_length		tx_word_length;
 
-	omap_mcbsp_io_type_t         io_type; /* IRQ or poll */
+	omap_mcbsp_io_type_t		io_type; /* IRQ or poll */
 	/* IRQ based TX/RX */
-	int                          rx_irq;
-	int                          tx_irq;
+	int				rx_irq;
+	int				tx_irq;
 
 	/* DMA stuff */
-	u8                           dma_rx_sync;
-	short                        dma_rx_lch;
-	u8                           dma_tx_sync;
-	short                        dma_tx_lch;
+	u8				dma_rx_sync;
+	short				dma_rx_lch;
+	u8				dma_tx_sync;
+	short				dma_tx_lch;
 
 	/* Completion queues */
-	struct completion            tx_irq_completion;
-	struct completion            rx_irq_completion;
-	struct completion            tx_dma_completion;
-	struct completion            rx_dma_completion;
-
-	spinlock_t                   lock;
+	struct completion		tx_irq_completion;
+	struct completion		rx_irq_completion;
+	struct completion		tx_dma_completion;
+	struct completion		rx_dma_completion;
+
+	spinlock_t			lock;
+	u32 				phy_base;
+
+	u8				auto_reset;	/* Auto Reset */
+	u8				txskip_alt;	/* Tx skip flags */
+	u8				rxskip_alt;	/* Rx skip flags */
+
+	void				*rx_cb_arg;
+	void				*tx_cb_arg;
+
+	omap_mcbsp_dma_cb		rx_callback;
+	omap_mcbsp_dma_cb		tx_callback;
+
+	int				rx_dma_chain_state;
+	int				tx_dma_chain_state;
+	int				interface_mode;
+	int				srg_enabled;
 };
 
 static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
@@ -70,20 +87,50 @@
 static struct clk *mcbsp_api_ck = 0;
 static struct clk *mcbsp_dspxor_ck = 0;
 #endif
-#ifdef CONFIG_ARCH_OMAP2
+#ifdef CONFIG_ARCH_OMAP2420
 static struct clk *mcbsp1_ick = 0;
 static struct clk *mcbsp1_fck = 0;
 static struct clk *mcbsp2_ick = 0;
 static struct clk *mcbsp2_fck = 0;
 #endif
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+static char omap_mcbsp_ick[OMAP_MAX_MCBSP_COUNT][15] = {"mcbsp1_ick\0",
+							"mcbsp2_ick\0",
+							"mcbsp3_ick\0",
+							"mcbsp4_ick\0",
+							"mcbsp5_ick\0"
+							};
+
+static char omap_mcbsp_fck[OMAP_MAX_MCBSP_COUNT][15] = {"mcbsp1_fck\0",
+							"mcbsp2_fck\0",
+							"mcbsp3_fck\0",
+							"mcbsp4_fck\0",
+							"mcbsp5_fck\0"
+							};
+
+static struct omap_mcbsp_clocks {
+			struct clk *ick;
+			struct clk *fck;
+			} omap_mcbsp_clk[OMAP_MAX_MCBSP_COUNT];
+
+static int omap_mcbsp_max_dmachs_rx[OMAP_MAX_MCBSP_COUNT] = {2, 2, 2, 2, 2};
+static int omap_mcbsp_max_dmachs_tx[OMAP_MAX_MCBSP_COUNT] = {2, 2, 2, 2, 2};
+
+#define OMAP_MCBSP_MAX_MULTI_CHS 127
+
+u32 omap_get_mcbspid[OMAP_MCBSP_MAX_MULTI_CHS] = {0};
+
+#endif
 
 static void omap_mcbsp_dump_reg(u8 id)
 {
 	DBG("**** MCBSP%d regs ****\n", mcbsp[id].id);
+#if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP34XX)
 	DBG("DRR2:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, DRR2));
 	DBG("DRR1:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, DRR1));
 	DBG("DXR2:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, DXR2));
 	DBG("DXR1:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, DXR1));
+#endif
 	DBG("SPCR2: 0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, SPCR2));
 	DBG("SPCR1: 0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, SPCR1));
 	DBG("RCR2:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, RCR2));
@@ -93,6 +140,12 @@
 	DBG("SRGR2: 0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, SRGR2));
 	DBG("SRGR1: 0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, SRGR1));
 	DBG("PCR0:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, PCR0));
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	DBG("DRR:   0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, DRR));
+	DBG("DXR:   0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, DXR));
+	DBG("XCCR:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, XCCR));
+	DBG("RCCR:  0x%04x\n", OMAP_MCBSP_READ(mcbsp[id].io_base, RCCR));
+#endif
 	DBG("***********************\n");
 }
 
@@ -115,6 +168,7 @@
 	complete(&mcbsp_rx->rx_irq_completion);
 	return IRQ_HANDLED;
 }
+#if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP34XX)
 
 static void omap_mcbsp_tx_dma_callback(int lch, u16 ch_status, void *data)
 {
@@ -142,6 +196,44 @@
 	complete(&mcbsp_dma_rx->rx_dma_completion);
 }
 
+#else
+
+static void omap_mcbsp_rx_dma_callback(int chainid, u16 ch_status, void *data)
+{
+	u32 id;
+	u32 io_base;
+
+	id = omap_get_mcbspid[chainid];
+	io_base = mcbsp[id].io_base;
+
+	/* If we are at the last transfer, Shut down the reciever */
+	if ((mcbsp[id].auto_reset & OMAP_MCBSP_AUTO_RRST)
+		&& (omap_dma_chain_status(chainid) == OMAP_DMA_CHAIN_INACTIVE))
+			OMAP_MCBSP_WRITE(io_base, SPCR1,
+				OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
+
+	if (mcbsp[id].rx_callback != NULL)
+		mcbsp[id].rx_callback(ch_status, data);
+
+}
+
+static void omap_mcbsp_tx_dma_callback(int chainid, u16 ch_status, void *data)
+{
+	u32 id;
+	u32 io_base;
+
+	id = omap_get_mcbspid[chainid];
+	io_base = mcbsp[id].io_base;
+
+	/* If we are at the last transfer, Shut down the Transmitter */
+	if ((mcbsp[id].auto_reset & OMAP_MCBSP_AUTO_XRST)
+		&& (omap_dma_chain_status(chainid) == OMAP_DMA_CHAIN_INACTIVE))
+			OMAP_MCBSP_WRITE(io_base, SPCR2,
+				OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
+	if (mcbsp[id].tx_callback != NULL)
+		mcbsp[id].tx_callback(ch_status, data);
+}
+#endif
 
 /*
  * omap_mcbsp_config simply write a config to the
@@ -168,10 +260,12 @@
 	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
 	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
 	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
+	OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
+#endif
 }
 
-
-
 static int omap_mcbsp_check(unsigned int id)
 {
 	if (cpu_is_omap730()) {
@@ -180,9 +274,7 @@
 		       return -1;
 		}
 		return 0;
-	}
-
-	if (cpu_is_omap15xx() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	} else {
 		if (id > OMAP_MAX_MCBSP_COUNT) {
 			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
 			return -1;
@@ -231,7 +323,7 @@
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
+#ifdef CONFIG_ARCH_OMAP2420
 static void omap2_mcbsp2_mux_setup(void)
 {
 	if (cpu_is_omap2420()) {
@@ -287,8 +379,8 @@
 		omap_mcbsp_dsp_request();
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
-	if (cpu_is_omap24xx()) {
+#ifdef CONFIG_ARCH_OMAP2420
+	if (cpu_is_omap2420()) {
 		if (id == OMAP_MCBSP1) {
 			clk_enable(mcbsp1_ick);
 			clk_enable(mcbsp1_fck);
@@ -298,6 +390,13 @@
 		}
 	}
 #endif
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		clk_enable(omap_mcbsp_clk[id].ick);
+		clk_enable(omap_mcbsp_clk[id].fck);
+
+	}
+#endif
 
 	spin_lock(&mcbsp[id].lock);
 	if (!mcbsp[id].free) {
@@ -307,6 +406,8 @@
 	}
 
 	mcbsp[id].free = 0;
+	mcbsp[id].dma_rx_lch = -1;
+	mcbsp[id].dma_tx_lch = -1;
 	spin_unlock(&mcbsp[id].lock);
 
 	if (mcbsp[id].io_type == OMAP_MCBSP_IRQ_IO) {
@@ -335,7 +436,6 @@
 
 		init_completion(&(mcbsp[id].rx_irq_completion));
 	}
-
 	return 0;
 
 }
@@ -352,8 +452,8 @@
 	}
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
-	if (cpu_is_omap24xx()) {
+#ifdef CONFIG_ARCH_OMAP2420
+	if (cpu_is_omap2420()) {
 		if (id == OMAP_MCBSP1) {
 			clk_disable(mcbsp1_ick);
 			clk_disable(mcbsp1_fck);
@@ -363,6 +463,20 @@
 		}
 	}
 #endif
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	if (mcbsp[id].dma_rx_lch != -1) {
+		omap_free_dma_chain(mcbsp[id].dma_rx_lch);
+		omap_get_mcbspid[mcbsp[id].dma_rx_lch] = -1;
+	}
+	if (mcbsp[id].dma_tx_lch != -1) {
+		omap_free_dma_chain(mcbsp[id].dma_tx_lch);
+		omap_get_mcbspid[mcbsp[id].dma_tx_lch] = -1;
+	}
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		clk_disable(omap_mcbsp_clk[id].ick);
+		clk_disable(omap_mcbsp_clk[id].fck);
+	}
+#endif
 
 	spin_lock(&mcbsp[id].lock);
 	if (mcbsp[id].free) {
@@ -444,7 +558,7 @@
 	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
 }
 
-
+#if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP34XX)
 /* polled mcbsp i/o operations */
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
@@ -682,7 +796,8 @@
 	if (omap_request_dma(mcbsp[id].dma_tx_sync, "McBSP TX", omap_mcbsp_tx_dma_callback,
 			     &mcbsp[id],
 			     &dma_tx_ch)) {
-		printk("OMAP-McBSP: Unable to request DMA channel for McBSP%d TX. Trying IRQ based TX\n", id+1);
+		printk(KERN_ERR "OMAP-McBSP: Unable to request DMA \
+			 channel for McBSP%d TX. Trying IRQ based TX\n", id+1);
 		return -EAGAIN;
 	}
 	mcbsp[id].dma_tx_lch = dma_tx_ch;
@@ -735,7 +850,8 @@
 	if (omap_request_dma(mcbsp[id].dma_rx_sync, "McBSP RX", omap_mcbsp_rx_dma_callback,
 			     &mcbsp[id],
 			     &dma_rx_ch)) {
-		printk("Unable to request DMA channel for McBSP%d RX. Trying IRQ based RX\n", id+1);
+		printk(KERN_ERR "Unable to request DMA channel for\
+				McBSP%d RX. Trying IRQ based RX\n", id+1);
 		return -EAGAIN;
 	}
 	mcbsp[id].dma_rx_lch = dma_rx_ch;
@@ -774,7 +890,6 @@
 	return 0;
 }
 
-
 /*
  * SPI wrapper.
  * Since SPI setup is much simpler than the generic McBSP one,
@@ -842,7 +957,800 @@
 
 	omap_mcbsp_config(id, &mcbsp_cfg);
 }
+#else
+
+/*
+ * Set McBSP recv parameters
+ * id           : McBSP interface ID
+ * mcbsp_cfg    : McBSP register configuration
+ * rp           : McBSP recv parameters
+ */
+int omap_mcbsp_set_recv_param(unsigned int id,
+				struct omap_mcbsp_reg_cfg *mcbsp_cfg,
+				struct omap_mcbsp_cfg_param *rp)
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
+		mcbsp_cfg->rcr2 = mcbsp_cfg->rcr2  | (RPHASE);
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
+	return 0;
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
+int omap_mcbsp_set_trans_param(unsigned int id,
+					struct omap_mcbsp_reg_cfg *mcbsp_cfg,
+					struct omap_mcbsp_cfg_param *tp)
+{
+	mcbsp_cfg->xcr2 = XCOMPAND(tp->reverse_compand) |
+					XDATDLY(tp->data_delay);
+	if (tp->phase == OMAP_MCBSP_FRAME_SINGLEPHASE)
+		mcbsp_cfg->xcr2 = mcbsp_cfg->xcr2 & ~(XPHASE);
+	else
+		mcbsp_cfg->xcr2 = mcbsp_cfg->xcr2 | (XPHASE);
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
+	return 0;
+
+}
+/*
+ * Set McBSP SRG configuration
+ * id			: McBSP interface ID
+ * mcbsp_cfg		: McBSP register configuration
+ * interface_mode	: Master/Slave
+ * param		: McBSP SRG and FSG configuration
+ */
+
+int omap_mcbsp_set_srg_cfg_param(unsigned int id, int interface_mode,
+					struct omap_mcbsp_reg_cfg *mcbsp_cfg,
+					struct omap_mcbsp_srg_fsg_cfg *param)
+{
+	u32 io_base;
+	u32 clk_rate, clkgdv = 1;
+	io_base = mcbsp[id].io_base;
+
+	mcbsp[id].interface_mode = interface_mode;
+	mcbsp_cfg->srgr1 = FWID(param->pulse_width);
+
+	if (interface_mode == OMAP_MCBSP_MASTER) {
+		clk_rate = clk_get_rate(omap_mcbsp_clk[id].fck);
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
+		if ((param->polarity == OMAP_MCBSP_CLKS_POLARITY_RISING) ||
+					(interface_mode == OMAP_MCBSP_MASTER))
+			mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2  & ~(CLKSP);
+		else
+			mcbsp_cfg->srgr2 = mcbsp_cfg->srgr2  |  (CLKSP);
+
+		break;
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
+	 mcbsp_cfg->xccr = XDMAEN | XENDLY(1);
+	if (param->dlb)
+		mcbsp_cfg->xccr = mcbsp_cfg->xccr | (DLB);
+
+	mcbsp_cfg->rccr = RDMAEN | RFULL_CYCLE;
+	return 0;
+
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
+int omap_mcbsp_params_cfg(unsigned int id, int interface_mode,
+				struct omap_mcbsp_cfg_param *rp,
+				struct omap_mcbsp_cfg_param *tp,
+				struct omap_mcbsp_srg_fsg_cfg *param)
+ {
+	struct omap_mcbsp_reg_cfg mcbsp_cfg = {0};
+
+	spin_lock(&mcbsp[id].lock);
+
+	if (rp)
+		omap_mcbsp_set_recv_param(id, &mcbsp_cfg, rp);
+
+	if (tp)
+		omap_mcbsp_set_trans_param(id, &mcbsp_cfg, tp);
+
+	if (param)
+		omap_mcbsp_set_srg_cfg_param(id,
+					interface_mode, &mcbsp_cfg, param);
+
+	omap_mcbsp_config(id, &mcbsp_cfg);
+	spin_unlock(&mcbsp[id].lock);
+	return (0);
+ }
+
+/*
+ * Enable/Disable the sample rate generator
+ * id		: McBSP interface ID
+ * state	: Enable/Disable
+ */
+int omap_mcbsp_set_srg_fsg(unsigned int id, u8 state)
+{
+	u32 io_base;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	io_base = mcbsp[id].io_base;
+	spin_lock(&mcbsp[id].lock);
+
+	if (state == OMAP_MCBSP_DISABLE_FSG_SRG) {
+		OMAP_MCBSP_WRITE(io_base, SPCR2,
+			OMAP_MCBSP_READ(io_base, SPCR2) & (~GRST));
+		OMAP_MCBSP_WRITE(io_base, SPCR2,
+			OMAP_MCBSP_READ(io_base, SPCR2) & (~FRST));
+	} else {
+		OMAP_MCBSP_WRITE(io_base, SPCR2,
+			OMAP_MCBSP_READ(io_base, SPCR2) | (GRST));
+		OMAP_MCBSP_WRITE(io_base, SPCR2,
+			OMAP_MCBSP_READ(io_base, SPCR2) | (FRST));
+	}
+	spin_unlock(&mcbsp[id].lock);
+	return (0);
+}
+
+/*
+ * Stop transmitting data on a McBSP interface
+ * id		: McBSP interface ID
+ */
+int omap_mcbsp_stop_datatx(unsigned int id)
+{
+	u32 io_base;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
 
+	if (mcbsp[id].dma_tx_lch != -1) {
+		if (omap_stop_dma_chain_transfers(mcbsp[id].dma_tx_lch) != 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+	}
+	mcbsp[id].tx_dma_chain_state = 0;
+	OMAP_MCBSP_WRITE(io_base, SPCR2,
+		OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
+
+	if (!(--mcbsp[id].srg_enabled))
+		omap_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+
+/*
+ * Stop receving data on a McBSP interface
+ * id		: McBSP interface ID
+ */
+int omap_mcbsp_stop_datarx(unsigned int id)
+{
+
+	u32 io_base;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
+
+	if (mcbsp[id].dma_rx_lch != -1) {
+		if (omap_stop_dma_chain_transfers(mcbsp[id].dma_rx_lch) != 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+	}
+	OMAP_MCBSP_WRITE(io_base, SPCR1,
+		OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
+	mcbsp[id].rx_dma_chain_state = 0;
+
+	if (!(--mcbsp[id].srg_enabled))
+		omap_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+
+/*
+ * Interface Reset
+ * id	: McBSP interface ID
+ * Resets the McBSP interface
+ */
+int omap_mcbsp_reset(unsigned int id)
+{
+	u32 io_base;
+	int counter = 0;
+	int wait_for_reset = 10000;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+	io_base = mcbsp[id].io_base;
+	spin_lock(&mcbsp[id].lock);
+
+	OMAP_MCBSP_WRITE(io_base, SYSCONFIG,
+		OMAP_MCBSP_READ(io_base, SYSCONFIG) | (SOFTRST));
+
+	while (OMAP_MCBSP_READ(io_base, SYSCONFIG) & SOFTRST) {
+		if (!in_interrupt()) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(10);
+		}
+		if (counter++ > wait_for_reset) {
+			printk(KERN_ERR "mcbsp[%d] Reset timeout\n", id);
+			spin_unlock(&mcbsp[id].lock);
+			return -ETIMEDOUT;
+		}
+	}
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+
+/*
+ * Get the element index and frame index of transmitter
+ * id		: McBSP interface ID
+ * ei		: element index
+ * fi		: frame index
+ */
+int omap_mcbsp_transmitter_index(unsigned int id, int *ei, int *fi)
+{
+	int eix = 0, fix = 0;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	if ((!ei) || (!fi)) {
+		printk(KERN_ERR	"OMAP_McBSP: Invalid ei and fi params \n");
+		goto txinx_err;
+	}
+
+	if (mcbsp[id].dma_tx_lch == -1) {
+		printk(KERN_ERR "OMAP_McBSP: Transmitter not started\n");
+		goto txinx_err;
+	}
+
+	if (omap_get_dma_chain_index
+		(mcbsp[id].dma_tx_lch, &eix, &fix) != 0) {
+		printk(KERN_ERR "OMAP_McBSP: Getting chain index failed\n");
+		goto txinx_err;
+	}
+
+	*ei = eix;
+	*fi = fix;
+
+	return 0;
+
+txinx_err:
+	return -EINVAL;
+}
+
+/*
+ * Get the element index and frame index of receiver
+ * id	: McBSP interface ID
+ * ei		: element index
+ * fi		: frame index
+ */
+int omap_mcbsp_receiver_index(unsigned int id, int *ei, int *fi)
+{
+	int eix = 0, fix = 0;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	if ((!ei) || (!fi)) {
+		printk(KERN_ERR	"OMAP_McBSP: Invalid ei and fi params x\n");
+		goto rxinx_err;
+	}
+
+	/* Check if chain exists */
+	if (mcbsp[id].dma_rx_lch == -1) {
+		printk(KERN_ERR "OMAP_McBSP: Receiver not started\n");
+		goto rxinx_err;
+	}
+
+	/* Get dma_chain_index */
+	if (omap_get_dma_chain_index
+		(mcbsp[id].dma_rx_lch, &eix, &fix) != 0) {
+		printk(KERN_ERR "OMAP_McBSP: Getting chain index failed\n");
+		goto rxinx_err;
+	}
+
+	*ei = eix;
+	*fi = fix;
+	return 0;
+
+rxinx_err:
+	return -EINVAL;
+}
+
+/*
+ * Basic Reset Transmitter
+ * id		: McBSP interface number
+ * state	: Disable (0)/ Enable (1) the transmitter
+ */
+int omap_mcbsp_set_xrst(unsigned int id, u8 state)
+{
+	u32 io_base;
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	io_base = mcbsp[id].io_base;
+
+	if (state == OMAP_MCBSP_XRST_DISABLE)
+		OMAP_MCBSP_WRITE(io_base, SPCR2,
+			OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
+	else
+		OMAP_MCBSP_WRITE(io_base, SPCR2,
+			OMAP_MCBSP_READ(io_base, SPCR2) | (XRST));
+	udelay(10);
+
+	return (0);
+}
+
+/*
+ * Reset Receiver
+ * id		: McBSP interface number
+ * state	: Disable (0)/ Enable (1) the receiver
+ */
+int omap_mcbsp_set_rrst(unsigned int id, u8 state)
+{
+	u32 io_base;
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	io_base = mcbsp[id].io_base;
+
+	if (state == OMAP_MCBSP_RRST_DISABLE)
+		OMAP_MCBSP_WRITE(io_base, SPCR1,
+			OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
+	else
+		OMAP_MCBSP_WRITE(io_base, SPCR1,
+			OMAP_MCBSP_READ(io_base, SPCR1) | (RRST));
+	udelay(10);
+	return 0;
+}
+
+/*
+ * Configure the receiver parameters
+ * id		: McBSP Interface ID
+ * rx_param	: DMA Receive parameters
+ */
+int omap_mcbsp_dma_recv_params(unsigned int id,
+				struct omap_mcbsp_dma_transfer_params *rx_param)
+{
+	struct omap_dma_channel_params rx_params;
+	int err, chain_id = -1;
+	u32 io_base;
+	u32  dt = 0;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
+
+	dt = rx_param->word_length1;
+
+	if (dt == OMAP_MCBSP_WORD_8)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S8;
+	else if (dt == OMAP_MCBSP_WORD_16)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S16;
+	else if (dt == OMAP_MCBSP_WORD_32)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
+	else {
+		spin_unlock(&mcbsp[id].lock);
+		return -EINVAL;
+	}
+
+	rx_params.read_prio = DMA_CH_PRIO_HIGH;
+	rx_params.write_prio = DMA_CH_PRIO_HIGH;
+
+	omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
+						DMA_DEFAULT_FIFO_DEPTH, 0);
+
+	rx_params.sync_mode = OMAP_DMA_SYNC_ELEMENT;
+	rx_params.src_fi = 0;
+	rx_params.trigger = mcbsp[id].dma_rx_sync;
+	rx_params.src_or_dst_synch = 0x01;
+	rx_params.src_amode = OMAP_DMA_AMODE_CONSTANT;
+	rx_params.src_ei = 0x0;
+	/* Indexing is always in bytes - so multiply with dt */
+	dt = (rx_params.data_type == OMAP_DMA_DATA_TYPE_S8) ? 1 :
+		(rx_params.data_type == OMAP_DMA_DATA_TYPE_S16) ? 2 : 4;
+	mcbsp[id].rx_word_length = dt;
+
+	if (rx_param->skip_alt == OMAP_MCBSP_SKIP_SECOND) {
+		rx_params.dst_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
+		rx_params.dst_ei = (1);
+		rx_params.dst_fi = (1) + ((-1) * dt);
+	} else if (rx_param->skip_alt == OMAP_MCBSP_SKIP_FIRST) {
+		rx_params.dst_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
+		rx_params.dst_ei = 1 + (-2) * dt;
+		rx_params.dst_fi = 1 + (2) * dt;
+	} else {
+		rx_params.dst_amode = OMAP_DMA_AMODE_POST_INC;
+		rx_params.dst_ei = 0;
+		rx_params.dst_fi = 0;
+	}
+
+	mcbsp[id].rxskip_alt = rx_param->skip_alt;
+	mcbsp[id].auto_reset &= ~OMAP_MCBSP_AUTO_RRST;
+	mcbsp[id].auto_reset |=	(rx_param->auto_reset & OMAP_MCBSP_AUTO_RRST);
+	mcbsp[id].rx_callback = rx_param->callback;
+
+	/* request for a chain of dma channels for data reception */
+	if (mcbsp[id].dma_rx_lch == -1) {
+		err = omap_request_dma_chain(id, "McBSP RX",
+					 omap_mcbsp_rx_dma_callback, &chain_id,
+					 omap_mcbsp_max_dmachs_rx[id],
+					 OMAP_DMA_DYNAMIC_CHAIN, rx_params);
+		if (err < 0) {
+			printk(KERN_ERR "Receive path configuration failed \n");
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+		mcbsp[id].dma_rx_lch = chain_id;
+		omap_get_mcbspid[chain_id] = id;
+		mcbsp[id].rx_dma_chain_state = 0;
+	} else {
+		/* DMA params already set, modify the same!! */
+		err = omap_modify_dma_chain_params(mcbsp[id].
+						 dma_rx_lch, rx_params);
+		if (err < 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+	}
+
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+
+/*
+ * Configure the transmitter parameters
+ * id		: McBSP Interface ID
+ * tx_param	: DMA Transfer parameters
+ */
+
+int omap_mcbsp_dma_trans_params(unsigned int id,
+				struct omap_mcbsp_dma_transfer_params *tx_param)
+{
+
+	struct omap_dma_channel_params tx_params;
+	int err = 0, chain_id = -1;
+	u32 io_base;
+	u32 dt = 0;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+	io_base = mcbsp[id].io_base;
+	spin_lock(&mcbsp[id].lock);
+
+	dt = tx_param->word_length1;
+
+	if (dt == OMAP_MCBSP_WORD_8)
+		tx_params.data_type = OMAP_DMA_DATA_TYPE_S8;
+	else if (dt == OMAP_MCBSP_WORD_16)
+		tx_params.data_type = OMAP_DMA_DATA_TYPE_S16;
+	else if (dt == OMAP_MCBSP_WORD_32)
+		tx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
+	else {
+		spin_unlock(&mcbsp[id].lock);
+		return -EINVAL;
+	}
+
+	tx_params.read_prio = DMA_CH_PRIO_HIGH;
+	tx_params.write_prio = DMA_CH_PRIO_HIGH;
+
+	omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
+					DMA_DEFAULT_FIFO_DEPTH, 0);
+
+	tx_params.sync_mode = OMAP_DMA_SYNC_ELEMENT;
+	tx_params.dst_fi = 0;
+
+	tx_params.trigger = mcbsp[id].dma_tx_sync;
+	tx_params.src_or_dst_synch = 0;
+	/* Indexing is always in bytes - so multiply with dt */
+	dt = (tx_params.data_type == OMAP_DMA_DATA_TYPE_S8) ? 1 :
+		(tx_params.data_type == OMAP_DMA_DATA_TYPE_S16) ? 2 : 4;
+	mcbsp[id].tx_word_length = dt;
+
+	if (tx_param->skip_alt == OMAP_MCBSP_SKIP_SECOND) {
+		tx_params.src_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
+		tx_params.src_ei = (1);
+		tx_params.src_fi = (1) + ((-1) * dt);
+	} else if (tx_param->skip_alt == OMAP_MCBSP_SKIP_FIRST) {
+		tx_params.src_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
+		tx_params.src_ei = 1 + (-2) * dt;
+		tx_params.src_fi = 1 + (2) * dt;
+	} else {
+		tx_params.src_amode = OMAP_DMA_AMODE_POST_INC;
+		tx_params.src_ei = 0;
+		tx_params.src_fi = 0;
+	}
+
+	tx_params.dst_amode = OMAP_DMA_AMODE_CONSTANT;
+	tx_params.dst_ei = 0;
+	mcbsp[id].txskip_alt = tx_param->skip_alt;
+
+	mcbsp[id].auto_reset &= ~OMAP_MCBSP_AUTO_XRST;
+	mcbsp[id].auto_reset |=
+		(tx_param->auto_reset & OMAP_MCBSP_AUTO_XRST);
+	mcbsp[id].tx_callback = tx_param->callback;
+
+	if (mcbsp[id].dma_tx_lch == -1) {
+		err = omap_request_dma_chain(id, "McBSP TX",
+					 omap_mcbsp_tx_dma_callback, &chain_id,
+					 omap_mcbsp_max_dmachs_tx[id],
+					 OMAP_DMA_DYNAMIC_CHAIN, tx_params);
+		if (err < 0) {
+			printk(KERN_ERR
+				"Transmit path configuration failed \n");
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+		mcbsp[id].tx_dma_chain_state = 0;
+		mcbsp[id].dma_tx_lch = chain_id;
+		omap_get_mcbspid[chain_id] = id;
+	} else {
+		/* DMA params already set, modify the same!! */
+		err = omap_modify_dma_chain_params(mcbsp[id].
+						 dma_tx_lch, tx_params);
+		if (err < 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+	}
+
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+
+/*
+ * Start receving data on a McBSP interface
+ * id			: McBSP interface ID
+ * cbdata		: User data to be returned with callback
+ * buf_start_addr	: The destination address [physical address]
+ * buf_size		: Buffer size
+ */
+
+int omap_mcbsp_receive_data(unsigned int id, void *cbdata,
+			     dma_addr_t buf_start_addr, u32 buf_size)
+{
+	u32 dma_chain_status = 0;
+	u32 io_base;
+	int enable_rx = 0;
+	int e_count = 0;
+	int f_count = 0;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+	io_base = mcbsp[id].io_base;
+	spin_lock(&mcbsp[id].lock);
+
+	/* Auto RRST handling logic - disable the Reciever before 1st dma */
+	if ((mcbsp[id].auto_reset & OMAP_MCBSP_AUTO_RRST) &&
+		(omap_dma_chain_status(mcbsp[id].dma_rx_lch)
+				== OMAP_DMA_CHAIN_INACTIVE)) {
+			OMAP_MCBSP_WRITE(io_base, SPCR1,
+				OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
+			enable_rx = 1;
+	}
+
+	e_count = (buf_size / mcbsp[id].rx_word_length);
+
+	if (mcbsp[id].rxskip_alt != OMAP_MCBSP_SKIP_NONE) {
+		/*
+		 * since the number of frames = total number of elements/element
+		 * count, However, with double indexing for data transfers,
+		 * double the number of elements need to be transmitted
+		 */
+		f_count = e_count;
+		e_count = 2;
+	} else {
+		f_count = 1;
+	}
+	/*
+	 * If the DMA is to be configured to skip the first byte, we need
+	 * to jump backwards, so we need to move one chunk forward and
+	 * ask dma if we dont want the client driver knowing abt this.
+	 */
+	if (mcbsp[id].rxskip_alt == OMAP_MCBSP_SKIP_FIRST)
+		buf_start_addr += mcbsp[id].rx_word_length;
+
+	dma_chain_status = omap_dma_chain_a_transfer(mcbsp[id]. dma_rx_lch,
+				(mcbsp[id].phy_base + OMAP_MCBSP_REG_DRR),
+				 buf_start_addr, e_count, f_count, cbdata);
+
+	if (mcbsp[id].rx_dma_chain_state == 0) {
+		if (mcbsp[id].interface_mode == OMAP_MCBSP_MASTER) {
+			omap_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
+			mcbsp[id].srg_enabled++ ;
+		}
+		dma_chain_status =
+			omap_start_dma_chain_transfers(mcbsp[id].dma_rx_lch);
+		mcbsp[id].rx_dma_chain_state = 1;
+	}
+
+	/* Auto RRST handling logic - Enable the Reciever after 1st dma */
+	if (enable_rx &&
+		(omap_dma_chain_status(mcbsp[id].dma_rx_lch)
+				== OMAP_DMA_CHAIN_ACTIVE))
+			OMAP_MCBSP_WRITE(io_base, SPCR1,
+				OMAP_MCBSP_READ(io_base, SPCR1) | (RRST));
+
+	if (dma_chain_status < 0) {
+		spin_unlock(&mcbsp[id].lock);
+		return -EPERM;
+	}
+
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+
+/*
+ * Start transmitting data through a McBSP interface
+ * id			: McBSP interface ID
+ * cbdata		: User data to be returned with callback
+ * buf_start_addr	: The source address [This should be physical address]
+ * buf_size		: Buffer size
+ */
+int omap_mcbsp_send_data(unsigned int id, void *cbdata,
+			  dma_addr_t buf_start_addr, u32 buf_size)
+{
+	u32 io_base;
+	u32 dma_chain_state = 0;
+	int enable_tx = 0;
+	int e_count = 0;
+	int f_count = 0;
+
+	if (omap_mcbsp_check(id) < 0)
+		return -EINVAL;
+	io_base = mcbsp[id].io_base;
+	spin_lock(&mcbsp[id].lock);
+
+	/* Auto RRST handling logic - disable the Reciever before 1st dma */
+	if ((mcbsp[id].auto_reset & OMAP_MCBSP_AUTO_XRST) &&
+			(omap_dma_chain_status(mcbsp[id].dma_tx_lch)
+				== OMAP_DMA_CHAIN_INACTIVE)) {
+			OMAP_MCBSP_WRITE(io_base, SPCR2,
+				OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
+			enable_tx = 1;
+	}
+
+	e_count = (buf_size / mcbsp[id].tx_word_length);
+	if (mcbsp[id].txskip_alt != OMAP_MCBSP_SKIP_NONE) {
+		/*
+		 * number of frames = total number of elements/element count,
+		 * However, with double indexing for data transfers, double
+		 * the number of elements need to be transmitted
+		 */
+		f_count = e_count;
+		e_count = 2;
+	} else {
+		f_count = 1;
+	}
+
+	/*
+	 * If the DMA is to be configured to skip the first byte, we need
+	 * to jump backwards, so we need to move one chunk forward and ask
+	 * dma if we dont want the client driver knowing abt this.
+	 */
+	if (mcbsp[id].txskip_alt == OMAP_MCBSP_SKIP_FIRST)
+		buf_start_addr += mcbsp[id].tx_word_length;
+
+	dma_chain_state = omap_dma_chain_a_transfer(mcbsp[id].dma_tx_lch,
+					buf_start_addr,
+					mcbsp[id].phy_base + OMAP_MCBSP_REG_DXR,
+					e_count, f_count, cbdata);
+
+	if (mcbsp[id].tx_dma_chain_state == 0) {
+		if (mcbsp[id].interface_mode == OMAP_MCBSP_MASTER) {
+			omap_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
+			mcbsp[id].srg_enabled++ ;
+		}
+		dma_chain_state =
+			omap_start_dma_chain_transfers(mcbsp[id].dma_tx_lch);
+		mcbsp[id].tx_dma_chain_state = 1;
+	}
+
+	if (dma_chain_state < 0) {
+		spin_unlock(&mcbsp[id].lock);
+		return -EPERM;
+	}
+	/* Auto XRST handling logic - Enable the Reciever after 1st dma */
+	if (enable_tx &&
+		(omap_dma_chain_status(mcbsp[id].dma_tx_lch)
+		== OMAP_DMA_CHAIN_ACTIVE))
+			OMAP_MCBSP_WRITE(io_base, SPCR2,
+				OMAP_MCBSP_READ(io_base, SPCR2) | (XRST));
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+
+#endif
 
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
@@ -850,6 +1758,7 @@
  */
 struct omap_mcbsp_info {
 	u32 virt_base;
+	u32 phy_base;
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 };
@@ -909,15 +1818,15 @@
 };
 #endif
 
-#if defined(CONFIG_ARCH_OMAP24XX)
+#if defined(CONFIG_ARCH_OMAP2420)
 static const struct omap_mcbsp_info mcbsp_24xx[] = {
-	[0] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
+	[0] = { .virt_base = IO_ADDRESS(OMAP2420_MCBSP1_BASE),
 		.dma_rx_sync = OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync = OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq = INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq = INT_24XX_MCBSP1_IRQ_TX,
 		},
-	[1] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
+	[1] = { .virt_base = IO_ADDRESS(OMAP2420_MCBSP2_BASE),
 		.dma_rx_sync = OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync = OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq = INT_24XX_MCBSP2_IRQ_RX,
@@ -926,6 +1835,76 @@
 };
 #endif
 
+#if defined(CONFIG_ARCH_OMAP2430)
+static const struct omap_mcbsp_info mcbsp_2430[] = {
+	[0] = {
+		.virt_base	= IO_ADDRESS(OMAP2430_MCBSP1_BASE),
+		.phy_base	= OMAP2430_MCBSP1_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
+		},
+	[1] = {
+		.virt_base	= IO_ADDRESS(OMAP2430_MCBSP2_BASE),
+		.phy_base	= OMAP2430_MCBSP2_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
+		},
+	[2] = {
+		.virt_base	= IO_ADDRESS(OMAP2430_MCBSP3_BASE),
+		.phy_base	= OMAP2430_MCBSP3_BASE,
+		.dma_rx_sync	= 17,
+		.dma_tx_sync	= 18,
+		},
+	[3] = {
+		.virt_base	= IO_ADDRESS(OMAP2430_MCBSP4_BASE),
+		.phy_base	= OMAP2430_MCBSP4_BASE,
+		.dma_rx_sync	= 19,
+		.dma_tx_sync	= 20,
+		},
+	[4] = {
+		.virt_base	= IO_ADDRESS(OMAP2430_MCBSP5_BASE),
+		.phy_base	= OMAP2430_MCBSP5_BASE,
+		.dma_rx_sync	= 21,
+		.dma_tx_sync	= 22,
+		},
+};
+#endif
+
+#if defined(CONFIG_ARCH_OMAP34XX)
+static const struct omap_mcbsp_info mcbsp_34xx[] = {
+	[0] = {
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
+		.phy_base	= OMAP34XX_MCBSP1_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
+		},
+	[1] = {
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
+		.phy_base	= OMAP34XX_MCBSP2_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
+		},
+	[2] = {
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.phy_base	= OMAP34XX_MCBSP3_BASE,
+		.dma_rx_sync	= 17,
+		.dma_tx_sync	= 18,
+		},
+	[3] = {
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.phy_base	= OMAP34XX_MCBSP4_BASE,
+		.dma_rx_sync	= 19,
+		.dma_tx_sync	= 20,
+		},
+	[4] = {
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.phy_base       = OMAP34XX_MCBSP5_BASE,
+		.dma_rx_sync	= 21,
+		.dma_tx_sync	= 22,
+		},
+};
+#endif
+
 static int __init omap_mcbsp_init(void)
 {
 	int mcbsp_count = 0, i;
@@ -950,7 +1929,7 @@
 		return PTR_ERR(mcbsp_dspxor_ck);
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP2
+#ifdef CONFIG_ARCH_OMAP2420
 	mcbsp1_ick = clk_get(0, "mcbsp1_ick");
 	if (IS_ERR(mcbsp1_ick)) {
 		printk(KERN_ERR "mcbsp: could not acquire mcbsp1_ick handle.\n");
@@ -973,6 +1952,26 @@
 	}
 #endif
 
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	for (i = 0; i < OMAP_MAX_MCBSP_COUNT; i++) {
+
+		omap_mcbsp_clk[i].ick = clk_get(0, omap_mcbsp_ick[i]);
+		if (IS_ERR(omap_mcbsp_ick[i])) {
+			printk(KERN_ERR "mcbsp[%d] could not \
+						acquire ick handle\n",i+1);
+			return PTR_ERR(omap_mcbsp_ick[i]);
+		}
+
+		omap_mcbsp_clk[i].fck = clk_get(0, omap_mcbsp_fck[i]);
+		if (IS_ERR(omap_mcbsp_fck[i])) {
+			printk(KERN_ERR "mcbsp[%d] could not \
+						acquire fck handle\n",i+1);
+			return PTR_ERR(omap_mcbsp_fck[i]);
+		}
+	}
+
+#endif
+
 #ifdef CONFIG_ARCH_OMAP730
 	if (cpu_is_omap730()) {
 		mcbsp_info = mcbsp_730;
@@ -991,13 +1990,26 @@
 		mcbsp_count = ARRAY_SIZE(mcbsp_1610);
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX)
-	if (cpu_is_omap24xx()) {
+#if defined(CONFIG_ARCH_OMAP2420)
+	if (cpu_is_omap2420()) {
 		mcbsp_info = mcbsp_24xx;
 		mcbsp_count = ARRAY_SIZE(mcbsp_24xx);
 		omap2_mcbsp2_mux_setup();
 	}
 #endif
+#if  defined(CONFIG_ARCH_OMAP2430)
+	if (cpu_is_omap2430()) {
+		mcbsp_info = mcbsp_2430;
+		mcbsp_count = ARRAY_SIZE(mcbsp_2430);
+	}
+#endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+	if (cpu_is_omap34xx()) {
+		mcbsp_info = mcbsp_34xx;
+		mcbsp_count = ARRAY_SIZE(mcbsp_34xx);
+	}
+#endif
+
 	for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
 		if (i >= mcbsp_count) {
 			mcbsp[i].io_base = 0;
@@ -1010,11 +2022,13 @@
 		mcbsp[i].dma_rx_lch = -1;
 
 		mcbsp[i].io_base = mcbsp_info[i].virt_base;
+		mcbsp[i].phy_base = mcbsp_info[i].phy_base;
 		mcbsp[i].io_type = OMAP_MCBSP_IRQ_IO; /* Default I/O is IRQ based */
 		mcbsp[i].tx_irq = mcbsp_info[i].tx_irq;
 		mcbsp[i].rx_irq = mcbsp_info[i].rx_irq;
 		mcbsp[i].dma_rx_sync = mcbsp_info[i].dma_rx_sync;
 		mcbsp[i].dma_tx_sync = mcbsp_info[i].dma_tx_sync;
+		mcbsp[i].srg_enabled = 0;
 		spin_lock_init(&mcbsp[i].lock);
 	}
 
@@ -1029,6 +2043,7 @@
 EXPORT_SYMBOL(omap_mcbsp_free);
 EXPORT_SYMBOL(omap_mcbsp_start);
 EXPORT_SYMBOL(omap_mcbsp_stop);
+#if !defined(CONFIG_ARCH_OMAP2430) &&  !defined(CONFIG_ARCH_OMAP34XX)
 EXPORT_SYMBOL(omap_mcbsp_pollread);
 EXPORT_SYMBOL(omap_mcbsp_pollwrite);
 EXPORT_SYMBOL(omap_mcbsp_xmit_word);
@@ -1038,3 +2053,17 @@
 EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
 EXPORT_SYMBOL(omap_mcbsp_spi_master_recv_word_poll);
 EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
+#else
+EXPORT_SYMBOL(omap_mcbsp_params_cfg);
+EXPORT_SYMBOL(omap_mcbsp_stop_datatx);
+EXPORT_SYMBOL(omap_mcbsp_stop_datarx);
+EXPORT_SYMBOL(omap_mcbsp_reset);
+EXPORT_SYMBOL(omap_mcbsp_transmitter_index);
+EXPORT_SYMBOL(omap_mcbsp_receiver_index);
+EXPORT_SYMBOL(omap_mcbsp_set_xrst);
+EXPORT_SYMBOL(omap_mcbsp_set_rrst);
+EXPORT_SYMBOL(omap_mcbsp_receive_data);
+EXPORT_SYMBOL(omap_mcbsp_send_data);
+EXPORT_SYMBOL(omap_mcbsp_dma_trans_params);
+EXPORT_SYMBOL(omap_mcbsp_dma_recv_params);
+#endif
Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2007-12-18 22:03:11.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2007-12-20 20:30:57.251392013 +0530
@@ -26,19 +26,33 @@
 
 #include <asm/hardware.h>
 
-#define OMAP730_MCBSP1_BASE	0xfffb1000
-#define OMAP730_MCBSP2_BASE	0xfffb1800
+#define OMAP730_MCBSP1_BASE		0xfffb1000
+#define OMAP730_MCBSP2_BASE		0xfffb1800
 
-#define OMAP1510_MCBSP1_BASE	0xe1011800
-#define OMAP1510_MCBSP2_BASE	0xfffb1000
-#define OMAP1510_MCBSP3_BASE	0xe1017000
-
-#define OMAP1610_MCBSP1_BASE	0xe1011800
-#define OMAP1610_MCBSP2_BASE	0xfffb1000
-#define OMAP1610_MCBSP3_BASE	0xe1017000
-
-#define OMAP24XX_MCBSP1_BASE	0x48074000
-#define OMAP24XX_MCBSP2_BASE	0x48076000
+#define OMAP1510_MCBSP1_BASE		0xe1011800
+#define OMAP1510_MCBSP2_BASE		0xfffb1000
+#define OMAP1510_MCBSP3_BASE		0xe1017000
+
+#define OMAP1610_MCBSP1_BASE		0xe1011800
+#define OMAP1610_MCBSP2_BASE		0xfffb1000
+#define OMAP1610_MCBSP3_BASE		0xe1017000
+
+#define OMAP2420_MCBSP1_BASE		0x48074000
+#define OMAP2420_MCBSP2_BASE		0x48076000
+
+#define OMAP2430_MCBSP1_BASE		(L4_24XX_BASE + 0x74000)
+#define OMAP2430_MCBSP2_BASE		(L4_24XX_BASE + 0x76000)
+#define OMAP2430_MCBSP3_BASE		(L4_24XX_BASE + 0x8C000)
+#define OMAP2430_MCBSP4_BASE		(L4_24XX_BASE + 0x8E000)
+#define OMAP2430_MCBSP5_BASE		(L4_24XX_BASE + 0x96000)
+
+#define OMAP34XX_MCBSP1_BASE		(L4_34XX_BASE + 0x74000)
+#define OMAP34XX_MCBSP2_BASE		(L4_PER_34XX_BASE + 0x22000)
+#define OMAP34XX_MCBSP3_BASE		(L4_PER_34XX_BASE + 0x24000)
+#define OMAP34XX_MCBSP4_BASE		(L4_PER_34XX_BASE + 0x26000)
+#define OMAP34XX_MCBSP5_BASE		(L4_34XX_BASE + 0x96000)
+#define OMAP34XX_MCBSP2_ST_BASE		(L4_PER_BASE + 0x28000)
+#define OMAP34XX_MCBSP3_ST_BASE		(L4_PER_BASE + 0x2A000)
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
 
@@ -85,10 +99,6 @@
 
 #elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
-#define OMAP_MCBSP_REG_DRR2	0x00
-#define OMAP_MCBSP_REG_DRR1	0x04
-#define OMAP_MCBSP_REG_DXR2	0x08
-#define OMAP_MCBSP_REG_DXR1	0x0C
 #define OMAP_MCBSP_REG_SPCR2	0x10
 #define OMAP_MCBSP_REG_SPCR1	0x14
 #define OMAP_MCBSP_REG_RCR2	0x18
@@ -117,20 +127,57 @@
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
 
-#define OMAP_MAX_MCBSP_COUNT 2
+#define AUDIO_MCBSP             OMAP_MCBSP2
+
+#if defined(CONFIG_ARCH_OMAP2420)
+#define OMAP_MCBSP_REG_DRR2	0x00
+#define OMAP_MCBSP_REG_DRR1	0x04
+#define OMAP_MCBSP_REG_DXR2	0x08
+#define OMAP_MCBSP_REG_DXR1	0x0C
 
-#define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
-#define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
+#define OMAP_MAX_MCBSP_COUNT	2
 
-#define AUDIO_MCBSP		OMAP_MCBSP2
+#define AUDIO_MCBSP_DATAWRITE	(OMAP2420_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
+#define AUDIO_MCBSP_DATAREAD	(OMAP2420_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
 #define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
 #define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
 
+#elif defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP2430)
+
+#define OMAP_MCBSP_REG_DRR		0x00
+#define OMAP_MCBSP_REG_DXR		0x08
+#define OMAP_MCBSP_REG_SYSCONFIG	0x8C
+#define OMAP_MCBSP_REG_THRSH2		0x90
+#define OMAP_MCBSP_REG_THRSH1		0x94
+#define OMAP_MCBSP_REG_IRQSTATUS	0xA0
+#define OMAP_MCBSP_REG_IRQENABLE	0xA4
+#define OMAP_MCBSP_REG_WAKEUPEN		0xA8
+#define OMAP_MCBSP_REG_XCCR		0xAC
+#define OMAP_MCBSP_REG_RCCR		0xB0
+#define OMAP_MCBSP_REG_XBUFFSTAT	0xB4
+#define OMAP_MCBSP_REG_RBUFFSTAT	0xB8
+
+#define OMAP_MAX_MCBSP_COUNT	5
+
+#endif
+
+#endif
+
+#if !defined(CONFIG_ARCH_OMAP34XX) && !defined(CONFIG_ARCH_OMAP2430)
+#define OMAP_MCBSP_READ(base, reg) \
+				__raw_readw((base) + OMAP_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(base, reg, val) \
+			__raw_writew((u16)(val), (base) + OMAP_MCBSP_REG_##reg)
+#else
+#define OMAP_MCBSP_READ(base, reg) \
+				__raw_readl((base) + OMAP_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(base, reg, val) \
+			__raw_writel((val), (base) + OMAP_MCBSP_REG_##reg)
 #endif
 
-#define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) + OMAP_MCBSP_REG_##reg)
+typedef void (*omap_mcbsp_dma_cb) (u32 ch_status, void *arg);
 
+#define OMAP_MCBSP_BIT(ARG)		((0x01)<<(ARG))
 
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
@@ -142,7 +189,11 @@
 #define DXENA			0x0080
 #define CLKSTP(value)		((value)<<11)	/* bits 11:12 */
 #define RJUST(value)		((value)<<13)	/* bits 13:14 */
+#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP2430)
+#define ALB			0x8000
+#else
 #define DLB			0x8000
+#endif
 
 /************************** McBSP SPCR2 bit definitions ***********************/
 #define XRST		0x0001
@@ -219,44 +270,180 @@
 #define XPABLK(value)		((value)<<5)	/* Bits 5:6 */
 #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
 
+# if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+
+/*********************** McBSP XCCR bit definitions *************************/
+#define DLB			OMAP_MCBSP_BIT(5)
+#define XDMAEN			OMAP_MCBSP_BIT(3)
+#define XDISABLE		OMAP_MCBSP_BIT(0)
+#define XENDLY(value)		((value)<<12)	/*Bits 12:13 */
+#define XFULL_CYCLE		OMAP_MCBSP_BIT(11)
+
+/********************** McBSP RCCR bit definitions *************************/
+#define RDMAEN			OMAP_MCBSP_BIT(3)
+#define RDISABLE		OMAP_MCBSP_BIT(0)
+#define RFULL_CYCLE		OMAP_MCBSP_BIT(11)
+
+/********************** McBSP SYSCONFIG bit definitions ********************/
+#define SOFTRST			OMAP_MCBSP_BIT(1)
+
+#endif
+/* mono to mono mode*/
+#define OMAP_MCBSP_SKIP_NONE			(0x0)
+/* mono to stereo mode */
+#define OMAP_MCBSP_SKIP_FIRST			(0x1<<1)
+#define OMAP_MCBSP_SKIP_SECOND			(0x1<<2)
+
+#define OMAP_MCBSP_AUTO_RRST			(0x1<<1)
+#define OMAP_MCBSP_AUTO_XRST			(0x1<<2)
+/* RRST STATE */
+#define OMAP_MCBSP_RRST_DISABLE			0
+#define OMAP_MCBSP_RRST_ENABLE			1
+
+/*XRST STATE */
+#define OMAP_MCBSP_XRST_DISABLE			0
+#define OMAP_MCBSP_XRST_ENABLE			1
+
+/* McBSP interface operating mode */
+#define OMAP_MCBSP_MASTER			1
+#define OMAP_MCBSP_SLAVE			0
+
+/* SRG ENABLE/DISABLE state */
+#define OMAP_MCBSP_DISABLE_FSG_SRG		0
+#define OMAP_MCBSP_ENABLE_FSG_SRG		1
+
+#define OMAP_MCBSP_FRAME_SINGLEPHASE		1
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
+#define OMAP_MCBSP_CLKRXSRC_EXTERNAL		0
+#define OMAP_MCBSP_CLKRXSRC_INTERNAL		1
+
+#define OMAP_MCBSP_CLKTXSRC_EXTERNAL		0
+#define OMAP_MCBSP_CLKTXSRC_INTERNAL		1
+
+/* Justification */
+#define OMAP_MCBSP_RJUST_ZEROMSB		0
+#define OMAP_MCBSP_RJUST_SIGNMSB		1
+#define OMAP_MCBSP_LJUST_ZEROLSB		2
+
+#define OMAP_MCBSP_AUTO_RST_NONE		(0x0)
+#define OMAP_MCBSP_AUTO_RRST			(0x1<<1)
+#define OMAP_MCBSP_AUTO_XRST			(0x1<<2)
+
+/* Reverse mode for 243X and 34XX */
+#define OMAP_MCBSP_MSBFIRST			0
+#define OMAP_MCBSP_LSBFIRST			1
+
+/* Data Delay */
+#define OMAP2_MCBSP_DATADELAY0			0
+#define OMAP2_MCBSP_DATADELAY1			1
+#define OMAP2_MCBSP_DATADELAY2			2
+
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
-	u16 spcr2;
-	u16 spcr1;
-	u16 rcr2;
-	u16 rcr1;
-	u16 xcr2;
-	u16 xcr1;
-	u16 srgr2;
-	u16 srgr1;
-	u16 mcr2;
-	u16 mcr1;
-	u16 pcr0;
-	u16 rcerc;
-	u16 rcerd;
-	u16 xcerc;
-	u16 xcerd;
-	u16 rcere;
-	u16 rcerf;
-	u16 xcere;
-	u16 xcerf;
-	u16 rcerg;
-	u16 rcerh;
-	u16 xcerg;
-	u16 xcerh;
+	u32 spcr2;
+	u32 spcr1;
+	u32 rcr2;
+	u32 rcr1;
+	u32 xcr2;
+	u32 xcr1;
+	u32 srgr2;
+	u32 srgr1;
+	u32 mcr2;
+	u32 mcr1;
+	u32 pcr0;
+	u32 rcerc;
+	u32 rcerd;
+	u32 xcerc;
+	u32 xcerd;
+	u32 rcere;
+	u32 rcerf;
+	u32 xcere;
+	u32 xcerf;
+	u32 rcerg;
+	u32 rcerh;
+	u32 xcerg;
+	u32 xcerh;
+	u32 xccr;
+	u32 rccr;
+};
+struct omap_mcbsp_dma_transfer_params {
+	/* Skip the alternate element */
+	u8 skip_alt;
+	/* Automagically handle Transfer [XR]RST? */
+	u8   auto_reset;
+	/* callback function executed for every tx/rx completion */
+	omap_mcbsp_dma_cb callback;
+	/* word length of data */
+	u32 word_length1;
+
+};
+
+struct omap_mcbsp_cfg_param {
+	u8 fsync_src;
+	u8 fs_polarity;
+	u8 clk_polarity;
+	u8 clk_mode;	/* Internal/External */
+	u8 frame_length1;
+	u8 word_length1;
+	u8 justification;
+	u8 reverse_compand;
+	u8 phase;
+	u8 data_delay;
+};
+
+struct omap_mcbsp_srg_fsg_cfg {
+	u32 period;		/* Frame period */
+	u32 pulse_width;	/* Frame width */
+	u8  fsgm;
+	u32 sample_rate;
+	u32 bits_per_sample;
+	u32 srg_src;		/*CLKR/CLKX/CLKS/FCLK */
+	u8  sync_mode;		/* SRG free running mode */
+	u8  polarity;		/* CLKS/CLKR/CLKX polarity */
+	u8  dlb;		/* digital loopback mode */
 };
 
 typedef enum {
 	OMAP_MCBSP1 = 0,
 	OMAP_MCBSP2,
 	OMAP_MCBSP3,
+	OMAP_MCBSP4,
+	OMAP_MCBSP5,
 } omap_mcbsp_id;
 
 typedef int __bitwise omap_mcbsp_io_type_t;
 #define OMAP_MCBSP_IRQ_IO ((__force omap_mcbsp_io_type_t) 1)
 #define OMAP_MCBSP_POLL_IO ((__force omap_mcbsp_io_type_t) 2)
 
+#define OMAP_MCBSP_FRAMELEN_N(NUM_WORDS) ((NUM_WORDS - 1) & 0x7F)
+
 typedef enum {
 	OMAP_MCBSP_WORD_8 = 0,
 	OMAP_MCBSP_WORD_12,
@@ -320,4 +507,27 @@
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 
+# if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+int omap_mcbsp_params_cfg(unsigned int id, int interface_mode,
+				struct omap_mcbsp_cfg_param *rp,
+				struct omap_mcbsp_cfg_param  *tp,
+				struct  omap_mcbsp_srg_fsg_cfg *param);
+
+int omap_mcbsp_stop_datatx(unsigned int id);
+int omap_mcbsp_stop_datarx(unsigned int id);
+int omap_mcbsp_reset(unsigned int id);
+int omap_mcbsp_transmitter_index(unsigned int id, int *ei, int *fi);
+int omap_mcbsp_receiver_index(unsigned int id, int *ei, int *fi);
+int omap_mcbsp_set_xrst(unsigned int id, u8 state);
+int omap_mcbsp_set_rrst(unsigned int id, u8 state);
+int omap_mcbsp_dma_recv_params(unsigned int id,
+			struct omap_mcbsp_dma_transfer_params *rx_param);
+int omap_mcbsp_dma_trans_params(unsigned int id,
+			struct omap_mcbsp_dma_transfer_params *tx_param);
+int omap_mcbsp_receive_data(unsigned int id, void *cbdata,
+				dma_addr_t buf_start_addr, u32 buf_size);
+int omap_mcbsp_send_data(unsigned int id, void *cbdata,
+				dma_addr_t buf_start_addr, u32 buf_size);
+
+#endif
 #endif
