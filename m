From: "Chandra shekhar" <x0044955@ti.com>
Subject: [RFC/PATCH  3/4] McBSP support  for 34XX
Date: Mon, 16 Jun 2008 17:51:05 +0530
Message-ID: <003d01c8cfab$72fba1f0$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45707 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbYFPMVP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jun 2008 08:21:15 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5GCL7Ko008961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 07:21:14 -0500
Received: from a0875540 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5GCL3G2023696
	for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 17:51:05 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: chandra shekhar <x0044955@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c       |  680 ++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/mcbsp.c        |    5 
 include/asm-arm/arch-omap/mcbsp.h |  117 +++++-
 3 files changed, 779 insertions(+), 23 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/mcbsp.c	2008-06-16 16:04:58.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c	2008-06-16 16:10:03.567491667 +0530
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
@@ -150,15 +152,687 @@
 	return 0;
 }
 
+static void omap2_mcbsp_free(unsigned int id)
+{
+	if (!cpu_is_omap2420()) {
+		if (mcbsp[id].dma_rx_lch != -1) {
+			omap_free_dma_chain(mcbsp[id].dma_rx_lch);
+			 mcbsp[id].dma_rx_lch = -1;
+		}
+
+		if (mcbsp[id].dma_tx_lch != -1) {
+			omap_free_dma_chain(mcbsp[id].dma_tx_lch);
+			mcbsp[id].dma_tx_lch = -1;
+		}
+	}
+	return;
+}
+void omap2_mcbsp_config(unsigned int id,
+			 const struct omap_mcbsp_reg_cfg *config)
+{
+	u32 io_base;
+	io_base = mcbsp[id].io_base;
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_XCCR, config->xccr);
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_RCCR, config->rccr);
+}
 static struct omap_mcbsp_ops omap2_mcbsp_ops = {
 	.request	= omap2_mcbsp_request,
 	.check		= omap2_mcbsp_check,
+	.free 		= omap2_mcbsp_free,
+	.config		= omap2_mcbsp_config,
 };
+static void omap2_mcbsp_rx_dma_callback(int lch, u16 ch_status, void *data)
+{
+	struct omap_mcbsp *mcbsp_dma_rx = data;
+	u32 io_base;
+	io_base = mcbsp_dma_rx->io_base;
+
+	/* If we are at the last transfer, Shut down the reciever */
+	if ((mcbsp_dma_rx->auto_reset & OMAP_MCBSP_AUTO_RRST)
+		&& (omap_dma_chain_status(mcbsp_dma_rx->dma_rx_lch) ==
+						 OMAP_DMA_CHAIN_INACTIVE))
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+			omap_mcbsp_read(io_base,
+					 OMAP_MCBSP_REG_SPCR1) & (~RRST));
+
+	if (mcbsp_dma_rx->rx_callback != NULL)
+		mcbsp_dma_rx->rx_callback(ch_status, mcbsp_dma_rx->rx_cb_arg);
+
+}
+
+static void omap2_mcbsp_tx_dma_callback(int lch, u16 ch_status, void *data)
+{
+	struct omap_mcbsp *mcbsp_dma_tx = data;
+	u32 io_base;
+	io_base = mcbsp_dma_tx->io_base;
+
+	/* If we are at the last transfer, Shut down the Transmitter */
+	if ((mcbsp_dma_tx->auto_reset & OMAP_MCBSP_AUTO_XRST)
+		&& (omap_dma_chain_status(mcbsp_dma_tx->dma_tx_lch) ==
+						 OMAP_DMA_CHAIN_INACTIVE))
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base,
+					 OMAP_MCBSP_REG_SPCR2) & (~XRST));
+
+	if (mcbsp_dma_tx->tx_callback != NULL)
+		mcbsp_dma_tx->tx_callback(ch_status, mcbsp_dma_tx->tx_cb_arg);
+}
+/*
+ * Enable/Disable the sample rate generator
+ * id		: McBSP interface ID
+ * state	: Enable/Disable
+ */
+int omap2_mcbsp_set_srg_fsg(unsigned int id, u8 state)
+{
+	u32 io_base;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
+
+	io_base = mcbsp[id].io_base;
+
+	if (state == OMAP_MCBSP_DISABLE_FSG_SRG) {
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base,
+					 OMAP_MCBSP_REG_SPCR2) & (~GRST));
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base,
+					 OMAP_MCBSP_REG_SPCR2) & (~FRST));
+	} else {
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2) | GRST);
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2) | FRST);
+	}
+	return (0);
+}
+
+/*
+ * Stop transmitting data on a McBSP interface
+ * id		: McBSP interface ID
+ */
+int omap2_mcbsp_stop_datatx(unsigned int id)
+{
+	u32 io_base;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
+
+	if (mcbsp[id].dma_tx_lch != -1) {
+		if (omap_stop_dma_chain_transfers(mcbsp[id].dma_tx_lch) != 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+	}
+	mcbsp[id].tx_dma_chain_state = 0;
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+		omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2) & (~XRST));
+
+	if (!(--mcbsp[id].srg_enabled))
+		omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_stop_datatx);
+
+/*
+ * Stop receving data on a McBSP interface
+ * id		: McBSP interface ID
+ */
+int omap2_mcbsp_stop_datarx(u32 id)
+{
+
+	u32 io_base;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
+
+	if (mcbsp[id].dma_rx_lch != -1) {
+		if (omap_stop_dma_chain_transfers(mcbsp[id].dma_rx_lch) != 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+	}
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+		omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1) & (~RRST));
+	mcbsp[id].rx_dma_chain_state = 0;
+	if (!(--mcbsp[id].srg_enabled))
+		omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_stop_datarx);
+
+/*
+ * Interface Reset
+ * id	: McBSP interface ID
+ * Resets the McBSP interface
+ */
+int omap2_mcbsp_reset(unsigned int id)
+{
+	u32 io_base;
+	int counter = 0;
+	int wait_for_reset = 10000;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
+
+	io_base = mcbsp[id].io_base;
+
+	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SYSCON,
+		omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SYSCON) | (SOFTRST));
+
+	while (omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SYSCON) & SOFTRST) {
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
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_reset);
+
+/*
+ * Get the element index and frame index of transmitter
+ * id		: McBSP interface ID
+ * ei		: element index
+ * fi		: frame index
+ */
+int omap2_mcbsp_transmitter_index(int id, int *ei, int *fi)
+{
+	int eix = 0, fix = 0;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
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
+EXPORT_SYMBOL(omap2_mcbsp_transmitter_index);
+
+/*
+ * Get the element index and frame index of receiver
+ * id	: McBSP interface ID
+ * ei		: element index
+ * fi		: frame index
+ */
+int omap2_mcbsp_receiver_index(int id, int *ei, int *fi)
+{
+	int eix = 0, fix = 0;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
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
+EXPORT_SYMBOL(omap2_mcbsp_receiver_index);
+
+/*
+ * Basic Reset Transmitter
+ * id		: McBSP interface number
+ * state	: Disable (0)/ Enable (1) the transmitter
+ */
+int omap2_mcbsp_set_xrst(unsigned int id, u8 state)
+{
+	u32 io_base;
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
+
+	io_base = mcbsp[id].io_base;
+
+	if (state == OMAP_MCBSP_XRST_DISABLE)
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+		      omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2) & (~XRST));
+	else
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2) | XRST);
+	udelay(10);
+
+	return (0);
+}
+EXPORT_SYMBOL(omap2_mcbsp_set_xrst);
+
+/*
+ * Reset Receiver
+ * id		: McBSP interface number
+ * state	: Disable (0)/ Enable (1) the receiver
+ */
+int omap2_mcbsp_set_rrst(unsigned int id, u8 state)
+{
+	u32 io_base;
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
+
+	io_base = mcbsp[id].io_base;
+
+	if (state == OMAP_MCBSP_RRST_DISABLE)
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+			omap_mcbsp_read(io_base,
+				 OMAP_MCBSP_REG_SPCR1) & (~RRST));
+	else
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+		      omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1) | RRST);
+	udelay(10);
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_set_rrst);
+
+/*
+ * Configure the receiver parameters
+ * id		: McBSP Interface ID
+ * rp		: DMA Receive parameters
+ */
+int omap2_mcbsp_dma_recv_params(unsigned int id,
+			struct omap_mcbsp_dma_transfer_params *rp)
+{
+	u32 io_base;
+	int err, chain_id = -1;
+	struct omap_dma_channel_params rx_params;
+	u32  dt = 0;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -EINVAL;
+	io_base = mcbsp[id].io_base;
+	dt = rp->word_length1;
+
+	if (dt == OMAP_MCBSP_WORD_8)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S8;
+	else if (dt == OMAP_MCBSP_WORD_16)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S16;
+	else if (dt == OMAP_MCBSP_WORD_32)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
+	else
+		return -EINVAL;
+
+	rx_params.read_prio = DMA_CH_PRIO_HIGH;
+	rx_params.write_prio = DMA_CH_PRIO_HIGH;
+	rx_params.sync_mode = OMAP_DMA_SYNC_ELEMENT;
+	rx_params.src_fi = 0;
+	rx_params.trigger = mcbsp[id].dma_rx_sync;
+	rx_params.src_or_dst_synch = 0x01;
+	rx_params.src_amode = OMAP_DMA_AMODE_CONSTANT;
+	rx_params.src_ei = 0x0;
+	/* Indexing is always in bytes - so multiply with dt */
+
+	dt = (rx_params.data_type == OMAP_DMA_DATA_TYPE_S8) ? 1 :
+		(rx_params.data_type == OMAP_DMA_DATA_TYPE_S16) ? 2 : 4;
+
+	/* SKIP_FIRST and sKIP_SECOND- 24 bit data in stereo mode*/
+	if (rp->skip_alt == OMAP_MCBSP_SKIP_SECOND) {
+		rx_params.dst_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
+		rx_params.dst_ei = (1);
+		rx_params.dst_fi = (1) + ((-1) * dt);
+	} else if (rp->skip_alt == OMAP_MCBSP_SKIP_FIRST) {
+		rx_params.dst_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
+		rx_params.dst_ei = 1 + (-2) * dt;
+		rx_params.dst_fi = 1 + (2) * dt;
+	} else {
+		rx_params.dst_amode = OMAP_DMA_AMODE_POST_INC;
+		rx_params.dst_ei = 0;
+		rx_params.dst_fi = 0;
+	}
+
+	mcbsp[id].rxskip_alt = rp->skip_alt;
+	mcbsp[id].auto_reset &= ~OMAP_MCBSP_AUTO_RRST;
+	mcbsp[id].auto_reset |=	(rp->auto_reset & OMAP_MCBSP_AUTO_RRST);
+
+	mcbsp[id].rx_word_length = rx_params.data_type << 0x1;
+	if (rx_params.data_type == 0)
+		mcbsp[id].rx_word_length = 1;
+
+	mcbsp[id].rx_callback = rp->callback;
+	/* request for a chain of dma channels for data reception */
+	if (mcbsp[id].dma_rx_lch == -1) {
+		err = omap_request_dma_chain(id, "McBSP RX",
+					 omap2_mcbsp_rx_dma_callback, &chain_id,
+					 2, OMAP_DMA_DYNAMIC_CHAIN, rx_params);
+		if (err < 0) {
+			printk(KERN_ERR "Receive path configuration failed \n");
+			return -EPERM;
+		}
+		mcbsp[id].dma_rx_lch = chain_id;
+		mcbsp[id].rx_dma_chain_state = 0;
+	} else {
+		/* DMA params already set, modify the same!! */
+		err = omap_modify_dma_chain_params(mcbsp[id].
+						 dma_rx_lch, rx_params);
+		if (err < 0)
+			return -EPERM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_dma_recv_params);
+
+/*
+ * Configure the transmitter parameters
+ * id		: McBSP Interface ID
+ * tp		: DMA Transfer parameters
+ */
+
+int omap2_mcbsp_dma_trans_params(unsigned int id,
+			struct omap_mcbsp_dma_transfer_params *tp)
+{
+
+	struct omap_dma_channel_params tx_params;
+	int err = 0, chain_id = -1;
+	u32 io_base;
+	u32 dt = 0;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -EINVAL;
+	io_base = mcbsp[id].io_base;
+
+	dt = tp->word_length1;
+	if ((dt != OMAP_MCBSP_WORD_8) && (dt != OMAP_MCBSP_WORD_16)
+						 && (dt != OMAP_MCBSP_WORD_32))
+		return -EINVAL;
+	if (dt == OMAP_MCBSP_WORD_8)
+		tx_params.data_type = OMAP_DMA_DATA_TYPE_S8;
+	else if (dt == OMAP_MCBSP_WORD_16)
+		tx_params.data_type = OMAP_DMA_DATA_TYPE_S16;
+	else if (dt == OMAP_MCBSP_WORD_32)
+		tx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
+	else
+		return -EINVAL;
+
+	tx_params.read_prio = DMA_CH_PRIO_HIGH;
+	tx_params.write_prio = DMA_CH_PRIO_HIGH;
+	tx_params.sync_mode = OMAP_DMA_SYNC_ELEMENT;
+	tx_params.dst_fi = 0;
+	tx_params.trigger = mcbsp[id].dma_tx_sync;
+	tx_params.src_or_dst_synch = 0;
+	/* Indexing is always in bytes - so multiply with dt */
+	mcbsp[id].tx_word_length = tx_params.data_type << 0x1;
+
+	if (tx_params.data_type == 0)
+		mcbsp[id].tx_word_length = 1;
+	dt = mcbsp[id].tx_word_length;
+
+	/* SKIP_FIRST and sKIP_SECOND- 24 bit data in stereo mode*/
+	if (tp->skip_alt == OMAP_MCBSP_SKIP_SECOND) {
+		tx_params.src_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
+		tx_params.src_ei = (1);
+		tx_params.src_fi = (1) + ((-1) * dt);
+	} else if (tp->skip_alt == OMAP_MCBSP_SKIP_FIRST) {
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
+	mcbsp[id].txskip_alt = tp->skip_alt;
+	mcbsp[id].auto_reset &= ~OMAP_MCBSP_AUTO_XRST;
+	mcbsp[id].auto_reset |=
+		(tp->auto_reset & OMAP_MCBSP_AUTO_XRST);
+	mcbsp[id].tx_callback = tp->callback;
+
+	/* Based on Rjust we can do double indexing DMA params configuration */
+	if (mcbsp[id].dma_tx_lch == -1) {
+		err = omap_request_dma_chain(id, "McBSP TX",
+					 omap2_mcbsp_tx_dma_callback, &chain_id,
+					 2, OMAP_DMA_DYNAMIC_CHAIN, tx_params);
+		if (err < 0) {
+			printk(KERN_ERR
+				"Transmit path configuration failed \n");
+			return -EPERM;
+		}
+		mcbsp[id].tx_dma_chain_state = 0;
+	mcbsp[id].dma_tx_lch = chain_id;
+	} else {
+		/* DMA params already set, modify the same!! */
+		err = omap_modify_dma_chain_params(mcbsp[id].
+						 dma_tx_lch, tx_params);
+		if (err < 0)
+			return -EPERM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_dma_trans_params);
+
+/*
+ * Start receving data on a McBSP interface
+ * id			: McBSP interface ID
+ * cbdata		: User data to be returned with callback
+ * buf_start_addr	: The destination address [physical address]
+ * buf_size		: Buffer size
+ */
+
+int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
+			     dma_addr_t buf_start_addr, u32 buf_size)
+{
+	u32 io_base;
+	int enable_rx = 0;
+	int e_count = 0;
+	int f_count = 0;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
+
+	mcbsp[id].rx_cb_arg = cbdata;
+
+	/* Auto RRST handling logic - disable the Reciever before 1st dma */
+	if ((mcbsp[id].auto_reset & OMAP_MCBSP_AUTO_RRST) &&
+		(omap_dma_chain_status(mcbsp[id].dma_rx_lch)
+				== OMAP_DMA_CHAIN_INACTIVE)) {
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+			omap_mcbsp_read(io_base,
+				 OMAP_MCBSP_REG_SPCR1) & (~RRST));
+		enable_rx = 1;
+	}
+
+	/*
+	 * for skip_first and second, we need to set e_count =2,
+	 * and f_count = number of frames = number of elements/e_count
+	 */
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
+	if (omap_dma_chain_a_transfer(mcbsp[id]. dma_rx_lch,
+			mcbsp[id].phy_base + OMAP_MCBSP_REG_DRR, buf_start_addr,
+			e_count, f_count, &mcbsp[id]) < 0) {
+		spin_unlock(&mcbsp[id].lock);
+		printk(KERN_ERR " Buffer chaining failed \n");
+		return -EPERM;
+	}
+	if (mcbsp[id].rx_dma_chain_state == 0) {
+		if (mcbsp[id].interface_mode == OMAP_MCBSP_MASTER) {
+			omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
+			mcbsp[id].srg_enabled++ ;
+		}
+		if (omap_start_dma_chain_transfers(mcbsp[id].dma_rx_lch) < 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+		mcbsp[id].rx_dma_chain_state = 1;
+	}
+	/* Auto RRST handling logic - Enable the Reciever after 1st dma */
+	if (enable_rx &&
+		(omap_dma_chain_status(mcbsp[id].dma_rx_lch)
+				== OMAP_DMA_CHAIN_ACTIVE))
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR1,
+			omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR1) | RRST);
+
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_receive_data);
+
+/*
+ * Start transmitting data through a McBSP interface
+ * id			: McBSP interface ID
+ * cbdata		: User data to be returned with callback
+ * buf_start_addr	: The source address [This should be physical address]
+ * buf_size		: Buffer size
+ */
+int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
+			  dma_addr_t buf_start_addr, u32 buf_size)
+{
+	u32 io_base;
+	u8 enable_tx = 0;
+	int e_count = 0;
+	int f_count = 0;
+
+	/* Check if mcbsp interface is valid and is reserved */
+	if (omap2_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
+
+	mcbsp[id].tx_cb_arg = cbdata;
+
+	/* Auto RRST handling logic - disable the Reciever before 1st dma */
+	if ((mcbsp[id].auto_reset & OMAP_MCBSP_AUTO_XRST) &&
+			(omap_dma_chain_status(mcbsp[id].dma_tx_lch)
+				== OMAP_DMA_CHAIN_INACTIVE)) {
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base,
+				OMAP_MCBSP_REG_SPCR2) & (~XRST));
+		enable_tx = 1;
+	}
+
+	/*
+	 * for skip_first and second, we need to set e_count =2, and
+	 * f_count = number of frames = number of elements/e_count
+	 */
+	e_count = (buf_size / mcbsp[id].tx_word_length);
+	if (mcbsp[id].txskip_alt != OMAP_MCBSP_SKIP_NONE) {
+		/*
+		 * number of frames = total number of elements/element count,
+		 * However, with double indexing for data transfers, double I
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
+	if (omap_dma_chain_a_transfer(mcbsp[id].dma_tx_lch,
+		buf_start_addr,	mcbsp[id].phy_base + OMAP_MCBSP_REG_DXR,
+		e_count, f_count, &mcbsp[id]) < 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+	}
+
+	if (mcbsp[id].tx_dma_chain_state == 0) {
+		if (mcbsp[id].interface_mode == OMAP_MCBSP_MASTER) {
+			omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
+			mcbsp[id].srg_enabled++ ;
+		}
+		if (omap_start_dma_chain_transfers(mcbsp[id].dma_tx_lch) < 0) {
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+		mcbsp[id].tx_dma_chain_state = 1;
+	}
+
+	/* Auto XRST handling logic - Enable the Reciever after 1st dma */
+	if (enable_tx &&
+		(omap_dma_chain_status(mcbsp[id].dma_tx_lch)
+		== OMAP_DMA_CHAIN_ACTIVE))
+		omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SPCR2,
+			omap_mcbsp_read(io_base, OMAP_MCBSP_REG_SPCR2) | XRST);
+
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_send_data);
 
 #ifdef CONFIG_ARCH_OMAP24XX
 static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
 	{
 		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
+		.phy_base	= OMAP24XX_MCBSP1_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
@@ -168,6 +842,7 @@
 	},
 	{
 		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
+		.phy_base	= OMAP24XX_MCBSP2_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -186,6 +861,7 @@
 static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	{
 		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
+		.phy_base	= OMAP34XX_MCBSP1_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
@@ -195,6 +871,7 @@
 	},
 	{
 		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
+		.phy_base	= OMAP34XX_MCBSP2_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -204,6 +881,7 @@
 	},
 	{
 		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.phy_base	= OMAP34XX_MCBSP3_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.ops		= &omap2_mcbsp_ops,
@@ -211,6 +889,7 @@
 	},
 	{
 		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP4_BASE),
+		.phy_base	= OMAP34XX_MCBSP4_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
 		.ops		= &omap2_mcbsp_ops,
@@ -218,6 +897,7 @@
 	},
 	{
 		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP5_BASE),
+		.phy_base	= OMAP34XX_MCBSP5_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
 		.ops		= &omap2_mcbsp_ops,
Index: linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2008-06-16 16:05:01.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2008-06-16 16:05:49.241714590 +0530
@@ -166,6 +166,10 @@
 	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_MCR2, config->mcr2);
 	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_MCR1, config->mcr1);
 	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_PCR0, config->pcr0);
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		if (mcbsp[id].pdata->ops->config)
+			mcbsp[id].pdata->ops->config(id, config);
+	}
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
@@ -859,6 +863,7 @@
 	mcbsp[id].dma_rx_lch = -1;
 
 	mcbsp[id].io_base = pdata->virt_base;
+	mcbsp[id].phy_base = pdata->phy_base;
 	/* Default I/O is IRQ based */
 	mcbsp[id].io_type = OMAP_MCBSP_IRQ_IO;
 	mcbsp[id].tx_irq = pdata->tx_irq;
Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-06-16 16:05:01.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-06-16 16:05:49.241714590 +0530
@@ -254,31 +254,56 @@
 
 /********************** MACRO DEFINITIONS *********************************/
 
+/* McBSP interface operating mode */
+#define OMAP_MCBSP_MASTER			1
+#define OMAP_MCBSP_SLAVE			0
+
+#define OMAP_MCBSP_AUTO_RST_NONE		(0x0)
+#define OMAP_MCBSP_AUTO_RRST			(0x1<<1)
+#define OMAP_MCBSP_AUTO_XRST			(0x1<<2)
+
+/* SRG ENABLE/DISABLE state */
+#define OMAP_MCBSP_ENABLE_FSG_SRG		1
+#define OMAP_MCBSP_DISABLE_FSG_SRG		2
+/* mono to mono mode*/
+#define OMAP_MCBSP_SKIP_NONE			(0x0)
+/* mono to stereo mode */
+#define OMAP_MCBSP_SKIP_FIRST			(0x1<<1)
+#define OMAP_MCBSP_SKIP_SECOND			(0x1<<2)
+/* RRST STATE */
+#define OMAP_MCBSP_RRST_DISABLE			0
+#define OMAP_MCBSP_RRST_ENABLE			1
+/*XRST STATE */
+#define OMAP_MCBSP_XRST_DISABLE			0
+#define OMAP_MCBSP_XRST_ENABLE			1
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
 };
 
 typedef enum {
@@ -292,6 +317,7 @@
 typedef int __bitwise omap_mcbsp_io_type_t;
 #define OMAP_MCBSP_IRQ_IO ((__force omap_mcbsp_io_type_t) 1)
 #define OMAP_MCBSP_POLL_IO ((__force omap_mcbsp_io_type_t) 2)
+typedef void (*omap_mcbsp_dma_cb) (u32 ch_status, void *arg);
 
 typedef enum {
 	OMAP_MCBSP_WORD_8 = 0,
@@ -334,15 +360,29 @@
 	omap_mcbsp_word_length		word_length;
 };
 
+struct omap_mcbsp_dma_transfer_params {
+	/* Skip the alternate element use fro stereo mode */
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
 /* Platform specific configuration */
 struct omap_mcbsp_ops {
 	void (*request)(unsigned int);
 	void (*free)(unsigned int);
 	int (*check)(unsigned int);
+	void (*config)(unsigned int,  const struct omap_mcbsp_reg_cfg *config);
 };
 
 struct omap_mcbsp_platform_data {
 	u32 virt_base;
+	u32 phy_base;
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
@@ -378,6 +418,18 @@
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
 	struct clk *clk;
+	u32 phy_base;
+	u8  auto_reset;	/* Auto Reset */
+	u8  txskip_alt;	/* Tx skip flags */
+	u8  rxskip_alt;	/* Rx skip flags */
+	void  *rx_cb_arg;
+	void  *tx_cb_arg;
+	omap_mcbsp_dma_cb  rx_callback;
+	omap_mcbsp_dma_cb  tx_callback;
+	int  rx_dma_chain_state;
+	int  tx_dma_chain_state;
+	int  interface_mode; /* Master / Slave */
+	int  srg_enabled;
 };
 extern struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
 
@@ -405,4 +457,23 @@
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 
+void omap_mcbsp_write(u32 io_base, u16 reg, u32 val);
+int omap_mcbsp_read(u32 io_base, u16 reg);
+
+int omap2_mcbsp_stop_datatx(unsigned int id);
+int omap2_mcbsp_stop_datarx(u32 id);
+int omap2_mcbsp_reset(unsigned int id);
+int omap2_mcbsp_transmitter_index(int id, int *ei, int *fi);
+int omap2_mcbsp_receiver_index(int id, int *ei, int *fi);
+int omap2_mcbsp_set_xrst(unsigned int id, u8 state);
+int omap2_mcbsp_set_rrst(unsigned int id, u8 state);
+int omap2_mcbsp_dma_recv_params(unsigned int id,
+			struct	omap_mcbsp_dma_transfer_params *rp);
+int omap2_mcbsp_dma_trans_params(unsigned int id,
+			struct	omap_mcbsp_dma_transfer_params *tp);
+int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
+				dma_addr_t buf_start_addr, u32 buf_size);
+int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
+				dma_addr_t buf_start_addr, u32 buf_size);
+
 #endif

