From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Camera: Add driver.
Date: Thu, 22 Mar 2007 19:07:02 +0200
Message-ID: <11745832251620-git-send-email-sakari.ailus@nokia.com>
References: <4602B745.7000006@nokia.com>
	<11745832253226-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11745832253226-git-send-email-sakari.ailus@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: eduardo.valentin@indt.org.br, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap/omap24xxcam-core.c   |  147 ++++
 drivers/media/video/omap/omap24xxcam-dma.c    |  613 ++++++++++++++
 drivers/media/video/omap/omap24xxcam-dma.h    |   42 +
 drivers/media/video/omap/omap24xxcam-sensor.c |  266 ++++++
 drivers/media/video/omap/omap24xxcam-vbq.c    |  399 +++++++++
 drivers/media/video/omap/omap24xxcam.c        | 1130 +++++++++++++++++++++++++
 drivers/media/video/omap/omap24xxcam.h        |  635 ++++++++++++++
 7 files changed, 3232 insertions(+), 0 deletions(-)
 create mode 100644 drivers/media/video/omap/omap24xxcam-core.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-dma.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-dma.h
 create mode 100644 drivers/media/video/omap/omap24xxcam-sensor.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-vbq.c
 create mode 100644 drivers/media/video/omap/omap24xxcam.c
 create mode 100644 drivers/media/video/omap/omap24xxcam.h

diff --git a/drivers/media/video/omap/omap24xxcam-core.c b/drivers/media/video/omap/omap24xxcam-core.c
new file mode 100644
index 0000000..e92622f
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-core.c
@@ -0,0 +1,147 @@
+/*
+ * omap24xxcam-core.c
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on code from Andy Lowe <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/io.h>
+
+#include "omap24xxcam.h"
+
+/*
+ * Set xclk.
+ *
+ * If the given value is not usable, the next possible lower value
+ * will be selected.
+ *
+ * To disable xclk, use value zero.
+ *
+ * The selected xclk value is returned.
+ */
+unsigned long omap24xxcam_core_xclk_set(const struct omap24xxcam_device *cam,
+					unsigned long xclk)
+{
+	unsigned long divisor;
+
+	if (xclk) {
+		if (xclk > CAM_MCLK)
+			xclk = CAM_MCLK;
+
+		divisor = CAM_MCLK / xclk;
+		if (xclk * divisor < CAM_MCLK)
+			divisor += 1;
+		if (divisor > 30)
+			divisor = 30;
+		xclk = CAM_MCLK / divisor;
+
+		if (divisor == 1)
+			omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET,
+					    CC_CTRL_XCLK,
+					    CC_CTRL_XCLK_DIV_BYPASS);
+		else
+			omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET,
+					    CC_CTRL_XCLK, divisor);
+	} else
+		omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET,
+				    CC_CTRL_XCLK, CC_CTRL_XCLK_DIV_STABLE_LOW);
+
+	return xclk;
+}
+
+void omap24xxcam_core_hwinit(const struct omap24xxcam_device *cam) {
+	/* Setting the camera core AUTOIDLE bit causes problems with frame 
+	 * synchronization, so we will clear the AUTOIDLE bit instead.
+	 */
+	//omap24xxcam_reg_out(cam, CC_SYSCONFIG, 0);
+	omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET, CC_SYSCONFIG,
+			    CC_SYSCONFIG_AUTOIDLE);
+
+	/* program the camera interface DMA packet size */
+	omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET, CC_CTRL_DMA,
+			    CC_CTRL_DMA_EN | (DMA_THRESHOLD / 4 - 1));
+
+	/* enable camera core error interrupts */
+	omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET, CC_IRQENABLE,
+			    CC_IRQENABLE_FW_ERR_IRQ
+			    | CC_IRQENABLE_FSC_ERR_IRQ
+			    | CC_IRQENABLE_SSC_ERR_IRQ
+			    | CC_IRQENABLE_FIFO_OF_IRQ);
+}
+
+/*
+ * Enable the camera core.
+ *
+ * Data transfer to the camera DMA starts from next starting frame.
+ */
+void omap24xxcam_core_enable(const struct omap24xxcam_device *cam)
+{
+	omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET, CC_CTRL,
+			    CC_CTRL_NOBT_SYNCHRO
+			    | CC_CTRL_PAR_MODE_NOBT8
+			    | CC_CTRL_CC_EN);
+}
+
+/*
+ * Disable camera core.
+ *
+ * The data transfer will be stopped immediately (CC_CTRL_CC_RST). The
+ * core internal state machines will be reset. Use
+ * CC_CTRL_CC_FRAME_TRIG instead if you want to transfer the current
+ * frame completely.
+ */
+void omap24xxcam_core_disable(const struct omap24xxcam_device *cam)
+{
+	omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET, CC_CTRL,
+			    CC_CTRL_CC_RST);
+}
+
+/* Interrupt service routine for camera core interrupts. */
+void omap24xxcam_core_isr(struct omap24xxcam_device *cam)
+{
+	unsigned long cc_irqstatus;
+	const unsigned long cc_irqstatus_err =
+		CC_IRQSTATUS_FW_ERR_IRQ
+		| CC_IRQSTATUS_FSC_ERR_IRQ
+		| CC_IRQSTATUS_SSC_ERR_IRQ
+		| CC_IRQSTATUS_FIFO_UF_IRQ
+		| CC_IRQSTATUS_FIFO_OF_IRQ;
+
+	cc_irqstatus = omap24xxcam_reg_in(cam->mmio_base + CC_REG_OFFSET,
+					  CC_IRQSTATUS);
+	omap24xxcam_reg_out(cam->mmio_base + CC_REG_OFFSET, CC_IRQSTATUS,
+			    cc_irqstatus);
+
+	if (cc_irqstatus & cc_irqstatus_err) {
+		printk(KERN_INFO
+		       "%s: scheduling camera reset, cc_irqstatus 0x%lx\n",
+		       __FUNCTION__, cc_irqstatus);
+		omap24xxcam_camera_reset_schedule(cam);
+	} else {
+		if (cc_irqstatus & 0xffff)
+			printk(KERN_INFO "%s: cc_irqstatus 0x%lx\n",
+			       __FUNCTION__, cc_irqstatus);
+	}
+
+}
diff --git a/drivers/media/video/omap/omap24xxcam-dma.c b/drivers/media/video/omap/omap24xxcam-dma.c
new file mode 100644
index 0000000..26716fd
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-dma.c
@@ -0,0 +1,613 @@
+/*
+ * omap24xxcam-dma.c
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on code from Andy Lowe <source@mvista.com> and
+ *                    David Cohen <david.cohen@indt.org.br>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/io.h>
+#include <asm/scatterlist.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+/*
+ *
+ * DMA hardware.
+ *
+ */
+
+/* Ack all interrupt on CSR and IRQSTATUS_L0 */
+static void omap24xxcam_dmahw_ack_all(unsigned long base)
+{
+	unsigned long csr;
+	int i;
+	
+	for (i = 0; i < NUM_CAMDMA_CHANNELS; ++i) {
+		csr = omap24xxcam_reg_in(base, CAMDMA_CSR(i));
+		/* ack interrupt in CSR */
+		omap24xxcam_reg_out(base, CAMDMA_CSR(i), csr);
+	}
+	omap24xxcam_reg_out(base, CAMDMA_IRQSTATUS_L0, 0xf);
+}
+
+/* Ack dmach on CSR and IRQSTATUS_L0 */
+static unsigned long omap24xxcam_dmahw_ack_ch(unsigned long base, int dmach)
+{
+	unsigned long csr;
+	
+	csr = omap24xxcam_reg_in(base, CAMDMA_CSR(dmach));
+	/* ack interrupt in CSR */
+	omap24xxcam_reg_out(base, CAMDMA_CSR(dmach), csr);
+	/* ack interrupt in IRQSTATUS */
+	omap24xxcam_reg_out(base, CAMDMA_IRQSTATUS_L0, (1 << dmach));
+
+	return csr;
+}
+
+static int omap24xxcam_dmahw_running(unsigned long base, int dmach)
+{
+	return omap24xxcam_reg_in(base, CAMDMA_CCR(dmach)) & CAMDMA_CCR_ENABLE;
+}
+
+static void omap24xxcam_dmahw_transfer_setup(unsigned long base, int dmach,
+					     dma_addr_t start,
+					     unsigned long len)
+{
+	omap24xxcam_reg_out(base, CAMDMA_CCR(dmach), 
+		       CAMDMA_CCR_SEL_SRC_DST_SYNC
+		       | CAMDMA_CCR_BS
+		       | CAMDMA_CCR_DST_AMODE_POST_INC
+		       | CAMDMA_CCR_SRC_AMODE_POST_INC
+		       | CAMDMA_CCR_FS
+		       | CAMDMA_CCR_WR_ACTIVE
+		       | CAMDMA_CCR_RD_ACTIVE
+		       | CAMDMA_CCR_SYNCHRO_CAMERA);
+	omap24xxcam_reg_out(base, CAMDMA_CLNK_CTRL(dmach), 0);
+	omap24xxcam_reg_out(base, CAMDMA_CEN(dmach), len);
+	omap24xxcam_reg_out(base, CAMDMA_CFN(dmach), 1);
+	omap24xxcam_reg_out(base, CAMDMA_CSDP(dmach), 
+		       CAMDMA_CSDP_WRITE_MODE_POSTED 
+		       | CAMDMA_CSDP_DST_BURST_EN_32
+		       | CAMDMA_CSDP_DST_PACKED
+		       | CAMDMA_CSDP_SRC_BURST_EN_32
+		       | CAMDMA_CSDP_SRC_PACKED
+		       | CAMDMA_CSDP_DATA_TYPE_8BITS);
+	omap24xxcam_reg_out(base, CAMDMA_CSSA(dmach), 0);
+	omap24xxcam_reg_out(base, CAMDMA_CDSA(dmach), start);
+	omap24xxcam_reg_out(base, CAMDMA_CSEI(dmach), 0);
+	omap24xxcam_reg_out(base, CAMDMA_CSFI(dmach), DMA_THRESHOLD);
+	omap24xxcam_reg_out(base, CAMDMA_CDEI(dmach), 0);
+	omap24xxcam_reg_out(base, CAMDMA_CDFI(dmach), 0);
+	omap24xxcam_reg_out(base, CAMDMA_CSR(dmach), 
+		       CAMDMA_CSR_MISALIGNED_ERR
+		       | CAMDMA_CSR_SECURE_ERR
+		       | CAMDMA_CSR_TRANS_ERR
+		       | CAMDMA_CSR_BLOCK
+		       | CAMDMA_CSR_DROP);
+	omap24xxcam_reg_out(base, CAMDMA_CICR(dmach), 
+		       CAMDMA_CICR_MISALIGNED_ERR_IE
+		       | CAMDMA_CICR_SECURE_ERR_IE
+		       | CAMDMA_CICR_TRANS_ERR_IE
+		       | CAMDMA_CICR_BLOCK_IE
+		       | CAMDMA_CICR_DROP_IE);
+}
+
+static void omap24xxcam_dmahw_transfer_start(unsigned long base, int dmach)
+{
+	omap24xxcam_reg_out(base, CAMDMA_CCR(dmach), 
+		       CAMDMA_CCR_SEL_SRC_DST_SYNC
+		       | CAMDMA_CCR_BS
+		       | CAMDMA_CCR_DST_AMODE_POST_INC
+		       | CAMDMA_CCR_SRC_AMODE_POST_INC
+		       | CAMDMA_CCR_ENABLE
+		       | CAMDMA_CCR_FS
+		       | CAMDMA_CCR_SYNCHRO_CAMERA);
+}
+
+static void omap24xxcam_dmahw_transfer_chain(unsigned long base, int dmach,
+					     int free_dmach)
+{
+	int prev_dmach, ch;
+
+	if (dmach == 0)
+		prev_dmach = NUM_CAMDMA_CHANNELS - 1;
+	else
+		prev_dmach = dmach - 1;
+	omap24xxcam_reg_out(base, CAMDMA_CLNK_CTRL(prev_dmach), 
+		       CAMDMA_CLNK_CTRL_ENABLE_LNK | dmach);
+	/* Did we chain the DMA transfer before the previous one 
+	 * finished?
+	 */
+	ch = (dmach + free_dmach) % NUM_CAMDMA_CHANNELS;
+	while (!(omap24xxcam_reg_in(base, CAMDMA_CCR(ch))
+		 & CAMDMA_CCR_ENABLE))
+	{
+		if (ch == dmach) {
+			/* The previous transfer has ended and this one 
+			 * hasn't started, so we must not have chained 
+			 * to the previous one in time.  We'll have to 
+			 * start it now.
+			 */
+			omap24xxcam_dmahw_transfer_start(base, dmach);
+			break;
+		} else
+			ch = (ch + 1) % NUM_CAMDMA_CHANNELS;
+	}
+}
+
+/* Abort all chained DMA transfers.  After all transfers have been aborted and 
+ * the DMA controller is idle, the completion routines for any aborted transfers
+ * will be called in sequence.  The DMA controller may not be idle after this 
+ * routine completes, because the completion routines might start new transfers.
+ */
+static void omap24xxcam_dmahw_abort_ch(unsigned long base, int dmach)
+{
+	/* mask all interrupts from this channel */
+	omap24xxcam_reg_out(base, CAMDMA_CICR(dmach), 0);
+	/* unlink this channel */
+	omap24xxcam_reg_merge(base, CAMDMA_CLNK_CTRL(dmach), 0,
+			CAMDMA_CLNK_CTRL_ENABLE_LNK);
+	/* disable this channel */
+	omap24xxcam_reg_merge(base, CAMDMA_CCR(dmach), 0, CAMDMA_CCR_ENABLE);
+}
+
+static void omap24xxcam_dmahw_init(unsigned long base)
+{
+	omap24xxcam_reg_out(base, CAMDMA_OCP_SYSCONFIG, 
+		CAMDMA_OCP_SYSCONFIG_MIDLEMODE_FSTANDBY
+	      | CAMDMA_OCP_SYSCONFIG_SIDLEMODE_FIDLE
+	      | CAMDMA_OCP_SYSCONFIG_AUTOIDLE);
+
+	omap24xxcam_reg_merge(base, CAMDMA_GCR, 0x10, 
+		CAMDMA_GCR_MAX_CHANNEL_FIFO_DEPTH);
+
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L0, 0xf);
+}
+
+/*
+ *
+ * Individual DMA channel handling.
+ *
+ */
+
+/* Start a DMA transfer from the camera to memory.
+ * Returns zero if the transfer was successfully started, or non-zero if all 
+ * DMA channels are already in use or starting is currently inhibited.
+ */
+static int omap24xxcam_dma_start(struct omap24xxcam_dma *dma, dma_addr_t start,
+				 unsigned long len, dma_callback_t callback,
+				 void *arg)
+{
+	unsigned long irqflags;
+	int dmach;
+
+	spin_lock_irqsave(&dma->lock, irqflags);
+
+	if (!dma->free_dmach || dma->dma_stop) {
+		spin_unlock_irqrestore(&dma->lock, irqflags);
+		return -EBUSY;
+	}
+
+	dmach = dma->next_dmach;
+
+	dma->ch_state[dmach].callback = callback;
+	dma->ch_state[dmach].arg = arg;
+
+	omap24xxcam_dmahw_transfer_setup(dma->base, dmach, start, len);
+
+	/* We're ready to start the DMA transfer. */
+
+	if (dma->free_dmach < NUM_CAMDMA_CHANNELS) {
+		/* A transfer is already in progress, so try to chain to it. */
+		omap24xxcam_dmahw_transfer_chain(dma->base, dmach, dma->free_dmach);
+	}
+	else {
+		/* No transfer is in progress, so we'll just start this one 
+		 * now.
+		 */
+		omap24xxcam_dmahw_transfer_start(dma->base, dmach);
+	}
+
+	dma->next_dmach = (dma->next_dmach + 1) % NUM_CAMDMA_CHANNELS;
+	dma->free_dmach--;
+
+	spin_unlock_irqrestore(&dma->lock, irqflags);
+
+	return 0;
+}
+
+/* Abort all chained DMA transfers.  After all transfers have been aborted and 
+ * the DMA controller is idle, the completion routines for any aborted transfers
+ * will be called in sequence.  The DMA controller may not be idle after this 
+ * routine completes, because the completion routines might start new transfers.
+ */
+static void omap24xxcam_dma_abort(struct omap24xxcam_dma *dma,
+				  unsigned long csr)
+{
+	unsigned long irqflags;
+	int dmach, i, free_dmach;
+	dma_callback_t callback;
+	void *arg;
+
+	spin_lock_irqsave(&dma->lock, irqflags);
+
+	/* stop any DMA transfers in progress */
+	dmach = (dma->next_dmach + dma->free_dmach) % NUM_CAMDMA_CHANNELS;
+	for (i = 0; i < NUM_CAMDMA_CHANNELS; i++) {
+		omap24xxcam_dmahw_abort_ch(dma->base, dmach);
+		dmach = (dmach + 1) % NUM_CAMDMA_CHANNELS;
+	}
+
+	/* We have to be careful here because the callback routine might start 
+	 * a new DMA transfer, and we only want to abort transfers that were 
+	 * started before this routine was called.
+	 */
+	free_dmach = dma->free_dmach;
+	while ((dma->free_dmach < NUM_CAMDMA_CHANNELS) &&
+	       (free_dmach < NUM_CAMDMA_CHANNELS)) {
+		dmach = (dma->next_dmach + dma->free_dmach)
+		    % NUM_CAMDMA_CHANNELS;
+		callback = dma->ch_state[dmach].callback;
+		arg = dma->ch_state[dmach].arg;
+		dma->free_dmach++;
+		free_dmach++;
+		if (callback) {
+			/* leave interrupts disabled during callback */
+			spin_unlock(&dma->lock);
+			(*callback) (dma, csr, arg);
+			spin_lock(&dma->lock);
+		}
+	}
+
+	spin_unlock_irqrestore(&dma->lock, irqflags);
+}
+
+/* Abort all chained DMA transfers.  After all transfers have been aborted and 
+ * the DMA controller is idle, the completion routines for any aborted transfers
+ * will be called in sequence.  If the completion routines attempt to start a 
+ * new DMA transfer it will fail, so the DMA controller will be idle after this 
+ * routine completes.
+ */
+static void omap24xxcam_dma_stop(struct omap24xxcam_dma *dma,
+				 unsigned long csr)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&dma->lock, irqflags);
+	dma->dma_stop++;
+	spin_unlock_irqrestore(&dma->lock, irqflags);
+	omap24xxcam_dma_abort(dma, csr);
+	spin_lock_irqsave(&dma->lock, irqflags);
+	dma->dma_stop--;
+	spin_unlock_irqrestore(&dma->lock, irqflags);
+}
+
+/* Camera DMA interrupt service routine. */
+void omap24xxcam_dma_isr(struct omap24xxcam_dma *dma)
+{
+	int dmach;
+	dma_callback_t callback;
+	void *arg;
+	unsigned long csr;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock(&dma->lock);
+
+	if (dma->free_dmach == NUM_CAMDMA_CHANNELS) {
+		/* A camera DMA interrupt occurred while all channels are idle, 
+		 * so we'll acknowledge the interrupt in the IRQSTATUS register 
+		 * and exit.
+		 */
+		omap24xxcam_dmahw_ack_all(dma->base);
+		spin_unlock(&dma->lock);
+		return;
+	}
+
+	while (dma->free_dmach < NUM_CAMDMA_CHANNELS) {
+		dmach = (dma->next_dmach + dma->free_dmach)
+		    % NUM_CAMDMA_CHANNELS;
+		if (omap24xxcam_dmahw_running(dma->base, dmach)) {
+			/* This buffer hasn't finished yet, so we're done. */
+			break;
+		}
+		csr = omap24xxcam_dmahw_ack_ch(dma->base, dmach);
+		if (csr & csr_error) {
+			/* A DMA error occurred, so stop all DMA transfers in 
+			 * progress.
+			 */
+			spin_unlock(&dma->lock);
+			omap24xxcam_dma_stop(dma, csr);
+			return;
+		} else {
+			callback = dma->ch_state[dmach].callback;
+			arg = dma->ch_state[dmach].arg;
+			dma->free_dmach++;
+			if (callback) {
+				spin_unlock(&dma->lock);
+				(*callback) (dma, csr, arg);
+				spin_lock(&dma->lock);
+			}
+		}
+	}
+
+	spin_unlock(&dma->lock);
+
+	omap24xxcam_sgdma_process(container_of(dma, struct omap24xxcam_sgdma, dma));
+}
+
+void omap24xxcam_dma_hwinit(const struct omap24xxcam_dma *dma)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&dma->lock, flags);
+
+	omap24xxcam_dmahw_init(dma->base);
+	
+	spin_unlock_irqrestore(&dma->lock, flags);
+}
+
+static void omap24xxcam_dma_init(struct omap24xxcam_dma *dma,
+				 unsigned long base)
+{
+	int ch;
+
+	/* group all channels on DMA IRQ0 and unmask irq */
+	spin_lock_init(&dma->lock);
+	dma->base = base;
+	dma->free_dmach = NUM_CAMDMA_CHANNELS;
+	dma->next_dmach = 0;
+	for (ch = 0; ch < NUM_CAMDMA_CHANNELS; ch++) {
+		dma->ch_state[ch].callback = NULL;
+		dma->ch_state[ch].arg = NULL;
+	}
+}
+
+/*
+ *
+ * Scatter-gather DMA.
+ *
+ * High-level DMA construct for transferring whole picture frames to
+ * memory that is discontinuous.
+ *
+ */
+
+/* DMA completion routine for the scatter-gather DMA fragments. */
+static void omap24xxcam_sgdma_callback(struct omap24xxcam_dma *dma,
+				       unsigned long csr, void *arg)
+{
+	struct omap24xxcam_sgdma *sgdma =
+		container_of(dma, struct omap24xxcam_sgdma, dma);
+	int sgslot = (int)arg;
+	struct sgdma_state *sg_state;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock(&sgdma->lock);
+
+	/* We got an interrupt, we can remove the timer */
+	del_timer(&sgdma->reset_timer);
+
+	sg_state = sgdma->sg_state + sgslot;
+	if (!sg_state->queued_sglist) {
+		spin_unlock(&sgdma->lock);
+		printk(KERN_DEBUG
+		       "%s: sgdma completed when none queued!\n", __FUNCTION__);
+		return;
+	}
+
+	sg_state->csr |= csr;
+	if (!--sg_state->queued_sglist) {
+		/* Queue for this sglist is empty, so check to see if we're 
+		 * done.
+		 */
+		if ((sg_state->next_sglist == sg_state->sglen)
+		    || (sg_state->csr & csr_error)) {
+			sgdma_callback_t callback = sg_state->callback;
+			void *arg = sg_state->arg;
+			unsigned long sg_csr = sg_state->csr;
+			/* All done with this sglist */
+			sgdma->free_sgdma++;
+			if (callback) {
+				spin_unlock(&sgdma->lock);
+				(*callback) (sgdma, sg_csr, arg);
+				return;
+			}
+		}
+	}
+
+	spin_unlock(&sgdma->lock);
+}
+
+/* Start queued scatter-gather DMA transfers. */
+void omap24xxcam_sgdma_process(struct omap24xxcam_sgdma *sgdma)
+{
+	unsigned long irqflags;
+	int queued_sgdma, sgslot;
+	struct sgdma_state *sg_state;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock_irqsave(&sgdma->lock, irqflags);
+
+	queued_sgdma = NUM_SG_DMA - sgdma->free_sgdma;
+	sgslot = (sgdma->next_sgdma + sgdma->free_sgdma) % NUM_SG_DMA;
+	while (queued_sgdma > 0) {
+		sg_state = sgdma->sg_state + sgslot;
+		while ((sg_state->next_sglist < sg_state->sglen) &&
+		       !(sg_state->csr & csr_error)) {
+			const struct scatterlist *sglist;
+			unsigned int len;
+
+			sglist = sg_state->sglist + sg_state->next_sglist;
+			/* try to start the next DMA transfer */
+			if ( sg_state->next_sglist + 1 == sg_state->sglen ) {
+				/* 
+				 *  On the last sg, we handle the case where
+				 *  cam->img.pix.sizeimage % PAGE_ALIGN != 0
+				 */
+				len = sg_state->len - sg_state->bytes_read;
+			} else {
+				len = sg_dma_len(sglist);
+			}
+
+			if (omap24xxcam_dma_start(&sgdma->dma,
+						  sg_dma_address(sglist),
+						  len,
+						  omap24xxcam_sgdma_callback,
+						  (void *)sgslot)) {
+				/* DMA start failed */
+				spin_unlock_irqrestore(&sgdma->lock, irqflags);
+				return;
+			} else {
+				unsigned long expires;
+				/* DMA start was successful */
+				sg_state->next_sglist++;
+				sg_state->bytes_read += len;
+				sg_state->queued_sglist++;
+
+				/* We start the reset timer */
+				expires = jiffies + HZ;
+				mod_timer(&sgdma->reset_timer, expires);
+			}
+		}
+		queued_sgdma--;
+		sgslot = (sgslot + 1) % NUM_SG_DMA;
+	}
+
+	spin_unlock_irqrestore(&sgdma->lock, irqflags);
+}
+
+/*
+ * Queue a scatter-gather DMA transfer from the camera to memory. 
+ * Returns zero if the transfer was successfully queued, or non-zero
+ * if all of the scatter-gather slots are already in use.
+ */
+int omap24xxcam_sgdma_queue(struct omap24xxcam_sgdma *sgdma,
+			    const struct scatterlist *sglist, int sglen,
+			    int len, sgdma_callback_t callback, void *arg)
+{
+	unsigned long irqflags;
+	struct sgdma_state *sg_state;
+
+	if ((sglen < 0) || ((sglen > 0) & !sglist))
+		return -EINVAL;
+
+	spin_lock_irqsave(&sgdma->lock, irqflags);
+
+	if (!sgdma->free_sgdma) {
+		spin_unlock_irqrestore(&sgdma->lock, irqflags);
+		return -EBUSY;
+	}
+
+	sg_state = sgdma->sg_state + sgdma->next_sgdma;
+
+	sg_state->sglist = sglist;
+	sg_state->sglen = sglen;
+	sg_state->next_sglist = 0;
+	sg_state->bytes_read = 0;
+	sg_state->len = len;
+	sg_state->queued_sglist = 0;
+	sg_state->csr = 0;
+	sg_state->callback = callback;
+	sg_state->arg = arg;
+
+	sgdma->next_sgdma = (sgdma->next_sgdma + 1) % NUM_SG_DMA;
+	sgdma->free_sgdma--;
+
+	spin_unlock_irqrestore(&sgdma->lock, irqflags);
+
+	omap24xxcam_sgdma_process(sgdma);
+
+	return 0;
+}
+
+/* Sync scatter-gather DMA by aborting any DMA transfers currently in progress.
+ * Any queued scatter-gather DMA transactions that have not yet been started 
+ * will remain queued.  The DMA controller will be idle after this routine 
+ * completes.  When the scatter-gather queue is restarted, the next 
+ * scatter-gather DMA transfer will begin at the start of a new transaction.
+ */
+void omap24xxcam_sgdma_sync(struct omap24xxcam_sgdma *sgdma)
+{
+	unsigned long irqflags;
+	int sgslot;
+	struct sgdma_state *sg_state;
+	unsigned long csr = CAMDMA_CSR_TRANS_ERR;
+
+	/* stop any DMA transfers in progress */
+	omap24xxcam_dma_stop(&sgdma->dma, csr);
+
+	spin_lock_irqsave(&sgdma->lock, irqflags);
+
+	if (sgdma->free_sgdma < NUM_SG_DMA) {
+		sgslot = (sgdma->next_sgdma + sgdma->free_sgdma) % NUM_SG_DMA;
+		sg_state = sgdma->sg_state + sgslot;
+		if (sg_state->next_sglist != 0) {
+			/* This DMA transfer was in progress, so abort it. */
+			sgdma_callback_t callback = sg_state->callback;
+			void *arg = sg_state->arg;
+			sgdma->free_sgdma++;
+			if (callback) {
+				/* leave interrupts masked */
+				spin_unlock(&sgdma->lock);
+				(*callback) (sgdma, csr, arg);
+				spin_lock(&sgdma->lock);
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&sgdma->lock, irqflags);
+}
+
+void omap24xxcam_sgdma_init(struct omap24xxcam_sgdma *sgdma,
+			    unsigned long base,
+			    void (*reset_callback)(unsigned long data),
+			    unsigned long reset_callback_data)
+{
+	int sg;
+
+	spin_lock_init(&sgdma->lock);
+	sgdma->free_sgdma = NUM_SG_DMA;
+	sgdma->next_sgdma = 0;
+	for (sg = 0; sg < NUM_SG_DMA; sg++) {
+		sgdma->sg_state[sg].sglen = 0;
+		sgdma->sg_state[sg].next_sglist = 0;
+		sgdma->sg_state[sg].bytes_read = 0;
+		sgdma->sg_state[sg].queued_sglist = 0;
+		sgdma->sg_state[sg].csr = 0;
+		sgdma->sg_state[sg].callback = NULL;
+		sgdma->sg_state[sg].arg = NULL;
+	}
+
+	omap24xxcam_dma_init(&sgdma->dma, base);
+	init_timer(&sgdma->reset_timer);
+	sgdma->reset_timer.function = reset_callback;
+	sgdma->reset_timer.data = reset_callback_data;
+}
diff --git a/drivers/media/video/omap/omap24xxcam-dma.h b/drivers/media/video/omap/omap24xxcam-dma.h
new file mode 100644
index 0000000..dc57799
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-dma.h
@@ -0,0 +1,42 @@
+/*
+ * omap24xxcam-dma.h
+ *
+ * Copyright (C) 2006 Instituto Nokia de Tecnolodia.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on code from David Cohen <david.cohen@indt.org.br>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+/* sgdma prototypes */
+
+void omap24xxcam_sgdma_process(struct omap24xxcam_sgdma *sgdma);
+int omap24xxcam_sgdma_queue(struct omap24xxcam_sgdma *sgdma,
+			    const struct scatterlist *sglist, int sglen,
+			    int len, sgdma_callback_t callback, void *arg);
+void omap24xxcam_sgdma_sync(struct omap24xxcam_sgdma *sgdma);
+void omap24xxcam_sgdma_init(struct omap24xxcam_sgdma *sgdma,
+			    unsigned long base,
+			    void (*reset_callback)(unsigned long data),
+			    unsigned long reset_callback_data);
+void omap24xxcam_sgdma_exit(struct omap24xxcam_sgdma *sgdma);
+
+/* dma prototypes */
+
+void omap24xxcam_dma_hwinit(const struct omap24xxcam_dma *dma);
+void omap24xxcam_dma_isr(struct omap24xxcam_dma *dma);
diff --git a/drivers/media/video/omap/omap24xxcam-sensor.c b/drivers/media/video/omap/omap24xxcam-sensor.c
new file mode 100644
index 0000000..791c4e9
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-sensor.c
@@ -0,0 +1,266 @@
+/*
+ * omap24xxcam-sensor.c
+ *
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/io.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+#include "sensor_if.h"
+
+/*
+ * Initialise the sensor.
+ *
+ * If the sensor has not been registered yet, -ENODEV is returned.
+ */
+int omap24xxcam_sensor_init(struct omap24xxcam_device *cam)
+{
+	int err = 0;
+
+	BUG_ON(cam->sensor == NULL);
+
+	omap24xxcam_clock_on(cam);
+	omap24xxcam_core_xclk_set(cam,
+				  omap24xxcam_sensor_xclk_calc(
+					  cam,
+					  &cam->pix,
+					  &cam->cparm.timeperframe));
+	
+	/* power up sensor during sensor initialization */
+	if (cam->sensor->power_on)
+		cam->sensor->power_on(cam->sensor);
+
+	err = cam->sensor->init(cam->sensor, &cam->pix, &omap24xxcam);
+	if (err) {
+		printk(KERN_ERR "%s: cannot initialize sensor, error %d\n",
+		       __FUNCTION__, err);
+		goto out;
+	}
+	
+	printk(KERN_INFO "%s: sensor is %s\n", __FUNCTION__, cam->sensor->name);
+
+out:
+	omap24xxcam_core_xclk_set(cam, 0);
+	omap24xxcam_clock_off(cam);
+
+	if (cam->sensor->power_off)
+		cam->sensor->power_off(cam->sensor);
+
+	return err;
+}
+
+void omap24xxcam_sensor_exit(struct omap24xxcam_device *cam)
+{
+	cam->sensor->cleanup(cam->sensor);
+}
+
+/* Power-up and configure camera sensor */
+int omap24xxcam_sensor_enable(struct omap24xxcam_device *cam)
+{
+	unsigned long xclk;
+	
+	omap24xxcam_clock_on(cam);
+	xclk = omap24xxcam_sensor_xclk_calc(cam, &cam->pix,
+					    &cam->cparm.timeperframe);
+	omap24xxcam_core_xclk_set(cam, xclk);
+
+ 	if (cam->sensor->power_on)
+		cam->sensor->power_on(cam->sensor);
+
+	/* program the sensor for the capture format and rate */
+	return cam->sensor->configure(cam->sensor, &cam->pix,
+				      xclk, &cam->cparm.timeperframe);
+}
+
+void omap24xxcam_sensor_disable(struct omap24xxcam_device *cam)
+{
+	omap24xxcam_core_xclk_set(cam, 0);
+	omap24xxcam_clock_off(cam);
+	if (cam->sensor->power_off)
+		cam->sensor->power_off(cam->sensor);
+}
+
+/* Calculate xclk based on the capture format and frame rate. */
+unsigned long omap24xxcam_sensor_calc_xclk(struct omap24xxcam_device *cam,
+					   struct v4l2_pix_format *pix,
+					   struct v4l2_fract *timeperframe)
+{
+	return cam->sensor->calc_xclk(cam->sensor, pix, timeperframe);
+}
+
+int omap24xxcam_sensor_try_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix)
+{
+	return cam->sensor->try_format(cam->sensor, pix);
+}
+
+int omap24xxcam_sensor_set_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix,
+				  struct v4l2_fract *timeperframe)
+{
+	int err;
+	unsigned long xclk;
+
+	if (timeperframe->numerator == 0
+	    || timeperframe->denominator == 0)
+		return -EINVAL;
+
+	xclk = omap24xxcam_sensor_xclk_calc(cam, pix, timeperframe);
+
+	omap24xxcam_core_xclk_set(cam, xclk);
+	
+	err = cam->sensor->configure(cam->sensor, pix, xclk, timeperframe);
+
+	return err;
+}
+
+unsigned long omap24xxcam_sensor_xclk_calc(struct omap24xxcam_device *cam,
+					   struct v4l2_pix_format *pix,
+					   struct v4l2_fract *timeperframe)
+{
+	return cam->sensor->calc_xclk(cam->sensor, pix, timeperframe);
+}
+				 
+
+int omap24xxcam_sensor_frame_check(struct omap24xxcam_device *cam,
+				   struct v4l2_pix_format *pix,
+				   void *buf)
+{
+	if (cam->sensor->frame_check)
+		return cam->sensor->frame_check(cam->sensor, pix, buf);
+
+	return 0;
+}
+
+int omap24xxcam_sensor_get_control(struct omap24xxcam_device *cam,
+				   struct v4l2_control *a)
+{
+	return cam->sensor->get_control(cam->sensor, a);
+}
+
+int omap24xxcam_sensor_set_control(struct omap24xxcam_device *cam,
+				   struct v4l2_control *a)
+{
+	return cam->sensor->set_control(cam->sensor, a);
+}
+
+int omap24xxcam_sensor_query_ctrl(struct omap24xxcam_device *cam,
+				  struct v4l2_queryctrl *a)
+{
+	return cam->sensor->query_control(cam->sensor, a);
+}
+
+int omap24xxcam_sensor_enum_pixformat(struct omap24xxcam_device *cam,
+				      struct v4l2_fmtdesc *f)
+{
+	return cam->sensor->enum_pixformat(cam->sensor, f);
+}
+
+void omap24xxcam_sensor_reset_work(struct work_struct *work)
+{
+	struct omap24xxcam_device *cam =
+		container_of(work, struct omap24xxcam_device,
+			     sensor_reset_work);
+	struct omap24xxcam_fh *fh;
+	unsigned long flags;
+
+	mutex_lock(&cam->mutex);
+	if (cam->streaming == NULL) {
+		mutex_unlock(&cam->mutex);
+		return;
+	}
+
+	fh = cam->streaming->private_data;
+
+	spin_lock_irqsave(&fh->vbq_lock, flags);
+	atomic_inc(&cam->in_reset);
+	omap24xxcam_core_disable(cam);
+	spin_unlock_irqrestore(&fh->vbq_lock, flags);
+	
+	omap24xxcam_sgdma_sync(&cam->sgdma);
+
+	omap24xxcam_sensor_disable(cam);
+	omap24xxcam_sensor_enable(cam);
+
+	omap24xxcam_sgdma_process(&cam->sgdma);
+	
+	spin_lock_irqsave(&fh->vbq_lock, flags);
+	atomic_dec(&cam->in_reset);
+	if (fh->sgdma_in_queue)
+		omap24xxcam_core_enable(fh->cam);
+	spin_unlock_irqrestore(&fh->vbq_lock, flags);
+
+	mutex_unlock(&cam->mutex);
+}
+
+void omap24xxcam_sensor_reset_schedule(struct omap_camera *oc,
+				       struct omap_camera_sensor *os)
+{
+	struct omap24xxcam_device *cam = oc->priv;
+	
+	schedule_work(&cam->sensor_reset_work);
+}
+
+/*
+ * Register sensor to the camera. Only works after the camera module
+ * is initialised.
+ */
+int omap24xxcam_sensor_register(struct omap_camera *oc,
+				struct omap_camera_sensor *os)
+{
+	struct omap24xxcam_device *cam = oc->priv;
+	int rval;
+
+	/* the device has not been initialised yet */
+	if (cam == NULL)
+		return -ENODEV;
+	if (!cam->camera_block_alive)
+		return -ENODEV;
+	if (cam->sensor != NULL)
+		return -EBUSY;
+	BUG_ON(os == NULL);
+
+	cam->sensor = os;
+
+	rval = omap24xxcam_device_enable(cam);
+	if (rval)
+		cam->sensor = NULL;
+
+	return rval;
+}
+
+void omap24xxcam_sensor_unregister(struct omap_camera *oc,
+				   struct omap_camera_sensor *os)
+{
+	struct omap24xxcam_device *cam = oc->priv;
+
+	mutex_lock(&cam->mutex);
+
+	BUG_ON(cam->users != 0);
+	BUG_ON(cam->sensor == NULL);
+
+	omap24xxcam_device_disable(cam);
+
+	cam->sensor = NULL;
+	mutex_unlock(&cam->mutex);
+}
diff --git a/drivers/media/video/omap/omap24xxcam-vbq.c b/drivers/media/video/omap/omap24xxcam-vbq.c
new file mode 100644
index 0000000..4961fd9
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-vbq.c
@@ -0,0 +1,399 @@
+/*
+ * omap24xxcam.c
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on code from Andy Lowe <source@mvista.com>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/videodev2.h>
+#include <linux/pci.h>		/* needed for videobufs */
+
+#include <asm/io.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+/*
+ *
+ * videobuf_buffer handling.
+ *
+ * Memory for mmapped videobuf_buffers is not allocated
+ * conventionally, but by several kmalloc allocations and then
+ * creating the scatterlist on our own. User-space buffers are handled
+ * normally.
+ *
+ * Mind the serialisation when accessing fh-> stuff!
+ *
+ */
+
+/*
+ * Free the memory-mapped buffer memory allocated for a
+ * videobuf_buffer and the associated scatterlist.
+ */
+void omap24xxcam_vbq_free_mmap_buffer(struct videobuf_buffer *vb)
+{
+	int i;
+	size_t alloc_size;
+	struct page *page;
+
+	if (vb->dma.sglist == NULL)
+		return;
+
+	i = vb->dma.sglen;
+	while (i) {
+		i--;
+		alloc_size = vb->dma.sglist[i].length;
+		page = vb->dma.sglist[i].page;
+		do {
+			ClearPageReserved(page++);
+		} while (alloc_size -= PAGE_SIZE);
+		__free_pages(vb->dma.sglist[i].page,
+			     get_order(vb->dma.sglist[i].length));
+	}
+
+	kfree(vb->dma.sglist);
+	vb->dma.sglist = NULL;
+}
+
+/*
+ * Allocate physically as contiguous as possible buffer for video
+ * frame and allocate and build DMA scatter-gather list for it.
+ */
+static int omap24xxcam_vbq_alloc_mmap_buffer(struct videobuf_buffer *vb)
+{
+	unsigned long order;
+	size_t alloc_size, size = vb->bsize; /* vb->bsize is page aligned */
+	struct page *page;
+	int max_pages, err = 0, i = 0;
+
+	/* allocate maximum size scatter-gather list. Note this is overhead. We
+	 * may not use as many entries as we allocate */
+	max_pages = vb->bsize >> PAGE_SHIFT;
+	vb->dma.sglist =
+		kcalloc(max_pages, sizeof(*vb->dma.sglist), GFP_KERNEL);
+	if (vb->dma.sglist == NULL) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	while (size) {
+		order = get_order(size);
+		/* do not over-allocate even if we would get larger contiguous
+		 * chunk that way */
+		if ((PAGE_SIZE << order) > size)
+			order--;
+
+		/* try to allocate as many contiguous pages as possible */
+		page = alloc_pages(GFP_KERNEL | GFP_DMA, order);
+		/* if allocation fails, try to allocate smaller amount */
+		while (page == NULL) {
+			order--;
+			page = alloc_pages(GFP_KERNEL | GFP_DMA, order);
+			if (page == NULL && !order) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+		size -= (PAGE_SIZE << order);
+
+		/* append allocated chunk of pages into scatter-gather list */
+		vb->dma.sglist[i].page = page;
+		vb->dma.sglist[i].length = (PAGE_SIZE << order);
+		vb->dma.sglen++;
+		i++;
+
+		alloc_size = (PAGE_SIZE << order);
+		
+		/* clear pages before giving them to user space */
+		memset(page_address(page), 0, alloc_size);
+
+		/* mark allocated pages reserved */
+		do {
+			SetPageReserved(page++);
+		} while (alloc_size -= PAGE_SIZE);
+	}
+	/* REVISIT: not fully correct to assign nr_pages == sglen but video-buf
+	 * is passing nr_pages for e.g. unmap_sg calls */
+	vb->dma.nr_pages = vb->dma.sglen;
+	vb->dma.direction = PCI_DMA_FROMDEVICE;
+
+	return 0;
+
+out:
+	omap24xxcam_vbq_free_mmap_buffer(vb);
+	return err;
+}
+
+int omap24xxcam_vbq_alloc_mmap_buffers(struct videobuf_queue *vbq,
+				       unsigned int count)
+{
+	int i, err = 0;
+
+	mutex_lock(&vbq->lock);
+
+	for (i = 0; i < count; i++) {
+		err = omap24xxcam_vbq_alloc_mmap_buffer(vbq->bufs[i]);
+		if (err)
+			goto out;
+		printk(KERN_INFO "%s: sglen is %d for buffer %d\n",
+		       __FUNCTION__, vbq->bufs[i]->dma.sglen, i);
+	}
+
+	mutex_unlock(&vbq->lock);
+
+	return 0;
+out:
+	while (i) {
+		i--;
+		omap24xxcam_vbq_free_mmap_buffer(vbq->bufs[i]);
+	}
+
+	mutex_unlock(&vbq->lock);
+
+	return err;
+}
+
+/* Release all memory related to the videobuf_queue. */
+void omap24xxcam_vbq_free_mmap_buffers(struct videobuf_queue *vbq)
+{
+	int i;
+
+	mutex_lock(&vbq->lock);
+
+	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
+		if (NULL == vbq->bufs[i])
+			continue;
+		if (V4L2_MEMORY_MMAP != vbq->bufs[i]->memory)
+			continue;
+		omap24xxcam_vbq_release(vbq, vbq->bufs[i]);
+		omap24xxcam_vbq_free_mmap_buffer(vbq->bufs[i]);
+		kfree(vbq->bufs[i]);
+		vbq->bufs[i] = NULL;
+	}
+
+	mutex_unlock(&vbq->lock);
+
+	videobuf_mmap_free(vbq);
+}
+
+/* This routine is called from interrupt context when a scatter-gather DMA 
+ * transfer of a videobuf_buffer completes.
+ */
+void omap24xxcam_vbq_complete(struct omap24xxcam_sgdma *sgdma,
+			      unsigned long csr, void *arg)
+{
+	struct omap24xxcam_device *cam =
+		container_of(sgdma, struct omap24xxcam_device, sgdma);
+	struct omap24xxcam_fh *fh = cam->streaming->private_data;
+	struct videobuf_buffer *vb = (struct videobuf_buffer *)arg;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fh->vbq_lock, flags);
+	if (--fh->sgdma_in_queue == 0)
+		omap24xxcam_core_disable(fh->cam);
+	spin_unlock_irqrestore(&fh->vbq_lock, flags);
+	
+	do_gettimeofday(&vb->ts);
+	vb->field_count = atomic_add_return(2, &fh->field_count);
+	if (csr & csr_error) {
+		vb->state = STATE_ERROR;
+		if (!atomic_read(&fh->cam->in_reset)) {
+			printk(KERN_INFO
+			       "%s: scheduling camera reset, csr 0x%lx\n",
+			       __FUNCTION__, csr);
+			omap24xxcam_camera_reset_schedule(cam);
+		}
+	} else
+		vb->state = STATE_DONE;
+	wake_up(&vb->done);
+}
+
+void omap24xxcam_vbq_release(struct videobuf_queue *vbq,
+			     struct videobuf_buffer *vb)
+{
+	struct videobuf_dmabuf *dma = &vb->dma;
+
+	/* wait for buffer, especially to get out of the sgdma queue */
+	videobuf_waiton(vb, 0, 0);
+	if (vb->memory == V4L2_MEMORY_MMAP) {
+		dma_unmap_sg(vbq->dev, dma->sglist, dma->sglen,
+			     dma->direction);
+		dma->direction = DMA_NONE;
+	} else {
+		videobuf_dma_unmap(vbq, &vb->dma);
+		videobuf_dma_free(&vb->dma);
+	}
+
+	vb->state = STATE_NEEDS_INIT;
+}
+
+/* Limit the number of available kernel image capture buffers based on the 
+ * number requested, the currently selected image size, and the maximum 
+ * amount of memory permitted for kernel capture buffers.
+ */
+static int omap24xxcam_vbq_setup(struct videobuf_queue *vbq, unsigned int *cnt,
+				 unsigned int *size)
+{
+	struct omap24xxcam_fh *fh = vbq->priv_data;
+
+	if (*cnt <= 0)
+		*cnt = VIDEO_MAX_FRAME;	/* supply a default number of buffers */
+
+	if (*cnt > VIDEO_MAX_FRAME)
+		*cnt = VIDEO_MAX_FRAME;
+
+	spin_lock(&fh->pix_lock);
+	*size = fh->pix.sizeimage;
+	spin_unlock(&fh->pix_lock);
+
+	/* accessing fh->cam.capture is ok, it's constant */
+	while (*size * *cnt > fh->cam->capture_mem)
+		(*cnt)--;
+
+	return 0;
+}
+
+static int omap24xxcam_dma_iolock(struct videobuf_queue *vbq,
+				  struct videobuf_dmabuf *dma)
+{
+	int err = 0;
+
+	dma->direction = PCI_DMA_FROMDEVICE;
+	if (!dma_map_sg(vbq->dev, dma->sglist, dma->sglen, dma->direction)) {
+		kfree(dma->sglist);
+		dma->sglist = NULL;
+		dma->sglen = 0;
+		err = -EIO;
+	}
+
+	return err;
+}
+
+static int omap24xxcam_vbq_prepare(struct videobuf_queue *vbq,
+				   struct videobuf_buffer *vb,
+				   enum v4l2_field field)
+{
+	struct omap24xxcam_fh *fh = vbq->priv_data;
+	struct v4l2_pix_format pix;
+	int err = 0;
+
+	spin_lock(&fh->pix_lock);
+	pix = fh->pix;
+	spin_unlock(&fh->pix_lock);
+
+	if (vb->baddr) {
+		/* This is a userspace buffer. */
+		if (pix.sizeimage > vb->bsize) {
+			/* The buffer isn't big enough. */
+			err = -EINVAL;
+		} else
+			vb->size = pix.sizeimage;
+	} else {
+		if (vb->state != STATE_NEEDS_INIT) {
+			/* We have a kernel bounce buffer that has already been 
+			 * allocated.
+			 */
+			if (pix.sizeimage > vb->size) {
+				/* The image size has been changed to a larger 
+				 * size since this buffer was allocated, so we 
+				 * need to free and reallocate it.
+				 */
+				omap24xxcam_vbq_release(vbq, vb);
+				vb->size = pix.sizeimage;
+			}
+		} else {
+			/* We need to allocate a new kernel bounce buffer. */
+			vb->size = pix.sizeimage;
+		}
+	}
+
+	if (err)
+		return err;
+
+	vb->width = pix.width;
+	vb->height = pix.height;
+	vb->field = field;
+
+	if (vb->state == STATE_NEEDS_INIT) {
+		if (vb->memory == V4L2_MEMORY_MMAP)
+			/* we have built the scatter-gather list by ourself so
+			 * do the scatter-gather mapping as well */
+			err = omap24xxcam_dma_iolock(vbq, &vb->dma);
+		else
+			err = videobuf_iolock(vbq, vb, NULL);
+	}
+
+	if (!err)
+		vb->state = STATE_PREPARED;
+	else
+		omap24xxcam_vbq_release(vbq, vb);
+
+	return err;
+}
+
+static void omap24xxcam_vbq_queue(struct videobuf_queue *vbq,
+				  struct videobuf_buffer *vb)
+{
+	struct omap24xxcam_fh *fh = vbq->priv_data;
+	enum videobuf_state state = vb->state;
+	int err;
+
+	/*
+	 * FIXME: We're marking the buffer active since we have no
+	 * pretty way of marking it active exactly when the
+	 * scatter-gather transfer starts.
+	 */
+	vb->state = STATE_ACTIVE;
+	err = omap24xxcam_sgdma_queue(&fh->cam->sgdma, vb->dma.sglist,
+				      vb->dma.sglen, vb->size,
+				      omap24xxcam_vbq_complete, vb);
+
+	/* We already hold &fh->vbq_lock! */
+	if (++fh->sgdma_in_queue == 1
+	    && !atomic_read(&fh->cam->in_reset))
+		omap24xxcam_core_enable(fh->cam);
+
+	if (err) {
+		/* Oops.  We're not supposed to get any errors here.  The only 
+		 * way we could get an error is if we ran out of scatter-gather 
+		 * DMA slots, but we are supposed to have at least as many 
+		 * scatter-gather DMA slots as video buffers so that can't 
+		 * happen.
+		 */
+		printk(KERN_DEBUG
+		       "%s: failed to queue a video buffer for dma!\n",
+			__FUNCTION__);
+		vb->state = state;
+	}
+}
+
+struct videobuf_queue_ops omap24xxcam_vbq_ops = {
+ 	.buf_setup = omap24xxcam_vbq_setup,
+	.buf_prepare = omap24xxcam_vbq_prepare,
+	.buf_queue = omap24xxcam_vbq_queue,
+	.buf_release = omap24xxcam_vbq_release,
+};
+
diff --git a/drivers/media/video/omap/omap24xxcam.c b/drivers/media/video/omap/omap24xxcam.c
new file mode 100644
index 0000000..ba4a6a1
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.c
@@ -0,0 +1,1130 @@
+/*
+ * omap24xxcam.c
+ *
+ * OMAP 2 camera block driver.
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on code from Andy Lowe <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/videodev2.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <linux/version.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <media/v4l2-common.h>
+
+#include <asm/io.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+#include "sensor_if.h"
+
+#define RESET_TIMEOUT (HZ * 10)
+
+struct omap_camera omap24xxcam = {
+	.sensor_register = &omap24xxcam_sensor_register,
+	.sensor_unregister = &omap24xxcam_sensor_unregister,
+	.sensor_reset = &omap24xxcam_sensor_reset_schedule,
+};
+
+/* module parameters */
+static int video_nr = -1;	/* video device minor (-1 ==> auto assign) */
+/* Maximum amount of memory to use for capture buffers.
+ * Default is 4800KB, enough to double-buffer SXGA.
+ */
+static int capture_mem = 1280 * 960 * 2 * 2;
+
+/*
+ *
+ * OMAP main camera system
+ *
+ */
+
+static void omap24xxcam_reset(const struct omap24xxcam_device *cam)
+{
+	unsigned long timeout;
+
+	omap24xxcam_reg_out(cam->mmio_base,
+			    CAM_SYSCONFIG,
+			    CAM_SYSCONFIG_SOFTRESET);
+	
+	/* wait for reset to complete */
+	timeout = jiffies + RESET_TIMEOUT;
+	
+	while (!(omap24xxcam_reg_in(cam->mmio_base, CAM_SYSSTATUS)
+		 & CAM_SYSSTATUS_RESETDONE)
+	       && time_before(jiffies, timeout)) {
+		msleep(1);
+	}
+
+	if (!(omap24xxcam_reg_in(cam->mmio_base, CAM_SYSSTATUS)
+	      & CAM_SYSSTATUS_RESETDONE)) {
+		printk(KERN_WARNING CAM_NAME
+		       ": timeout waiting for camera subsystem reset\n");
+	}
+}
+
+/*
+ * Reset the whole OMAP camera. After this the subsystems in the
+ * camera can be used. I.e. use after power-on and when in need to
+ * reset the camera.
+ */
+static void omap24xxcam_hwinit(const struct omap24xxcam_device *cam)
+{
+	omap24xxcam_reset(cam);
+
+	/* set the camera subsystem autoidle bit */
+	omap24xxcam_reg_out(cam->mmio_base, CAM_SYSCONFIG,
+			    CAM_SYSCONFIG_AUTOIDLE);
+
+	/* initialize the camera MMU */
+	/* set the camera MMU autoidle bit */
+	omap24xxcam_reg_out(cam->mmio_base,
+			    CAMMMU_REG_OFFSET + CAMMMU_SYSCONFIG,
+			    CAMMMU_SYSCONFIG_AUTOIDLE);
+
+	omap24xxcam_core_hwinit(cam);
+
+	omap24xxcam_dma_hwinit(&cam->sgdma.dma);
+}
+
+/*
+ * Callback for dma transfer stalling.
+ */
+static void omap24xxcam_stalled_dma_reset(unsigned long data)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)data;
+
+	if (!atomic_read(&cam->in_reset)) {
+		printk(KERN_WARNING
+		       "%s: dma stalled, scheduling camera reset\n",
+		       __FUNCTION__);
+
+		omap24xxcam_camera_reset_schedule(cam);
+	}
+}
+
+/*
+ * Work to reset the camera software (and hardware).
+ */
+void omap24xxcam_camera_reset_work(struct work_struct *work)
+{
+	struct omap24xxcam_device *cam =
+		container_of(work, struct omap24xxcam_device,
+			     sensor_reset_work);
+	struct omap24xxcam_fh *fh;
+	unsigned long flags;
+
+	mutex_lock(&cam->mutex);
+	if (cam->streaming == NULL) {
+		mutex_unlock(&cam->mutex);
+		return;
+	}
+
+	fh = cam->streaming->private_data;
+
+	/* Reset and re-initialize the entire camera subsystem.
+	 * Resetting the camera FIFO via the CC_RST bit in the CC_CTRL 
+	 * register is supposed to be sufficient to recover from a 
+	 * camera interface error, but it doesn't seem to be enough.  If 
+	 * we only do that then subsequent image captures are out of sync 
+	 * by either one or two times DMA_THRESHOLD bytes.  Resetting and 
+	 * re-initializing the entire camera subsystem prevents the problem 
+	 * with frame synchronization.
+	 */
+	spin_lock_irqsave(&fh->vbq_lock, flags);
+	atomic_inc(&cam->in_reset);
+	omap24xxcam_core_disable(cam);
+	spin_unlock_irqrestore(&fh->vbq_lock, flags);
+	
+	omap24xxcam_sgdma_sync(&cam->sgdma);
+	omap24xxcam_hwinit(cam);
+
+	omap24xxcam_sgdma_process(&cam->sgdma);
+	omap24xxcam_core_xclk_set(cam,
+				  omap24xxcam_sensor_xclk_calc(
+					  cam,
+					  &cam->pix,
+					  &cam->cparm.timeperframe));
+
+	spin_lock_irqsave(&fh->vbq_lock, flags);
+	atomic_dec(&cam->in_reset);
+	if (fh->sgdma_in_queue)
+		omap24xxcam_core_enable(fh->cam);
+	spin_unlock_irqrestore(&fh->vbq_lock, flags);
+
+	mutex_unlock(&cam->mutex);
+}
+
+void omap24xxcam_camera_reset_schedule(struct omap24xxcam_device *cam)
+{
+	schedule_work(&cam->camera_reset_work);
+}
+
+/*
+ * The main interrupt handler.
+ */
+static irqreturn_t omap24xxcam_isr(int irq, void *arg)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)arg;
+	unsigned long irqstatus;
+	unsigned int irqhandled = 0;
+
+	irqstatus = omap24xxcam_reg_in(cam->mmio_base, CAM_IRQSTATUS);
+
+	if (irqstatus &
+	    (CAM_IRQSTATUS_DMA_IRQ2 | CAM_IRQSTATUS_DMA_IRQ1
+	     | CAM_IRQSTATUS_DMA_IRQ0)) {
+		omap24xxcam_dma_isr(&cam->sgdma.dma);
+		irqhandled = 1;
+	}
+	if (irqstatus & CAM_IRQSTATUS_CC_IRQ) {
+		omap24xxcam_core_isr(cam);
+		irqhandled = 1;
+	}
+	if (irqstatus & CAM_IRQSTATUS_MMU_IRQ)
+		printk(KERN_ERR "%s: unhandled camera MMU interrupt!\n",
+			__FUNCTION__);
+
+	return IRQ_RETVAL(irqhandled);
+}
+
+/*
+ *
+ * IOCTL interface.
+ *
+ */
+
+static int vidioc_querycap(struct file *file, void *fh,
+			   struct v4l2_capability *cap)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	memset(cap, 0, sizeof(*cap));
+	strlcpy(cap->driver, CAM_NAME, sizeof(cap->driver));
+	strlcpy(cap->card, cam->vfd->name, sizeof(cap->card));
+	cap->bus_info[0] = '\0';
+	cap->version = KERNEL_VERSION(0, 0, 0);
+	cap->capabilities =
+		V4L2_CAP_VIDEO_CAPTURE
+		| V4L2_CAP_STREAMING;
+	
+	return 0;
+}
+
+static int vidioc_enum_input(struct file *file, void *fh,
+			     struct v4l2_input *inp)
+{
+	/* default handler assumes 1 video input (the camera) */
+	int index = inp->index;
+
+	memset(inp, 0, sizeof(*inp));
+	inp->index = index;
+
+	if (index > 0)
+		return -EINVAL;
+
+	strlcpy(inp->name, "camera", sizeof(inp->name));
+	inp->type = V4L2_INPUT_TYPE_CAMERA;
+	
+	return 0;
+}
+
+static int vidioc_g_input(struct file *file, void *fh, unsigned int *i)
+{
+	*i = 0;
+
+	return 0;
+}
+
+static int vidioc_s_input(struct file *file, void *fh, unsigned int i)
+{
+	if (i > 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vidioc_g_fmt_cap(struct file *file, void *fh,
+			    struct v4l2_format *f)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct v4l2_pix_format *pix = &f->fmt.pix;
+
+	mutex_lock(&cam->mutex);
+	*pix = cam->pix;
+	mutex_unlock(&cam->mutex);
+
+	return 0;
+}
+
+static int vidioc_try_fmt_cap(struct file *file, void *fh,
+			      struct v4l2_format *f)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	int rval;
+
+	mutex_lock(&cam->mutex);
+	rval = omap24xxcam_sensor_try_format(cam, &f->fmt.pix);
+	mutex_unlock(&cam->mutex);
+
+	return rval;
+}
+
+static int vidioc_s_fmt_cap(struct file *file, void *fh,
+			    struct v4l2_format *f)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	int rval;
+
+	mutex_lock(&cam->mutex);
+
+	if (cam->streaming) {
+		rval = -EBUSY;
+		goto out;
+	}
+
+	omap24xxcam_sensor_try_format(cam, &f->fmt.pix);
+	/* set the new capture format */
+	cam->pix = f->fmt.pix;
+	/* adjust the capture frame rate */
+	rval = omap24xxcam_sensor_set_format(cam,
+					     &cam->pix,
+					     &cam->cparm.timeperframe);
+
+	spin_lock(&ofh->pix_lock);
+	ofh->pix = f->fmt.pix;
+	spin_unlock(&ofh->pix_lock);
+
+out:
+	mutex_unlock(&cam->mutex);
+
+	return rval;
+}
+
+static int vidioc_g_parm(struct file *file, void *fh,
+			 struct v4l2_streamparm *a) {
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	enum v4l2_buf_type type = a->type;
+
+	if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	memset(a, 0, sizeof(*a));
+	a->type = type;
+
+	mutex_lock(&cam->mutex);
+	a->parm.capture = cam->cparm;
+	mutex_unlock(&cam->mutex);
+
+	return 0;
+}
+
+static int vidioc_s_parm(struct file *file, void *fh,
+			 struct v4l2_streamparm *a)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct v4l2_captureparm *cparm = &a->parm.capture;
+	int rval;
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	mutex_lock(&cam->mutex);
+	if (cam->streaming) {
+		rval = -EBUSY;
+		goto out;
+	}
+
+	rval = omap24xxcam_sensor_set_format(cam,
+					     &cam->pix,
+					     &cparm->timeperframe);
+	if (rval)
+		goto out;
+	
+	cam->cparm.capturemode = cparm->capturemode;
+	cam->cparm.timeperframe = cparm->timeperframe;
+	spin_lock(&ofh->pix_lock);
+	ofh->pix = cam->pix;
+	spin_unlock(&ofh->pix_lock);
+
+out:
+	mutex_unlock(&cam->mutex);
+	
+	return rval;
+}
+
+static int vidioc_reqbufs(struct file *file, void *fh,
+			  struct v4l2_requestbuffers *b)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	int rval;
+
+	mutex_lock(&cam->mutex);
+	if (cam->streaming) {
+		mutex_unlock(&cam->mutex);
+		return -EBUSY;
+	}
+	mutex_unlock(&cam->mutex);
+
+	omap24xxcam_vbq_free_mmap_buffers(&ofh->vbq);
+	rval = videobuf_reqbufs(&ofh->vbq, b);
+
+	if (rval || b->memory != V4L2_MEMORY_MMAP)
+		goto out;
+
+	rval = omap24xxcam_vbq_alloc_mmap_buffers(&ofh->vbq, b->count);
+	if (rval)
+		omap24xxcam_vbq_free_mmap_buffers(&ofh->vbq);
+	
+out:
+	return rval;
+}
+
+static int vidioc_querybuf(struct file *file, void *fh,
+			   struct v4l2_buffer *b)
+{
+	struct omap24xxcam_fh *ofh = fh;
+
+	return videobuf_querybuf(&ofh->vbq, b);
+}
+
+static int vidioc_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	int rval;
+
+	rval = videobuf_qbuf(&ofh->vbq, b);
+	return rval;
+}
+
+static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct videobuf_buffer *vb;
+	struct v4l2_pix_format pix;
+	int rval;
+
+	rval = videobuf_dqbuf(&ofh->vbq, b, file->f_flags & O_NONBLOCK);
+	if (rval < 0)
+		return rval;
+	
+	vb = ofh->vbq.bufs[b->index];
+
+	mutex_lock(&cam->mutex);
+	pix = cam->pix;
+	mutex_unlock(&cam->mutex);
+
+	return omap24xxcam_sensor_frame_check(cam, &pix, (void *)vb->baddr);
+}
+
+static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	int rval;
+
+	mutex_lock(&cam->mutex);
+	if (cam->streaming) {
+		mutex_unlock(&cam->mutex);
+		return -EBUSY;
+	}
+
+	if (!(rval = videobuf_streamon(&ofh->vbq)))
+		cam->streaming = file;
+
+	mutex_unlock(&cam->mutex);
+
+	return rval;
+}
+
+static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct videobuf_queue *q = &ofh->vbq;
+	int rval;
+
+	mutex_lock(&cam->mutex);
+	if ((rval = videobuf_streamoff(q)))
+		goto out;
+
+	cam->streaming = NULL;
+	
+out:
+	mutex_unlock(&cam->mutex);
+
+	return rval;
+}
+
+static int vidioc_g_ctrl(struct file *file, void *fh,
+			 struct v4l2_control *a)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	int rval;
+
+	mutex_lock(&cam->mutex);
+	rval = omap24xxcam_sensor_get_control(cam, a);
+	mutex_unlock(&cam->mutex);
+
+	return rval;
+}
+
+static int vidioc_s_ctrl(struct file *file, void *fh,
+			 struct v4l2_control *a)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	int rval;
+
+	mutex_lock(&cam->mutex);
+	rval = omap24xxcam_sensor_set_control(cam, a);
+	mutex_unlock(&cam->mutex);
+
+	return rval;
+}
+
+static int vidioc_queryctrl(struct file *file, void *fh,
+			    struct v4l2_queryctrl *a)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	return omap24xxcam_sensor_query_ctrl(cam, a);
+}
+
+static int vidioc_enum_fmt_cap(struct file *file, void *fh,
+			       struct v4l2_fmtdesc *f)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	return omap24xxcam_sensor_enum_pixformat(cam, f);
+}
+
+/*
+ *
+ * File operations.
+ *
+ */
+
+static unsigned int omap24xxcam_poll(struct file *file,
+				     struct poll_table_struct *wait)
+{
+       struct omap24xxcam_fh *fh = file->private_data;
+       struct omap24xxcam_device *cam = fh->cam;
+       struct videobuf_buffer *vb;
+
+       mutex_lock(&cam->mutex);
+       if (cam->streaming != file) {
+               mutex_unlock(&cam->mutex);
+	       return POLLERR;
+       }
+       mutex_unlock(&cam->mutex);
+
+       mutex_lock(&fh->vbq.lock);
+       if (list_empty(&fh->vbq.stream)) {
+	       mutex_unlock(&fh->vbq.lock);
+	       return POLLERR;
+       }
+       vb = list_entry(fh->vbq.stream.next, struct videobuf_buffer, stream);
+       mutex_unlock(&fh->vbq.lock);
+
+       poll_wait(file, &vb->done, wait);
+
+       if (vb->state == STATE_DONE || vb->state == STATE_ERROR)
+               return POLLIN | POLLRDNORM;
+
+       return 0;
+}
+
+static int
+omap24xxcam_mmap_buffers(struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	struct videobuf_queue *vbq = &fh->vbq;
+	struct videobuf_buffer *vb;
+	unsigned int first, last, size, i, j;
+	int err = 0;
+
+	mutex_lock(&cam->mutex);
+	if (cam->streaming) {
+		mutex_unlock(&cam->mutex);
+		return -EBUSY;
+	}
+	mutex_unlock(&cam->mutex);
+	mutex_lock(&vbq->lock);
+
+	/* look for first buffer to map */
+	for (first = 0; first < VIDEO_MAX_FRAME; first++) {
+		if (NULL == vbq->bufs[first])
+			continue;
+		if (V4L2_MEMORY_MMAP != vbq->bufs[first]->memory)
+			continue;
+		if (vbq->bufs[first]->boff == (vma->vm_pgoff << PAGE_SHIFT))
+			break;
+	}
+
+	/* look for last buffer to map */
+	for (size = 0, last = first; last < VIDEO_MAX_FRAME; last++) {
+		if (NULL == vbq->bufs[last])
+			continue;
+		if (V4L2_MEMORY_MMAP != vbq->bufs[last]->memory)
+			continue;
+		size += vbq->bufs[last]->bsize;
+		if (size == (vma->vm_end - vma->vm_start))
+			break;
+	}
+
+	size = 0;
+	for (i = first; i <= last; i++) {
+		vb = vbq->bufs[i];
+		for (j = 0; j < vb->dma.sglen; j++) {
+			err = remap_pfn_range(vma, vma->vm_start + size,
+				page_to_pfn(vb->dma.sglist[j].page),
+				vb->dma.sglist[j].length, vma->vm_page_prot);
+			if (err)
+				goto out;
+			size += vb->dma.sglist[j].length;
+		}
+	}
+
+out:
+	mutex_unlock(&vbq->lock);
+
+	return err;
+}
+
+static int omap24xxcam_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	int rval;
+
+	/* let the video-buf mapper check arguments and set-up structures */
+	rval = videobuf_mmap_mapper(&fh->vbq, vma);
+	if (rval)
+		return rval;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	/* do mapping to our allocated buffers */
+	rval = omap24xxcam_mmap_buffers(file, vma);
+	/* In case of error, free vma->vm_private_data allocated by
+	 * videobuf_mmap_mapper. */
+	if (rval)
+		kfree(vma->vm_private_data);
+	
+	return rval;
+}
+
+static int omap24xxcam_open(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	struct omap24xxcam_device *cam = omap24xxcam.priv;
+	struct omap24xxcam_fh *fh;
+
+	if (!cam || !cam->vfd || (cam->vfd->minor != minor))
+		return -ENODEV;
+
+	if (!try_module_get(cam->sensor->module))
+		return -ENODEV;
+	
+	fh = kzalloc(sizeof(*fh), GFP_KERNEL);
+	
+	if (fh == NULL)
+		return -ENOMEM;
+
+	fh->cam = cam;
+	file->private_data = fh;
+
+	spin_lock_init(&fh->vbq_lock);
+	spin_lock_init(&fh->pix_lock);
+
+	videobuf_queue_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
+			    &fh->vbq_lock, V4L2_BUF_TYPE_VIDEO_CAPTURE,
+			    V4L2_FIELD_NONE,
+			    sizeof(struct videobuf_buffer), fh);
+	
+	mutex_lock(&cam->mutex);
+	if (cam->users == 0) {
+		omap24xxcam_hwinit(cam);
+		omap24xxcam_sensor_enable(cam);
+
+	}
+	cam->users++;
+	mutex_unlock(&cam->mutex);
+
+	return 0;
+}
+
+static int omap24xxcam_release(struct inode *inode, struct file *file)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+
+	mutex_lock(&cam->mutex);
+	/* stop streaming capture */
+	if (cam->streaming == file) {
+		cam->streaming = NULL;
+		mutex_unlock(&cam->mutex);
+		videobuf_streamoff(&fh->vbq);
+	} else {
+		mutex_unlock(&cam->mutex);
+	}
+
+	omap24xxcam_vbq_free_mmap_buffers(&fh->vbq);
+	
+	/* Make sure the reset work we might have scheduled is not
+	 * pending! It may be run *only* if we have users. (And it may
+	 * not be scheduled anymore since streaming is already
+	 * disabled.)
+	 */
+	flush_scheduled_work();
+	
+	mutex_lock(&cam->mutex);
+	if (--cam->users == 0) {
+		/* power down the sensor */
+		omap24xxcam_sensor_disable(cam);
+		omap24xxcam_reset(cam);
+	}
+	mutex_unlock(&cam->mutex);
+
+	file->private_data = NULL;
+
+	module_put(cam->sensor->module);
+	kfree(fh);
+
+	return 0;
+}
+
+static struct file_operations omap24xxcam_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.ioctl = video_ioctl2,
+	.poll = omap24xxcam_poll,
+	.mmap = omap24xxcam_mmap,
+	.open = omap24xxcam_open,
+	.release = omap24xxcam_release,
+};
+
+/*
+ *
+ * Clocks.
+ *
+ */
+
+static int omap24xxcam_clock_get(struct omap24xxcam_device *cam)
+{
+	cam->fck = clk_get(cam->dev, "cam_fck");
+	if (IS_ERR((cam->fck))) {
+		dev_err(cam->dev, "can't get cam_fck");
+		return PTR_ERR(cam->fck);
+	}
+
+	cam->ick = clk_get(cam->dev, "cam_ick");
+	if (IS_ERR((cam->ick))) {
+		dev_err(cam->dev, "can't get cam_ick");
+		clk_put(cam->fck);
+		return PTR_ERR(cam->ick);
+	}
+
+	return 0;
+}
+
+static void omap24xxcam_clock_put(struct omap24xxcam_device *cam)
+{
+	/*
+	 * Either getting the clocks failed or they're NULL since we
+	 * didn't get that far to begin with.
+	 */
+	if (IS_ERR(cam->ick) || cam->ick == NULL)
+		return;
+
+	clk_put(cam->ick);
+	clk_put(cam->fck);
+}
+
+void omap24xxcam_clock_on(struct omap24xxcam_device *cam)
+{
+	clk_enable(cam->fck);
+	clk_enable(cam->ick);
+}
+
+void omap24xxcam_clock_off(struct omap24xxcam_device *cam)
+{
+	clk_disable(cam->fck);
+	clk_disable(cam->ick);
+}
+
+/*
+ *
+ * Power management.
+ *
+ */
+
+#ifdef CONFIG_PM
+static int omap24xxcam_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+
+	mutex_lock(&cam->mutex);
+	if (cam->users == 0) {
+		mutex_unlock(&cam->mutex);
+		return 0;
+	}
+
+	if (cam->streaming) {
+		omap24xxcam_core_disable(cam);
+		omap24xxcam_sgdma_sync(&cam->sgdma);
+	}
+	
+	omap24xxcam_sensor_disable(cam);
+	omap24xxcam_reset(cam);
+
+	mutex_unlock(&cam->mutex);
+
+	return 0;
+}
+
+static int omap24xxcam_resume(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+	unsigned long flags;
+
+	mutex_lock(&cam->mutex);
+	if (cam->users == 0) {
+		mutex_unlock(&cam->mutex);
+		return 0;
+	}
+
+	/* power-up and re-configure the sensor */
+	omap24xxcam_hwinit(cam);
+	omap24xxcam_sensor_enable(cam);
+
+	if (cam->streaming) {
+		struct omap24xxcam_fh *fh = cam->streaming->private_data;
+		omap24xxcam_sgdma_process(&cam->sgdma);
+		spin_lock_irqsave(&fh->vbq_lock, flags);
+		if (fh->sgdma_in_queue)
+			omap24xxcam_core_enable(fh->cam);
+		spin_unlock_irqrestore(&fh->vbq_lock, flags);
+	}
+
+	mutex_unlock(&cam->mutex);
+
+	/* camera interface will be enabled through dma_notify function
+	 ** automatically when new dma starts 
+	 */
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+/*
+ *
+ * Camera device (i.e. /dev/video).
+ *
+ */
+
+int omap24xxcam_device_enable(struct omap24xxcam_device *cam)
+{
+	struct video_device *vfd;
+	int rval;
+
+	/* initialize the video_device struct */
+	vfd = cam->vfd = video_device_alloc();
+	if (!vfd) {
+		printk(KERN_ERR 
+		       "%s: could not allocate video device struct\n",
+			__FUNCTION__);
+		rval = -ENOMEM;
+		goto err;
+	}
+	vfd->release = video_device_release;
+
+	strlcpy(vfd->name, CAM_NAME, sizeof(vfd->name));
+	vfd->type = VID_TYPE_CAPTURE | VID_TYPE_CHROMAKEY;
+	/* need to register for a VID_HARDWARE_* ID in videodev.h */
+	vfd->hardware = 0;
+	vfd->fops = &omap24xxcam_fops;
+	/* FIXME: need to use the full v4l2 API */
+	vfd->priv = cam;
+	vfd->minor = -1;
+
+	vfd->vidioc_querycap = &vidioc_querycap;
+	vfd->vidioc_enum_input = &vidioc_enum_input;
+	vfd->vidioc_g_input = &vidioc_g_input;
+	vfd->vidioc_s_input = &vidioc_s_input;
+	vfd->vidioc_g_fmt_cap = &vidioc_g_fmt_cap;
+	vfd->vidioc_try_fmt_cap = &vidioc_try_fmt_cap;
+	vfd->vidioc_s_fmt_cap = &vidioc_s_fmt_cap;
+	vfd->vidioc_g_parm = &vidioc_g_parm;
+	vfd->vidioc_s_parm = &vidioc_s_parm;
+	vfd->vidioc_reqbufs = &vidioc_reqbufs;
+	vfd->vidioc_querybuf = &vidioc_querybuf;
+	vfd->vidioc_qbuf = &vidioc_qbuf;
+	vfd->vidioc_dqbuf = &vidioc_dqbuf;
+	vfd->vidioc_streamon = &vidioc_streamon;
+	vfd->vidioc_streamoff = &vidioc_streamoff;
+	vfd->vidioc_g_ctrl = &vidioc_g_ctrl;
+	vfd->vidioc_s_ctrl = &vidioc_s_ctrl;
+	vfd->vidioc_queryctrl = &vidioc_queryctrl;
+	vfd->vidioc_enum_fmt_cap = &vidioc_enum_fmt_cap;
+
+	if ((rval = omap24xxcam_sensor_init(cam)))
+		goto err;
+
+	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
+		printk(KERN_ERR
+		       "%s: could not register Video for Linux device\n",
+			__FUNCTION__);
+		vfd->minor = -1;
+		rval = -EBUSY;
+		goto err;
+	}
+
+	omap24xxcam_reset(cam);
+
+	printk(KERN_INFO "%s: registered device video%d [v4l2]\n",
+	       __FUNCTION__, vfd->minor);
+
+	return 0;
+	
+err:
+	omap24xxcam_device_disable(cam);
+
+	return rval;
+}
+
+void omap24xxcam_device_disable(struct omap24xxcam_device *cam)
+{
+	omap24xxcam_sensor_exit(cam);
+	
+	if (cam->vfd) {
+		if (cam->vfd->minor == -1) {
+			/* The device was never registered, so release the 
+			 * video_device struct directly.
+			 */
+			video_device_release(cam->vfd);
+		} else {
+			/* The unregister function will release the video_device
+			 * struct as well as unregistering it.
+			 */
+			video_unregister_device(cam->vfd);
+		}
+		cam->vfd = NULL;
+	}
+}
+
+/*
+ *
+ * Driver initialisation and deinitialisation.
+ *
+ */
+
+static int omap24xxcam_remove(struct platform_device *pdev);
+
+static int omap24xxcam_probe(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam;
+	struct resource *mem;
+	int irq;
+
+	cam = omap24xxcam.priv = kzalloc(sizeof(*cam), GFP_KERNEL);
+	if (!cam) {
+		printk(KERN_ERR "%s: could not allocate memory\n",
+		       __FUNCTION__);
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, cam);
+
+	cam->dev = &pdev->dev;
+
+	/* Impose a lower limit on the amount of memory allocated for capture.
+	 * We require at least enough memory to double-buffer QVGA (300KB).
+	 */
+	if (capture_mem < 320 * 240 * 2 * 2)
+		capture_mem = 320 * 240 * 2 * 2;
+	cam->capture_mem = capture_mem;
+
+	/* request the mem region for the camera registers */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		printk(KERN_ERR "%s: no mem resource?\n", __FUNCTION__);
+		goto err;
+	}
+	if (!request_mem_region(mem->start, (mem->end - mem->start) + 1,
+				pdev->name)) {
+		printk(KERN_ERR
+		       "%s: cannot reserve camera register I/O region\n",
+			__FUNCTION__);
+		goto err;
+	}
+	cam->mmio_base_phys = mem->start;
+	cam->mmio_size = (mem->end - mem->start) + 1;
+
+	/* map the region */
+	cam->mmio_base = (unsigned long)
+		ioremap_nocache(cam->mmio_base_phys, cam->mmio_size);
+	if (!cam->mmio_base) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot map camera register I/O region\n");
+		goto err;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		printk(KERN_ERR "%s: no irq for camera?\n", __FUNCTION__);
+		goto err;
+	}
+
+	/* install the interrupt service routine */
+	if (request_irq(irq, omap24xxcam_isr, 0, CAM_NAME, cam)) {
+		printk(KERN_ERR 
+		       "%s: could not install interrupt service routine\n",
+			__FUNCTION__);
+		goto err;
+	}
+	cam->irq = irq;
+
+	if (omap24xxcam_clock_get(cam))
+		goto err;
+
+	INIT_WORK(&cam->camera_reset_work, omap24xxcam_camera_reset_work);
+	INIT_WORK(&cam->sensor_reset_work, omap24xxcam_sensor_reset_work);
+
+	/* initialize the streaming capture parameters */
+	cam->cparm.readbuffers = 1;
+	cam->cparm.capability = V4L2_CAP_TIMEPERFRAME;
+
+	/* select an arbitrary default capture frame rate of 5fps */
+	cam->cparm.timeperframe.numerator = 1;
+	cam->cparm.timeperframe.denominator = 15;
+
+	mutex_init(&cam->mutex);
+
+	omap24xxcam_sgdma_init(&cam->sgdma,
+			       cam->mmio_base + CAMDMA_REG_OFFSET,
+			       &omap24xxcam_stalled_dma_reset,
+			       (unsigned long)cam);
+
+ 	/* initialize the camera block (base system, core, mmu) */
+	omap24xxcam_hwinit(cam);
+
+	cam->camera_block_alive = 1;
+
+	return 0;
+
+err:
+	omap24xxcam_remove(pdev);
+	return -ENODEV;
+}
+
+static int omap24xxcam_remove(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+	
+	if (!cam)
+		return 0;
+
+	omap24xxcam_device_disable(cam);
+	omap24xxcam_clock_put(cam);
+
+	if (cam->irq) {
+		free_irq(cam->irq, cam);
+		cam->irq = 0;
+	}
+
+	if (cam->mmio_base) {
+		iounmap((void *)cam->mmio_base);
+		cam->mmio_base = 0;
+	}
+
+	if (cam->mmio_base_phys) {
+		release_mem_region(cam->mmio_base_phys, cam->mmio_size);
+		cam->mmio_base_phys = 0;
+	}
+
+	kfree(cam);
+	omap24xxcam.priv = NULL;
+
+	return 0;
+}
+
+static struct platform_driver omap24xxcam_driver = {
+	.probe = omap24xxcam_probe,
+	.remove = omap24xxcam_remove,
+#ifdef CONFIG_PM
+	.suspend = omap24xxcam_suspend,
+	.resume = omap24xxcam_resume,
+#endif
+	.driver = {
+		.name = CAM_NAME,
+	},
+};
+
+/*
+ *
+ * Module initialisation and deinitialisation
+ *
+ */
+
+int __init omap24xxcam_init(void)
+{
+	return platform_driver_register(&omap24xxcam_driver);
+}
+
+void __exit omap24xxcam_cleanup(void)
+{
+	platform_driver_unregister(&omap24xxcam_driver);
+}
+
+MODULE_AUTHOR("MontaVista Software, Inc.");
+MODULE_DESCRIPTION("OMAP24xx Video for Linux camera driver");
+MODULE_LICENSE("GPL");
+module_param(video_nr, int, 0);
+MODULE_PARM_DESC(video_nr,
+		 "Minor number for video device (-1 ==> auto assign)");
+module_param(capture_mem, int, 0);
+MODULE_PARM_DESC(capture_mem,
+		 "Maximum amount of memory for capture buffers (default 4800KB)");
+
+module_init(omap24xxcam_init);
+module_exit(omap24xxcam_cleanup);
diff --git a/drivers/media/video/omap/omap24xxcam.h b/drivers/media/video/omap/omap24xxcam.h
new file mode 100644
index 0000000..a550878
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.h
@@ -0,0 +1,635 @@
+/*
+ * omap24xxcam.c
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on code from Andy Lowe <source@mvista.com>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#ifndef OMAP24XXCAM_H
+#define OMAP24XXCAM_H
+
+#include <media/video-buf.h>
+
+#include "sensor_if.h"
+
+/*
+ *
+ * General driver related definitions.
+ *
+ */
+
+#define CAM_NAME		"omap24xxcam"
+
+#define CAM_MCLK		96000000
+
+/* number of bytes transferred per DMA request */
+#define DMA_THRESHOLD		32
+
+/* NUM_CAMDMA_CHANNELS is the number of logical channels provided by
+ * the camera DMA controller.
+ */
+#define NUM_CAMDMA_CHANNELS	4
+
+/* NUM_SG_DMA is the number of scatter-gather DMA transfers that can
+ * be queued. We need it to be 2 greater than the maximum number of
+ * video frames so that we can use 2 slots for overlay while still
+ * having VIDEO_MAX_FRAME slots left for streaming.
+ */
+#define NUM_SG_DMA		(VIDEO_MAX_FRAME+2)
+
+/*
+ *
+ * Register definitions.
+ *
+ */
+
+/* subsystem register block offsets */
+#define CC_REG_OFFSET		0x00000400
+#define CAMDMA_REG_OFFSET	0x00000800
+#define CAMMMU_REG_OFFSET	0x00000C00
+
+/* define camera subsystem register offsets */
+#define CAM_REVISION			0x000
+#define CAM_SYSCONFIG			0x010
+#define CAM_SYSSTATUS			0x014
+#define CAM_IRQSTATUS			0x018
+#define CAM_GPO				0x040
+#define CAM_GPI				0x050
+
+/* define camera core register offsets */
+#define CC_REVISION			0x000
+#define CC_SYSCONFIG			0x010
+#define CC_SYSSTATUS			0x014
+#define CC_IRQSTATUS			0x018
+#define CC_IRQENABLE			0x01C
+#define CC_CTRL				0x040
+#define CC_CTRL_DMA			0x044
+#define CC_CTRL_XCLK			0x048
+#define CC_FIFODATA			0x04C
+#define CC_TEST				0x050
+#define CC_GENPAR			0x054
+#define CC_CCPFSCR			0x058
+#define CC_CCPFECR			0x05C
+#define CC_CCPLSCR			0x060
+#define CC_CCPLECR			0x064
+#define CC_CCPDFR			0x068
+
+/* define camera dma register offsets */
+#define CAMDMA_REVISION			0x000
+#define CAMDMA_IRQSTATUS_L0		0x008
+#define CAMDMA_IRQSTATUS_L1		0x00C
+#define CAMDMA_IRQSTATUS_L2		0x010
+#define CAMDMA_IRQSTATUS_L3		0x014
+#define CAMDMA_IRQENABLE_L0		0x018
+#define CAMDMA_IRQENABLE_L1		0x01C
+#define CAMDMA_IRQENABLE_L2		0x020
+#define CAMDMA_IRQENABLE_L3		0x024
+#define CAMDMA_SYSSTATUS		0x028
+#define CAMDMA_OCP_SYSCONFIG		0x02C
+#define CAMDMA_CAPS_0			0x064
+#define CAMDMA_CAPS_2			0x06C
+#define CAMDMA_CAPS_3			0x070
+#define CAMDMA_CAPS_4			0x074
+#define CAMDMA_GCR			0x078
+#define CAMDMA_CCR(n)			(0x080 + (n)*0x60)
+#define CAMDMA_CLNK_CTRL(n)		(0x084 + (n)*0x60)
+#define CAMDMA_CICR(n)			(0x088 + (n)*0x60)
+#define CAMDMA_CSR(n)			(0x08C + (n)*0x60)
+#define CAMDMA_CSDP(n)			(0x090 + (n)*0x60)
+#define CAMDMA_CEN(n)			(0x094 + (n)*0x60)
+#define CAMDMA_CFN(n)			(0x098 + (n)*0x60)
+#define CAMDMA_CSSA(n)			(0x09C + (n)*0x60)
+#define CAMDMA_CDSA(n)			(0x0A0 + (n)*0x60)
+#define CAMDMA_CSEI(n)			(0x0A4 + (n)*0x60)
+#define CAMDMA_CSFI(n)			(0x0A8 + (n)*0x60)
+#define CAMDMA_CDEI(n)			(0x0AC + (n)*0x60)
+#define CAMDMA_CDFI(n)			(0x0B0 + (n)*0x60)
+#define CAMDMA_CSAC(n)			(0x0B4 + (n)*0x60)
+#define CAMDMA_CDAC(n)			(0x0B8 + (n)*0x60)
+#define CAMDMA_CCEN(n)			(0x0BC + (n)*0x60)
+#define CAMDMA_CCFN(n)			(0x0C0 + (n)*0x60)
+#define CAMDMA_COLOR(n)			(0x0C4 + (n)*0x60)
+
+/* define camera mmu register offsets */
+#define CAMMMU_REVISION			0x000
+#define CAMMMU_SYSCONFIG		0x010
+#define CAMMMU_SYSSTATUS		0x014
+#define CAMMMU_IRQSTATUS		0x018
+#define CAMMMU_IRQENABLE		0x01C
+#define CAMMMU_WALKING_ST		0x040
+#define CAMMMU_CNTL			0x044
+#define CAMMMU_FAULT_AD			0x048
+#define CAMMMU_TTB			0x04C
+#define CAMMMU_LOCK			0x050
+#define CAMMMU_LD_TLB			0x054
+#define CAMMMU_CAM			0x058
+#define CAMMMU_RAM			0x05C
+#define CAMMMU_GFLUSH			0x060
+#define CAMMMU_FLUSH_ENTRY		0x064
+#define CAMMMU_READ_CAM			0x068
+#define CAMMMU_READ_RAM			0x06C
+#define CAMMMU_EMU_FAULT_AD		0x070
+
+/* Define bit fields within selected registers */
+#define CAM_REVISION_MAJOR				(15 << 4)
+#define CAM_REVISION_MAJOR_SHIFT			4
+#define CAM_REVISION_MINOR				(15 << 0)
+#define CAM_REVISION_MINOR_SHIFT			0
+
+#define CAM_SYSCONFIG_SOFTRESET				(1 <<  1)
+#define CAM_SYSCONFIG_AUTOIDLE				(1 <<  0)
+
+#define CAM_SYSSTATUS_RESETDONE				(1 <<  0)
+
+#define CAM_IRQSTATUS_CC_IRQ				(1 <<  4)
+#define CAM_IRQSTATUS_MMU_IRQ				(1 <<  3)
+#define CAM_IRQSTATUS_DMA_IRQ2				(1 <<  2)
+#define CAM_IRQSTATUS_DMA_IRQ1				(1 <<  1)
+#define CAM_IRQSTATUS_DMA_IRQ0				(1 <<  0)
+
+#define CAM_GPO_CAM_S_P_EN				(1 <<  1)
+#define CAM_GPO_CAM_CCP_MODE				(1 <<  0)
+
+#define CAM_GPI_CC_DMA_REQ1				(1 << 24)
+#define CAP_GPI_CC_DMA_REQ0				(1 << 23)
+#define CAP_GPI_CAM_MSTANDBY				(1 << 21)
+#define CAP_GPI_CAM_WAIT				(1 << 20)
+#define CAP_GPI_CAM_S_DATA				(1 << 17)
+#define CAP_GPI_CAM_S_CLK				(1 << 16)
+#define CAP_GPI_CAM_P_DATA				(0xFFF << 3)
+#define CAP_GPI_CAM_P_DATA_SHIFT			3
+#define CAP_GPI_CAM_P_VS				(1 <<  2)
+#define CAP_GPI_CAM_P_HS				(1 <<  1)
+#define CAP_GPI_CAM_P_CLK				(1 <<  0)
+
+#define CC_REVISION_MAJOR				(15 << 4)
+#define CC_REVISION_MAJOR_SHIFT				4
+#define CC_REVISION_MINOR				(15 << 0)
+#define CC_REVISION_MINOR_SHIFT				0
+
+#define CC_SYSCONFIG_SIDLEMODE				(3 <<  3)
+#define CC_SYSCONFIG_SIDLEMODE_FIDLE			(0 <<  3)
+#define CC_SYSCONFIG_SIDLEMODE_NIDLE			(1 <<  3)
+#define CC_SYSCONFIG_SOFTRESET				(1 <<  1)
+#define CC_SYSCONFIG_AUTOIDLE				(1 <<  0)
+
+#define CC_SYSSTATUS_RESETDONE				(1 <<  0)
+
+#define CC_IRQSTATUS_FS_IRQ				(1 << 19)
+#define CC_IRQSTATUS_LE_IRQ				(1 << 18)
+#define CC_IRQSTATUS_LS_IRQ				(1 << 17)
+#define CC_IRQSTATUS_FE_IRQ				(1 << 16)
+#define CC_IRQSTATUS_FW_ERR_IRQ				(1 << 10)
+#define CC_IRQSTATUS_FSC_ERR_IRQ			(1 <<  9)
+#define CC_IRQSTATUS_SSC_ERR_IRQ			(1 <<  8)
+#define CC_IRQSTATUS_FIFO_NOEMPTY_IRQ			(1 <<  4)
+#define CC_IRQSTATUS_FIFO_FULL_IRQ			(1 <<  3)
+#define CC_IRQSTATUS_FIFO_THR_IRQ			(1 <<  2)
+#define CC_IRQSTATUS_FIFO_OF_IRQ			(1 <<  1)
+#define CC_IRQSTATUS_FIFO_UF_IRQ			(1 <<  0)
+
+#define CC_IRQENABLE_FS_IRQ				(1 << 19)
+#define CC_IRQENABLE_LE_IRQ				(1 << 18)
+#define CC_IRQENABLE_LS_IRQ				(1 << 17)
+#define CC_IRQENABLE_FE_IRQ				(1 << 16)
+#define CC_IRQENABLE_FW_ERR_IRQ				(1 << 10)
+#define CC_IRQENABLE_FSC_ERR_IRQ			(1 <<  9)
+#define CC_IRQENABLE_SSC_ERR_IRQ			(1 <<  8)
+#define CC_IRQENABLE_FIFO_NOEMPTY_IRQ			(1 <<  4)
+#define CC_IRQENABLE_FIFO_FULL_IRQ			(1 <<  3)
+#define CC_IRQENABLE_FIFO_THR_IRQ			(1 <<  2)
+#define CC_IRQENABLE_FIFO_OF_IRQ			(1 <<  1)
+#define CC_IRQENABLE_FIFO_UF_IRQ			(1 <<  0)
+
+#define CC_CTRL_CC_ONE_SHOT				(1 << 20)
+#define CC_CTRL_CC_IF_SYNCHRO				(1 << 19)
+#define CC_CTRL_CC_RST					(1 << 18)
+#define CC_CTRL_CC_FRAME_TRIG				(1 << 17)
+#define CC_CTRL_CC_EN					(1 << 16)
+#define CC_CTRL_NOBT_SYNCHRO				(1 << 13)
+#define CC_CTRL_BT_CORRECT				(1 << 12)
+#define CC_CTRL_PAR_ORDERCAM				(1 << 11)
+#define CC_CTRL_PAR_CLK_POL				(1 << 10)
+#define CC_CTRL_NOBT_HS_POL				(1 <<  9)
+#define CC_CTRL_NOBT_VS_POL				(1 <<  8)
+#define CC_CTRL_PAR_MODE				(7 <<  1)
+#define CC_CTRL_PAR_MODE_SHIFT				1
+#define CC_CTRL_PAR_MODE_NOBT8				(0 <<  1)
+#define CC_CTRL_PAR_MODE_NOBT10				(1 <<  1)
+#define CC_CTRL_PAR_MODE_NOBT12				(2 <<  1)
+#define CC_CTRL_PAR_MODE_BT8				(4 <<  1)
+#define CC_CTRL_PAR_MODE_BT10				(5 <<  1)
+#define CC_CTRL_PAR_MODE_FIFOTEST			(7 <<  1)
+#define CC_CTRL_CCP_MODE				(1 <<  0)
+
+#define CC_CTRL_DMA_EN					(1 <<  8)
+#define CC_CTRL_DMA_FIFO_THRESHOLD			(0x7F << 0)
+#define CC_CTRL_DMA_FIFO_THRESHOLD_SHIFT		0
+
+#define CC_CTRL_XCLK_DIV				(0x1F << 0)
+#define CC_CTRL_XCLK_DIV_SHIFT				0
+#define CC_CTRL_XCLK_DIV_STABLE_LOW			(0 <<  0)
+#define CC_CTRL_XCLK_DIV_STABLE_HIGH			(1 <<  0)
+#define CC_CTRL_XCLK_DIV_BYPASS				(31 << 0)
+
+#define CC_TEST_FIFO_RD_POINTER				(0xFF << 24)
+#define CC_TEST_FIFO_RD_POINTER_SHIFT			24
+#define CC_TEST_FIFO_WR_POINTER				(0xFF << 16)
+#define CC_TEST_FIFO_WR_POINTER_SHIFT			16
+#define CC_TEST_FIFO_LEVEL				(0xFF <<  8)
+#define CC_TEST_FIFO_LEVEL_SHIFT			8
+#define CC_TEST_FIFO_LEVEL_PEAK				(0xFF <<  0)
+#define CC_TEST_FIFO_LEVEL_PEAK_SHIFT			0
+
+#define CC_GENPAR_FIFO_DEPTH				(7 <<  0)
+#define CC_GENPAR_FIFO_DEPTH_SHIFT			0
+
+#define CC_CCPDFR_ALPHA					(0xFF <<  8)
+#define CC_CCPDFR_ALPHA_SHIFT				8
+#define CC_CCPDFR_DATAFORMAT				(15 <<  0)
+#define CC_CCPDFR_DATAFORMAT_SHIFT			0
+#define CC_CCPDFR_DATAFORMAT_YUV422BE			( 0 <<  0)
+#define CC_CCPDFR_DATAFORMAT_YUV422			( 1 <<  0)
+#define CC_CCPDFR_DATAFORMAT_YUV420			( 2 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB444			( 4 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB565			( 5 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB888NDE			( 6 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB888			( 7 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW8NDE			( 8 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW8			( 9 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW10NDE			(10 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW10			(11 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW12NDE			(12 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW12			(13 <<  0)
+#define CC_CCPDFR_DATAFORMAT_JPEG8			(15 <<  0)
+
+#define CAMDMA_REVISION_MAJOR				(15 << 4)
+#define CAMDMA_REVISION_MAJOR_SHIFT			4
+#define CAMDMA_REVISION_MINOR				(15 << 0)
+#define CAMDMA_REVISION_MINOR_SHIFT			0
+
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE			(3 << 12)
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE_FSTANDBY		(0 << 12)
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE_NSTANDBY		(1 << 12)
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE_SSTANDBY		(2 << 12)
+#define CAMDMA_OCP_SYSCONFIG_FUNC_CLOCK			(1 <<  9)
+#define CAMDMA_OCP_SYSCONFIG_OCP_CLOCK			(1 <<  8)
+#define CAMDMA_OCP_SYSCONFIG_EMUFREE			(1 <<  5)
+#define CAMDMA_OCP_SYSCONFIG_SIDLEMODE			(3 <<  3)
+#define CAMDMA_OCP_SYSCONFIG_SIDLEMODE_FIDLE		(0 <<  3)
+#define CAMDMA_OCP_SYSCONFIG_SIDLEMODE_NIDLE		(1 <<  3)
+#define CAMDMA_OCP_SYSCONFIG_SIDLEMODE_SIDLE		(2 <<  3)
+#define CAMDMA_OCP_SYSCONFIG_SOFTRESET			(1 <<  1)
+#define CAMDMA_OCP_SYSCONFIG_AUTOIDLE			(1 <<  0)
+
+#define CAMDMA_SYSSTATUS_RESETDONE			(1 <<  0)
+
+#define CAMDMA_GCR_ARBITRATION_RATE			(0xFF << 16)
+#define CAMDMA_GCR_ARBITRATION_RATE_SHIFT		16
+#define CAMDMA_GCR_MAX_CHANNEL_FIFO_DEPTH		(0xFF << 0)
+#define CAMDMA_GCR_MAX_CHANNEL_FIFO_DEPTH_SHIFT		0
+
+#define CAMDMA_CCR_SEL_SRC_DST_SYNC			(1 << 24)
+#define CAMDMA_CCR_PREFETCH				(1 << 23)
+#define CAMDMA_CCR_SUPERVISOR				(1 << 22)
+#define CAMDMA_CCR_SECURE				(1 << 21)
+#define CAMDMA_CCR_BS					(1 << 18)
+#define CAMDMA_CCR_TRANSPARENT_COPY_ENABLE		(1 << 17)
+#define CAMDMA_CCR_CONSTANT_FILL_ENABLE			(1 << 16)
+#define CAMDMA_CCR_DST_AMODE				(3 << 14)
+#define CAMDMA_CCR_DST_AMODE_CONST_ADDR			(0 << 14)
+#define CAMDMA_CCR_DST_AMODE_POST_INC			(1 << 14)
+#define CAMDMA_CCR_DST_AMODE_SGL_IDX			(2 << 14)
+#define CAMDMA_CCR_DST_AMODE_DBL_IDX			(3 << 14)
+#define CAMDMA_CCR_SRC_AMODE				(3 << 12)
+#define CAMDMA_CCR_SRC_AMODE_CONST_ADDR			(0 << 12)
+#define CAMDMA_CCR_SRC_AMODE_POST_INC			(1 << 12)
+#define CAMDMA_CCR_SRC_AMODE_SGL_IDX			(2 << 12)
+#define CAMDMA_CCR_SRC_AMODE_DBL_IDX			(3 << 12)
+#define CAMDMA_CCR_WR_ACTIVE				(1 << 10)
+#define CAMDMA_CCR_RD_ACTIVE				(1 <<  9)
+#define CAMDMA_CCR_SUSPEND_SENSITIVE			(1 <<  8)
+#define CAMDMA_CCR_ENABLE				(1 <<  7)
+#define CAMDMA_CCR_PRIO					(1 <<  6)
+#define CAMDMA_CCR_FS					(1 <<  5)
+#define CAMDMA_CCR_SYNCHRO				((3 << 19) | (31 << 0))
+#define CAMDMA_CCR_SYNCHRO_CAMERA			0x01
+
+#define CAMDMA_CLNK_CTRL_ENABLE_LNK			(1 << 15)
+#define CAMDMA_CLNK_CTRL_NEXTLCH_ID			(0x1F << 0)
+#define CAMDMA_CLNK_CTRL_NEXTLCH_ID_SHIFT		0
+
+#define CAMDMA_CICR_MISALIGNED_ERR_IE			(1 << 11)
+#define CAMDMA_CICR_SUPERVISOR_ERR_IE			(1 << 10)
+#define CAMDMA_CICR_SECURE_ERR_IE			(1 <<  9)
+#define CAMDMA_CICR_TRANS_ERR_IE			(1 <<  8)
+#define CAMDMA_CICR_PACKET_IE				(1 <<  7)
+#define CAMDMA_CICR_BLOCK_IE				(1 <<  5)
+#define CAMDMA_CICR_LAST_IE				(1 <<  4)
+#define CAMDMA_CICR_FRAME_IE				(1 <<  3)
+#define CAMDMA_CICR_HALF_IE				(1 <<  2)
+#define CAMDMA_CICR_DROP_IE				(1 <<  1)
+
+#define CAMDMA_CSR_MISALIGNED_ERR			(1 << 11)
+#define CAMDMA_CSR_SUPERVISOR_ERR			(1 << 10)
+#define CAMDMA_CSR_SECURE_ERR				(1 <<  9)
+#define CAMDMA_CSR_TRANS_ERR				(1 <<  8)
+#define CAMDMA_CSR_PACKET				(1 <<  7)
+#define CAMDMA_CSR_SYNC					(1 <<  6)
+#define CAMDMA_CSR_BLOCK				(1 <<  5)
+#define CAMDMA_CSR_LAST					(1 <<  4)
+#define CAMDMA_CSR_FRAME				(1 <<  3)
+#define CAMDMA_CSR_HALF					(1 <<  2)
+#define CAMDMA_CSR_DROP					(1 <<  1)
+
+#define CAMDMA_CSDP_SRC_ENDIANNESS			(1 << 21)
+#define CAMDMA_CSDP_SRC_ENDIANNESS_LOCK			(1 << 20)
+#define CAMDMA_CSDP_DST_ENDIANNESS			(1 << 19)
+#define CAMDMA_CSDP_DST_ENDIANNESS_LOCK			(1 << 18)
+#define CAMDMA_CSDP_WRITE_MODE				(3 << 16)
+#define CAMDMA_CSDP_WRITE_MODE_WRNP			(0 << 16)
+#define CAMDMA_CSDP_WRITE_MODE_POSTED			(1 << 16)
+#define CAMDMA_CSDP_WRITE_MODE_POSTED_LAST_WRNP		(2 << 16)
+#define CAMDMA_CSDP_DST_BURST_EN			(3 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_1			(0 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_16			(1 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_32			(2 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_64			(3 << 14)
+#define CAMDMA_CSDP_DST_PACKED				(1 << 13)
+#define CAMDMA_CSDP_WR_ADD_TRSLT			(15 << 9)
+#define CAMDMA_CSDP_WR_ADD_TRSLT_ENABLE_MREQADD		(3 <<  9)
+#define CAMDMA_CSDP_SRC_BURST_EN			(3 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_1			(0 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_16			(1 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_32			(2 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_64			(3 <<  7)
+#define CAMDMA_CSDP_SRC_PACKED				(1 <<  6)
+#define CAMDMA_CSDP_RD_ADD_TRSLT			(15 << 2)
+#define CAMDMA_CSDP_RD_ADD_TRSLT_ENABLE_MREQADD		(3 <<  2)
+#define CAMDMA_CSDP_DATA_TYPE				(3 <<  0)
+#define CAMDMA_CSDP_DATA_TYPE_8BITS			(0 <<  0)
+#define CAMDMA_CSDP_DATA_TYPE_16BITS			(1 <<  0)
+#define CAMDMA_CSDP_DATA_TYPE_32BITS			(2 <<  0)
+
+#define CAMMMU_SYSCONFIG_AUTOIDLE			(1 <<  0)
+
+/*
+ *
+ * Declarations.
+ *
+ */
+
+/* forward declarations */
+struct omap24xxcam_fh;
+struct omap24xxcam_device;
+struct omap24xxcam_sgdma;
+struct omap24xxcam_dma;
+
+extern struct omap_camera omap24xxcam;
+extern struct videobuf_queue_ops omap24xxcam_vbq_ops;
+
+typedef void (*sgdma_callback_t)(struct omap24xxcam_sgdma * cam,
+				 unsigned long status, void *arg);
+typedef void (*dma_callback_t)(struct omap24xxcam_dma * cam,
+			       unsigned long status, void *arg);
+
+struct channel_state {
+	dma_callback_t callback;
+	void *arg;
+};
+
+/* sgdma state for each of the possible videobuf_buffers + 2 overlays */
+struct sgdma_state {
+	const struct scatterlist *sglist;
+	int sglen;		 /* number of sglist entries */
+	int next_sglist;	 /* index of next sglist entry to process */
+	unsigned int bytes_read; /* number of bytes read */
+	unsigned int len;        /* total length of sglist (excluding
+				  * bytes due to page alignment) */
+	int queued_sglist;	 /* number of sglist entries queued for DMA */
+	unsigned long csr;	 /* DMA return code */
+	sgdma_callback_t callback;
+	void *arg;
+};
+
+/* physical DMA channel management */
+struct omap24xxcam_dma {
+	spinlock_t lock;
+
+	unsigned long base; /* base address for dma controller */
+
+	/* While dma_stop!=0, an attempt to start a new DMA transfer will 
+	 * fail.
+	 */
+	int dma_stop;
+	int free_dmach;		/* number of dma channels free */
+	int next_dmach;		/* index of next dma channel to use */
+	struct channel_state ch_state[NUM_CAMDMA_CHANNELS];
+};
+
+/* scatter-gather DMA (scatterlist stuff) management */
+struct omap24xxcam_sgdma {
+	struct omap24xxcam_dma dma;
+
+	spinlock_t lock;
+	int free_sgdma;		/* number of free sg dma slots */
+	int next_sgdma;		/* index of next sg dma slot to use */
+	struct sgdma_state sg_state[NUM_SG_DMA];
+
+	/* Reset timer data */
+	struct timer_list reset_timer;
+};
+
+/* per-device data structure */
+struct omap24xxcam_device {
+	/*** mutex  ***/
+	/*
+	 * This mutex serialises access to this structure. Also
+	 * initialisation / reset is serialised using this.
+	 */
+	struct mutex mutex;
+
+	/*** general driver state information ***/
+	int users;
+	int camera_block_alive; /* camera block is initialised and well */
+
+	/*** subsystem structures ***/
+	struct omap24xxcam_sgdma sgdma;
+
+	/*** hardware parameters. ***/
+	unsigned int irq;
+	unsigned long mmio_base;
+	unsigned long mmio_base_phys;
+	unsigned long mmio_size;
+
+	/*** interface and device pointers ***/
+	struct omap_camera_sensor *sensor;
+	struct device *dev;
+	struct video_device *vfd;
+
+	/*** camera and sensor reset related stuff ***/
+	struct work_struct camera_reset_work;
+	struct work_struct sensor_reset_work;
+	atomic_t in_reset;
+
+	/*** video device parameters ***/
+	int capture_mem;
+
+	/*** camera module clocks ***/
+	struct clk *fck;
+	struct clk *ick;
+
+	/*** capture data ***/
+	/* pix defines the size and pixel format of the image captured
+	 * by the sensor. This also defines the size of the
+	 * framebuffers. The same pool of framebuffers is used for
+	 * video capture and video overlay. These parameters are
+	 * set/queried by the VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with a
+	 * CAPTURE buffer type.
+	 */
+	struct v4l2_pix_format pix;
+	
+	/* capture parameters (frame rate, number of buffers) */
+	struct v4l2_captureparm cparm;
+
+	/* file handle, if streaming is on */
+	struct file *streaming;
+};
+
+/* Per-file handle data. */
+struct omap24xxcam_fh {
+	spinlock_t vbq_lock; /* spinlock for the videobuf queue */
+	int sgdma_in_queue; /* number or sgdma requests in queue, also
+			     * protected by vbq_lock */
+	struct videobuf_queue vbq;
+	spinlock_t pix_lock; /* lock for pix! */
+	struct v4l2_pix_format pix;
+	atomic_t field_count; /* field counter for videobuf_buffer */
+	/* accessing cam here doesn't need serialisation: it's constant */
+	struct omap24xxcam_device *cam;
+};
+
+/*
+ *
+ * Register I/O functions.
+ *
+ */
+
+static __inline__ u32 omap24xxcam_reg_in(unsigned long base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static __inline__ u32 omap24xxcam_reg_out(unsigned long base, u32 offset,
+					  u32 val)
+{
+	writel(val, base + offset);
+	return val;
+}
+
+static __inline__ u32 omap24xxcam_reg_merge(unsigned long base, u32 offset,
+					    u32 val, u32 mask)
+{
+	u32 addr = base + offset;
+	u32 new_val = (readl(addr) & ~mask) | (val & mask);
+
+	writel(new_val, addr);
+	return new_val;
+}
+
+/*
+ *
+ * Function prototypes.
+ *
+ */
+
+/* camera core */
+
+void omap24xxcam_core_hwinit(const struct omap24xxcam_device *cam);
+void omap24xxcam_core_enable(const struct omap24xxcam_device *cam);
+void omap24xxcam_core_disable(const struct omap24xxcam_device *cam);
+void omap24xxcam_core_isr(struct omap24xxcam_device *cam);
+unsigned long omap24xxcam_core_xclk_set(const struct omap24xxcam_device *cam,
+					unsigned long xclk);
+
+/* camera -> sensor interface */
+
+int omap24xxcam_sensor_init(struct omap24xxcam_device *cam);
+void omap24xxcam_sensor_exit(struct omap24xxcam_device *cam);
+int omap24xxcam_sensor_enable(struct omap24xxcam_device *cam);
+void omap24xxcam_sensor_disable(struct omap24xxcam_device *cam);
+unsigned long omap24xxcam_sensor_calc_xclk(struct omap24xxcam_device *cam,
+					   struct v4l2_pix_format *pix,
+					   struct v4l2_fract *timeperframe);
+int omap24xxcam_sensor_try_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix);
+int omap24xxcam_sensor_set_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix,
+				  struct v4l2_fract *timeperframe);
+unsigned long omap24xxcam_sensor_xclk_calc(struct omap24xxcam_device *cam,
+					   struct v4l2_pix_format *pix,
+					   struct v4l2_fract *timeperframe);
+int omap24xxcam_sensor_frame_check(struct omap24xxcam_device *cam,
+				   struct v4l2_pix_format *pix,
+				   void *buf);
+int omap24xxcam_sensor_get_control(struct omap24xxcam_device *cam,
+				   struct v4l2_control *a);
+int omap24xxcam_sensor_set_control(struct omap24xxcam_device *cam,
+				   struct v4l2_control *a);
+int omap24xxcam_sensor_query_ctrl(struct omap24xxcam_device *cam,
+				  struct v4l2_queryctrl *a);
+int omap24xxcam_sensor_enum_pixformat(struct omap24xxcam_device *cam,
+				      struct v4l2_fmtdesc *f);
+
+/* camera -> sensor interface */
+
+void omap24xxcam_sensor_reset_work(struct work_struct *work);
+void omap24xxcam_sensor_reset_schedule(struct omap_camera *oc,
+				       struct omap_camera_sensor *os);
+int omap24xxcam_sensor_register(struct omap_camera *oc,
+				struct omap_camera_sensor *os);
+void omap24xxcam_sensor_unregister(struct omap_camera *oc,
+				   struct omap_camera_sensor *os);
+
+/* vbq */
+
+int
+omap24xxcam_vbq_alloc_mmap_buffers(struct videobuf_queue *vbq,
+				   unsigned int count);
+void omap24xxcam_vbq_free_mmap_buffers(struct videobuf_queue *vbq);
+void
+omap24xxcam_vbq_complete(struct omap24xxcam_sgdma *sgdma, unsigned long csr,
+			 void *arg);
+void
+omap24xxcam_vbq_release(struct videobuf_queue *vbq, struct videobuf_buffer *vb);
+
+/* misc. stuff */
+
+void omap24xxcam_camera_reset_schedule(struct omap24xxcam_device *cam);
+
+void omap24xxcam_clock_on(struct omap24xxcam_device *cam);
+void omap24xxcam_clock_off(struct omap24xxcam_device *cam);
+
+int omap24xxcam_device_enable(struct omap24xxcam_device *cam);
+void omap24xxcam_device_disable(struct omap24xxcam_device *cam);
+
+#endif				/* ifndef OMAP24XXCAM_H */
-- 
1.5.0.1
