From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Camera: Add OMAP2 24xx camera driver.
Date: Wed, 28 Feb 2007 17:59:13 +0200
Message-ID: <11726783562347-git-send-email-sakari.ailus@nokia.com>
References: <45E5A489.2040108@nokia.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <45E5A489.2040108@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a modified version of the camera driver originally from Montavista.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap/Makefile             |    1 +
 drivers/media/video/omap/omap24xxcam-core.c   |  202 ++++
 drivers/media/video/omap/omap24xxcam-dma.c    |  320 +++++++
 drivers/media/video/omap/omap24xxcam-dma.h    |   65 ++
 drivers/media/video/omap/omap24xxcam-dmahw.c  |  224 +++++
 drivers/media/video/omap/omap24xxcam-sensor.c |  226 +++++
 drivers/media/video/omap/omap24xxcam-sgdma.c  |  298 ++++++
 drivers/media/video/omap/omap24xxcam-vbq.c    |  370 ++++++++
 drivers/media/video/omap/omap24xxcam.c        | 1216 +++++++++++++++++++++++++
 drivers/media/video/omap/omap24xxcam.h        |  659 +++++++++++++
 10 files changed, 3581 insertions(+), 0 deletions(-)
 create mode 100644 drivers/media/video/omap/omap24xxcam-core.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-dma.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-dma.h
 create mode 100644 drivers/media/video/omap/omap24xxcam-dmahw.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-sensor.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-sgdma.c
 create mode 100644 drivers/media/video/omap/omap24xxcam-vbq.c
 create mode 100644 drivers/media/video/omap/omap24xxcam.c
 create mode 100644 drivers/media/video/omap/omap24xxcam.h

diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index 36ae615..4ca1d1d 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
 obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o camera_core.o
+objs-y$(CONFIG_ARCH_OMAP24XX) += omap24xxcam.o omap24xxcam-sgdma.o omap24xxcam-dma.o omap24xxcam-dmahw.o omap24xxcam-core.o omap24xxcam-sensor.o omap24xxcam-vbq.o
 objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
 objs-y$(CONFIG_MACH_OMAP_H4) += h4_sensor_power.o
 
diff --git a/drivers/media/video/omap/omap24xxcam-core.c b/drivers/media/video/omap/omap24xxcam-core.c
new file mode 100644
index 0000000..1e30768
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-core.c
@@ -0,0 +1,202 @@
+/*
+ * OMAP 24xx camera high-level DMA (not hardware) and scatter-gather
+ * DMA handling
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
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
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/input.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+
+#include "omap24xxcam.h"
+
+/* Program the camera interface xclk for the frequency cam->img.xclk based on 
+ * the functional clock frequency cam->img.mclk.  If the specifed cam->img.xclk 
+ * frequency is not possible based on the value of cam->img.mclk, then the 
+ * closest xclk frequency lower than the specified xclk will be selected.  
+ * The actual xclk frequency is returned in cam->img.xclk.  If cam->img.xclk is zero, 
+ * then xclk is turned off (stable low value).
+ */
+
+void omap24xxcam_core_init(struct omap24xxcam_core *core,
+			   unsigned long base)
+{
+	DBG;
+
+	core->base = base;
+	
+	/* Setting the camera core AUTOIDLE bit causes problems with frame 
+	 * synchronization, so we will clear the AUTOIDLE bit instead.
+	 */
+	//omap24xxcam_reg_out(cam, CC_SYSCONFIG, 0);
+	omap24xxcam_reg_out(core->base, CC_SYSCONFIG, CC_SYSCONFIG_AUTOIDLE);
+
+	core->xclk_enabled = 0;
+}
+
+void omap24xxcam_core_exit(const struct omap24xxcam_core *core)
+{
+}
+
+/* Enable the camera core interface. */
+void omap24xxcam_core_enable(struct omap24xxcam_core *core)
+{
+	DBG;
+
+	/* program the camera interface DMA packet size */
+	omap24xxcam_reg_out(core->base, CC_CTRL_DMA,
+		   CC_CTRL_DMA_EN | (DMA_THRESHOLD / 4 - 1));
+
+	/* enable camera core error interrupts */
+	omap24xxcam_reg_out(core->base, CC_IRQENABLE,
+		   CC_IRQENABLE_FW_ERR_IRQ | CC_IRQENABLE_FSC_ERR_IRQ
+		   | CC_IRQENABLE_SSC_ERR_IRQ | CC_IRQENABLE_FIFO_OF_IRQ);
+
+	/* enable the camera interface */
+	omap24xxcam_reg_out(core->base, CC_CTRL,
+		   CC_CTRL_NOBT_SYNCHRO
+		   | CC_CTRL_PAR_MODE_NOBT8
+		   | CC_CTRL_CC_EN);
+
+	if (core->xclk_enabled)
+		omap24xxcam_core_xclk_enable(core);
+}
+
+void omap24xxcam_core_disable(struct omap24xxcam_core *core)
+{
+	omap24xxcam_reg_out(core->base, CC_CTRL, 0);
+	omap24xxcam_reg_out(core->base, CC_CTRL, CC_CTRL_CC_RST);
+}
+
+void omap24xxcam_core_enable_callback(struct omap24xxcam_device *cam)
+{
+	omap24xxcam_core_enable(&cam->core);
+}
+/* reset core fifo and dma */
+/* void omap24xxcam_core_reset(struct omap24xxcam_device *cam) */
+/* { */
+/* 	omap24xxcam_reg_out(cam, CC_CTRL, CC_CTRL_CC_RST); */
+/* } */
+
+/* Interrupt service routine for camera core interrupts. */
+void omap24xxcam_core_isr(struct omap24xxcam_core *core)
+{
+	unsigned long cc_irqstatus;
+	const unsigned long cc_irqstatus_err =
+		CC_IRQSTATUS_FW_ERR_IRQ
+		| CC_IRQSTATUS_FSC_ERR_IRQ
+		| CC_IRQSTATUS_SSC_ERR_IRQ
+		| CC_IRQSTATUS_FIFO_UF_IRQ
+		| CC_IRQSTATUS_FIFO_OF_IRQ;
+
+	DBG;
+
+	cc_irqstatus = omap24xxcam_reg_in(core->base, CC_IRQSTATUS);
+	omap24xxcam_reg_out(core->base, CC_IRQSTATUS, cc_irqstatus);
+
+	if (cc_irqstatus & cc_irqstatus_err) {
+		printk("%s: scheduling camera reset, cc_irqstatus 0x%lx\n",
+		       __FUNCTION__, cc_irqstatus);
+		omap24xxcam_camera_reset_schedule(
+			container_of(core, struct omap24xxcam_device, core));
+	} else {
+		if (cc_irqstatus & 0xffff)
+			printk("%s: cc_irqstatus 0x%lx\n",
+			       __FUNCTION__, cc_irqstatus);
+	}
+
+}
+
+static void xclk_set(struct omap24xxcam_core *core)
+{
+	unsigned long divisor = core->mclk / core->xclk;
+
+	if (core->xclk_enabled) {
+		if (divisor == 1)
+			omap24xxcam_reg_out(core->base, CC_CTRL_XCLK,
+				   CC_CTRL_XCLK_DIV_BYPASS);
+		else
+			omap24xxcam_reg_out(core->base, CC_CTRL_XCLK, divisor);
+	} else
+		omap24xxcam_reg_out(core->base, CC_CTRL_XCLK,
+			   CC_CTRL_XCLK_DIV_STABLE_LOW);
+
+}
+
+void omap24xxcam_core_xclk_enable(struct omap24xxcam_core *core)
+{
+	core->xclk_enabled = 1;
+	xclk_set(core);
+}
+
+void omap24xxcam_core_xclk_disable(struct omap24xxcam_core *core)
+{
+
+	core->xclk_enabled = 0;
+	xclk_set(core);
+}
+
+void omap24xxcam_core_xclk_set(struct omap24xxcam_core *core,
+			       unsigned long xclk)
+{
+	unsigned long divisor;
+
+	DBG;
+
+	if (xclk > core->mclk)
+		xclk = core->mclk;
+
+	divisor = core->mclk / xclk;
+	if (xclk * divisor < core->mclk)
+		divisor += 1;
+	if (divisor > 30)
+		divisor = 30;
+	core->xclk = core->mclk / divisor;
+
+	xclk_set(core);
+}
+
+void omap24xxcam_core_mclk_set(struct omap24xxcam_core *core,
+			       unsigned long mclk)
+{
+	core->mclk = mclk;
+}
diff --git a/drivers/media/video/omap/omap24xxcam-dma.c b/drivers/media/video/omap/omap24xxcam-dma.c
new file mode 100644
index 0000000..d10f1c8
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-dma.c
@@ -0,0 +1,320 @@
+/*
+ * drivers/media/video/omap/omap24xxcam-dma.c
+ *
+ * Video-for-Linux (Version 2) camera capture driver for 
+ * the OMAP24xx camera controller.
+ *
+ * Author: David Cohen <david.cohen@indt.org.br>
+ * Based on: omap24xxcam.c by Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * History:
+ * 2005/nov - David Cohen <david.cohen@indt.org.br>
+ *            Updated the driver for the Linux Device Model and new version of V4L2.
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/input.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+/* configuration macros */
+#define CAM_NAME 	"omap24xxcam"
+#define CONFIG_H4
+
+/* Start a DMA transfer from the camera to memory.
+ * Returns zero if the transfer was successfully started, or non-zero if all 
+ * DMA channels are already in use or starting is currently inhibited.
+ */
+int
+omap24xxcam_dma_start(struct omap24xxcam_dma *dma, dma_addr_t start, 
+	unsigned long len, dma_callback_t callback, void *arg)
+{
+	unsigned long irqflags;
+	int dmach;
+	void (*dma_notify)(struct omap24xxcam_device *cam);
+
+	DBG;
+
+	spin_lock_irqsave(&dma->lock, irqflags);
+
+	if (!dma->free_dmach || dma->dma_stop) {
+		spin_unlock_irqrestore(&dma->lock, irqflags);
+		DBG_MID(3);
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
+	dma_notify = dma->dma_notify;
+	dma->dma_notify = NULL;
+
+	spin_unlock_irqrestore(&dma->lock, irqflags);
+
+	if (dma_notify)
+		(*dma_notify)(container_of(container_of(dma, struct omap24xxcam_sgdma, dma), struct omap24xxcam_device, sgdma));
+
+	DBG_END;
+
+	return 0;
+}
+
+/* Abort all chained DMA transfers.  After all transfers have been aborted and 
+ * the DMA controller is idle, the completion routines for any aborted transfers
+ * will be called in sequence.  The DMA controller may not be idle after this 
+ * routine completes, because the completion routines might start new transfers.
+ */
+void
+omap24xxcam_dma_abort(struct omap24xxcam_dma *dma, unsigned long csr)
+{
+	unsigned long irqflags;
+	int dmach, i, free_dmach;
+	dma_callback_t callback;
+	void *arg;
+
+	DBG;
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
+void
+omap24xxcam_dma_stop(struct omap24xxcam_dma *dma, unsigned long csr)
+{
+	unsigned long irqflags;
+
+	DBG;
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
+/* Register a routine to be called once immediately after a DMA transfer is 
+ * started.  The purpose of this is to allow the camera interface to be 
+ * started only after a DMA transaction has been queued in order to avoid 
+ * DMA overruns.  The registered callback routine will only be called one 
+ * time and then discarded.  Only one callback routine may be registered at a 
+ * time.
+ * Returns zero if successful, or a non-zero error code if a different callback 
+ * routine has already been registered.
+ */
+int
+omap24xxcam_dma_notify(struct omap24xxcam_dma *dma,
+		       void (*callback) (struct omap24xxcam_device * cam))
+{
+	unsigned long irqflags;
+
+	DBG;
+
+	spin_lock_irqsave(&dma->lock, irqflags);
+
+	if (dma->dma_notify && (dma->dma_notify != callback)) {
+		spin_unlock_irqrestore(&dma->lock, irqflags);
+		return -EBUSY;
+	}
+
+	dma->dma_notify = callback;
+
+	spin_unlock_irqrestore(&dma->lock, irqflags);
+
+	return 0;
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
+	DBG;
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
+void omap24xxcam_dma_init(struct omap24xxcam_dma *dma, unsigned long base)
+{
+	int ch;
+
+	DBG;
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
+/* Shutdown the camera DMA driver and controller. */
+void
+omap24xxcam_dma_exit(struct omap24xxcam_dma *dma)
+{
+	DBG;
+
+	omap24xxcam_dma_disable(dma);
+}
+
+void omap24xxcam_dma_enable(struct omap24xxcam_dma *dma)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&dma->lock, flags);
+
+	omap24xxcam_dmahw_init(dma->base);
+	omap24xxcam_dmahw_unmask_irq0(dma->base);
+	
+	spin_unlock_irqrestore(&dma->lock, flags);
+}
+
+void omap24xxcam_dma_disable(struct omap24xxcam_dma *dma)
+{
+	int ch;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&dma->lock, flags);
+	
+	/* Mask all DMA interrupts */
+	omap24xxcam_dmahw_mask_all(dma->base);
+
+	/* disable all DMA channels */
+	for (ch = 0; ch < NUM_CAMDMA_CHANNELS; ch++)
+		omap24xxcam_dmahw_disable_ch(dma->base, ch);
+
+	spin_unlock_irqrestore(&dma->lock, flags);
+}
diff --git a/drivers/media/video/omap/omap24xxcam-dma.h b/drivers/media/video/omap/omap24xxcam-dma.h
new file mode 100644
index 0000000..5898fd9
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-dma.h
@@ -0,0 +1,65 @@
+/*
+ * drivers/media/video/omap/omap24xxcam-dma.h
+ *
+ * Copyright (C) 2006 Instituto Nokia de Tecnolodia
+ *
+ * Author: David Cohen <david.cohen@indt.org.br>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/* sg_dma prototypes */
+
+void omap24xxcam_sgdma_process(struct omap24xxcam_sgdma *sgdma);
+int
+omap24xxcam_sgdma_queue(struct omap24xxcam_sgdma *sgdma,
+			const struct scatterlist *sglist, int sglen, int len,
+			 sgdma_callback_t callback, void *arg);
+void
+omap24xxcam_sgdma_sync(struct omap24xxcam_sgdma *sgdma, unsigned long csr);
+void omap24xxcam_sgdma_init(struct omap24xxcam_sgdma *sgdma, unsigned long base);
+void omap24xxcam_sgdma_exit(struct omap24xxcam_sgdma *sgdma);
+void omap24xxcam_sgdma_enable(struct omap24xxcam_sgdma *sgdma);
+void omap24xxcam_sgdma_disable(struct omap24xxcam_sgdma *sgdma);
+
+/* dma prototypes */
+
+int
+omap24xxcam_dma_start(struct omap24xxcam_dma *dma, dma_addr_t start, 
+		      unsigned long len, dma_callback_t callback, void *arg);
+void
+omap24xxcam_dma_abort(struct omap24xxcam_dma *dma, unsigned long csr);
+void
+omap24xxcam_dma_stop(struct omap24xxcam_dma *dma, unsigned long csr);
+int
+omap24xxcam_dma_notify(struct omap24xxcam_dma *dma,
+		       void (*callback) (struct omap24xxcam_device * cam));
+void omap24xxcam_dma_isr(struct omap24xxcam_dma *dma);
+void
+omap24xxcam_dma_init(struct omap24xxcam_dma *dma, unsigned long base);
+void
+omap24xxcam_dma_exit(struct omap24xxcam_dma *dma);
+void
+omap24xxcam_dma_enable(struct omap24xxcam_dma *dma);
+void
+omap24xxcam_dma_disable(struct omap24xxcam_dma *dma);
+
+/* dmahw prototypes */
+
+void omap24xxcam_dmahw_ack_all(unsigned long base);
+unsigned long omap24xxcam_dmahw_ack_ch(unsigned long base, int dmach);
+int omap24xxcam_dmahw_running(unsigned long base, int dmach);
+void omap24xxcam_dmahw_transfer_setup(unsigned long base, int dmach,
+				      dma_addr_t start, unsigned long len);
+void omap24xxcam_dmahw_transfer_chain(unsigned long base, int dmach,
+				      int free_dmach);
+void omap24xxcam_dmahw_transfer_start(unsigned long base, int dmach);
+void
+omap24xxcam_dmahw_abort_ch(unsigned long base, int dmach);
+void omap24xxcam_dmahw_mask_all(unsigned long base);
+void omap24xxcam_dmahw_unmask_irq0(unsigned long base);
+void omap24xxcam_dmahw_disable_ch(unsigned long base, int ch);
+void omap24xxcam_dmahw_init(unsigned long base);
+
diff --git a/drivers/media/video/omap/omap24xxcam-dmahw.c b/drivers/media/video/omap/omap24xxcam-dmahw.c
new file mode 100644
index 0000000..21d23db
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-dmahw.c
@@ -0,0 +1,224 @@
+/*
+ * drivers/media/video/omap/omap24xxcam-dma.c
+ *
+ * Video-for-Linux (Version 2) camera capture driver for 
+ * the OMAP24xx camera controller.
+ *
+ * Author: David Cohen <david.cohen@indt.org.br>
+ * Based on: omap24xxcam.c by Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * History:
+ * 2005/nov - David Cohen <david.cohen@indt.org.br>
+ *            Updated the driver for the Linux Device Model and new version of V4L2.
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/input.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+/* configuration macros */
+#define CAM_NAME 	"omap24xxcam"
+#define CONFIG_H4
+
+/* Ack all interrupt on CSR and IRQSTATUS_L0 */
+void omap24xxcam_dmahw_ack_all(unsigned long base)
+{
+	unsigned long csr;
+	int i;
+	
+	for (i = 0; i< 4; ++i) {
+		csr = omap24xxcam_reg_in(base, CAMDMA_CSR(i));
+		/* ack interrupt in CSR */
+		omap24xxcam_reg_out(base, CAMDMA_CSR(i), csr);
+	}
+	omap24xxcam_reg_out(base, CAMDMA_IRQSTATUS_L0, 0xffffffff);
+}
+
+/* Ack dmach on CSR and IRQSTATUS_L0 */
+unsigned long omap24xxcam_dmahw_ack_ch(unsigned long base, int dmach)
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
+int omap24xxcam_dmahw_running(unsigned long base, int dmach)
+{
+	return omap24xxcam_reg_in(base, CAMDMA_CCR(dmach)) & CAMDMA_CCR_ENABLE;
+}
+
+void omap24xxcam_dmahw_transfer_setup(unsigned long base, int dmach,
+			     dma_addr_t start, unsigned long len)
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
+		       | CAMDMA_CSR_SUPERVISOR_ERR
+		       | CAMDMA_CSR_SECURE_ERR
+		       | CAMDMA_CSR_TRANS_ERR
+		       | CAMDMA_CSR_BLOCK
+		       | CAMDMA_CSR_DROP);
+	omap24xxcam_reg_out(base, CAMDMA_CICR(dmach), 
+		       CAMDMA_CICR_MISALIGNED_ERR_IE
+		       | CAMDMA_CICR_SUPERVISOR_ERR_IE
+		       | CAMDMA_CICR_SECURE_ERR_IE
+		       | CAMDMA_CICR_TRANS_ERR_IE
+		       | CAMDMA_CICR_BLOCK_IE
+		       | CAMDMA_CICR_DROP_IE);
+}
+
+void omap24xxcam_dmahw_transfer_chain(unsigned long base, int dmach,
+				      int free_dmach)
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
+	DBG_MID(1);
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
+	DBG_MID(2);
+}
+
+void omap24xxcam_dmahw_transfer_start(unsigned long base, int dmach)
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
+/* Abort all chained DMA transfers.  After all transfers have been aborted and 
+ * the DMA controller is idle, the completion routines for any aborted transfers
+ * will be called in sequence.  The DMA controller may not be idle after this 
+ * routine completes, because the completion routines might start new transfers.
+ */
+void
+omap24xxcam_dmahw_abort_ch(unsigned long base, int dmach)
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
+/* Mask all DMA interrupts */
+void omap24xxcam_dmahw_mask_all(unsigned long base)
+{
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L0, 0);
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L1, 0);
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L2, 0);
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L3, 0);
+}
+
+/* group all channels on DMA IRQ0 and unmask irq */
+void omap24xxcam_dmahw_unmask_irq0(unsigned long base)
+{
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L0, 0xffffffff);
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L1, 0);
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L2, 0);
+	omap24xxcam_reg_out(base, CAMDMA_IRQENABLE_L3, 0);
+}
+
+void omap24xxcam_dmahw_disable_ch(unsigned long base, int ch)
+{
+	omap24xxcam_reg_out(base, CAMDMA_CCR(ch), 0);
+}
+
+void omap24xxcam_dmahw_init(unsigned long base)
+{
+	DBG;
+	omap24xxcam_reg_out(base, CAMDMA_OCP_SYSCONFIG, 
+		CAMDMA_OCP_SYSCONFIG_MIDLEMODE_FSTANDBY
+	      | CAMDMA_OCP_SYSCONFIG_SIDLEMODE_FIDLE
+	      | CAMDMA_OCP_SYSCONFIG_AUTOIDLE);
+
+	omap24xxcam_reg_merge(base, CAMDMA_GCR, 0x10, 
+		CAMDMA_GCR_MAX_CHANNEL_FIFO_DEPTH);
+}
+
diff --git a/drivers/media/video/omap/omap24xxcam-sensor.c b/drivers/media/video/omap/omap24xxcam-sensor.c
new file mode 100644
index 0000000..bde7429
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-sensor.c
@@ -0,0 +1,226 @@
+/*
+ * drivers/media/video/omap/omap24xxcam-dma.c
+ *
+ * Video-for-Linux (Version 2) camera capture driver for 
+ * the OMAP24xx camera controller.
+ *
+ * Author: David Cohen <david.cohen@indt.org.br>
+ * Based on: omap24xxcam.c by Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * History:
+ * 2005/nov - David Cohen <david.cohen@indt.org.br>
+ *            Updated the driver for the Linux Device Model and new version of V4L2.
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/input.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+
+#include "omap24xxcam.h"
+#include "sensor_if.h"
+#include "omap24xxcam-dma.h"
+
+/* camera driver: initialise sensor */
+int omap24xxcam_sensor_init(struct omap24xxcam_device *cam)
+{
+	int err = 0;
+
+	if (cam->sensor == NULL)
+		return -ENODEV;
+	
+	if (cam->sensor_alive)
+		return 0;
+
+	omap24xxcam_clock_on(cam);
+	omap24xxcam_core_xclk_enable(&cam->core);
+	
+	/* power up sensor during sensor initialization */
+	if (cam->sensor->power_on)
+		cam->sensor->power_on(cam->sensor);
+
+	/* initialize the sensor and define a default capture format cam->img.pix */
+	err = cam->sensor->init(cam->sensor,
+				&cam->img.pix,
+				&omap24xxcam_camera);
+	if (err) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot initialize sensor, error %d\n", err);
+		goto out;
+	}
+	printk(KERN_INFO "Sensor is %s\n", cam->sensor->name);
+
+out:
+	omap24xxcam_core_xclk_disable(&cam->core);
+	omap24xxcam_clock_off(cam);
+
+	if (cam->sensor->power_off)
+		cam->sensor->power_off(cam->sensor);
+
+	cam->sensor_alive = 1;
+
+	return err;
+}
+
+void omap24xxcam_sensor_exit(struct omap24xxcam_device *cam)
+{
+	if (cam->sensor == NULL)
+		return;
+	if (!cam->sensor_alive)
+		return;
+
+	omap24xxcam_sensor_disable(cam);
+	cam->sensor->cleanup(cam->sensor);
+	cam->sensor_alive = 0;
+}
+
+/* Power-up and configure camera sensor */
+int omap24xxcam_sensor_enable(struct omap24xxcam_device *cam)
+{
+	omap24xxcam_clock_on(cam);
+
+	/* calculate xclk based on the default capture format and default 
+	 * frame rate
+	 */
+	omap24xxcam_core_xclk_set(
+		&cam->core,
+		cam->sensor->calc_xclk(
+			cam->sensor,
+			&cam->img.pix,
+			&cam->img.cparm.timeperframe));
+	omap24xxcam_core_xclk_enable(&cam->core);
+
+ 	if (cam->sensor->power_on)
+		cam->sensor->power_on(cam->sensor);
+
+	/* program the sensor for the default capture format and rate */
+	cam->sensor->configure(cam->sensor, &cam->img.pix,
+			       cam->core.xclk, &cam->img.cparm.timeperframe);
+
+	return 0;
+}
+
+void omap24xxcam_sensor_disable(struct omap24xxcam_device *cam)
+{
+	omap24xxcam_core_xclk_disable(&cam->core);
+	omap24xxcam_clock_off(cam);
+	if (cam->sensor->power_off)
+		cam->sensor->power_off(cam->sensor);
+}
+
+void omap24xxcam_sensor_reset_work(void * data)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)data;
+	
+	omap24xxcam_sensor_disable(cam);
+
+	omap24xxcam_sensor_enable(cam);
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
+EXPORT_SYMBOL(omap24xxcam_sensor_reset_schedule);
+
+unsigned long omap24xxcam_sensor_calc_xclk(struct omap24xxcam_device *cam,
+					   struct v4l2_pix_format *pix,
+					   struct v4l2_fract *timeperframe)
+{
+	return cam->sensor->calc_xclk(cam->sensor,
+				      pix,
+				      timeperframe);
+}
+
+int omap24xxcam_sensor_try_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix)
+{
+	return cam->sensor->try_format(cam->sensor,
+				       pix);
+}
+
+int omap24xxcam_sensor_set_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix,
+				  struct v4l2_fract *timeperframe,
+				  unsigned long *xclk)
+{
+	int err;
+
+	if (timeperframe->numerator == 0
+	    || timeperframe->denominator == 0)
+		return -EINVAL;
+
+	*xclk = cam->sensor->calc_xclk(cam->sensor, pix, timeperframe);
+
+	omap24xxcam_core_xclk_set(&cam->core, *xclk);
+	
+	err = cam->sensor->configure(cam->sensor, pix, *xclk, timeperframe);
+
+	return err;
+}
+
+/* This should be called by the sensor code whenever it's ready */
+int omap24xxcam_sensor_register(struct omap_camera *oc,
+				struct omap_camera_sensor *os)
+{
+	struct omap24xxcam_device *cam = oc->priv;
+	int rval;
+
+	/* the device has not been initialised yet */
+	if (cam == NULL)
+		return -ENODEV;
+	if (os == NULL)
+		return -EINVAL;
+	if (cam->sensor != NULL)
+		return -EBUSY;
+
+	cam->sensor = os;
+	rval = omap24xxcam_device_enable(cam);
+
+	if (rval)
+		cam->sensor = NULL;
+	return rval;
+}
+
+EXPORT_SYMBOL(omap24xxcam_sensor_register);
+
+void omap24xxcam_sensor_unregister(struct omap_camera *oc,
+				   struct omap_camera_sensor *os)
+{
+	struct omap24xxcam_device *cam = oc->priv;
+
+	BUG_ON(cam->users != 0);
+	BUG_ON(cam->sensor == NULL);
+
+	cam->sensor = NULL;
+}
+
+EXPORT_SYMBOL(omap24xxcam_sensor_unregister);
diff --git a/drivers/media/video/omap/omap24xxcam-sgdma.c b/drivers/media/video/omap/omap24xxcam-sgdma.c
new file mode 100644
index 0000000..0243a59
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-sgdma.c
@@ -0,0 +1,298 @@
+/*
+ * OMAP 24xx camera high-level DMA (not hardware) and scatter-gather
+ * DMA handling
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
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
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/input.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+/*
+ * Scatter-gather DMA
+ *
+ * High-level DMA construct for transferring whole picture frames to
+ * memory that is discontinuous.
+ */
+
+/* DMA completion routine for the scatter-gather DMA fragments. */
+static void
+omap24xxcam_sgdma_callback(struct omap24xxcam_dma *dma, unsigned long csr,
+			    void *arg)
+{
+	struct omap24xxcam_sgdma *sgdma =
+		container_of(dma, struct omap24xxcam_sgdma, dma);
+	int sgslot = (int)arg;
+	struct sgdma_state *sg_state;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	DBG;
+
+	spin_lock(&sgdma->lock);
+
+	/* We got an interrupt, we can remove the timer */
+	del_timer(&sgdma->reset_timer);
+
+	sg_state = sgdma->sg_state + sgslot;
+	if (!sg_state->queued_sglist) {
+		spin_unlock(&sgdma->lock);
+		printk(KERN_DEBUG CAM_NAME
+		       ": sgdma completed when none queued!\n");
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
+/* Process the scatter-gather DMA queue by starting queued transfers. */
+void omap24xxcam_sgdma_process(struct omap24xxcam_sgdma *sgdma)
+{
+	unsigned long irqflags;
+	int queued_sgdma, sgslot;
+	struct sgdma_state *sg_state;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	DBG;
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
+			if (omap24xxcam_dma_start(&sgdma->dma, sg_dma_address(sglist),
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
+	DBG_END;
+}
+
+/* Queue a scatter-gather DMA transfer from the camera to memory.
+ * Returns zero if the transfer was successfully queued, or 
+ * non-zero if all of the scatter-gather slots are already in use.
+ */
+int
+omap24xxcam_sgdma_queue(struct omap24xxcam_sgdma *sgdma,
+			const struct scatterlist *sglist, int sglen, int len,
+			 sgdma_callback_t callback, void *arg)
+{
+	unsigned long irqflags;
+	struct sgdma_state *sg_state;
+
+	DBG;
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
+void
+omap24xxcam_sgdma_sync(struct omap24xxcam_sgdma *sgdma, unsigned long csr)
+{
+	unsigned long irqflags;
+	int sgslot;
+	struct sgdma_state *sg_state;
+
+	DBG;
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
+
+void omap24xxcam_sgdma_init(struct omap24xxcam_sgdma *sgdma, unsigned long base)
+{
+	int sg;
+
+	DBG;
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
+}
+
+void omap24xxcam_sgdma_exit(struct omap24xxcam_sgdma *sgdma)
+{
+	omap24xxcam_sgdma_sync(sgdma, CAMDMA_CSR_TRANS_ERR);
+	omap24xxcam_dma_exit(&sgdma->dma);
+}
+
+void omap24xxcam_sgdma_enable(struct omap24xxcam_sgdma *sgdma)
+{
+	omap24xxcam_dma_enable(&sgdma->dma);
+	omap24xxcam_sgdma_process(sgdma);
+}
+
+void omap24xxcam_sgdma_disable(struct omap24xxcam_sgdma *sgdma)
+{
+	omap24xxcam_sgdma_sync(sgdma, CAMDMA_CSR_TRANS_ERR);
+	omap24xxcam_dma_disable(&sgdma->dma);
+}
diff --git a/drivers/media/video/omap/omap24xxcam-vbq.c b/drivers/media/video/omap/omap24xxcam-vbq.c
new file mode 100644
index 0000000..f6d8803
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam-vbq.c
@@ -0,0 +1,370 @@
+/*
+ * OMAP 24xx camera high-level DMA (not hardware) and scatter-gather
+ * DMA handling
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
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
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/input.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+static void
+omap24xxcam_vbq_free_mmap_buffer(struct videobuf_buffer *vb)
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
+/* Allocate physically as contiguous as possible buffer for video frame and
+ * build DMA scatter-gather list for it
+ */
+static int
+omap24xxcam_vbq_alloc_mmap_buffer(struct videobuf_buffer *vb)
+{
+	unsigned long order;
+	size_t alloc_size, size = vb->bsize; /* vb->bsize is page aligned */
+	struct page *page;
+	int max_pages, err = 0, i = 0;
+
+	/* allocate maximum size scatter-gather list. Note this is overhead. We
+	 * may not use as many entries as we allocate */
+	max_pages = vb->bsize >> PAGE_SHIFT;
+	vb->dma.sglist = kcalloc(max_pages, sizeof(*vb->dma.sglist), GFP_KERNEL);
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
+int
+omap24xxcam_vbq_alloc_mmap_buffers(struct videobuf_queue *vbq,
+				   unsigned int count)
+{
+	int i, err = 0;
+
+	mutex_lock(&vbq->lock);
+	for (i = 0; i < count; i++) {
+		err = omap24xxcam_vbq_alloc_mmap_buffer(vbq->bufs[i]);
+		if (err)
+			goto out;
+		printk("%s: sglen is %d for buffer %d\n",
+		       __FUNCTION__, vbq->bufs[i]->dma.sglen, i);
+	}
+	mutex_unlock(&vbq->lock);
+
+	return 0;
+out:
+	while (i) {
+		i--;
+		omap24xxcam_vbq_free_mmap_buffer(vbq->bufs[i]);
+	}
+	mutex_unlock(&vbq->lock);
+
+	return err;
+}
+
+/* This routine is called from interrupt context when a scatter-gather DMA 
+ * transfer of a videobuf_buffer completes.
+ */
+void
+omap24xxcam_vbq_complete(struct omap24xxcam_sgdma *sgdma, unsigned long csr,
+			 void *arg)
+{
+	struct omap24xxcam_device *cam =
+		container_of(sgdma, struct omap24xxcam_device, sgdma);
+	struct omap24xxcam_capture *capture = &cam->capture;
+	struct videobuf_buffer *vb = (struct videobuf_buffer *)arg;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	DBG;
+
+	spin_lock(&capture->lock);
+
+	do_gettimeofday(&vb->ts);
+	vb->field_count = capture->field_count;
+	capture->field_count += 2;
+	if (csr & csr_error) {
+		vb->state = STATE_ERROR;
+		printk(KERN_INFO "%s: scheduling camera reset, csr 0x%lx\n",
+		       __FUNCTION__, csr);
+		omap24xxcam_camera_reset_schedule(cam);
+	} else
+		vb->state = STATE_DONE;
+	wake_up(&vb->done);
+	spin_unlock(&capture->lock);
+}
+
+void
+omap24xxcam_vbq_release(struct videobuf_queue *vbq, struct videobuf_buffer *vb)
+{
+	struct videobuf_dmabuf *dma = &vb->dma;
+	DBG;
+
+	videobuf_waiton(vb, 0, 0);
+	if (vb->memory == V4L2_MEMORY_MMAP) {
+		dma_unmap_sg(vbq->dev, dma->sglist, dma->sglen,
+			     dma->direction);
+		dma->direction = PCI_DMA_NONE;
+		omap24xxcam_vbq_free_mmap_buffer(vb);
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
+static int
+omap24xxcam_vbq_setup(struct videobuf_queue *vbq, unsigned int *cnt,
+		      unsigned int *size)
+{
+	struct omap24xxcam_device *cam = vbq->priv_data;
+
+	DBG;
+
+	if (*cnt <= 0)
+		*cnt = VIDEO_MAX_FRAME;	/* supply a default number of buffers */
+
+	if (*cnt > VIDEO_MAX_FRAME)
+		*cnt = VIDEO_MAX_FRAME;
+
+	spin_lock(&cam->img.img_lock);
+
+	*size = cam->img.pix.sizeimage;
+
+	spin_unlock(&cam->img.img_lock);
+
+	while (*size * *cnt > cam->capture_mem)
+		(*cnt)--;
+
+	return 0;
+}
+
+static int
+omap24xxcam_dma_iolock(struct videobuf_queue* vbq, struct videobuf_dmabuf *dma)
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
+static int
+omap24xxcam_vbq_prepare(struct videobuf_queue *vbq, struct videobuf_buffer *vb,
+			enum v4l2_field field)
+{
+	struct omap24xxcam_device *cam = vbq->priv_data;
+	int err = 0;
+
+	DBG;
+
+	spin_lock(&cam->img.img_lock);
+
+	if (vb->baddr) {
+		/* This is a userspace buffer. */
+		if (cam->img.pix.sizeimage > vb->bsize) {
+			/* The buffer isn't big enough. */
+			err = -EINVAL;
+		} else
+			vb->size = cam->img.pix.sizeimage;
+	} else if (!vb->baddr) {
+		if (vb->state != STATE_NEEDS_INIT) {
+			/* We have a kernel bounce buffer that has already been 
+			 * allocated.
+			 */
+			if (cam->img.pix.sizeimage > vb->size) {
+				/* The image size has been changed to a larger 
+				 * size since this buffer was allocated, so we 
+				 * need to free and reallocate it.
+				 */
+				spin_unlock(&cam->img.img_lock);
+				omap24xxcam_vbq_release(vbq, vb);
+				spin_lock(&cam->img.img_lock);
+				vb->size = cam->img.pix.sizeimage;
+			}
+		} else {
+			/* We need to allocate a new kernel bounce buffer. */
+			vb->size = cam->img.pix.sizeimage;
+		}
+	}
+
+	vb->width = cam->img.pix.width;
+	vb->height = cam->img.pix.height;
+	vb->field = field;
+
+	spin_unlock(&cam->img.img_lock);
+
+	if (err)
+		return err;
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
+static void
+omap24xxcam_vbq_queue(struct videobuf_queue *vbq, struct videobuf_buffer *vb)
+{
+	struct omap24xxcam_device *cam = vbq->priv_data;
+	enum videobuf_state state = vb->state;
+	int err;
+
+	DBG;
+
+	vb->state = STATE_QUEUED;
+	err = omap24xxcam_sgdma_queue(&cam->sgdma, vb->dma.sglist, vb->dma.sglen,
+				      cam->img.pix.sizeimage,
+				       omap24xxcam_vbq_complete, vb);
+	if (err) {
+		/* Oops.  We're not supposed to get any errors here.  The only 
+		 * way we could get an error is if we ran out of scatter-gather 
+		 * DMA slots, but we are supposed to have at least as many 
+		 * scatter-gather DMA slots as video buffers so that can't 
+		 * happen.
+		 */
+		printk(KERN_DEBUG CAM_NAME
+		       ": Failed to queue a video buffer for DMA!\n");
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
index 0000000..4f954ed
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.c
@@ -0,0 +1,1216 @@
+/*
+ * drivers/media/video/omap/omap24xxcam.c
+ *
+ * Video-for-Linux (Version 2) camera capture driver for 
+ * the OMAP24xx camera controller.
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * History:
+ * 2005/nov - David Cohen <david.cohen@indt.org.br>
+ *            Updated the driver for the Linux Device Model and new version of V4L2.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/i2c.h>
+#include <linux/videodev2.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <linux/dma-mapping.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <media/video-buf.h>
+#include <media/v4l2-common.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+#include <asm/processor.h>
+
+#include <asm/arch/clock.h>
+
+#include "omap24xxcam.h"
+#include "omap24xxcam-dma.h"
+
+#include "sensor_if.h"
+
+/* configuration macros */
+
+//#define DEBUG_CAM
+#ifdef DEBUG_CAM
+#define DBG		printk(KERN_INFO CAM_NAME ": %s\n", __FUNCTION__)
+#define DBG_END 	printk(KERN_INFO CAM_NAME ": %s END!\n", __FUNCTION__)
+#define DBG_MID(x)	printk(KERN_INFO CAM_NAME ": %s - %d\n", __FUNCTION__, x)
+#else
+#define DBG
+#define DBG_END
+#define DBG_MID(x)
+#endif
+
+#define RESET_TIMEOUT (HZ / 5)
+
+struct omap_camera omap24xxcam_camera = {
+	.sensor_register = &omap24xxcam_sensor_register,
+	.sensor_unregister = &omap24xxcam_sensor_unregister,
+	.sensor_reset = &omap24xxcam_sensor_reset_schedule,
+};
+
+struct omap24xxcam_device *camera_module;
+
+static struct platform_device omap24xxcam_dev;
+
+static int omap24xxcam_remove(struct platform_device *pdev);
+
+/* module parameters */
+static int video_nr = -1;	/* video device minor (-1 ==> auto assign) */
+/* Maximum amount of memory to use for capture buffers.
+ * Default is 4800KB, enough to double-buffer SXGA.
+ */
+static int capture_mem = 1280 * 960 * 2 * 2;
+
+/* -------------------------------------------------------------------------- */
+
+/* Initialize the camera subsystem (camera core, camera DMA, and camera MMU) */
+static void omap24xxcam_reset(const struct omap24xxcam_device *cam)
+{
+	unsigned long timeout;
+
+	DBG;
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
+}
+
+/* This gets called whenever a DMA transfer is stalled */
+static void omap24xxcam_reset_timer(unsigned long data)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)data;
+
+	printk("%s()\n", __FUNCTION__);
+
+	/*
+	 * Sensor reset must not be called from
+	 * interrupt context as it may sleep
+	 */
+	omap24xxcam_camera_reset_schedule(cam);
+}
+
+void omap24xxcam_camera_reset_work(void * data)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)data;
+
+	/* Disable and reset the camera interface. */
+	omap24xxcam_core_disable(&cam->core);
+
+ 	/* Stop the DMA controller and frame sync scatter-gather DMA. */
+	omap24xxcam_sgdma_disable(&cam->sgdma);
+
+	/* Reset and re-initialize the entire camera subsystem.
+	 * Resetting the camera FIFO via the CC_RST bit in the CC_CTRL 
+	 * register is supposed to be sufficient to recover from a 
+	 * camera interface error, but it doesn't seem to be enough.  If 
+	 * we only do that then subsequent image captures are out of sync 
+	 * by either one or two times DMA_THRESHOLD bytes.  Resetting and 
+	 * re-initializing the entire camera subsystem prevents the problem 
+	 * with frame synchronization.  Calling cam_init() from an ISR is
+	 * undesirable since it waits an indeterminate amount of time for the 
+	 * camera subsystem reset to complete.  If we ever figure out exactly 
+	 * what needs to be reset to recover from a camera interface error, 
+	 * maybe we can replace this global reset with something less drastic.
+	 */
+	omap24xxcam_reset(cam);
+	omap24xxcam_core_enable(&cam->core);
+
+	if (cam->capture.streaming) {
+		/* Preview or capture is in progress, so we need to register 
+		 * our routine to restart the camera interface the next time a 
+		 * DMA transfer is queued.
+		 */
+		omap24xxcam_dma_notify(&cam->sgdma.dma, omap24xxcam_core_enable_callback);
+	}
+
+	omap24xxcam_sgdma_enable(&cam->sgdma);
+}
+
+void omap24xxcam_camera_reset_schedule(struct omap24xxcam_device *cam)
+{
+	schedule_work(&cam->camera_reset_work);
+}
+
+static irqreturn_t omap24xxcam_isr(int irq, void *arg, struct pt_regs *regs)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)arg;
+	unsigned long irqstatus;
+	unsigned int irqhandled = 0;
+
+	DBG;
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
+		omap24xxcam_core_isr(&cam->core);
+		irqhandled = 1;
+	}
+	if (irqstatus & CAM_IRQSTATUS_MMU_IRQ)
+		printk(KERN_ERR CAM_NAME ": Unhandled camera MMU interrupt!\n");
+
+	return IRQ_RETVAL(irqhandled);
+}
+
+/* -------------------------------------------------------------------------- */
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
+		| V4L2_CAP_READWRITE
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
+
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
+	memset(pix, 0, sizeof(*pix));
+	spin_lock(&cam->img.img_lock);
+	*pix = cam->img.pix;
+	spin_unlock(&cam->img.img_lock);
+	return 0;
+}
+
+static int vidioc_try_fmt_cap(struct file *file, void *fh,
+			      struct v4l2_format *f)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	return omap24xxcam_sensor_try_format(cam, &f->fmt.pix);
+}
+
+static int vidioc_s_fmt_cap(struct file *file, void *fh,
+			    struct v4l2_format *f)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct omap24xxcam_capture *capture = &cam->capture;
+	int err;
+
+	spin_lock(&capture->lock);
+	if (capture->streaming) {
+		spin_unlock(&capture->lock);
+		return -EBUSY;
+	}
+	spin_unlock(&capture->lock);
+	spin_lock(&cam->img.img_lock);
+	omap24xxcam_sensor_try_format(cam, &f->fmt.pix);
+	/* set the new capture format */
+	cam->img.pix = f->fmt.pix;
+	/* adjust the capture frame rate */
+	err = omap24xxcam_sensor_set_format(cam,
+					    &cam->img.pix,
+					    &cam->img.cparm.timeperframe,
+					    &cam->core.xclk);
+	spin_unlock(&cam->img.img_lock);
+	return err;
+}
+
+static int vidioc_g_parm(struct file *file, void *fh,
+			 struct v4l2_streamparm *a) {
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	enum v4l2_buf_type type = a->type;
+
+	memset(a, 0, sizeof(*a));
+	a->type = type;
+	if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+	spin_lock(&cam->img.img_lock);
+	a->parm.capture = cam->img.cparm;
+	spin_unlock(&cam->img.img_lock);
+	return 0;
+}
+
+static int vidioc_s_parm(struct file *file, void *fh,
+			 struct v4l2_streamparm *a)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct omap24xxcam_capture *capture = &cam->capture;
+	int err;
+	struct v4l2_captureparm *cparm = &a->parm.capture;
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+	spin_lock(&capture->lock);
+	if (capture->streaming) {
+		spin_unlock(&capture->lock);
+		return -EBUSY;
+	}
+	spin_unlock(&capture->lock);
+	spin_lock(&cam->img.img_lock);
+	err = omap24xxcam_sensor_set_format(
+		cam,
+		&cam->img.pix,
+		&cparm->timeperframe,
+		&cam->core.xclk);
+	if (!err) {
+		cam->img.cparm.capturemode = cparm->capturemode;
+		cam->img.cparm.timeperframe =
+			cparm->timeperframe;
+		spin_unlock(&cam->img.img_lock);
+	} else {
+		spin_unlock(&cam->img.img_lock);
+	}
+	return 0;
+}
+
+static int vidioc_reqbufs(struct file *file, void *fh,
+			  struct v4l2_requestbuffers *b)
+{
+	struct omap24xxcam_fh *ofh = fh;
+
+	int err = videobuf_reqbufs(&ofh->vbq, b);
+	if (b->memory == V4L2_MEMORY_MMAP && !err) {
+		err = omap24xxcam_vbq_alloc_mmap_buffers(&ofh->vbq,
+							 b->count);
+		if (err) {
+			/* REVISIT: is this proper reverse for
+			 * videobuf_reqbufs? */
+			videobuf_mmap_free(&ofh->vbq);
+		}
+	}
+	return err;
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
+
+	return videobuf_qbuf(&ofh->vbq, b);
+}
+
+static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct videobuf_buffer *vb;
+	int rval;
+
+	rval = videobuf_dqbuf(&ofh->vbq, b,
+			      file->f_flags & O_NONBLOCK);
+
+	if (rval < 0)
+		return rval;
+	vb = ofh->vbq.bufs[b->index];
+
+	if (cam->sensor->frame_check)
+		rval = cam->sensor->frame_check(
+			cam->sensor,
+			&cam->img.pix,
+			(void *)vb->baddr);
+
+	return rval;
+
+}
+
+static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct omap24xxcam_capture *capture = &cam->capture;
+
+	spin_lock(&capture->lock);
+	if (capture->streaming) {
+		spin_unlock(&capture->lock);
+		return -EBUSY;
+	} else
+		capture->streaming = file;
+	spin_unlock(&capture->lock);
+
+	omap24xxcam_dma_notify(&cam->sgdma.dma, omap24xxcam_core_enable_callback);
+	return videobuf_streamon(&ofh->vbq);
+}
+
+static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+	struct omap24xxcam_capture *capture = &cam->capture;
+	struct videobuf_queue *q = &ofh->vbq;
+	int j;
+	int err;
+
+	/* video-buf lib has trouble to turn off streaming while
+	   any buffer is still in QUEUED state. Let's wait until
+	   all queued buffers are filled.
+	*/
+	for (j = 0; j < VIDEO_MAX_FRAME; j++) {
+		if (NULL == q->bufs[j])
+			continue;
+		videobuf_waiton(q->bufs[j], 0, 0);
+	}
+
+	err = videobuf_streamoff(q);
+	
+	if (err < 0)
+		return err;
+
+	spin_lock(&capture->lock);
+	if (capture->streaming == file)
+		capture->streaming = NULL;
+	spin_unlock(&capture->lock);
+	return 0;
+}
+static int vidioc_g_ctrl(struct file *file, void *fh,
+			 struct v4l2_control *a)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	return cam->sensor->get_control(cam->sensor, a);
+}
+
+static int vidioc_s_ctrl(struct file *file, void *fh,
+			 struct v4l2_control *a)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	return cam->sensor->set_control(cam->sensor, a);
+}
+
+static int vidioc_queryctrl(struct file *file, void *fh,
+			    struct v4l2_queryctrl *a) {
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	return cam->sensor->query_control(cam->sensor, a);
+}
+
+static int vidioc_enum_fmt_cap(struct file *file, void *fh,
+			       struct v4l2_fmtdesc *f)
+{
+	struct omap24xxcam_fh *ofh = fh;
+	struct omap24xxcam_device *cam = ofh->cam;
+
+	return cam->sensor->enum_pixformat(cam->sensor,
+					   f);
+}
+
+/* -------------------------------------------------------------------------- */
+
+	/*
+	 *  file operations
+	 */
+
+static unsigned
+int omap24xxcam_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	struct omap24xxcam_capture *capture = &cam->capture;
+	struct videobuf_buffer *vb;
+	enum v4l2_field field;
+
+	DBG;
+
+	spin_lock(&capture->lock);
+
+	if (capture->streaming == file) {
+		spin_unlock(&capture->lock);
+		/* streaming capture */
+		if (list_empty(&fh->vbq.stream))
+			return POLLERR;
+		vb = list_entry(fh->vbq.stream.next, struct videobuf_buffer,
+				stream);
+	} else if (capture->streaming) {
+		/* streaming I/O is in progress on another file descriptor */
+		spin_unlock(&capture->lock);
+		return POLLERR;
+	} else {
+		/* read() capture */
+		spin_unlock(&capture->lock);
+		mutex_lock(&fh->vbq.lock);
+		if (fh->vbq.read_buf == NULL) {
+			/* need to capture a new image */
+			fh->vbq.read_buf =
+				videobuf_alloc(fh->vbq.msize);
+			if (fh->vbq.read_buf == NULL) {
+				mutex_unlock(&fh->vbq.lock);
+				return POLLERR;
+			}
+			fh->vbq.read_buf->memory = V4L2_MEMORY_USERPTR;
+			field = videobuf_next_field(&fh->vbq);
+			if (fh->vbq.ops->buf_prepare(&fh->vbq,
+						     fh->vbq.read_buf,
+						     field) != 0) {
+				mutex_unlock(&fh->vbq.lock);
+				return POLLERR;
+			}
+			
+			omap24xxcam_dma_notify(&cam->sgdma.dma, omap24xxcam_core_enable_callback);
+			fh->vbq.ops->buf_queue(&fh->vbq,
+					       fh->vbq.read_buf);
+			fh->vbq.read_off = 0;
+		}
+		mutex_unlock(&fh->vbq.lock);
+		vb = (struct videobuf_buffer *)fh->vbq.read_buf;
+	}
+
+	omap24xxcam_dma_notify(&cam->sgdma.dma, omap24xxcam_core_enable_callback);
+	poll_wait(file, &vb->done, wait);
+	if (vb->state == STATE_DONE || vb->state == STATE_ERROR)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static ssize_t
+omap24xxcam_read(struct file *file, char *data, size_t count, loff_t * ppos)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	struct omap24xxcam_capture *capture = &cam->capture;
+	int err;
+
+	DBG;
+
+	spin_lock(&capture->lock);
+	if (capture->streaming) {
+		spin_unlock(&capture->lock);
+		return -EBUSY;
+	}
+	spin_unlock(&capture->lock);
+
+	omap24xxcam_dma_notify(&cam->sgdma.dma, omap24xxcam_core_enable_callback);
+
+	err =
+		videobuf_read_one(&fh->vbq, data, count, ppos,
+				  file->f_flags & O_NONBLOCK);
+
+	DBG_END;
+
+	return err;
+}
+
+static int
+omap24xxcam_mmap_buffers(struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct videobuf_queue *vbq = &fh->vbq;
+	struct videobuf_buffer *vb;
+	unsigned int first, last, size, i, j;
+	int err = 0;
+
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
+static int
+omap24xxcam_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	int err;
+
+	/* let the video-buf mapper check arguments and set-up structures */
+	err = videobuf_mmap_mapper(&fh->vbq, vma);
+	if (err)
+		goto err1;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	/* do mapping to our allocated buffers */
+	err = omap24xxcam_mmap_buffers(file, vma);
+	if (err)
+		goto err2;
+
+	return 0;
+
+err2:
+	if (vma->vm_private_data)
+		kfree(vma->vm_private_data);
+err1:
+
+	return err;
+}
+
+static int omap24xxcam_clock_get(struct omap24xxcam_device *cam)
+{
+	cam->img.fck = clk_get(0, "cam_fck");
+	if (IS_ERR((cam->img.fck))) {
+		dev_err(cam->dev, "can't get cam_fck");
+		return PTR_ERR(cam->img.fck);
+	}
+
+	cam->img.ick = clk_get(0, "cam_ick");
+	if (IS_ERR((cam->img.ick))) {
+		dev_err(cam->dev, "can't get cam_ick");
+		clk_put(cam->img.fck);
+		return PTR_ERR(cam->img.ick);
+	}
+
+	return 0;
+}
+
+static void omap24xxcam_clock_put(struct omap24xxcam_device *cam)
+{
+	if (cam->img.ick == NULL)
+		return;
+
+	clk_put(cam->img.ick);
+	clk_put(cam->img.fck);
+}
+
+/*
+ * Do some sanity check, set clock rate, starts it and
+ *  turn codec audio on 
+ */
+int omap24xxcam_clock_on(struct omap24xxcam_device *cam)
+{
+
+	clk_enable(cam->img.fck);
+	clk_enable(cam->img.ick);
+
+	printk(KERN_DEBUG
+	       "FCLK = %d [%d], usecount = %d\n",
+	       (uint) clk_get_rate(cam->img.fck), CAM_CLOCK,
+	       clk_get_usecount(cam->img.fck));
+
+	return 0;
+}
+
+/*
+ * Do some sanity check, turn clock off and then turn
+ *  codec audio off
+ */
+int omap24xxcam_clock_off(struct omap24xxcam_device *cam)
+{
+	if (cam->img.ick == NULL)
+		return 0;
+	
+	if (clk_get_usecount(cam->img.fck) > 0) {
+		if (clk_get_rate(cam->img.fck) != CAM_CLOCK) {
+			printk(KERN_WARNING
+			       "FCLK for camera should be %d Hz. But is %d Hz\n",
+			       (uint) clk_get_rate(cam->img.fck), CAM_CLOCK);
+		}
+
+		clk_disable(cam->img.fck);
+		clk_disable(cam->img.ick);
+	}
+
+	return 0;
+}
+
+static int omap24xxcam_release(struct inode *inode, struct file *file)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	struct omap24xxcam_capture *capture = &cam->capture;
+
+	DBG;
+
+	spin_lock(&capture->lock);
+
+	/* stop streaming capture */
+	if (capture->streaming == file) {
+		capture->streaming = NULL;
+		spin_unlock(&capture->lock);
+		videobuf_streamoff(&fh->vbq);
+		spin_lock(&capture->lock);
+	}
+
+	/* release read_buf videobuf_buffer struct */
+	if (fh->vbq.read_buf) {
+		omap24xxcam_vbq_release(&fh->vbq, fh->vbq.read_buf);
+		kfree(fh->vbq.read_buf);
+	}
+	spin_unlock(&capture->lock);
+
+	mutex_lock(&cam->mutex);
+	if (--cam->users == 0) {
+		/* power down the sensor */
+		omap24xxcam_core_disable(&cam->core);
+		omap24xxcam_sgdma_disable(&cam->sgdma);
+		omap24xxcam_sensor_disable(cam);
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
+static int omap24xxcam_open(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	struct omap24xxcam_device *cam = camera_module;
+	struct omap24xxcam_capture *capture = &cam->capture;
+	struct omap24xxcam_fh *fh;
+
+	DBG;
+
+	if (!cam || !cam->vfd || (cam->vfd->minor != minor))
+		return -ENODEV;
+
+	if (!try_module_get(cam->sensor->module))
+		return -ENODEV;
+	
+	fh = kzalloc(sizeof(struct omap24xxcam_fh), GFP_KERNEL);
+	
+	if (fh == NULL)
+		return -ENOMEM;
+
+	fh->cam = cam;
+	file->private_data = fh;
+
+	videobuf_queue_init(&fh->vbq, &omap24xxcam_vbq_ops, NULL,
+			    &capture->lock, V4L2_BUF_TYPE_VIDEO_CAPTURE,
+			    V4L2_FIELD_NONE,
+			    sizeof(struct videobuf_buffer), cam);
+	
+	mutex_lock(&cam->mutex);
+	if (cam->users == 0) {
+		omap24xxcam_sgdma_enable(&cam->sgdma);
+		omap24xxcam_sensor_enable(cam);
+
+	}
+	cam->users++;
+	mutex_unlock(&cam->mutex);
+
+	return 0;
+}
+
+static struct file_operations omap24xxcam_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = omap24xxcam_read,
+	.poll = omap24xxcam_poll,
+	.ioctl = video_ioctl2,
+	.mmap = omap24xxcam_mmap,
+	.open = omap24xxcam_open,
+	.release = omap24xxcam_release,
+};
+
+/* -------------------------------------------------------------------------- */
+#ifdef CONFIG_PM
+static int omap24xxcam_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+
+	DBG;
+
+	mutex_lock(&cam->mutex);
+	if (cam->users == 0) {
+		mutex_unlock(&cam->mutex);
+		return 0;
+	}
+	mutex_unlock(&cam->mutex);
+
+	/* Disable the camera interface. */
+	omap24xxcam_core_disable(&cam->core);
+
+	/* Stop the DMA controller and frame sync scatter-gather DMA. */
+	omap24xxcam_sgdma_disable(&cam->sgdma);
+
+	/* power down the sensor */
+	omap24xxcam_sensor_disable(cam);
+
+	return 0;
+}
+static int omap24xxcam_resume(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+
+	DBG;
+
+	mutex_lock(&cam->mutex);
+	if (cam->users == 0) {
+		mutex_unlock(&cam->mutex);
+		return 0;
+	}
+	mutex_unlock(&cam->mutex);
+
+	/* FIXME: what clocks need to be enabled now? None? */
+	omap24xxcam_core_enable(&cam->core);
+
+	if (cam->capture.streaming) {
+		/* capture was in progress, so we need to register 
+		 * our routine to restart the camera interface the next time a 
+		 * DMA transfer is queued.
+		 */
+		omap24xxcam_dma_notify(&cam->sgdma.dma, omap24xxcam_core_enable_callback);
+	}
+
+	/* Restart the scatter-gather DMA queue. */
+	omap24xxcam_sgdma_enable(&cam->sgdma);
+
+	/* power-up and re-configure the sensor */
+	omap24xxcam_sensor_enable(cam);
+
+	/* camera interface will be enabled through dma_notify function
+	 ** automatically when new dma starts 
+	 */
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+int omap24xxcam_device_enable(struct omap24xxcam_device *cam)
+{
+	struct video_device *vfd;
+	int rval;
+
+	if (cam == NULL || !cam->camera_block_alive || cam->vfd != NULL)
+		return -EBUSY;
+
+	/* initialize the video_device struct */
+	vfd = cam->vfd = video_device_alloc();
+	if (!vfd) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not allocate video device struct\n");
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
+	vfd->priv = camera_module;
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
+	/* Enable the xclk output.  The sensor may (and does, in the case of 
+	 * the OV9640) require an xclk input in order for its initialization 
+	 * routine to work.
+	 */
+	/* choose an arbitrary xclk frequency */
+	omap24xxcam_core_xclk_set(&cam->core, 12000000);
+
+	omap24xxcam_camera.priv = cam;
+	
+	if ((rval = omap24xxcam_sensor_init(cam))) {
+		goto err;
+	}
+
+	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not register Video for Linux device\n");
+		vfd->minor = -1;
+		rval = -EBUSY;
+		goto err;
+	}
+
+	printk(KERN_INFO CAM_NAME
+	       ": registered device video%d [v4l2]\n", vfd->minor);
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
+static int omap24xxcam_probe(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam;
+	DBG;
+
+	cam = camera_module = kzalloc(sizeof(struct omap24xxcam_device),
+				      GFP_KERNEL);
+	if (!cam) {
+		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
+		goto err;
+	}
+	cam->dev = &pdev->dev;
+
+	/* initialize the videobuf queue ops */
+	spin_lock_init(&cam->capture.lock);
+
+	/* Impose a lower limit on the amount of memory allocated for capture.
+	 * We require at least enough memory to double-buffer QVGA (300KB).
+	 */
+	if (capture_mem < 320 * 240 * 2 * 2)
+		capture_mem = 320 * 240 * 2 * 2;
+	cam->capture_mem = capture_mem;
+
+	/* request the mem region for the camera registers */
+	if (!request_mem_region(CAM_REG_BASE, CAM_REG_SIZE, CAM_NAME)) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot reserve camera register I/O region\n");
+		goto err;
+	}
+	cam->mmio_base_phys = CAM_REG_BASE;
+	cam->mmio_size = CAM_REG_SIZE;
+
+	/* map the region */
+	cam->mmio_base = (unsigned long)
+		ioremap_nocache(cam->mmio_base_phys,
+				cam->mmio_size);
+	if (!cam->mmio_base) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot map camera register I/O region\n");
+		goto err;
+	}
+
+	/* initialize the camera interface */
+	omap24xxcam_reset(cam);
+
+	init_timer(&cam->sgdma.reset_timer);
+	cam->sgdma.reset_timer.function = omap24xxcam_reset_timer;
+	cam->sgdma.reset_timer.data = (unsigned long)cam;
+	INIT_WORK(&cam->camera_reset_work,
+		  omap24xxcam_camera_reset_work, cam);
+	INIT_WORK(&cam->sensor_reset_work,
+		  omap24xxcam_sensor_reset_work, cam);
+
+	/* initialize the spinlock used to serialize access to the image 
+	 * parameters
+	 */
+	spin_lock_init(&cam->img.img_lock);
+
+	/* initialize the camera interface functional clock frequency */
+	omap24xxcam_core_mclk_set(&cam->core, 96000000); /* 96MHz */
+	if (omap24xxcam_clock_get(cam) < 0)
+		goto err;
+
+	/* initialize the streaming capture parameters */
+	cam->img.cparm.readbuffers = 1;
+	cam->img.cparm.capability = V4L2_CAP_TIMEPERFRAME;
+
+	/* select an arbitrary default capture frame rate of 5fps */
+	cam->img.cparm.timeperframe.numerator = 1;
+	cam->img.cparm.timeperframe.denominator = 15;
+
+	omap24xxcam_core_init(&cam->core, cam->mmio_base + CC_REG_OFFSET);
+	omap24xxcam_sgdma_init(&cam->sgdma, cam->mmio_base + CAMDMA_REG_OFFSET);
+
+	/* install the interrupt service routine */
+	if (request_irq(INT_24XX_CAM_IRQ, omap24xxcam_isr, IRQF_DISABLED,
+			CAM_NAME, cam)) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not install interrupt service routine\n");
+		goto err;
+	}
+	cam->irq = INT_24XX_CAM_IRQ;
+
+	/* set driver specific data to use in power management functions */
+	platform_set_drvdata(pdev, cam);
+
+	mutex_init(&cam->mutex);
+	cam->users = 0;
+
+	cam->camera_block_alive = 1;
+	
+	omap24xxcam_device_enable(cam);
+
+	return 0;
+
+err:
+	omap24xxcam_remove(&omap24xxcam_dev);
+	return -ENODEV;
+}
+
+static int omap24xxcam_remove(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam = camera_module;
+	
+	if (!cam)
+		return 0;
+
+	omap24xxcam_device_disable(cam);
+
+	if (cam->irq) {
+		free_irq(cam->irq, cam);
+		cam->irq = 0;
+	}
+
+	omap24xxcam_sgdma_exit(&cam->sgdma);
+	omap24xxcam_core_exit(&cam->core);
+	
+	omap24xxcam_clock_off(cam);
+	omap24xxcam_clock_put(cam);
+
+	if (cam->mmio_base) {
+		iounmap((void *)cam->mmio_base);
+		cam->mmio_base = 0;
+	}
+
+	if (cam->mmio_base_phys) {
+		release_mem_region(cam->mmio_base_phys,
+				   cam->mmio_size);
+		cam->mmio_base_phys = 0;
+	}
+
+	kfree(cam);
+	camera_module = NULL;
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
+#else
+	.suspend = NULL,
+	.resume = NULL,
+#endif
+	.shutdown = NULL,
+	.driver = {
+		.name = CAM_NAME,
+	},
+};
+
+static struct platform_device omap24xxcam_dev = {
+	.name = CAM_NAME,
+	.dev = {
+		.release = NULL,
+		},
+	.id = 0,
+};
+
+int __init omap24xxcam_init(void)
+{
+	int ret;
+
+	DBG;
+
+	ret = platform_driver_register(&omap24xxcam_driver);
+	if (ret != 0)
+		return ret;
+
+	ret = platform_device_register(&omap24xxcam_dev);
+	if (ret != 0) {
+		platform_driver_unregister(&omap24xxcam_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
+void __exit omap24xxcam_cleanup(void)
+{
+	DBG;
+
+	platform_device_unregister(&omap24xxcam_dev);
+	platform_driver_unregister(&omap24xxcam_driver);
+
+	omap24xxcam_remove(&omap24xxcam_dev);
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
index 0000000..eba5ea6
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.h
@@ -0,0 +1,659 @@
+/*
+ * drivers/media/video/omap24xxcam.h
+ *
+ * Video-for-Linux (Version 2) camera capture driver for 
+ * the OMAP24xx camera controller.
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#ifndef OMAP24XXCAM_H
+#define OMAP24XXCAM_H
+
+#include "sensor_if.h"
+
+//#define DEBUG_CAM
+
+#define CAM_NAME 	"omap24xxcam"
+
+#ifdef DEBUG_CAM
+#define DBG		printk(KERN_INFO CAM_NAME ": %s\n", __FUNCTION__)
+#define DBG_END 	printk(KERN_INFO CAM_NAME ": %s END!\n", __FUNCTION__)
+#define DBG_MID(x)	printk(KERN_INFO CAM_NAME ": %s - %d\n", __FUNCTION__, x)
+#else
+#define DBG
+#define DBG_END
+#define DBG_MID(x)
+#endif
+
+#define CAM_CLOCK		96000000
+
+/* physical memory map definitions */
+	/* camera subsystem */
+#define CAM_REG_BASE		0x48052000
+#define CAM_REG_SIZE		0x00001000
+	/* camera core */
+#define CC_REG_OFFSET		0x00000400
+	/* camera DMA */
+#define CAMDMA_REG_OFFSET	0x00000800
+	/* camera MMU */
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
+struct omap24xx_cc_regs {
+	u32 revision;		/* 0x000 */
+	u32 res1[3];
+	u32 sysconfig;		/* 0x010 */
+	u32 sysstatus;		/* 0x014 */
+	u32 irqstatus;		/* 0x018 */
+	u32 irqenable;		/* 0x01C */
+	u32 res2[8];
+	u32 ctrl;		/* 0x040 */
+	u32 ctrl_dma;		/* 0x044 */
+	u32 ctrl_xclk;		/* 0x048 */
+	u32 fifodata;		/* 0x04C */
+	u32 test;		/* 0x050 */
+	u32 genpar;		/* 0x054 */
+	u32 ccpfscr;		/* 0x058 */
+	u32 ccpfecr;		/* 0x05C */
+	u32 ccplscr;		/* 0x060 */
+	u32 ccplecr;		/* 0x064 */
+	u32 ccpdfr;		/* 0x068 */
+};
+struct omap24xx_vid2_format {
+	struct v4l2_pix_format pix;
+	__s32 left;		/* following two members are defined to */
+	__s32 top;		/* position the video2 layer on the lcd */
+
+};
+
+/* forward declarations */
+struct omap24xxcam_fh;
+struct omap24xxcam_device;
+struct omap24xxcam_sgdma;
+struct omap24xxcam_dma;
+
+extern struct omap_camera omap24xxcam_camera;
+extern struct omap24xxcam_device *camera_module;
+extern struct videobuf_queue_ops omap24xxcam_vbq_ops;
+
+/* camera DMA definitions */
+#define DMA_THRESHOLD 32		/* number of bytes transferred per DMA request */
+/* NUM_CAMDMA_CHANNELS is the number of logical channels provided by the camera 
+ * DMA controller.
+ */
+#define NUM_CAMDMA_CHANNELS 4
+/* NUM_SG_DMA is the number of scatter-gather DMA transfers that can be queued.
+ * We need it to be 2 greater than the maximum number of video frames so that 
+ * we can use 2 slots for overlay while still having VIDEO_MAX_FRAME slots left 
+ * for streaming.
+ */
+#define NUM_SG_DMA (VIDEO_MAX_FRAME+2)
+
+typedef void (*sgdma_callback_t) (struct omap24xxcam_sgdma * cam,
+				unsigned long status, void *arg);
+typedef void (*dma_callback_t) (struct omap24xxcam_dma * cam,
+				unsigned long status, void *arg);
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
+	unsigned int len;        /* total length of sglist (excluding bytes due to page alignment) */
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
+	/* dma_notify is a pointer to a callback routine for notification when 
+	 * a DMA transfer has been started.
+	 */
+	void (*dma_notify) (struct omap24xxcam_device * cam);
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
+/* videobuf_queue */
+struct omap24xxcam_capture {
+	spinlock_t lock;	/* spinlock for videobuf queues */
+	/* We allow streaming from at most one filehandle at a time.  
+	 * non-NULL means streaming is in progress.
+	 */
+	unsigned long field_count;	/* field counter for videobuf_buffer */
+	struct file *streaming;
+};
+
+/* image parameters */
+struct omap24xxcam_img {
+	/* The img_lock is used to serialize access to the image parameters for 
+	 * overlay and capture.
+	 */
+	spinlock_t img_lock;
+
+	/* Access to everything below here is locked by img_lock */
+
+	/* capture parameters (frame rate, number of buffers) */
+	struct v4l2_captureparm cparm;
+
+	/* pix defines the size and pixel format of the image captured by the 
+	 * sensor.  This also defines the size of the framebuffers.  The 
+	 * same pool of framebuffers is used for video capture and video 
+	 * overlay.  These parameters are set/queried by the 
+	 * VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with a CAPTURE buffer type.
+	 */
+	struct v4l2_pix_format pix;
+
+	/* Camera module clocks */
+	struct clk *fck;
+	struct clk *ick;
+};
+
+struct omap24xxcam_core {
+	/* camera core base address */
+	unsigned long base;
+	
+	/* If non-zero, enable xclk immediately after _enable */
+	int xclk_enabled;
+
+	/* frequency (in Hz) of camera interface xclk output */
+	unsigned long xclk;
+
+	/* frequncy (in Hz) of camera interface functional clock (MCLK) */
+	unsigned long mclk;
+};
+
+/* per-device data structure */
+struct omap24xxcam_device {
+	/*
+	 * Lock mutex before accessing users. Mutex also serialises
+	 * sensor (de)initialisation. 
+	 */
+	struct mutex mutex;
+	int users;
+	int sensor_alive;
+	int camera_block_alive;
+	int camera_init;
+	
+	struct omap24xxcam_sgdma sgdma;
+
+	struct omap24xxcam_capture capture;
+
+	struct omap24xxcam_img img;
+
+	struct omap24xxcam_core core;
+
+	unsigned int irq;
+
+	unsigned long mmio_base;
+	unsigned long mmio_base_phys;
+	unsigned long mmio_size;
+
+	struct omap_camera_sensor *sensor;
+
+	struct device *dev;
+	struct video_device *vfd;
+
+	struct work_struct camera_reset_work;
+	struct work_struct sensor_reset_work;
+
+	int capture_mem;
+};
+
+struct omap24xxcam_fh {
+	struct videobuf_queue vbq;
+	struct omap24xxcam_device *cam;
+};
+
+/*
+ * camera subsystem register I/O routines
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
+/* camera core function prototypes */
+
+void omap24xxcam_core_init(struct omap24xxcam_core *core,
+			   unsigned long base);
+void omap24xxcam_core_exit(const struct omap24xxcam_core *core);
+void omap24xxcam_core_enable(struct omap24xxcam_core *core);
+void omap24xxcam_core_disable(struct omap24xxcam_core *core);
+void omap24xxcam_core_enable_callback(struct omap24xxcam_device *cam);
+void omap24xxcam_core_isr(struct omap24xxcam_core *core);
+
+void omap24xxcam_core_xclk_enable(struct omap24xxcam_core *core);
+void omap24xxcam_core_xclk_disable(struct omap24xxcam_core *core);
+void omap24xxcam_core_xclk_set(struct omap24xxcam_core *core, unsigned long xclk);
+void omap24xxcam_core_mclk_set(struct omap24xxcam_core *core,
+			       unsigned long mclk);
+
+/* sensor function prototypes */
+
+int omap24xxcam_sensor_init(struct omap24xxcam_device *cam);
+void omap24xxcam_sensor_exit(struct omap24xxcam_device *cam);
+int omap24xxcam_sensor_enable(struct omap24xxcam_device *cam);
+void omap24xxcam_sensor_disable(struct omap24xxcam_device *cam);
+void omap24xxcam_sensor_reset_work(void * data);
+void omap24xxcam_sensor_reset_schedule(struct omap_camera *oc,
+				       struct omap_camera_sensor *os);
+unsigned long omap24xxcam_sensor_calc_xclk(struct omap24xxcam_device *cam,
+					   struct v4l2_pix_format *pix,
+					   struct v4l2_fract *timeperframe);
+int omap24xxcam_sensor_try_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix);
+int omap24xxcam_sensor_set_format(struct omap24xxcam_device *cam,
+				  struct v4l2_pix_format *pix,
+				  struct v4l2_fract *timeperframe,
+				  unsigned long *xclk);
+int omap24xxcam_sensor_register(struct omap_camera *oc,
+				struct omap_camera_sensor *os);
+void omap24xxcam_sensor_unregister(struct omap_camera *oc,
+				   struct omap_camera_sensor *os);
+
+/* vbq function prototypes */
+
+int
+omap24xxcam_vbq_alloc_mmap_buffers(struct videobuf_queue *vbq,
+				   unsigned int count);
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
+int omap24xxcam_clock_on(struct omap24xxcam_device *cam);
+int omap24xxcam_clock_off(struct omap24xxcam_device *cam);
+void omap24xxcam_dispc_clock_on(struct omap24xxcam_device *cam);
+void omap24xxcam_dispc_clock_off(struct omap24xxcam_device *cam);
+void omap24xxcam_new_capture_format(struct omap24xxcam_device *cam);
+
+int omap24xxcam_device_enable(struct omap24xxcam_device *cam);
+void omap24xxcam_device_disable(struct omap24xxcam_device *cam);
+
+#endif				/* ifndef OMAP24XXCAM_H */
-- 
1.5.0.1
