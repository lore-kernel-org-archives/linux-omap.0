From: "Chandra shekhar" <x0044955@ti.com>
Subject: [RFC/PATCH  1/1] McBSP support for 2430/34XX
Date: Thu, 24 Apr 2008 20:29:38 +0530
Message-ID: <012601c8a61b$d1c38a40$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60288 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915AbYDXO7t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2008 10:59:49 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m3OExeED014276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 09:59:47 -0500
Received: from a0875540 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m3OExcPu022012
	for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 20:29:39 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi,

Here is a patch that adds support for McBSP on 2430/34XX (without disturbing the current mcbsp equilibrium).
Omap2420 specific code has been left in mcbsp.c because of difference in register set.( 16 bit registers in 2420)
It has been verified in digital loopback mode. ( Compilation tested for 2420 )
Since 2430 onwards registers are 32 bit, all the instances of omap24xx which were relevant to 
only 2420 has been changed to omap2420.  

The patch includes the following features.


1. Supporting all the LP features.
2. Support of DMA chaining mode and one time configuration for entire transfer to improve performance.
3. Independent configurations and transfer of Rx and Tx
4. MCBSP data transfer in 8, 16 and 32 bit mode.
5. instead of mcbsp client configuring all the register, it allows clients to  configure parameters like clk polarity, clk src and
other parameters.

Regards
Chandra Shekhar

Signed-off-by: chandra shekhar <x0044955@ti.com>

---
 arch/arm/configs/omap_3430sdp_defconfig |    1 
 arch/arm/mach-omap2/Makefile            |    4 
 arch/arm/mach-omap2/omap2-mcbsp.c       | 1132 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/mcbsp.c              |  126 +--
 include/asm-arm/arch-omap/mcbsp.h       |  348 ++++++++-
 5 files changed, 1489 insertions(+), 122 deletions(-)

Index: 2.6_kernel/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- 2.6_kernel.orig/arch/arm/configs/omap_3430sdp_defconfig	2008-04-24 19:48:59.000000000 +0530
+++ 2.6_kernel/arch/arm/configs/omap_3430sdp_defconfig	2008-04-24 19:50:31.000000000 +0530
@@ -179,6 +179,7 @@
 # CONFIG_OMAP_MCBSP is not set
 # CONFIG_OMAP_MMU_FWK is not set
 # CONFIG_OMAP_MBOX_FWK is not set
+CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MPU_TIMER is not set
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
Index: 2.6_kernel/arch/arm/mach-omap2/Makefile
===================================================================
--- 2.6_kernel.orig/arch/arm/mach-omap2/Makefile	2008-04-24 19:49:07.000000000 +0530
+++ 2.6_kernel/arch/arm/mach-omap2/Makefile	2008-04-24 19:50:40.000000000 +0530
@@ -22,6 +22,10 @@
 mailbox_mach-objs		:= mailbox.o
 mmu_mach-objs			:= mmu.o
 
+ifeq ($(CONFIG_ARCH_OMAP2420),)
+obj-$(CONFIG_OMAP_MCBSP) += omap2-mcbsp.o
+endif
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
Index: 2.6_kernel/arch/arm/mach-omap2/omap2-mcbsp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6_kernel/arch/arm/mach-omap2/omap2-mcbsp.c	2008-04-24 19:50:20.000000000 +0530
@@ -0,0 +1,1132 @@
+/*
+ * arch/arm/mach-omap2/omap2-mcbsp.c
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Author: chandra shekhar <x0044955@ti.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/wait.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <linux/io.h>
+#include <linux/irq.h>
+
+#include <asm/arch/dma.h>
+#include <asm/arch/irqs.h>
+#include <asm/arch/mcbsp.h>
+
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
+/* No. of dma channels in a chain, setting 2 for each interface */
+static int omap_mcbsp_max_dmachs_rx[OMAP_MAX_MCBSP_COUNT] = {2, 2, 2, 2, 2};
+static int omap_mcbsp_max_dmachs_tx[OMAP_MAX_MCBSP_COUNT] = {2, 2, 2, 2, 2};
+
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
+			OMAP_MCBSP_WRITE(io_base, SPCR1,
+				OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
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
+			OMAP_MCBSP_WRITE(io_base, SPCR2,
+				OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
+
+	if (mcbsp_dma_tx->tx_callback != NULL)
+		mcbsp_dma_tx->tx_callback(ch_status, mcbsp_dma_tx->tx_cb_arg);
+}
+
+/*
+ * omap_mcbsp_config simply write a config to the
+ * appropriate McBSP.
+ * You either call this function or set the McBSP registers
+ * by yourself before calling omap_mcbsp_start().
+ */
+
+void omap2_mcbsp_config(unsigned int id,
+				const struct omap_mcbsp_reg_cfg *config)
+{
+	u32 io_base = mcbsp[id].io_base;
+
+	/* We write the given config */
+	OMAP_MCBSP_WRITE(io_base, SPCR2, config->spcr2);
+	OMAP_MCBSP_WRITE(io_base, SPCR1, config->spcr1);
+	OMAP_MCBSP_WRITE(io_base, RCR2, config->rcr2);
+	OMAP_MCBSP_WRITE(io_base, RCR1, config->rcr1);
+	OMAP_MCBSP_WRITE(io_base, XCR2, config->xcr2);
+	OMAP_MCBSP_WRITE(io_base, XCR1, config->xcr1);
+	OMAP_MCBSP_WRITE(io_base, SRGR2, config->srgr2);
+	OMAP_MCBSP_WRITE(io_base, SRGR1, config->srgr1);
+	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
+	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
+	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
+	OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
+	OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
+}
+
+static int omap2_mcbsp_check(unsigned int id)
+{
+	if ((id > OMAP_MAX_MCBSP_COUNT) && (id < 0)) {
+			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't \
+							exist\n", id + 1);
+			return -ENXIO;
+		}
+	return 0;
+}
+
+int omap2_mcbsp_request(unsigned int id)
+{
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
+
+	spin_lock(&mcbsp[id].lock);
+	if (!mcbsp[id].free) {
+		printk(KERN_ERR "OMAP-McBSP: McBSP%d is currently \
+							in use\n", id + 1);
+		spin_unlock(&mcbsp[id].lock);
+		return -1;
+	}
+
+	clk_enable(omap_mcbsp_clk[id].ick);
+	clk_enable(omap_mcbsp_clk[id].fck);
+	mcbsp[id].free = 0;
+	mcbsp[id].dma_rx_lch = -1;
+	mcbsp[id].dma_tx_lch = -1;
+	spin_unlock(&mcbsp[id].lock);
+
+	return 0;
+
+}
+
+void omap2_mcbsp_free(unsigned int id)
+{
+	if (omap2_mcbsp_check(id) < 0)
+		return;
+
+	spin_lock(&mcbsp[id].lock);
+
+	if (mcbsp[id].free) {
+		printk(KERN_ERR "OMAP-McBSP: McBSP%d was not \
+						reserved\n", id + 1);
+		spin_unlock(&mcbsp[id].lock);
+		return;
+	}
+
+	clk_disable(omap_mcbsp_clk[id].ick);
+	clk_disable(omap_mcbsp_clk[id].fck);
+
+	if (mcbsp[id].dma_rx_lch != -1) {
+		omap_free_dma_chain(mcbsp[id].dma_rx_lch);
+		 mcbsp[id].dma_rx_lch = -1;
+	}
+
+	if (mcbsp[id].dma_tx_lch != -1) {
+		omap_free_dma_chain(mcbsp[id].dma_tx_lch);
+		mcbsp[id].dma_tx_lch = -1;
+	}
+
+	mcbsp[id].free = 1;
+	spin_unlock(&mcbsp[id].lock);
+
+}
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
+	return;
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
+	mcbsp_cfg->xccr = OMAP_MCBSP_READ(io_base, XCCR);
+	if (param->dlb)
+		mcbsp_cfg->xccr = mcbsp_cfg->xccr | (DLB);
+
+	mcbsp_cfg->rccr = OMAP_MCBSP_READ(io_base, RCCR);
+
+	return;
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
+int omap2_mcbsp_params_cfg(unsigned int id, int interface_mode,
+				struct omap_mcbsp_cfg_param *rp,
+				struct omap_mcbsp_cfg_param *tp,
+				struct omap_mcbsp_srg_fsg_cfg *param)
+ {
+	struct omap_mcbsp_reg_cfg mcbsp_cfg = {0};
+
+	spin_lock(&mcbsp[id].lock);
+
+	if (rp)
+		omap2_mcbsp_set_recv_param(id, &mcbsp_cfg, rp);
+
+	if (tp)
+		omap2_mcbsp_set_trans_param(id, &mcbsp_cfg, tp);
+
+	if (param)
+		omap2_mcbsp_set_srg_cfg_param(id,
+					interface_mode, &mcbsp_cfg, param);
+
+	omap2_mcbsp_config(id, &mcbsp_cfg);
+	spin_unlock(&mcbsp[id].lock);
+	return (0);
+
+ }
+
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
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
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
+	OMAP_MCBSP_WRITE(io_base, SPCR2,
+		OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
+
+	if (!(--mcbsp[id].srg_enabled))
+		omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
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
+	OMAP_MCBSP_WRITE(io_base, SPCR1,
+		OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
+	mcbsp[id].rx_dma_chain_state = 0;
+	if (!(--mcbsp[id].srg_enabled))
+		omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
+	spin_unlock(&mcbsp[id].lock);
+	return 0;
+}
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
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
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
+int omap2_mcbsp_set_rrst(unsigned int id, u8 state)
+{
+	u32 io_base;
+	if (omap2_mcbsp_check(id) < 0)
+		return -ENXIO;
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
+ * rp		: DMA Receive parameters
+ */
+int omap2_mcbsp_dma_recv_params(unsigned int id,
+				omap_mcbsp_dma_transfer_params *rp)
+{
+	u32 io_base;
+	int err, chain_id = -1;
+	struct omap_dma_channel_params rx_params;
+	u32  dt = 0;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -EINVAL;
+	spin_lock(&mcbsp[id].lock);
+	io_base = mcbsp[id].io_base;
+
+	dt = rp->word_length1;
+	if ((dt != OMAP_MCBSP_WORD_8) && (dt != OMAP_MCBSP_WORD_16) &&
+						(dt != OMAP_MCBSP_WORD_32))
+		return -EINVAL;
+	if (dt == OMAP_MCBSP_WORD_8)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S8;
+	else if (dt == OMAP_MCBSP_WORD_16)
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S16;
+	else
+		rx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
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
+
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
+
+	/* request for a chain of dma channels for data reception */
+	if (mcbsp[id].dma_rx_lch == -1) {
+		err = omap_request_dma_chain(id, "McBSP RX",
+					 omap2_mcbsp_rx_dma_callback, &chain_id,
+					 omap_mcbsp_max_dmachs_rx[id],
+					 OMAP_DMA_DYNAMIC_CHAIN, rx_params);
+		if (err < 0) {
+			printk(KERN_ERR "Receive path configuration failed \n");
+			spin_unlock(&mcbsp[id].lock);
+			return -EPERM;
+		}
+		mcbsp[id].dma_rx_lch = chain_id;
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
+ * tp		: DMA Transfer parameters
+ */
+
+int omap2_mcbsp_dma_trans_params(unsigned int id,
+				 omap_mcbsp_dma_transfer_params *tp)
+{
+
+	struct omap_dma_channel_params tx_params;
+	int err = 0, chain_id = -1;
+	u32 io_base;
+	u32 dt = 0;
+
+	if (omap2_mcbsp_check(id) < 0)
+		return -EINVAL;
+
+	spin_lock(&mcbsp[id].lock);
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
+	else
+		tx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
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
+	mcbsp[id].tx_word_length = tx_params.data_type << 0x1;
+	if (tx_params.data_type == 0)
+		mcbsp[id].tx_word_length = 1;
+	dt = mcbsp[id].tx_word_length;
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
+
+	mcbsp[id].txskip_alt = tp->skip_alt;
+	mcbsp[id].auto_reset &= ~OMAP_MCBSP_AUTO_XRST;
+	mcbsp[id].auto_reset |=
+		(tp->auto_reset & OMAP_MCBSP_AUTO_XRST);
+
+	mcbsp[id].tx_callback = tp->callback;
+
+	/* Based on Rjust we can do double indexing DMA params configuration */
+
+	if (mcbsp[id].dma_tx_lch == -1) {
+		err = omap_request_dma_chain(id, "McBSP TX",
+					 omap2_mcbsp_tx_dma_callback, &chain_id,
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
+int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
+			     dma_addr_t buf_start_addr, u32 buf_size)
+{
+	u32 dma_chain_status = 0;
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
+			OMAP_MCBSP_WRITE(io_base, SPCR1,
+				OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
+			enable_rx = 1;
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
+	dma_chain_status = omap_dma_chain_a_transfer(mcbsp[id]. dma_rx_lch,
+				(mcbsp[id].phy_base + OMAP_MCBSP_REG_DRR),
+				 buf_start_addr, e_count, f_count, &mcbsp[id]);
+
+	if (mcbsp[id].rx_dma_chain_state == 0) {
+		if (mcbsp[id].interface_mode == OMAP_MCBSP_MASTER) {
+			omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
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
+int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
+			  dma_addr_t buf_start_addr, u32 buf_size)
+{
+	u32 io_base;
+	u32 dma_chain_state = 0;
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
+			OMAP_MCBSP_WRITE(io_base, SPCR2,
+				OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
+			enable_tx = 1;
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
+	dma_chain_state = omap_dma_chain_a_transfer(mcbsp[id].dma_tx_lch,
+					buf_start_addr,
+					mcbsp[id].phy_base + OMAP_MCBSP_REG_DXR,
+					e_count, f_count, &mcbsp[id]);
+
+	if (mcbsp[id].tx_dma_chain_state == 0) {
+		if (mcbsp[id].interface_mode == OMAP_MCBSP_MASTER) {
+			omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
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
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
+		},
+	[3] = {
+		.virt_base	= IO_ADDRESS(OMAP2430_MCBSP4_BASE),
+		.phy_base	= OMAP2430_MCBSP4_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
+		},
+	[4] = {
+		.virt_base	= IO_ADDRESS(OMAP2430_MCBSP5_BASE),
+		.phy_base	= OMAP2430_MCBSP5_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
+		},
+};
+
+#define MCBSP_2430_SZ	ARRAY_SIZE(mcbsp_2430)
+#else
+
+#define mcbsp_2430	NULL
+#define MCBSP_2430_SZ	0
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
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
+		},
+	[3] = {
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.phy_base	= OMAP34XX_MCBSP4_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
+		},
+	[4] = {
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.phy_base       = OMAP34XX_MCBSP5_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
+		},
+};
+
+#define MCBSP_34XX_SZ	ARRAY_SIZE(mcbsp_34xx)
+#else
+#define mcbsp_34xx	NULL
+#define MCBSP_34XX_SZ	0
+#endif
+
+static int __init omap2_mcbsp_init(void)
+{
+	int mcbsp_count = 0, i;
+	static const struct omap_mcbsp_info *mcbsp_info;
+
+	for (i = 0; i < OMAP_MAX_MCBSP_COUNT; i++) {
+
+		omap_mcbsp_clk[i].ick = clk_get(0, omap_mcbsp_ick[i]);
+		if (IS_ERR(omap_mcbsp_clk[i].ick)) {
+			printk(KERN_ERR "mcbsp[%d] could not \
+						acquire ick handle\n", i+1);
+			return PTR_ERR(omap_mcbsp_ick[i]);
+		}
+
+		omap_mcbsp_clk[i].fck = clk_get(0, omap_mcbsp_fck[i]);
+		if (IS_ERR(omap_mcbsp_clk[i].fck)) {
+			printk(KERN_ERR "mcbsp[%d] could not \
+						acquire fck handle\n", i+1);
+			return PTR_ERR(omap_mcbsp_fck[i]);
+		}
+	}
+
+	if (cpu_is_omap2430()) {
+		mcbsp_info = mcbsp_2430;
+		mcbsp_count = MCBSP_2430_SZ;
+	}
+	if (cpu_is_omap34xx()) {
+		mcbsp_info = mcbsp_34xx;
+		mcbsp_count = MCBSP_34XX_SZ;
+	}
+
+	if (mcbsp_count) {
+		for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
+			mcbsp[i].phy_base = mcbsp_info[i].phy_base;
+			mcbsp[i].srg_enabled = 0;
+		}
+	omap_mcbsp_initialize(mcbsp_count, mcbsp_info);
+	}
+
+	return 0;
+}
+
+arch_initcall(omap2_mcbsp_init);
+
+EXPORT_SYMBOL(omap2_mcbsp_config);
+EXPORT_SYMBOL(omap2_mcbsp_request);
+EXPORT_SYMBOL(omap2_mcbsp_free);
+EXPORT_SYMBOL(omap2_mcbsp_params_cfg);
+EXPORT_SYMBOL(omap2_mcbsp_stop_datatx);
+EXPORT_SYMBOL(omap2_mcbsp_stop_datarx);
+EXPORT_SYMBOL(omap2_mcbsp_reset);
+EXPORT_SYMBOL(omap2_mcbsp_transmitter_index);
+EXPORT_SYMBOL(omap2_mcbsp_receiver_index);
+EXPORT_SYMBOL(omap2_mcbsp_set_xrst);
+EXPORT_SYMBOL(omap2_mcbsp_set_rrst);
+EXPORT_SYMBOL(omap2_mcbsp_receive_data);
+EXPORT_SYMBOL(omap2_mcbsp_send_data);
+EXPORT_SYMBOL(omap2_mcbsp_dma_trans_params);
+EXPORT_SYMBOL(omap2_mcbsp_dma_recv_params);
Index: 2.6_kernel/arch/arm/plat-omap/mcbsp.c
===================================================================
--- 2.6_kernel.orig/arch/arm/plat-omap/mcbsp.c	2008-04-24 20:05:57.000000000 +0530
+++ 2.6_kernel/arch/arm/plat-omap/mcbsp.c	2008-04-24 20:07:30.000000000 +0530
@@ -37,40 +37,14 @@
 #define DBG(x...)			do { } while (0)
 #endif
 
-struct omap_mcbsp {
-	u32                          io_base;
-	u8                           id;
-	u8                           free;
-	omap_mcbsp_word_length       rx_word_length;
-	omap_mcbsp_word_length       tx_word_length;
-
-	omap_mcbsp_io_type_t         io_type; /* IRQ or poll */
-	/* IRQ based TX/RX */
-	int                          rx_irq;
-	int                          tx_irq;
-
-	/* DMA stuff */
-	u8                           dma_rx_sync;
-	short                        dma_rx_lch;
-	u8                           dma_tx_sync;
-	short                        dma_tx_lch;
-
-	/* Completion queues */
-	struct completion            tx_irq_completion;
-	struct completion            rx_irq_completion;
-	struct completion            tx_dma_completion;
-	struct completion            rx_dma_completion;
+struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
 
-	spinlock_t                   lock;
-};
-
-static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
 #ifdef CONFIG_ARCH_OMAP1
 static struct clk *mcbsp_dsp_ck = 0;
 static struct clk *mcbsp_api_ck = 0;
 static struct clk *mcbsp_dspxor_ck = 0;
 #endif
-#ifdef CONFIG_ARCH_OMAP2
+#ifdef CONFIG_ARCH_OMAP2420
 static struct clk *mcbsp1_ick = 0;
 static struct clk *mcbsp1_fck = 0;
 static struct clk *mcbsp2_ick = 0;
@@ -118,6 +92,7 @@
 	return IRQ_HANDLED;
 }
 
+#if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP34XX)
 static void omap_mcbsp_tx_dma_callback(int lch, u16 ch_status, void *data)
 {
 	struct omap_mcbsp *mcbsp_dma_tx = data;
@@ -145,6 +120,7 @@
 
 	complete(&mcbsp_dma_rx->rx_dma_completion);
 }
+#endif
 
 
 /*
@@ -235,7 +211,7 @@
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
+#ifdef CONFIG_ARCH_OMAP2420
 static void omap2_mcbsp2_mux_setup(void)
 {
 	if (cpu_is_omap2420()) {
@@ -291,8 +267,8 @@
 		omap_mcbsp_dsp_request();
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
-	if (cpu_is_omap24xx()) {
+#ifdef CONFIG_ARCH_OMAP2420
+	if (cpu_is_omap2420()) {
 		if (id == OMAP_MCBSP1) {
 			clk_enable(mcbsp1_ick);
 			clk_enable(mcbsp1_fck);
@@ -356,8 +332,8 @@
 	}
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
-	if (cpu_is_omap24xx()) {
+#ifdef CONFIG_ARCH_OMAP2420
+	if (cpu_is_omap2420()) {
 		if (id == OMAP_MCBSP1) {
 			clk_disable(mcbsp1_ick);
 			clk_disable(mcbsp1_fck);
@@ -448,6 +424,7 @@
 	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
 }
 
+#if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP34XX)
 
 /* polled mcbsp i/o operations */
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
@@ -777,7 +754,7 @@
 	wait_for_completion(&(mcbsp[id].rx_dma_completion));
 	return 0;
 }
-
+#endif
 
 /*
  * SPI wrapper.
@@ -847,17 +824,6 @@
 	omap_mcbsp_config(id, &mcbsp_cfg);
 }
 
-
-/*
- * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
- * 730 has only 2 McBSP, and both of them are MPU peripherals.
- */
-struct omap_mcbsp_info {
-	u32 virt_base;
-	u8 dma_rx_sync, dma_tx_sync;
-	u16 rx_irq, tx_irq;
-};
-
 #ifdef CONFIG_ARCH_OMAP730
 static const struct omap_mcbsp_info mcbsp_730[] = {
 	[0] = { .virt_base = io_p2v(OMAP730_MCBSP1_BASE),
@@ -913,15 +879,15 @@
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
@@ -930,9 +896,38 @@
 };
 #endif
 
+void omap_mcbsp_initialize(int mcbsp_count,
+				const struct omap_mcbsp_info *mcbsp_info)
+
+{
+	int i;
+
+	for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
+		if (i >= mcbsp_count) {
+			mcbsp[i].io_base = 0;
+			mcbsp[i].free = 0;
+			continue;
+		}
+		mcbsp[i].id = i + 1;
+		mcbsp[i].free = 1;
+		mcbsp[i].dma_tx_lch = -1;
+		mcbsp[i].dma_rx_lch = -1;
+
+		mcbsp[i].io_base = mcbsp_info[i].virt_base;
+		 /* Default I/O is IRQ based */
+		mcbsp[i].io_type = OMAP_MCBSP_IRQ_IO;
+		mcbsp[i].tx_irq = mcbsp_info[i].tx_irq;
+		mcbsp[i].rx_irq = mcbsp_info[i].rx_irq;
+		mcbsp[i].dma_rx_sync = mcbsp_info[i].dma_rx_sync;
+		mcbsp[i].dma_tx_sync = mcbsp_info[i].dma_tx_sync;
+		spin_lock_init(&mcbsp[i].lock);
+	}
+	return;
+}
+
 static int __init omap_mcbsp_init(void)
 {
-	int mcbsp_count = 0, i;
+	int mcbsp_count = 0;
 	static const struct omap_mcbsp_info *mcbsp_info;
 
 	printk("Initializing OMAP McBSP system\n");
@@ -954,7 +949,7 @@
 		return PTR_ERR(mcbsp_dspxor_ck);
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP2
+#ifdef CONFIG_ARCH_OMAP2420
 	mcbsp1_ick = clk_get(0, "mcbsp1_ick");
 	if (IS_ERR(mcbsp1_ick)) {
 		printk(KERN_ERR "mcbsp: could not acquire mcbsp1_ick handle.\n");
@@ -995,41 +990,23 @@
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
-	for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
-		if (i >= mcbsp_count) {
-			mcbsp[i].io_base = 0;
-			mcbsp[i].free = 0;
-                        continue;
-		}
-		mcbsp[i].id = i + 1;
-		mcbsp[i].free = 1;
-		mcbsp[i].dma_tx_lch = -1;
-		mcbsp[i].dma_rx_lch = -1;
-
-		mcbsp[i].io_base = mcbsp_info[i].virt_base;
-		mcbsp[i].io_type = OMAP_MCBSP_IRQ_IO; /* Default I/O is IRQ based */
-		mcbsp[i].tx_irq = mcbsp_info[i].tx_irq;
-		mcbsp[i].rx_irq = mcbsp_info[i].rx_irq;
-		mcbsp[i].dma_rx_sync = mcbsp_info[i].dma_rx_sync;
-		mcbsp[i].dma_tx_sync = mcbsp_info[i].dma_tx_sync;
-		spin_lock_init(&mcbsp[i].lock);
-	}
+	if (mcbsp_count)
+		omap_mcbsp_initialize(mcbsp_count, mcbsp_info);
 
 	return 0;
 }
-
 arch_initcall(omap_mcbsp_init);
-
+EXPORT_SYMBOL(omap_mcbsp_set_io_type);
+#if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP34XX)
 EXPORT_SYMBOL(omap_mcbsp_config);
 EXPORT_SYMBOL(omap_mcbsp_request);
-EXPORT_SYMBOL(omap_mcbsp_set_io_type);
 EXPORT_SYMBOL(omap_mcbsp_free);
 EXPORT_SYMBOL(omap_mcbsp_start);
 EXPORT_SYMBOL(omap_mcbsp_stop);
@@ -1042,3 +1019,4 @@
 EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
 EXPORT_SYMBOL(omap_mcbsp_spi_master_recv_word_poll);
 EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
+#endif
Index: 2.6_kernel/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- 2.6_kernel.orig/include/asm-arm/arch-omap/mcbsp.h	2008-04-24 19:48:41.000000000 +0530
+++ 2.6_kernel/include/asm-arm/arch-omap/mcbsp.h	2008-04-24 19:50:09.000000000 +0530
@@ -26,26 +26,38 @@
 
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
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
 
-#define OMAP_MCBSP_REG_DRR2	0x00
-#define OMAP_MCBSP_REG_DRR1	0x02
-#define OMAP_MCBSP_REG_DXR2	0x04
-#define OMAP_MCBSP_REG_DXR1	0x06
+#define OMAP_MCBSP_REG_DRR2     0x00
+#define OMAP_MCBSP_REG_DRR1     0x02
+#define OMAP_MCBSP_REG_DXR2     0x04
+#define OMAP_MCBSP_REG_DXR1     0x06
 #define OMAP_MCBSP_REG_SPCR2	0x08
 #define OMAP_MCBSP_REG_SPCR1	0x0a
 #define OMAP_MCBSP_REG_RCR2	0x0c
@@ -85,10 +97,6 @@
 
 #elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
-#define OMAP_MCBSP_REG_DRR2	0x00
-#define OMAP_MCBSP_REG_DRR1	0x04
-#define OMAP_MCBSP_REG_DXR2	0x08
-#define OMAP_MCBSP_REG_DXR1	0x0C
 #define OMAP_MCBSP_REG_SPCR2	0x10
 #define OMAP_MCBSP_REG_SPCR1	0x14
 #define OMAP_MCBSP_REG_RCR2	0x18
@@ -117,20 +125,51 @@
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
 
-#define OMAP_MAX_MCBSP_COUNT 2
+#if defined(CONFIG_ARCH_OMAP2420)
+#define OMAP_MCBSP_REG_DRR2	0x00
+#define OMAP_MCBSP_REG_DRR1	0x04
+#define OMAP_MCBSP_REG_DXR2	0x08
+#define OMAP_MCBSP_REG_DXR1	0x0C
 
-#define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
-#define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
+#define OMAP_MAX_MCBSP_COUNT	2
 
+#define AUDIO_MCBSP_DATAWRITE	(OMAP2420_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
+#define AUDIO_MCBSP_DATAREAD	(OMAP2420_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
 #define AUDIO_MCBSP		OMAP_MCBSP2
 #define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
 #define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
 
+#elif defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP2430)
+
+#define OMAP_MCBSP_REG_DRR		0x00
+#define OMAP_MCBSP_REG_DXR		0x08
+#define OMAP_MCBSP_REG_SYSCONFIG        0x8C
+#define OMAP_MCBSP_REG_XCCR		0xAC
+#define OMAP_MCBSP_REG_RCCR		0xB0
+
+#define AUDIO_MCBSP             	OMAP_MCBSP2
+
+#define OMAP_MAX_MCBSP_COUNT	5
+
+#endif
+
 #endif
 
-#define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) + OMAP_MCBSP_REG_##reg)
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
+#endif
 
+typedef void (*omap_mcbsp_dma_cb) (u32 ch_status, void *arg);
+
+#define OMAP_MCBSP_BIT(ARG)		((0x01)<<(ARG))
 
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
@@ -142,7 +181,11 @@
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
@@ -219,38 +262,133 @@
 #define XPABLK(value)		((value)<<5)	/* Bits 5:6 */
 #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
 
+# if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+
+/*********************** McBSP XCCR bit definitions *************************/
+#define DLB			OMAP_MCBSP_BIT(5)
+#define XDMAEN			OMAP_MCBSP_BIT(3)
+#define XDISABLE		OMAP_MCBSP_BIT(0)
+
+/********************** McBSP RCCR bit definitions *************************/
+#define RDMAEN			OMAP_MCBSP_BIT(3)
+#define RDISABLE		OMAP_MCBSP_BIT(0)
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
+#define OMAP_MCBSP_ENABLE_FSG_SRG		1
+#define OMAP_MCBSP_DISABLE_FSG_SRG		2
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
+#define OMAP_MCBSP_AUTO_RST_NONE		(0x0)
+#define OMAP_MCBSP_AUTO_RRST			(0x1<<1)
+#define OMAP_MCBSP_AUTO_XRST			(0x1<<2)
+
+/* Reverse mode for 243X and 34XX */
+#define OMAP_MCBSP_MSBFIRST			0
+#define OMAP_MCBSP_LSBFIRST			1
+
+#define OMAP_MCBSP_FRAMELEN_N(NUM_WORDS) 	((NUM_WORDS - 1) & 0x7F)
 
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
 	OMAP_MCBSP1 = 0,
 	OMAP_MCBSP2,
 	OMAP_MCBSP3,
+	OMAP_MCBSP4,
+	OMAP_MCBSP5,
 } omap_mcbsp_id;
 
 typedef int __bitwise omap_mcbsp_io_type_t;
@@ -298,6 +436,90 @@
 	omap_mcbsp_word_length		word_length;
 };
 
+typedef struct omap_mcbsp_dma_transfer_parameters {
+	/* Skip the alternate element */
+	u8 skip_alt;
+	/* Automagically handle Transfer [XR]RST? */
+	u8   auto_reset;
+	/* callback function executed for every tx/rx completion */
+	omap_mcbsp_dma_cb callback;
+	/* word length of data */
+	u32 word_length1;
+
+} omap_mcbsp_dma_transfer_params;
+
+struct omap_mcbsp_cfg_param {
+	u8 fsync_src;
+	u8 fs_polarity;
+	u8 clk_polarity;
+	u8 clk_mode;
+	u8 frame_length1;
+	u8 word_length1;
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
+struct omap_mcbsp_info {
+	u32 virt_base;
+	u32 phy_base;
+	u8 dma_rx_sync, dma_tx_sync;
+	u16 rx_irq, tx_irq;
+};
+
+struct omap_mcbsp {
+	u32				io_base;
+	u8				id;
+	u8				free;
+	omap_mcbsp_word_length		rx_word_length;
+	omap_mcbsp_word_length		tx_word_length;
+
+	omap_mcbsp_io_type_t		io_type; /* IRQ or poll */
+	/* IRQ based TX/RX */
+	int				rx_irq;
+	int				tx_irq;
+
+	/* DMA stuff */
+	u8				dma_rx_sync;
+	short				dma_rx_lch;
+	u8				dma_tx_sync;
+	short				dma_tx_lch;
+
+	/* Completion queues */
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
+	void				*rx_cb_arg;
+	void				*tx_cb_arg;
+	omap_mcbsp_dma_cb		rx_callback;
+	omap_mcbsp_dma_cb		tx_callback;
+	int				rx_dma_chain_state;
+	int				tx_dma_chain_state;
+	int				interface_mode;
+	int				srg_enabled;
+};
+extern struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
@@ -319,5 +541,35 @@
 int omap_mcbsp_pollread(unsigned int id, u16 * buf);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
+extern void omap_mcbsp_initialize(int mcbsp_count,
+				 const struct omap_mcbsp_info *mcbsp_info);
 
+# if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+void omap2_mcbsp_config(unsigned int id,
+			const struct omap_mcbsp_reg_cfg *config);
+int omap2_mcbsp_request(unsigned int id);
+void omap2_mcbsp_free(unsigned int id);
+int omap2_mcbsp_params_cfg(unsigned int id, int interface_mode,
+				struct omap_mcbsp_cfg_param *rp,
+				struct omap_mcbsp_cfg_param  *tp,
+				struct  omap_mcbsp_srg_fsg_cfg *param);
+
+int omap2_mcbsp_set_srg_fsg(unsigned int id, u8 state);
+int omap2_mcbsp_stop_datatx(unsigned int id);
+int omap2_mcbsp_stop_datarx(u32 id);
+int omap2_mcbsp_reset(unsigned int id);
+int omap2_mcbsp_transmitter_index(int id, int *ei, int *fi);
+int omap2_mcbsp_receiver_index(int id, int *ei, int *fi);
+int omap2_mcbsp_set_xrst(unsigned int id, u8 state);
+int omap2_mcbsp_set_rrst(unsigned int id, u8 state);
+int omap2_mcbsp_dma_recv_params(unsigned int id,
+					omap_mcbsp_dma_transfer_params *rp);
+int omap2_mcbsp_dma_trans_params(unsigned int id,
+					 omap_mcbsp_dma_transfer_params *tp);
+int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
+				dma_addr_t buf_start_addr, u32 buf_size);
+int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
+			  dma_addr_t buf_start_addr, u32 buf_size);
+
+#endif
 #endif

