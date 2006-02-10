From: David Cohen <david.cohen@indt.org.br>
Subject: [PATCH] omap camera
Date: Fri, 10 Feb 2006 17:03:23 -0400
Message-ID: <43ECFF9B.80509@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070003090305090504080104"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003090305090504080104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I've updated the driver for OMAP 24xx camera from TI (kernel version
2.6.10). It is now working with the public omap tree.
Is there anybody else working with camera driver?
I don't think it is appropriate to use a common driver (camera_core) for
the omap 2420 and 1611/1710. I guess creating a common driver for omap1
(current camera_core) and other for omap2 (an updated camera_core) could
be better. Any comment?

BR,

David Cohen


--------------070003090305090504080104
Content-Type: text/plain;
 name="diff_omap24xxcam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff_omap24xxcam.patch"

diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index 93cfb54..5988ca3 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_VIDEO_BTCX)  += btcx-risc.o
 obj-$(CONFIG_VIDEO_TVEEPROM) += tveeprom.o
 
 obj-$(CONFIG_VIDEO_M32R_AR_M64278) += arv.o
-obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omap/
+obj-$(CONFIG_VIDEO_OMAP) += omap/
 
 obj-$(CONFIG_VIDEO_DECODER)     += saa7115.o cx25840/ saa7127.o
 
diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/omap/Kconfig
index 809193b..ecb7f53 100644
--- a/drivers/media/video/omap/Kconfig
+++ b/drivers/media/video/omap/Kconfig
@@ -1,7 +1,11 @@
+config VIDEO_OMAP
+	tristate "Video devices for OMAP1/2"
+	select VIDEO_BUF
+	depends on VIDEO_DEV
+	
 config VIDEO_OMAP_CAMERA
 	tristate "OMAP Camera support (EXPERIMENTAL)"
-	select VIDEO_BUF
-	depends on VIDEO_DEV && (ARCH_OMAP16XX || ARCH_OMAP24XX)
+	depends on VIDEO_OMAP && (ARCH_OMAP16XX || ARCH_OMAP24XX)
 	help
 	  V4L2 camera driver support for OMAP1/2 based boards.
 	
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index c4c5a81..6c052ce 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -2,12 +2,16 @@
 
 obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
 obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
+obj-$(CONFIG_VIDEO_OMAP2_OUT) += omapvout.o
 
-objs-yy := camera_core.o
+objs-y$(CONFIG_ARCH_OMAP16XX) += camera_core.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o
+objs-y$(CONFIG_ARCH_OMAP24XX) += omap24xxcam.o
 objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
+objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_MACH_OMAP_H4) += omap24xxvout.o omap24xxlib.o
 
 omapcamera-objs := $(objs-yy)
+omapvout-objs := $(objs-yy)
 
 EXTRA_CFLAGS = -I$(src)/..
diff --git a/drivers/media/video/omap/omap24xxcam.c b/drivers/media/video/omap/omap24xxcam.c
new file mode 100644
index 0000000..8133804
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.c
@@ -0,0 +1,2603 @@
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
+ * January 2006 - Modified for new sensor interface.
+ * Copyright (C) 2006 Texas Instruments, Inc.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/delay.h>
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
+#include <linux/videodev.h>
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/device.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+#include <asm/processor.h>
+
+#include <asm/arch/clock.h>
+#include <asm/arch/display.h>
+
+#include "omap24xxcam.h"
+#include "sensor_if.h"
+#include "omap24xxlib.h"
+
+#define DEFAULT_CAM_FUNC_CLK 96000000	/* 96MHz */
+#define DEFAULT_SENSOR_XCLK  12000000	/* 12MHz */
+
+#define QVGA_SIZE 	320*240*2	/* memory needed for QVGA image */
+#define VGA_SIZE 	QVGA_SIZE*4	/* memory needed for VGA image */
+#define SXGA_SIZE 	1280*960*2	/* memory needed for SXGA image */
+
+#define CAM_NAME "omap24xxcam"
+
+/* this is the sensor ops implemented by the associated sesnor driver */
+extern struct camera_sensor camera_sensor_if;
+
+static void omap24xxcam_cleanup(void);
+
+/* global variables */
+static struct omap24xxcam_device *saved_cam;
+
+/* module parameters */
+static int video_nr = -1;	/* video device minor (-1 ==> auto assign) */
+
+/* Maximum amount of memory to use for capture buffers.
+ * Default is 4800KB, enough to double-buffer SXGA. */
+static int capture_mem = SXGA_SIZE * 2;
+
+/* Size of video overlay framebuffer.  This determines the maximum image size
+ * that can be previewed.  Default is 600KB, enough for VGA. */
+static int overlay_mem = VGA_SIZE;
+
+/* -------------------------------------------------------------------------- */
+#ifdef CONFIG_OMAP24XX_DPM
+#define omap24xxcam_suspend_lockout(s,f) \
+	if ((s)->suspended) {\
+		if ((f)->f_flags & O_NONBLOCK)\
+			return -EBUSY;\
+		wait_event_interruptible((s)->suspend_wq,\
+					(s)->suspended == 0);\
+	}
+#else
+#define omap24xxcam_suspend_lockout(s, f) do {} while(0)
+#endif
+
+/* Set the value of the CC_CTRL register in cam->cc_ctrl that is required to
+ * support the currently selected capture format in cam->pix.  The CC_CTRL bits
+ * which must be configured are:  NOBT_SYNCHRO, BT_CORRECT, PAR_ORDERCAM,
+ * PAR_CLK_POL, NOBT_HS_POL, NOBT_VS_POL, PAR_MODE, and CCP_MODE.  The CC_RST,
+ * CC_FRAME_TRIG, and CC_EN bits are actively managed by the driver and should
+ * be set to zero by this routine.
+ */
+static void
+omap24xxcam_sensor_cc_ctrl(struct omap24xxcam_device *cam)
+{
+	struct v4l2_pix_format *pix = &cam->pix;
+	struct camera_sensor *sensor = cam->cam_sensor;
+	 
+	/* basic mode */
+	cam->cc_ctrl = sensor->parallel_mode << CC_CTRL_PAR_MODE_SHIFT;
+	/* sync polarity */
+	cam->cc_ctrl |= (sensor->hs_polarity << CC_CTRL_NOBT_HS_POL_SHIFT);
+	cam->cc_ctrl |= (sensor->vs_polarity << CC_CTRL_NOBT_VS_POL_SHIFT);
+	/* swap */
+	cam->cc_ctrl |= (sensor->image_swap ? CC_CTRL_PAR_ORDERCAM : 0);
+	/* based on BT or NOBT */
+	if ((sensor->parallel_mode == PAR_MODE_BT8) ||
+	  (sensor->parallel_mode == PAR_MODE_BT10))
+		/* BT correction enable */
+		cam->cc_ctrl |= (sensor->bt_correction ? CC_CTRL_BT_CORRECT : 0);
+	else
+		/* always use the rising edger to trigger the acquisition
+		   in NOBT modes. This is recommended */
+		cam->cc_ctrl |= CC_CTRL_NOBT_SYNCHRO;
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_RGB555:
+	default:
+		/* These formats need a 16-bit byte swap */
+		cam->cc_ctrl |= CC_CTRL_PAR_ORDERCAM;
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_RGB565X:
+	case V4L2_PIX_FMT_RGB555X:
+		/* These formats don't need a 16-bit byte swap */
+		break;
+	}
+}
+
+/*
+ * camera core register I/O routines
+ */
+
+static __inline__ u32
+cc_reg_in(const struct omap24xxcam_device *cam, u32 offset)
+{
+	return readl(cam->cam_mmio_base + CC_REG_OFFSET + offset);
+}
+
+static __inline__ u32
+cc_reg_out(const struct omap24xxcam_device *cam, u32 offset, u32 val)
+{
+	writel(val, cam->cam_mmio_base + CC_REG_OFFSET + offset);
+	return val;
+}
+
+static __inline__ u32
+cc_reg_merge(const struct omap24xxcam_device *cam, u32 offset,
+	     u32 val, u32 mask)
+{
+	u32 addr = cam->cam_mmio_base + CC_REG_OFFSET + offset;
+	u32 new_val = (readl(addr) & ~mask) | (val & mask);
+
+	writel(new_val, addr);
+	return new_val;
+}
+
+static void
+cc_init(const struct omap24xxcam_device *cam)
+{
+	cc_reg_out(cam, CC_SYSCONFIG, CC_SYSCONFIG_AUTOIDLE);
+}
+
+/*
+ * camera DMA register I/O routines
+ */
+
+static __inline__ u32
+camdma_reg_in(const struct omap24xxcam_device *cam, u32 offset)
+{
+	return readl(cam->cam_mmio_base + CAMDMA_REG_OFFSET + offset);
+}
+
+static __inline__ u32
+camdma_reg_out(const struct omap24xxcam_device *cam, u32 offset, u32 val)
+{
+	writel(val, cam->cam_mmio_base + CAMDMA_REG_OFFSET + offset);
+	return val;
+}
+
+static __inline__ u32
+camdma_reg_merge(const struct omap24xxcam_device *cam, u32 offset,
+		 u32 val, u32 mask)
+{
+	u32 addr = cam->cam_mmio_base + CAMDMA_REG_OFFSET + offset;
+	u32 new_val = (readl(addr) & ~mask) | (val & mask);
+
+	writel(new_val, addr);
+	return new_val;
+}
+
+static void
+camdma_init(const struct omap24xxcam_device *cam)
+{
+	camdma_reg_out(cam, CAMDMA_OCP_SYSCONFIG,
+		       CAMDMA_OCP_SYSCONFIG_MIDLEMODE_FSTANDBY
+		       | CAMDMA_OCP_SYSCONFIG_SIDLEMODE_FIDLE
+		       | CAMDMA_OCP_SYSCONFIG_AUTOIDLE);
+
+	camdma_reg_merge(cam, CAMDMA_GCR, 0x10,
+			 CAMDMA_GCR_MAX_CHANNEL_FIFO_DEPTH);
+}
+
+/*
+ * camera MMU register I/O routines
+ */
+
+static __inline__ u32
+cammmu_reg_in(const struct omap24xxcam_device *cam, u32 offset)
+{
+	return readl(cam->cam_mmio_base + CAMMMU_REG_OFFSET + offset);
+}
+
+static __inline__ u32
+cammmu_reg_out(const struct omap24xxcam_device *cam, u32 offset, u32 val)
+{
+	writel(val, cam->cam_mmio_base + CAMMMU_REG_OFFSET + offset);
+	return val;
+}
+
+static __inline__ u32
+cammmu_reg_merge(const struct omap24xxcam_device *cam, u32 offset,
+		 u32 val, u32 mask)
+{
+	u32 addr = cam->cam_mmio_base + CAMMMU_REG_OFFSET + offset;
+	u32 new_val = (readl(addr) & ~mask) | (val & mask);
+
+	writel(new_val, addr);
+	return new_val;
+}
+
+static void
+cammmu_init(const struct omap24xxcam_device *cam)
+{
+	/* set the camera MMU autoidle bit */
+	cammmu_reg_out(cam, CAMMMU_SYSCONFIG, CAMMMU_SYSCONFIG_AUTOIDLE);
+}
+
+/*
+ * camera subsystem register I/O routines
+ */
+
+static __inline__ u32
+cam_reg_in(const struct omap24xxcam_device *cam, u32 offset)
+{
+	return readl(cam->cam_mmio_base + offset);
+}
+
+static __inline__ u32
+cam_reg_out(const struct omap24xxcam_device *cam, u32 offset, u32 val)
+{
+	writel(val, cam->cam_mmio_base + offset);
+	return val;
+}
+
+static __inline__ u32
+cam_reg_merge(const struct omap24xxcam_device *cam, u32 offset,
+	      u32 val, u32 mask)
+{
+	u32 addr = cam->cam_mmio_base + offset;
+	u32 new_val = (readl(addr) & ~mask) | (val & mask);
+
+	writel(new_val, addr);
+	return new_val;
+}
+
+/* Reset the camera subsystem (camera core, camera DMA, and camera MMU) */
+static void
+cam_reset(const struct omap24xxcam_device *cam, unsigned long timeout_ticks)
+{
+	unsigned long timeout;
+
+	cam_reg_out(cam, CAM_SYSCONFIG, CAM_SYSCONFIG_SOFTRESET);
+	/* wait for reset to complete */
+	timeout = jiffies + timeout_ticks;
+	while (!(cam_reg_in(cam, CAM_SYSSTATUS) & CAM_SYSSTATUS_RESETDONE)
+	       && time_before(jiffies, timeout)) {
+		if (!in_atomic()) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(1);
+		} else
+			udelay(10);
+	}
+	if (unlikely
+	    (!(cam_reg_in(cam, CAM_SYSSTATUS) & CAM_SYSSTATUS_RESETDONE))) {
+		printk(KERN_WARNING CAM_NAME
+		       ": timeout waiting for camera subsystem reset\n");
+	}
+
+	return;
+}
+
+/* Initialize the camera subsystem (camera core, camera DMA, and camera MMU) */
+static void
+cam_init(const struct omap24xxcam_device *cam)
+{
+	/* reset the camera subsystem with a timeout of 200ms */
+	cam_reset(cam, HZ / 5);
+
+	/* set the camera subsystem autoidle bit */
+	cam_reg_out(cam, CAM_SYSCONFIG, CAM_SYSCONFIG_AUTOIDLE);
+
+	/* initialize the camera MMU */
+	cammmu_init(cam);
+
+	/* initialize the camera DMA controller */
+	camdma_init(cam);
+
+	/* initialize the camera core module */
+	cc_init(cam);
+}
+
+/* Program the camera interface xclk for the frequency cam->xclk based on
+ * the functional clock frequency cam->mclk.  If the specifed cam->xclk
+ * frequency is not possible based on the value of cam->mclk, then the
+ * closest xclk frequency lower than the specified xclk will be selected.
+ * The actual xclk frequency is returned in cam->xclk.  If cam->xclk is zero,
+ * then xclk is turned off (stable low value).
+ */
+static void
+omap24xxcam_set_xclk(struct omap24xxcam_device *cam)
+{
+	unsigned long divisor;
+
+	if (cam->mclk == 0)
+		cam->mclk = DEFAULT_CAM_FUNC_CLK;	/* supply a default mclk */
+
+	if (cam->xclk == 0) {
+		cc_reg_out(cam, CC_CTRL_XCLK, CC_CTRL_XCLK_DIV_STABLE_LOW);
+		return;
+	}
+
+	if (cam->xclk > cam->mclk)
+		cam->xclk = cam->mclk;
+
+	divisor = cam->mclk / cam->xclk;
+	if (cam->xclk * divisor < cam->mclk)
+		divisor += 1;
+	if (divisor > (CC_CTRL_XCLK_DIV >> CC_CTRL_XCLK_DIV_SHIFT))
+		divisor = CC_CTRL_XCLK_DIV >> CC_CTRL_XCLK_DIV_SHIFT;
+	cam->xclk = cam->mclk / divisor;
+	if (divisor == 1)
+		cc_reg_out(cam, CC_CTRL_XCLK, CC_CTRL_XCLK_DIV_BYPASS);
+	else
+		cc_reg_out(cam, CC_CTRL_XCLK, divisor);
+}
+
+/* -------------------------------------------------------------------------- */
+
+/* Start a DMA transfer from the camera to memory.
+ * Returns zero if the transfer was successfully started, or non-zero if all
+ * DMA channels are already in use or starting is currently inhibited.
+ */
+static int
+omap24xxcam_dma_start(struct omap24xxcam_device *cam, dma_addr_t start,
+		      unsigned long len, dma_callback_t callback, void *arg)
+{
+	unsigned long irqflags;
+	int dmach;
+	void (*dma_notify) (struct omap24xxcam_device * cam);
+
+	spin_lock_irqsave(&cam->dma_lock, irqflags);
+
+	if (!cam->free_dmach || cam->dma_stop) {
+		spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+		return -EBUSY;
+	}
+
+	dmach = cam->next_dmach;
+
+	cam->camdma[dmach].callback = callback;
+	cam->camdma[dmach].arg = arg;
+
+	camdma_reg_out(cam, CAMDMA_CCR(dmach),
+		       CAMDMA_CCR_SEL_SRC_DST_SYNC
+		       | CAMDMA_CCR_BS
+		       | CAMDMA_CCR_DST_AMODE_POST_INC
+		       | CAMDMA_CCR_SRC_AMODE_POST_INC
+		       | CAMDMA_CCR_FS | CAMDMA_CCR_SYNCHRO_CAMERA);
+	camdma_reg_out(cam, CAMDMA_CLNK_CTRL(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CEN(dmach), len);
+	camdma_reg_out(cam, CAMDMA_CFN(dmach), 1);
+	camdma_reg_out(cam, CAMDMA_CSDP(dmach),
+		       CAMDMA_CSDP_WRITE_MODE_POSTED
+		       | CAMDMA_CSDP_DST_BURST_EN_16
+		       | CAMDMA_CSDP_DST_PACKED
+		       | CAMDMA_CSDP_SRC_BURST_EN_16
+		       | CAMDMA_CSDP_SRC_PACKED
+		       | CAMDMA_CSDP_DATA_TYPE_8BITS);
+	camdma_reg_out(cam, CAMDMA_CSSA(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CDSA(dmach), start);
+	camdma_reg_out(cam, CAMDMA_CSEI(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CSFI(dmach), DMA_THRESHOLD);
+	camdma_reg_out(cam, CAMDMA_CDEI(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CDFI(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CSR(dmach),
+		       CAMDMA_CSR_MISALIGNED_ERR
+		       | CAMDMA_CSR_SUPERVISOR_ERR
+		       | CAMDMA_CSR_SECURE_ERR
+		       | CAMDMA_CSR_TRANS_ERR
+		       | CAMDMA_CSR_BLOCK | CAMDMA_CSR_DROP);
+	camdma_reg_out(cam, CAMDMA_CICR(dmach),
+		       CAMDMA_CICR_MISALIGNED_ERR_IE
+		       | CAMDMA_CICR_SUPERVISOR_ERR_IE
+		       | CAMDMA_CICR_SECURE_ERR_IE
+		       | CAMDMA_CICR_TRANS_ERR_IE
+		       | CAMDMA_CICR_BLOCK_IE | CAMDMA_CICR_DROP_IE);
+
+	/* We're ready to start the DMA transfer. */
+	if (cam->free_dmach < NUM_CAMDMA_CHANNELS) {
+		/* A transfer is already in progress, so try to chain to it. */
+		int prev_dmach, ch;
+
+		if (dmach == 0)
+			prev_dmach = NUM_CAMDMA_CHANNELS - 1;
+		else
+			prev_dmach = dmach - 1;
+		camdma_reg_out(cam, CAMDMA_CLNK_CTRL(prev_dmach),
+			       CAMDMA_CLNK_CTRL_ENABLE_LNK | dmach);
+		/* Did we chain the DMA transfer before the previous one
+		 * finished? Scan the in-use channel list. ch is the first one.
+		 */
+		ch = (dmach + cam->free_dmach) % NUM_CAMDMA_CHANNELS;
+		/* dmach is guranteed to start as long as we find one channel
+		   is still enabled */
+		while (!(camdma_reg_in(cam, CAMDMA_CCR(ch))
+			 & CAMDMA_CCR_ENABLE)) {
+			if (ch == dmach) {
+				/* The previous transfers have ended and this one
+				 * hasn't started, so we must not have chained
+				 * to the previous one in time.  We'll have to
+				 * start it now.
+				 */
+				camdma_reg_out(cam, CAMDMA_CCR(dmach),
+					       CAMDMA_CCR_SEL_SRC_DST_SYNC
+					       | CAMDMA_CCR_BS
+					       | CAMDMA_CCR_DST_AMODE_POST_INC
+					       | CAMDMA_CCR_SRC_AMODE_POST_INC
+					       | CAMDMA_CCR_ENABLE
+					       | CAMDMA_CCR_FS
+					       | CAMDMA_CCR_SYNCHRO_CAMERA);
+				break;
+			} else
+				ch = (ch + 1) % NUM_CAMDMA_CHANNELS;
+		}
+	} else {
+		/* No transfer is in progress, so we'll just start this one
+		 * now.
+		 */
+		camdma_reg_out(cam, CAMDMA_CCR(dmach),
+			       CAMDMA_CCR_SEL_SRC_DST_SYNC
+			       | CAMDMA_CCR_BS
+			       | CAMDMA_CCR_DST_AMODE_POST_INC
+			       | CAMDMA_CCR_SRC_AMODE_POST_INC
+			       | CAMDMA_CCR_ENABLE
+			       | CAMDMA_CCR_FS | CAMDMA_CCR_SYNCHRO_CAMERA);
+	}
+
+	cam->next_dmach = (cam->next_dmach + 1) % NUM_CAMDMA_CHANNELS;
+	cam->free_dmach--;
+
+	dma_notify = cam->dma_notify;
+	cam->dma_notify = NULL;
+
+	spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+
+	if (dma_notify)
+		(*dma_notify) (cam);
+
+	return 0;
+}
+
+/* DMA completion routine for the scatter-gather DMA fragments. */
+static void
+omap24xxcam_sg_dma_callback(struct omap24xxcam_device *cam, unsigned long csr,
+			    void *arg)
+{
+	int sgslot = (int) arg;
+	struct sgdma_state *sgdma;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock(&cam->sg_lock);
+
+	sgdma = cam->sgdma + sgslot;
+	if (!sgdma->queued_sglist) {
+		spin_unlock(&cam->sg_lock);
+		printk(KERN_DEBUG CAM_NAME
+		       ": sgdma completed when none queued!\n");
+		return;
+	}
+
+	sgdma->csr |= csr;
+	if (!--sgdma->queued_sglist) {
+		/* Queue for this sglist is empty, so check to see if we're
+		 * done.
+		 */
+		if ((sgdma->next_sglist == sgdma->sglen)
+		    || (sgdma->csr & csr_error)) {
+			dma_callback_t callback = sgdma->callback;
+			void *arg = sgdma->arg;
+			unsigned long sg_csr = sgdma->csr;
+			/* All done with this sglist */
+			cam->free_sgdma++;
+			if (callback) {
+				spin_unlock(&cam->sg_lock);
+				(*callback) (cam, sg_csr, arg);
+				return;
+			}
+		}
+	}
+
+	spin_unlock(&cam->sg_lock);
+}
+
+/* Process the scatter-gather DMA queue by starting queued transfers. */
+static void
+omap24xxcam_sg_dma_process(struct omap24xxcam_device *cam)
+{
+	unsigned long irqflags;
+	int queued_sgdma, sgslot;
+	struct sgdma_state *sgdma;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock_irqsave(&cam->sg_lock, irqflags);
+
+	queued_sgdma = NUM_SG_DMA - cam->free_sgdma;
+	sgslot = (cam->next_sgdma + cam->free_sgdma) % NUM_SG_DMA;
+	while (queued_sgdma > 0) {
+		sgdma = cam->sgdma + sgslot;
+		while ((sgdma->next_sglist < sgdma->sglen) &&
+		       !(sgdma->csr & csr_error)) {
+			const struct scatterlist *sglist;
+
+			sglist = sgdma->sglist + sgdma->next_sglist;
+			/* try to start the next DMA transfer */
+			if (omap24xxcam_dma_start(cam, sg_dma_address(sglist),
+						  sg_dma_len(sglist),
+						  omap24xxcam_sg_dma_callback,
+						  (void *) sgslot)) {
+				/* DMA start failed */
+				spin_unlock_irqrestore(&cam->sg_lock, irqflags);
+				return;
+			} else {
+				/* DMA start was successful */
+				sgdma->next_sglist++;
+				sgdma->queued_sglist++;
+			}
+		}
+		queued_sgdma--;
+		sgslot = (sgslot + 1) % NUM_SG_DMA;
+	}
+
+	spin_unlock_irqrestore(&cam->sg_lock, irqflags);
+}
+
+/* Queue a scatter-gather DMA transfer from the camera to memory.
+ * Returns zero if the transfer was successfully queued, or
+ * non-zero if all of the scatter-gather slots are already in use.
+ */
+static int
+omap24xxcam_sg_dma_queue(struct omap24xxcam_device *cam,
+			 const struct scatterlist *sglist, int sglen,
+			 dma_callback_t callback, void *arg)
+{
+	unsigned long irqflags;
+	struct sgdma_state *sgdma;
+
+	if ((sglen < 0) || ((sglen > 0) & !sglist))
+		return -EINVAL;
+
+	spin_lock_irqsave(&cam->sg_lock, irqflags);
+
+	if (!cam->free_sgdma) {
+		spin_unlock_irqrestore(&cam->sg_lock, irqflags);
+		return -EBUSY;
+	}
+
+	sgdma = cam->sgdma + cam->next_sgdma;
+
+	sgdma->sglist = sglist;
+	sgdma->sglen = sglen;
+	sgdma->next_sglist = 0;
+	sgdma->queued_sglist = 0;
+	sgdma->csr = 0;
+	sgdma->callback = callback;
+	sgdma->arg = arg;
+
+	cam->next_sgdma = (cam->next_sgdma + 1) % NUM_SG_DMA;
+	cam->free_sgdma--;
+
+	spin_unlock_irqrestore(&cam->sg_lock, irqflags);
+
+	omap24xxcam_sg_dma_process(cam);
+
+	return 0;
+}
+
+/* Abort all chained DMA transfers.  After all transfers have been aborted and
+ * the DMA controller is idle, the completion routines for any aborted transfers
+ * will be called in sequence.  The DMA controller may not be idle after this
+ * routine completes, because the completion routines might start new transfers.
+ */
+static void
+omap24xxcam_dma_abort(struct omap24xxcam_device *cam, unsigned long csr)
+{
+	unsigned long irqflags;
+	int dmach, i, free_dmach;
+	dma_callback_t callback;
+	void *arg;
+
+	spin_lock_irqsave(&cam->dma_lock, irqflags);
+
+	/* stop any DMA transfers in progress */
+	dmach = (cam->next_dmach + cam->free_dmach) % NUM_CAMDMA_CHANNELS;
+	for (i = 0; i < NUM_CAMDMA_CHANNELS; i++) {
+		/* mask all interrupts from this channel */
+		camdma_reg_out(cam, CAMDMA_CICR(dmach), 0);
+		/* unlink this channel */
+		camdma_reg_merge(cam, CAMDMA_CLNK_CTRL(dmach), 0,
+				 CAMDMA_CLNK_CTRL_ENABLE_LNK);
+		/* disable this channel */
+		camdma_reg_merge(cam, CAMDMA_CCR(dmach), 0, CAMDMA_CCR_ENABLE);
+		dmach = (dmach + 1) % NUM_CAMDMA_CHANNELS;
+	}
+
+	/* We have to be careful here because the callback routine might start
+	 * a new DMA transfer, and we only want to abort transfers that were
+	 * started before this routine was called.
+	 */
+	free_dmach = cam->free_dmach;
+	while ((cam->free_dmach < NUM_CAMDMA_CHANNELS) &&
+	       (free_dmach < NUM_CAMDMA_CHANNELS)) {
+		dmach = (cam->next_dmach + cam->free_dmach)
+		    % NUM_CAMDMA_CHANNELS;
+		callback = cam->camdma[dmach].callback;
+		arg = cam->camdma[dmach].arg;
+		cam->free_dmach++;
+		free_dmach++;
+		if (callback) {
+			/* leave interrupts disabled during callback */
+			spin_unlock(&cam->dma_lock);
+			(*callback) (cam, csr, arg);
+			spin_lock(&cam->dma_lock);
+		}
+	}
+
+	spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+}
+
+/* Abort all chained DMA transfers.  After all transfers have been aborted and
+ * the DMA controller is idle, the completion routines for any aborted transfers
+ * will be called in sequence.  If the completion routines attempt to start a
+ * new DMA transfer it will fail, so the DMA controller will be idle after this
+ * routine completes.
+ */
+static void
+omap24xxcam_dma_stop(struct omap24xxcam_device *cam, unsigned long csr)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cam->dma_lock, irqflags);
+	cam->dma_stop++;
+	spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+	omap24xxcam_dma_abort(cam, csr);
+	spin_lock_irqsave(&cam->dma_lock, irqflags);
+	cam->dma_stop--;
+	spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+}
+
+/* Sync scatter-gather DMA by aborting any DMA transfers currently in progress.
+ * Any queued scatter-gather DMA transactions that have not yet been started
+ * will remain queued.  The DMA controller will be idle after this routine
+ * completes.  When the scatter-gather queue is restarted, the next
+ * scatter-gather DMA transfer will begin at the start of a new transaction.
+ */
+static void
+omap24xxcam_sg_dma_sync(struct omap24xxcam_device *cam, unsigned long csr)
+{
+	unsigned long irqflags;
+	int sgslot;
+	struct sgdma_state *sgdma;
+
+	/* stop any DMA transfers in progress */
+	omap24xxcam_dma_stop(cam, csr);
+
+	spin_lock_irqsave(&cam->sg_lock, irqflags);
+
+	if (cam->free_sgdma < NUM_SG_DMA) {
+		sgslot = (cam->next_sgdma + cam->free_sgdma) % NUM_SG_DMA;
+		sgdma = cam->sgdma + sgslot;
+		if (sgdma->next_sglist != 0) {
+			/* This DMA transfer was in progress, so abort it. */
+			dma_callback_t callback = sgdma->callback;
+			void *arg = sgdma->arg;
+			cam->free_sgdma++;
+			if (callback) {
+				/* leave interrupts masked */
+				spin_unlock(&cam->sg_lock);
+				(*callback) (cam, csr, arg);
+				spin_lock(&cam->sg_lock);
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&cam->sg_lock, irqflags);
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
+static int
+omap24xxcam_dma_notify(struct omap24xxcam_device *cam,
+		       void (*callback) (struct omap24xxcam_device * cam))
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cam->dma_lock, irqflags);
+
+	if (cam->dma_notify && (cam->dma_notify != callback)) {
+		spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+		return -EBUSY;
+	}
+
+	cam->dma_notify = callback;
+
+	spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+
+	return 0;
+}
+
+/* Camera DMA interrupt service routine. */
+static void
+omap24xxcam_dma_isr(struct omap24xxcam_device *cam)
+{
+	int dmach, i;
+	dma_callback_t callback;
+	void *arg;
+	unsigned long csr;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock(&cam->dma_lock);
+	if (cam->free_dmach == NUM_CAMDMA_CHANNELS) {
+		/* A camera DMA interrupt occurred while all channels are idle,
+		 * so we'll acknowledge the interrupt in the IRQSTATUS register
+		 * and exit.
+		 */
+		for (i = 0; i < NUM_CAMDMA_CHANNELS; ++i) {
+			csr = camdma_reg_in(cam, CAMDMA_CSR(i));
+			/* ack interrupt in CSR */
+			camdma_reg_out(cam, CAMDMA_CSR(i), csr);
+		}
+		camdma_reg_out(cam, CAMDMA_IRQSTATUS_L0, 0xffffffff);
+		spin_unlock(&cam->dma_lock);
+		return;
+	}
+
+	while (cam->free_dmach < NUM_CAMDMA_CHANNELS) {
+		dmach = (cam->next_dmach + cam->free_dmach)
+		    % NUM_CAMDMA_CHANNELS;
+		if (camdma_reg_in(cam, CAMDMA_CCR(dmach)) & CAMDMA_CCR_ENABLE) {
+			/* This buffer hasn't finished yet, so we're done. */
+			break;
+		}
+		csr = camdma_reg_in(cam, CAMDMA_CSR(dmach));
+		/* ack interrupt in CSR */
+		camdma_reg_out(cam, CAMDMA_CSR(dmach), csr);
+		/* ack interrupt in IRQSTATUS */
+		camdma_reg_out(cam, CAMDMA_IRQSTATUS_L0, (1 << dmach));
+		if (csr & csr_error) {
+			/* A DMA error occurred, so stop all DMA transfers in
+			 * progress.
+			 */
+			spin_unlock(&cam->dma_lock);
+			omap24xxcam_dma_stop(cam, csr);
+			return;
+		} else {
+			callback = cam->camdma[dmach].callback;
+			arg = cam->camdma[dmach].arg;
+			cam->free_dmach++;
+			if (callback) {
+				spin_unlock(&cam->dma_lock);
+				(*callback) (cam, csr, arg);
+				spin_lock(&cam->dma_lock);
+			}
+		}
+	}
+
+	spin_unlock(&cam->dma_lock);
+
+	omap24xxcam_sg_dma_process(cam);
+}
+
+/* Shutdown the camera DMA driver and controller. */
+static void
+omap24xxcam_dma_exit(struct omap24xxcam_device *cam)
+{
+	int ch;
+
+	/* Mask all DMA interrupts */
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L0, 0);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L1, 0);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L2, 0);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L3, 0);
+
+	/* disable all DMA channels */
+	for (ch = 0; ch < NUM_CAMDMA_CHANNELS; ch++)
+		camdma_reg_out(cam, CAMDMA_CCR(ch), 0);
+}
+
+/* Initialize the camera DMA driver. */
+static void
+omap24xxcam_dma_init(struct omap24xxcam_device *cam)
+{
+	int ch, sg;
+
+	/* group all channels on DMA IRQ0 and unmask irq */
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L0, 0xffffffff);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L1, 0);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L2, 0);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L3, 0);
+
+	spin_lock_init(&cam->dma_lock);
+	cam->free_dmach = NUM_CAMDMA_CHANNELS;
+	cam->next_dmach = 0;
+	for (ch = 0; ch < NUM_CAMDMA_CHANNELS; ch++) {
+		cam->camdma[ch].callback = NULL;
+		cam->camdma[ch].arg = NULL;
+	}
+
+	spin_lock_init(&cam->sg_lock);
+	cam->free_sgdma = NUM_SG_DMA;
+	cam->next_sgdma = 0;
+	for (sg = 0; sg < NUM_SG_DMA; sg++) {
+		cam->sgdma[sg].sglen = 0;
+		cam->sgdma[sg].next_sglist = 0;
+		cam->sgdma[sg].queued_sglist = 0;
+		cam->sgdma[sg].csr = 0;
+		cam->sgdma[sg].callback = NULL;
+		cam->sgdma[sg].arg = NULL;
+	}
+}
+
+/* -------------------------------------------------------------------------- */
+
+/* Callback routine for overlay DMA completion.  We just start another DMA
+ * transfer unless overlay has been turned off.
+ */
+static void
+omap24xxcam_overlay_callback(struct omap24xxcam_device *cam, unsigned long csr,
+			     void *arg)
+{
+	int err;
+	unsigned long irqflags;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock_irqsave(&cam->overlay_lock, irqflags);
+
+	if (cam->overlay_cnt > 0)
+		--cam->overlay_cnt;
+
+	if (!cam->previewing || (csr & csr_error)) {
+		spin_unlock_irqrestore(&cam->overlay_lock, irqflags);
+		return;
+	}
+
+	sg_dma_address(&cam->overlay_sglist) = cam->overlay_base_phys;
+	sg_dma_len(&cam->overlay_sglist) = cam->pix.sizeimage;
+
+	while (cam->overlay_cnt < 2) {
+		err = omap24xxcam_sg_dma_queue(cam, &cam->overlay_sglist, 1,
+					       omap24xxcam_overlay_callback,
+					       NULL);
+		if (err)
+			break;
+		++cam->overlay_cnt;
+	}
+
+	spin_unlock_irqrestore(&cam->overlay_lock, irqflags);
+}
+
+/* Begin DMA'ing into the camera overlay framebuffer.  We queue up two DMA
+ * transfers so that all frames will be captured.
+ */
+static void
+omap24xxcam_start_overlay_dma(struct omap24xxcam_device *cam)
+{
+	int err;
+	unsigned long irqflags;
+
+	if (!cam->previewing)
+		return;
+
+	if (cam->pix.sizeimage > cam->overlay_size)
+		return;
+
+	spin_lock_irqsave(&cam->overlay_lock, irqflags);
+
+	sg_dma_address(&cam->overlay_sglist) = cam->overlay_base_phys;
+	sg_dma_len(&cam->overlay_sglist) = cam->pix.sizeimage;
+
+	while (cam->overlay_cnt < 2) {
+		err = omap24xxcam_sg_dma_queue(cam, &cam->overlay_sglist, 1,
+					       omap24xxcam_overlay_callback,
+					       NULL);
+		if (err)
+			break;
+		++cam->overlay_cnt;
+	}
+
+	spin_unlock_irqrestore(&cam->overlay_lock, irqflags);
+}
+
+/* Enable the camera core interface. */
+static void
+omap24xxcam_cc_enable(struct omap24xxcam_device *cam)
+{
+	/* Get the CC_CTRL register value for the current capture format. */
+	omap24xxcam_sensor_cc_ctrl(cam);
+
+	/* program the camera interface DMA packet size */
+	cc_reg_out(cam, CC_CTRL_DMA, CC_CTRL_DMA_EN | (DMA_THRESHOLD / 4 - 1));
+
+	/* enable camera core error interrupts */
+	cc_reg_out(cam, CC_IRQENABLE, CC_IRQENABLE_FW_ERR_IRQ
+		   | CC_IRQENABLE_FSC_ERR_IRQ | CC_IRQENABLE_SSC_ERR_IRQ
+		   | CC_IRQENABLE_FIFO_OF_IRQ);
+
+	/* enable the camera interface */
+	cc_reg_out(cam, CC_CTRL, cam->cc_ctrl | CC_CTRL_CC_EN);
+}
+
+/* Error recovery for DMA errors and camera interface errors. */
+static void
+omap24xxcam_error_handler(struct omap24xxcam_device *cam)
+{
+	/* Get the CC_CTRL register value for the current capture format. */
+	omap24xxcam_sensor_cc_ctrl(cam);
+
+	/* Disable and reset the camera interface. */
+	cc_reg_out(cam, CC_CTRL,
+		   cam->cc_ctrl & ~(CC_CTRL_CC_EN | CC_CTRL_CC_FRAME_TRIG));
+	cc_reg_out(cam, CC_CTRL, (cam->cc_ctrl | CC_CTRL_CC_RST)
+		   & ~(CC_CTRL_CC_EN | CC_CTRL_CC_FRAME_TRIG));
+
+	/* Stop the DMA controller and frame sync scatter-gather DMA. */
+	omap24xxcam_sg_dma_sync(cam, CAMDMA_CSR_TRANS_ERR);
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
+	cam_init(cam);
+	omap24xxcam_set_xclk(cam);
+	/* group all channels on DMA IRQ0 and unmask irq */
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L0, 0xffffffff);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L1, 0);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L2, 0);
+	camdma_reg_out(cam, CAMDMA_IRQENABLE_L3, 0);
+
+	if (cam->previewing || cam->streaming) {
+		/* Preview or capture is in progress, so we need to register
+		 * our routine to restart the camera interface the next time a
+		 * DMA transfer is queued.
+		 */
+		omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+	}
+
+	/* Restart overlay DMA if preview is enabled. */
+	if (cam->previewing)
+		omap24xxcam_start_overlay_dma(cam);
+
+	/* Restart the scatter-gather DMA queue. */
+	omap24xxcam_sg_dma_process(cam);
+}
+
+/* Interrupt service routine for camera core interrupts. */
+static void
+omap24xxcam_cc_isr(struct omap24xxcam_device *cam)
+{
+	unsigned long cc_irqstatus;
+	const unsigned long cc_irqstatus_err = CC_IRQSTATUS_FW_ERR_IRQ
+	    | CC_IRQSTATUS_FSC_ERR_IRQ | CC_IRQSTATUS_SSC_ERR_IRQ
+	    | CC_IRQSTATUS_FIFO_OF_IRQ;
+
+	cc_irqstatus = cc_reg_in(cam, CC_IRQSTATUS);
+	cc_reg_out(cam, CC_IRQSTATUS, cc_irqstatus);
+
+	if (cc_irqstatus & cc_irqstatus_err)
+		omap24xxcam_error_handler(cam);
+}
+
+static irqreturn_t
+omap24xxcam_isr(int irq, void *arg, struct pt_regs *regs)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *) arg;
+	unsigned long irqstatus;
+	unsigned int irqhandled = 0;
+
+	irqstatus = cam_reg_in(cam, CAM_IRQSTATUS);
+	if (irqstatus &
+	    (CAM_IRQSTATUS_DMA_IRQ2 | CAM_IRQSTATUS_DMA_IRQ1
+	     | CAM_IRQSTATUS_DMA_IRQ0)) {
+		omap24xxcam_dma_isr(cam);
+		irqhandled = 1;
+	}
+	if (irqstatus & CAM_IRQSTATUS_CC_IRQ) {
+		omap24xxcam_cc_isr(cam);
+		irqhandled = 1;
+	}
+	if (irqstatus & CAM_IRQSTATUS_MMU_IRQ)
+		printk(KERN_ERR CAM_NAME ": Unhandled camera MMU interrupt!\n");
+
+	return IRQ_RETVAL(irqhandled);
+}
+
+static void
+omap24xxcam_adjust_xclk(struct omap24xxcam_device *cam)
+{
+	unsigned long divisor;
+
+	if (cam->xclk > cam->mclk)
+		cam->xclk = cam->mclk;
+	divisor = cam->mclk / cam->xclk;
+	if (cam->xclk * divisor < cam->mclk)
+		divisor += 1;
+	if (divisor > 30)
+		divisor = 30;
+
+	cam->xclk = cam->mclk / divisor;
+}
+
+/* -------------------------------------------------------------------------- */
+
+/* This routine is called from interrupt context when a scatter-gather DMA
+ * transfer of a videobuf_buffer completes.
+ */
+static void
+omap24xxcam_vbq_complete(struct omap24xxcam_device *cam, unsigned long csr,
+			 void *arg)
+{
+	struct videobuf_buffer *vb = (struct videobuf_buffer *) arg;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	spin_lock(&cam->vbq_lock);
+
+	do_gettimeofday(&vb->ts);
+	vb->field_count = cam->field_count;
+	cam->field_count += 2;
+	if (csr & csr_error) {
+		vb->state = STATE_ERROR;
+		omap24xxcam_error_handler(cam);
+	} else
+		vb->state = STATE_DONE;
+	wake_up(&vb->done);
+	spin_unlock(&cam->vbq_lock);
+}
+
+static void
+omap24xxcam_vbq_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
+{
+	videobuf_waiton(vb, 0, 0);
+	videobuf_dma_pci_unmap(NULL, &vb->dma);
+	videobuf_dma_free(&vb->dma);
+
+	vb->state = STATE_NEEDS_INIT;
+}
+
+/* Limit the number of available kernel image capture buffers based on the
+ * number requested, the currently selected image size, and the maximum
+ * amount of memory permitted for kernel capture buffers.
+ */
+static int
+omap24xxcam_vbq_setup(struct videobuf_queue *q, unsigned int *cnt, unsigned int *size)
+{
+	struct omap24xxcam_fh *fh = q->priv_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	unsigned long irqflags;
+
+	if (*cnt <= 0)
+		*cnt = VIDEO_MAX_FRAME;	/* supply a default number of buffers */
+
+	if (*cnt > VIDEO_MAX_FRAME)
+		*cnt = VIDEO_MAX_FRAME;
+
+	spin_lock_irqsave(&cam->img_lock, irqflags);
+	if (cam->still_capture && cam->cam_sensor->try_format_still_capture)
+		*size = cam->pix2.sizeimage;
+	else
+		*size = cam->pix.sizeimage;
+	spin_unlock_irqrestore(&cam->img_lock, irqflags);
+
+	while (*size * *cnt > capture_mem)
+		(*cnt)--;
+
+	return 0;
+}
+
+static int
+omap24xxcam_vbq_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
+	enum v4l2_field field)
+{
+	struct omap24xxcam_fh *fh = q->priv_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	unsigned int size;
+	unsigned long irqflags;
+	int err = 0;
+
+	spin_lock_irqsave(&cam->img_lock, irqflags);
+	if (cam->still_capture && cam->cam_sensor->try_format_still_capture)
+		size = cam->pix2.sizeimage;
+	else
+		size = cam->pix.sizeimage;
+
+	if (vb->baddr) {
+		/* This is a userspace buffer. */
+		if (size > vb->bsize) {
+			/* The buffer isn't big enough. */
+			err = -EINVAL;
+		} else
+			vb->size = size;
+	} else if (!vb->baddr) {
+		if (vb->state != STATE_NEEDS_INIT) {
+			/* We have a kernel bounce buffer that has already been
+			 * allocated.
+			 */
+			if (size > vb->size) {
+				/* The image size has been changed to a larger
+				 * size since this buffer was allocated, so we
+				 * need to free and reallocate it.
+				 */
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+				omap24xxcam_vbq_release(q, vb);
+				spin_lock_irqsave(&cam->img_lock, irqflags);
+				vb->size = size;
+			}
+		} else {
+			/* We need to allocate a new kernel bounce buffer. */
+			vb->size = size;
+		}
+	}
+
+	if (cam->still_capture && cam->cam_sensor->try_format_still_capture) {
+		vb->width = cam->pix2.width;
+		vb->height = cam->pix2.height;
+	}
+	else {
+		vb->width = cam->pix.width;
+		vb->height = cam->pix.height;
+	}
+	vb->field = field;
+
+	spin_unlock_irqrestore(&cam->img_lock, irqflags);
+
+	if (err)
+		return err;
+
+	if (vb->state == STATE_NEEDS_INIT)
+		err = videobuf_iolock(NULL, vb, NULL);
+
+	if (!err) {
+		vb->state = STATE_PREPARED;
+		if (vb->baddr) {
+			/* sync a userspace buffer */
+			consistent_sync((void *) vb->baddr, vb->bsize,
+					vb->dma.direction);
+		} else {
+			/* sync a kernel buffer */
+			consistent_sync(vb->dma.vmalloc, vb->dma.sglen/*size*/,
+					vb->dma.direction);
+		}
+	} else
+		omap24xxcam_vbq_release(q, vb);
+
+	return err;
+}
+
+static void
+omap24xxcam_vbq_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
+{
+	struct omap24xxcam_fh *fh = q->priv_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	enum videobuf_state state = vb->state;
+	int err;
+
+	vb->state = STATE_QUEUED;
+	err = omap24xxcam_sg_dma_queue(cam, vb->dma.sglist, vb->dma.sglen,
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
+/* -------------------------------------------------------------------------- */
+
+static int
+omap24xxcam_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     void *arg)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	unsigned long irqflags;
+	int err;
+
+	switch (cmd) {
+		/* for time being below IOCTL cmd is here */
+
+	case VIDIOC_ENUMINPUT:
+		{
+			/* default handler assumes 1 video input (the camera) */
+			struct v4l2_input *input = (struct v4l2_input *) arg;
+			int index = input->index;
+
+			memset(input, 0, sizeof (*input));
+			input->index = index;
+
+			if (index > 0)
+				return -EINVAL;
+
+			strncpy(input->name, "camera", sizeof (input->name));
+			input->type = V4L2_INPUT_TYPE_CAMERA;
+
+			return 0;
+		}
+
+	case VIDIOC_G_INPUT:
+		{
+			unsigned int *input = arg;
+			*input = 0;
+
+			return 0;
+		}
+
+	case VIDIOC_S_INPUT:
+		{
+			unsigned int *input = arg;
+
+			if (*input > 0)
+				return -EINVAL;
+
+			return 0;
+		}
+
+	case VIDIOC_QUERYCAP:
+		{
+			struct v4l2_capability *cap =
+			    (struct v4l2_capability *) arg;
+
+			memset(cap, 0, sizeof (*cap));
+			strncpy(cap->driver, CAM_NAME, sizeof (cap->driver));
+			strncpy(cap->card, cam->vfd->name, sizeof (cap->card));
+			cap->bus_info[0] = '\0';
+			cap->version = KERNEL_VERSION(0, 0, 0);
+			cap->capabilities =
+			    V4L2_CAP_VIDEO_CAPTURE |
+			    V4L2_CAP_VIDEO_OVERLAY |
+			    V4L2_CAP_READWRITE | V4L2_CAP_STREAMING;
+			return 0;
+		}
+
+	case VIDIOC_G_FMT:
+		{
+			struct v4l2_format *f = (struct v4l2_format *) arg;
+			switch (f->type) {
+			case V4L2_BUF_TYPE_STILL_CAPTURE:
+				{
+					if (cam->cam_sensor->try_format_still_capture){
+					struct v4l2_pix_format *pix =
+					    &f->fmt.pix;
+					memset(pix, 0, sizeof (*pix));
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					*pix = cam->pix2;
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return 0;
+					}
+					/* else fall through */
+				}
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					struct v4l2_pix_format *pix =
+					    &f->fmt.pix;
+					memset(pix, 0, sizeof (*pix));
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					*pix = cam->pix;
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return 0;
+				}
+
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_window *win = &f->fmt.win;
+					memset(win, 0, sizeof (*win));
+					/* The API has a bit of a problem here.
+					 * We're returning a v4l2_window
+					 * structure, but that structure
+					 * contains pointers to variable-sized
+					 * objects for clipping rectangles and
+					 * clipping bitmaps.  We will just
+					 * return NULLs for those pointers.
+					 */
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					win->w = cam->win.w;
+					win->field = cam->win.field;
+					win->chromakey = cam->win.chromakey;
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return 0;
+				}
+
+			default:
+				{
+					return -EINVAL;
+				}
+			}
+		}
+
+	case VIDIOC_TRY_FMT:
+		{
+			struct v4l2_format *f = (struct v4l2_format *) arg;
+
+			switch (f->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_window *win = &f->fmt.win;
+
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					err =
+					    omap24xxvout_try_window(&cam->fbuf,
+								    win);
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return err;
+				}
+
+			case V4L2_BUF_TYPE_STILL_CAPTURE:
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					return cam->cam_sensor->try_format(&f->
+									   fmt.
+									   pix,
+									   cam->
+									   sensor);
+				}
+
+			default:
+				{
+					return -EINVAL;
+				}
+			}
+		}
+
+	case VIDIOC_S_FMT:
+		{
+			struct v4l2_format *f = (struct v4l2_format *) arg;
+
+			switch (f->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_window *win = &f->fmt.win;
+
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					if (cam->previewing || cam->streaming) {
+						spin_unlock_irqrestore(&cam->img_lock, irqflags);
+						return -EBUSY;
+					}
+					/* Get the panel parameters.
+					 * They can change from LCD to TV
+					 * or TV to LCD
+					 */
+					omap2_disp_get_panel_size(
+					 omap2_disp_get_output_dev(cam->vid_preview),
+				  	 &(cam->fbuf.fmt.width),
+				  	 &(cam->fbuf.fmt.height));
+
+					err =
+					    omap24xxvout_new_window(&cam->crop,
+								    &cam->win,
+								    &cam->fbuf,
+								    win);
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return err;
+				}
+
+			case V4L2_BUF_TYPE_STILL_CAPTURE:
+				{
+					if (cam->cam_sensor->try_format_still_capture &&
+					    cam->cam_sensor->configure_still_capture) {
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					cam->cam_sensor->try_format_still_capture(&f->fmt.pix,
+								    cam->
+								    sensor);
+					/* set the new capture format */
+					cam->pix2 = f->fmt.pix;
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					err =
+					    cam->cam_sensor->configure_still_capture
+					    			      (&cam->
+								       pix2,
+								       cam->
+								       xclk,
+								       &cam->
+								       cparm.
+								       timeperframe,
+								       cam->
+								       sensor);
+					return err;
+					}
+					/* else fall through */
+				}
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					if (cam->streaming || cam->previewing) {
+						spin_unlock_irqrestore(&cam->img_lock, irqflags);
+						return -EBUSY;
+					}
+					cam->cam_sensor->try_format(&f->fmt.pix,
+								    cam->
+								    sensor);
+					/* set the new capture format */
+					cam->pix = f->fmt.pix;
+					/* adjust the capture frame rate */
+					cam->xclk =
+					    cam->cam_sensor->calc_xclk(&cam->
+								       pix,
+								       &cam->
+								       nominal_timeperframe,
+								       cam->
+								       sensor);
+					omap24xxcam_adjust_xclk(cam);
+					cam->cparm.timeperframe =
+					    cam->nominal_timeperframe;
+					/* Get the panel parameters.
+					 * They can change from LCD to TV
+					 * or TV to LCD
+					 */
+					omap2_disp_get_panel_size(
+					 omap2_disp_get_output_dev(cam->vid_preview),
+				  	 &(cam->fbuf.fmt.width),
+				  	 &(cam->fbuf.fmt.height));
+
+					/* intialize the preview parameters */
+					omap24xxvout_new_format(&cam->pix,
+								&cam->fbuf,
+								&cam->crop,
+								&cam->win);
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					/* program xclk */
+					omap24xxcam_set_xclk(cam);
+					/* program the sensor */
+					err =
+					    cam->cam_sensor->configure(&cam->
+								       pix,
+								       cam->
+								       xclk,
+								       &cam->
+								       cparm.
+								       timeperframe,
+								       cam->
+								       sensor);
+					return err;
+				}
+
+			default:
+				{
+					return -EINVAL;
+				}
+			}
+		}
+
+	case VIDIOC_G_FBUF:
+		{
+			struct v4l2_framebuffer *fbuf =
+			    (struct v4l2_framebuffer *) arg;
+
+			spin_lock_irqsave(&cam->img_lock, irqflags);
+			*fbuf = cam->fbuf;
+			spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			return 0;
+		}
+
+	case VIDIOC_S_FBUF:
+		{
+			struct v4l2_framebuffer *fbuf =
+			    (struct v4l2_framebuffer *) arg;
+			unsigned int flags = fbuf->flags;
+
+			/* The only field the user is allowed to change is
+			 * fbuf->flags.
+			 */
+			spin_lock_irqsave(&cam->img_lock, irqflags);
+			if (cam->previewing) {
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+				return -EBUSY;
+			}
+			if (flags & V4L2_FBUF_FLAG_CHROMAKEY)
+				cam->fbuf.flags |= V4L2_FBUF_FLAG_CHROMAKEY;
+			else
+				cam->fbuf.flags &= ~V4L2_FBUF_FLAG_CHROMAKEY;
+			spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			return 0;
+		}
+
+	case VIDIOC_CROPCAP:
+		{
+			struct v4l2_cropcap *cropcap =
+			    (struct v4l2_cropcap *) arg;
+			enum v4l2_buf_type type = cropcap->type;
+
+			memset(cropcap, 0, sizeof (*cropcap));
+			cropcap->type = type;
+			switch (type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_pix_format *pix = &cam->pix;
+
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					cropcap->bounds.width = pix->width & ~1;
+					cropcap->bounds.height =
+					    pix->height & ~1;
+					omap24xxvout_default_crop(&cam->pix,
+								  &cam->fbuf,
+								  &cropcap->
+								  defrect);
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					cropcap->pixelaspect.numerator = 1;
+					cropcap->pixelaspect.denominator = 1;
+					return 0;
+				}
+
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					/* We're required to support the CROPCAP
+					 * ioctl even though the G_CROP/S_CROP
+					 * ioctls are optional, which seems a
+					 * little strange.  We don't support
+					 * cropping of captured images.
+					 */
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					cropcap->bounds.width = cam->pix.width;
+					cropcap->bounds.height =
+					    cam->pix.height;
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					cropcap->defrect.width =
+					    cropcap->bounds.width;
+					cropcap->defrect.height =
+					    cropcap->bounds.height;
+					cropcap->pixelaspect.numerator = 1;
+					cropcap->pixelaspect.denominator = 1;
+					return 0;
+				}
+
+			default:
+				{
+					return -EINVAL;
+				}
+			}
+		}
+
+	case VIDIOC_G_CROP:
+		{
+			struct v4l2_crop *crop = (struct v4l2_crop *) arg;
+
+			switch (crop->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					crop->c = cam->crop;
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return 0;
+				}
+
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					/* We don't support cropping of captured
+					 * images.
+					 */
+					return -EINVAL;
+				}
+
+			default:
+				{
+					return -EINVAL;
+				}
+			}
+		}
+
+	case VIDIOC_S_CROP:
+		{
+			struct v4l2_crop *crop = (struct v4l2_crop *) arg;
+
+			switch (crop->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					spin_lock_irqsave(&cam->img_lock, irqflags);
+					if (cam->previewing) {
+						spin_unlock(&cam->img_lock);
+						return -EBUSY;
+					}
+					err = omap24xxvout_new_crop(&cam->pix,
+								    &cam->crop,
+								    &cam->win,
+								    &cam->fbuf,
+								    &crop->c);
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return err;
+				}
+
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					/* We don't support cropping of captured
+					 * images.
+					 */
+					return -EINVAL;
+				}
+
+			default:
+				{
+					return -EINVAL;
+				}
+			}
+		}
+
+	case VIDIOC_G_PARM:
+		{
+			struct v4l2_streamparm *parm =
+			    (struct v4l2_streamparm *) arg;
+			enum v4l2_buf_type type = parm->type;
+
+			memset(parm, 0, sizeof (*parm));
+			parm->type = type;
+			if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+				return -EINVAL;
+			spin_lock_irqsave(&cam->img_lock, irqflags);
+			parm->parm.capture = cam->cparm;
+			spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			return 0;
+		}
+
+	case VIDIOC_S_PARM:
+		{
+			struct v4l2_streamparm *parm =
+			    (struct v4l2_streamparm *) arg;
+			struct v4l2_captureparm *cparm = &parm->parm.capture;
+
+			if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+				return -EINVAL;
+			spin_lock_irqsave(&cam->img_lock, irqflags);
+			if (cam->streaming || cam->previewing) {
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+				return -EBUSY;
+			}
+			cam->cparm.capturemode = cparm->capturemode;
+			if (cparm->timeperframe.numerator
+			    && cparm->timeperframe.denominator) {
+				cam->nominal_timeperframe = cparm->timeperframe;
+				/* adjust the capture frame rate */
+				cam->xclk =
+				    cam->cam_sensor->calc_xclk(&cam->pix,
+							       &cam->
+							       nominal_timeperframe,
+							       cam->sensor);
+				omap24xxcam_adjust_xclk(cam);
+				cam->cparm.timeperframe =
+				    cam->nominal_timeperframe;
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+				/* program xclk */
+				omap24xxcam_set_xclk(cam);
+				/* program the sensor */
+				err =
+				    cam->cam_sensor->configure(&cam->pix,
+							       cam->xclk,
+							       &cam->cparm.
+							       timeperframe,
+							       cam->sensor);
+				cparm->timeperframe = cam->cparm.timeperframe;
+			} else {
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			}
+			return 0;
+		}
+
+	case VIDIOC_OVERLAY:
+		{
+			int *on = arg;
+
+			spin_lock_irqsave(&cam->img_lock, irqflags);
+			
+			if (!cam->previewing && *on) {
+				if (cam->pix.sizeimage <= cam->overlay_size) {
+					/* V1 is the default for preview */
+					cam->vid_preview = (*on == 2) ?
+					    OMAP2_VIDEO2 : OMAP2_VIDEO1;
+					if (!omap2_disp_request_layer
+					    (cam->vid_preview)) {
+						spin_unlock_irqrestore(&cam->img_lock, irqflags);
+						return -EBUSY;
+					}
+					omap2_disp_get_dss();
+
+					/* Turn on the overlay window */
+					omap2_disp_config_vlayer(cam->
+								 vid_preview,
+								 &cam->pix,
+								 &cam->crop,
+								 &cam->win, -1,
+								 0);
+					omap2_disp_start_vlayer(cam->
+								vid_preview,
+								&cam->pix,
+								&cam->crop,
+								cam->
+								overlay_base_phys,
+								-1, 0);
+					cam->previewing = fh;
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					/* start the camera interface */
+					omap24xxcam_dma_notify(cam,
+							       omap24xxcam_cc_enable);
+					omap24xxcam_start_overlay_dma(cam);
+				} else {
+					/* Image size is bigger than overlay
+					 * buffer.
+					 */
+					spin_unlock_irqrestore(&cam->img_lock, irqflags);
+					return -EINVAL;
+				}
+			} else if (!*on) {
+				/* turn overlay off */
+				omap2_disp_disable_layer(cam->vid_preview);
+				omap2_disp_release_layer(cam->vid_preview);
+				omap2_disp_put_dss();
+				cam->previewing = NULL;
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			} else
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			return 0;
+		}
+
+	case VIDIOC_REQBUFS:
+		return videobuf_reqbufs(&fh->vbq, arg);
+
+	case VIDIOC_QUERYBUF:
+		return videobuf_querybuf(&fh->vbq, arg);
+
+	case VIDIOC_QBUF:
+		return videobuf_qbuf(&fh->vbq, arg);
+
+	case VIDIOC_DQBUF:
+		return videobuf_dqbuf(&fh->vbq, arg, file->f_flags & O_NONBLOCK);
+
+	case VIDIOC_STREAMON:
+		{
+			spin_lock_irqsave(&cam->img_lock, irqflags);
+			if (cam->streaming) {
+				spin_unlock_irqrestore(&cam->img_lock, irqflags);
+				return -EBUSY;
+			} else
+				cam->streaming = fh;
+			spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			
+			omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+			return videobuf_streamon(&fh->vbq);
+		}
+
+	case VIDIOC_STREAMOFF:
+		{
+			struct videobuf_queue *q = &fh->vbq;
+			int i;
+
+			/* video-buf lib has trouble to turn off streaming while
+			   any buffer is still in QUEUED state. Let's wait until
+			   all queued buffers are filled.
+			 */
+			for (i = 0; i < VIDEO_MAX_FRAME; i++) {
+				if (NULL == q->bufs[i])
+					continue;
+				while (q->bufs[i]->state == STATE_QUEUED) ;
+			}
+
+			err = videobuf_streamoff(q);
+			if (err < 0)
+				return err;
+
+			for (i = 0; i < VIDEO_MAX_FRAME; i++) {
+				if (NULL == q->bufs[i])
+					continue;
+				if (q->bufs[i]->memory == V4L2_MEMORY_USERPTR)
+					omap24xxcam_vbq_release(q,
+								q->bufs[i]);
+			}
+
+			spin_lock_irqsave(&cam->img_lock, irqflags);
+			if (cam->streaming == fh)
+				cam->streaming = NULL;
+			spin_unlock_irqrestore(&cam->img_lock, irqflags);
+			
+			return 0;
+		}
+
+	case VIDIOC_G_CTRL:
+		{
+			struct v4l2_control *vc = arg;
+			return cam->cam_sensor->get_control(vc, cam->sensor);
+		}
+	case VIDIOC_S_CTRL:
+		{
+			struct v4l2_control *vc = arg;
+			return cam->cam_sensor->set_control(vc, cam->sensor);
+		}
+	case VIDIOC_QUERYCTRL:
+		{
+			struct v4l2_queryctrl *qc = arg;
+			return cam->cam_sensor->query_control(qc, cam->sensor);
+		}
+	case VIDIOC_QUERYMENU:
+		{
+			return -EINVAL;
+		}
+
+	case VIDIOC_ENUMSTD:
+	case VIDIOC_G_STD:
+	case VIDIOC_S_STD:
+	case VIDIOC_QUERYSTD:
+		{
+			/* Digital cameras don't have an analog video standard,
+			 * so we don't need to implement these ioctls.
+			 */
+			return -EINVAL;
+		}
+
+	case VIDIOC_G_AUDIO:
+	case VIDIOC_S_AUDIO:
+	case VIDIOC_G_AUDOUT:
+	case VIDIOC_S_AUDOUT:
+		{
+			/* we don't have any audio inputs or outputs */
+			return -EINVAL;
+		}
+
+	case VIDIOC_G_JPEGCOMP:
+	case VIDIOC_S_JPEGCOMP:
+		{
+			/* JPEG compression is not supported */
+			return -EINVAL;
+		}
+
+	case VIDIOC_G_TUNER:
+	case VIDIOC_S_TUNER:
+	case VIDIOC_G_MODULATOR:
+	case VIDIOC_S_MODULATOR:
+	case VIDIOC_G_FREQUENCY:
+	case VIDIOC_S_FREQUENCY:
+		{
+			/* we don't have a tuner or modulator */
+			return -EINVAL;
+		}
+
+	case VIDIOC_ENUMOUTPUT:
+	case VIDIOC_G_OUTPUT:
+	case VIDIOC_S_OUTPUT:
+		{
+			/* we don't have any video outputs */
+			return -EINVAL;
+		}
+
+	case VIDIOC_ENUM_FMT:
+		{
+			struct v4l2_fmtdesc *fmt = arg;
+			return cam->cam_sensor->enum_pixformat(fmt,
+							       cam->sensor);
+		}
+
+	default:
+		{
+			/* unrecognized ioctl */
+			return -ENOIOCTLCMD;
+		}
+	}
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+
+	/*
+	 *  file operations
+	 */
+
+static unsigned
+    int
+omap24xxcam_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	struct videobuf_buffer *vb;
+	enum v4l2_field field;
+	unsigned long irqflags;
+
+	omap24xxcam_suspend_lockout(cam, file);
+
+	spin_lock_irqsave(&cam->img_lock, irqflags);
+	
+	if (cam->streaming == fh) {
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		/* streaming capture */
+		if (list_empty(&fh->vbq.stream))
+			return POLLERR;
+		vb = list_entry(fh->vbq.stream.next, struct videobuf_buffer,
+				stream);
+	} else if (cam->streaming) {
+		/* streaming I/O is in progress on another file descriptor */
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		return POLLERR;
+	} else {
+		/* read() capture */
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		down(&fh->vbq.lock);
+		if (fh->vbq.read_buf == NULL) {
+			/* need to capture a new image */
+			fh->vbq.read_buf = videobuf_alloc(fh->vbq.msize);
+			if (fh->vbq.read_buf == NULL) {
+				up(&fh->vbq.lock);
+				return POLLERR;
+			}
+			fh->vbq.read_buf->memory = V4L2_MEMORY_USERPTR;
+			field = videobuf_next_field(&fh->vbq);
+			if (fh->vbq.ops->buf_prepare(&fh->vbq, fh->vbq.read_buf,
+						     field) != 0) {
+				up(&fh->vbq.lock);
+				return POLLERR;
+			}
+
+			omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+			fh->vbq.ops->buf_queue(&fh->vbq, fh->vbq.read_buf);
+			fh->vbq.read_off = 0;
+		}
+		up(&fh->vbq.lock);
+		vb = (struct videobuf_buffer *) fh->vbq.read_buf;
+	}
+
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
+	struct omap24xxcam_fh *preview_fh;
+	unsigned long irqflags;
+	int free_sgdma, err;
+
+	omap24xxcam_suspend_lockout(cam, file);
+
+	/* user buffer has to be word aligned */
+	if (((unsigned int) data & 0x3) != 0)
+		return -EIO;
+
+	spin_lock_irqsave(&cam->img_lock, irqflags);
+	if (cam->streaming) {
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		return -EBUSY;
+	}
+	preview_fh = NULL;
+	if (cam->previewing) {
+		preview_fh = cam->previewing;
+		/* stop preview */
+		cam->previewing = NULL;
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		/* We need wait until sgdmas used by preview are freed.
+		 * To minimize the shot-to-shot delay, we don't want to
+		 * yield. Just want to start one-shot capture as soon as
+		 * possible. An alternative is to stop the dma but the
+		 * sync error would require a reset of the camera system.
+		 */
+		do {
+			/* prevent the race with dma handler */
+			spin_lock_irqsave(&cam->sg_lock, irqflags);
+			free_sgdma = cam->free_sgdma;
+			spin_unlock_irqrestore(&cam->sg_lock, irqflags);
+		} while (NUM_SG_DMA != free_sgdma);
+	
+		spin_lock_irqsave(&cam->img_lock, irqflags);
+	}
+	cam->still_capture = 1;
+	spin_unlock_irqrestore(&cam->img_lock, irqflags);
+	
+	if (cam->cam_sensor->enter_still_capture)
+		cam->cam_sensor->enter_still_capture(16, cam->sensor);
+	omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+	if (((unsigned int) data & (DMA_THRESHOLD - 1)) == 0) {
+		/* use zero-copy if user buffer is aligned with DMA_THRESHOLD */
+		err = videobuf_read_one(&fh->vbq, data, count, ppos, file->f_flags & O_NONBLOCK);
+	} else {
+		/* if user buffer is not aligned with DMA_THRESHOLD, the last DMA
+		   transfer to the first page frame is less than DMA_THRESHOLD.
+		   Camera DMA physical channel 1 doesn't seem to handle this
+		   partial transfer correctly. We end up with sync problem with
+		   an offset of DMA_THRESHOLD. For this case, We will use kernel
+		   bounce buffer to capture the image pretending that we want to
+		   read one pixel less than the actual image size.
+		 */
+		err = videobuf_read_one(&fh->vbq, data, count - 2, ppos, file->f_flags & O_NONBLOCK);
+	}
+	spin_lock_irqsave(&cam->img_lock, irqflags);
+	cam->still_capture = 0;
+	spin_unlock_irqrestore(&cam->img_lock, irqflags);
+
+	if (cam->cam_sensor->exit_still_capture)
+		cam->cam_sensor->exit_still_capture(cam->sensor);
+
+	/* if previwing was on, re-start it after the read */
+	if (preview_fh) { /* was previewing */
+		spin_lock_irqsave(&cam->img_lock, irqflags);
+		cam->previewing = preview_fh;
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+		omap24xxcam_start_overlay_dma(cam);
+	}
+
+	return err;
+}
+
+static int
+omap24xxcam_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+
+	omap24xxcam_suspend_lockout(cam, file);
+	return videobuf_mmap_mapper(&fh->vbq, vma);
+}
+
+static int
+omap24xxcam_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		  unsigned long arg)
+{
+	omap24xxcam_suspend_lockout(cam, file);
+	return video_usercopy(inode, file, cmd, arg, omap24xxcam_do_ioctl);
+}
+
+static int
+omap24xxcam_release(struct inode *inode, struct file *file)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	struct videobuf_queue *q = &fh->vbq;
+	unsigned long irqflags;
+	int i;
+
+	omap24xxcam_suspend_lockout(cam, file);
+
+	spin_lock_irqsave(&cam->img_lock, irqflags);
+	/* turn off overlay */
+	if (cam->previewing == fh) {
+		cam->previewing = NULL;
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		omap2_disp_disable_layer(cam->vid_preview);
+		omap2_disp_release_layer(cam->vid_preview);
+		omap2_disp_put_dss();
+		spin_lock_irqsave(&cam->img_lock, irqflags);
+	}
+
+	/* stop streaming capture */
+	if (cam->streaming == fh) {
+		cam->streaming = NULL;
+		spin_unlock_irqrestore(&cam->img_lock, irqflags);
+		for (i = 0; i < VIDEO_MAX_FRAME; i++) {
+			if (NULL == q->bufs[i])
+				continue;
+			if (q->bufs[i]->memory == V4L2_MEMORY_USERPTR)
+				omap24xxcam_vbq_release(q, q->bufs[i]);
+		}
+		videobuf_streamoff(q);
+		spin_lock_irqsave(&cam->img_lock, irqflags);
+	}
+	spin_unlock_irqrestore(&cam->img_lock, irqflags);
+
+	/* release read_buf videobuf_buffer struct */
+	if (fh->vbq.read_buf) {
+		omap24xxcam_vbq_release(q, fh->vbq.read_buf);
+		kfree(fh->vbq.read_buf);
+	}
+
+	/* free video_buffer objects */
+	videobuf_mmap_free(q);
+
+	file->private_data = NULL;
+	kfree(fh);
+
+	return 0;
+}
+
+static int
+omap24xxcam_open(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	struct omap24xxcam_device *cam = saved_cam;
+	struct omap24xxcam_fh *fh;
+
+	if (!cam || !cam->vfd || (cam->vfd->minor != minor))
+		return -ENODEV;
+
+	omap24xxcam_suspend_lockout(cam, file);
+
+	/* allocate per-filehandle data */
+	fh = kmalloc(sizeof (*fh), GFP_KERNEL);
+	if (NULL == fh)
+		return -ENOMEM;
+	file->private_data = fh;
+	fh->cam = cam;
+	fh->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+	videobuf_queue_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
+			    fh->type, V4L2_FIELD_NONE,
+			    sizeof (struct videobuf_buffer), fh);
+
+	return 0;
+}
+
+static struct file_operations omap24xxcam_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = omap24xxcam_read,
+	.poll = omap24xxcam_poll,
+	.ioctl = omap24xxcam_ioctl,
+	.mmap = omap24xxcam_mmap,
+	.open = omap24xxcam_open,
+	.release = omap24xxcam_release,
+};
+
+/* -------------------------------------------------------------------------- */
+static int
+omap24xxcam_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+	unsigned long irqflags;
+
+	/*if (level != SUSPEND_POWER_DOWN)
+		return 0;*/
+
+	if (cam->suspended)
+		return 0;
+	/* lock-out applications during suspend */
+	cam->suspended = 1;
+
+	/* stall previewing */
+	spin_lock_irqsave(&cam->img_lock, irqflags);
+	if (cam->previewing) {
+		omap2_disp_disable_layer(cam->vid_preview);
+		/* we still hold the video layer */
+		omap2_disp_put_dss();
+	}
+	spin_unlock_irqrestore(&cam->img_lock, irqflags);
+	
+	/* Get the CC_CTRL register value for the current capture format. */
+	omap24xxcam_sensor_cc_ctrl(cam);
+
+	/* Disable the camera interface. */
+	cc_reg_out(cam, CC_CTRL,
+		   cam->cc_ctrl & ~(CC_CTRL_CC_EN | CC_CTRL_CC_FRAME_TRIG));
+
+	/* Stop the DMA controller and frame sync scatter-gather DMA. */
+	omap24xxcam_sg_dma_sync(cam, CAMDMA_CSR_TRANS_ERR);
+
+	/* power down the sensor */
+	cam->cam_sensor->power_off(cam->sensor);
+
+	/* stop XCLK */
+	cc_reg_out(cam, CC_CTRL_XCLK, CC_CTRL_XCLK_DIV_STABLE_LOW);
+
+	clk_disable(cam->cami);
+	clk_disable(cam->camf);
+
+	return 0;
+}
+static int
+omap24xxcam_resume(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+
+	/*if (level != RESUME_POWER_ON)
+		return 0;*/
+
+	if (!cam->suspended)
+		return 0;
+
+	clk_enable(cam->cami);
+	clk_enable(cam->camf);
+
+	cam_init(cam);
+
+	/* set XCLK */
+	omap24xxcam_set_xclk(cam);
+
+	/* power up the sensor */
+	cam->cam_sensor->power_on(cam->sensor);
+
+	if (cam->streaming || cam->previewing) {
+		/* capture or previewing was in progress, so we need to register
+		 * our routine to restart the camera interface the next time a
+		 * DMA transfer is queued.
+		 */
+		omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+	}
+	if (cam->previewing) {
+		omap2_disp_get_dss();
+		omap2_disp_enable_layer(cam->vid_preview);
+		omap24xxcam_start_overlay_dma(cam);
+	}
+	omap24xxcam_sg_dma_process(cam);
+
+	/* camera interface will be enabled through dma_notify function
+	 ** automatically when new dma starts
+	 */
+
+	/* wake up applications waiting on suspend queue */
+	cam->suspended = 0;
+	wake_up(&cam->suspend_wq);
+	return 0;
+}
+
+static int
+omap24xxcam_probe(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam;
+	struct video_device *vfd;
+
+	cam = kmalloc(sizeof (struct omap24xxcam_device), GFP_KERNEL);
+	if (!cam) {
+		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
+		goto init_error;
+	}
+	memset(cam, 0, sizeof (struct omap24xxcam_device));
+	saved_cam = cam;
+
+	cam->suspended = 0;
+	init_waitqueue_head(&cam->suspend_wq);
+
+	/* initialize the video_device struct */
+	vfd = cam->vfd = video_device_alloc();
+	if (!vfd) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not allocate video device struct\n");
+		goto init_error;
+	}
+	vfd->release = video_device_release;
+
+	strncpy(vfd->name, CAM_NAME, sizeof (vfd->name));
+	vfd->type = VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
+	/* need to register for a VID_HARDWARE_* ID in videodev.h */
+	vfd->hardware = 0;
+	vfd->fops = &omap24xxcam_fops;
+	video_set_drvdata(vfd, cam);
+	vfd->minor = -1;
+
+	/* initialize the videobuf queue ops */
+	cam->vbq_ops.buf_setup = omap24xxcam_vbq_setup;
+	cam->vbq_ops.buf_prepare = omap24xxcam_vbq_prepare;
+	cam->vbq_ops.buf_queue = omap24xxcam_vbq_queue;
+	cam->vbq_ops.buf_release = omap24xxcam_vbq_release;
+	spin_lock_init(&cam->vbq_lock);
+
+	/* Impose a lower limit on the amount of memory allocated for capture.
+	 * We require at least enough memory to double-buffer QVGA (300KB).
+	 */
+	if (capture_mem < QVGA_SIZE * 2)
+		capture_mem = QVGA_SIZE * 2;
+
+	/* request the mem region for the camera registers */
+	if (!request_mem_region(CAM_REG_BASE, CAM_REG_SIZE, vfd->name)) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot reserve camera register I/O region\n");
+		goto init_error;
+	}
+	cam->cam_mmio_base_phys = CAM_REG_BASE;
+	cam->cam_mmio_size = CAM_REG_SIZE;
+
+	/* map the region */
+	cam->cam_mmio_base = (unsigned long)
+	    ioremap(cam->cam_mmio_base_phys, cam->cam_mmio_size);
+	if (!cam->cam_mmio_base) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot map camera register I/O region\n");
+		goto init_error;
+	}
+
+	/* allocate coherent memory for the overlay framebuffer */
+	cam->overlay_size = overlay_mem;
+	if (cam->overlay_size > 0) {
+		cam->overlay_base = (unsigned long) dma_alloc_coherent(NULL,
+			cam->overlay_size,
+			(dma_addr_t *) &cam->overlay_base_phys,
+			GFP_KERNEL | GFP_DMA);
+		if (!cam->overlay_base) {
+			printk(KERN_ERR CAM_NAME
+			       ": cannot allocate overlay framebuffer\n");
+			goto init_error;
+		}
+	}
+	memset((void *) cam->overlay_base, 0, cam->overlay_size);
+
+	/* initialize the overlay spinlock  */
+	spin_lock_init(&cam->overlay_lock);
+
+	/* Enable interface & functional clocks */
+	cam->cami = clk_get(NULL,"cam_ick");
+	cam->camf = clk_get(NULL,"cam_fck");
+	clk_enable(cam->cami);
+	clk_enable(cam->camf);
+
+	/* initialize the camera interface */
+	cam_init(cam);
+
+	/* initialize the spinlock used to serialize access to the image
+	 * parameters
+	 */
+	spin_lock_init(&cam->img_lock);
+	cam->cam_sensor = &camera_sensor_if;
+
+	/* initialize the camera interface functional clock frequency */
+	cam->mclk = DEFAULT_CAM_FUNC_CLK;
+
+	/* initialize the streaming capture parameters */
+	cam->cparm.readbuffers = 1;
+	cam->cparm.capability = V4L2_CAP_TIMEPERFRAME;
+
+	/* Enable the xclk output.  The sensor may (and does, in the case of
+	 * the OV9640) require an xclk input in order for its initialization
+	 * routine to work.
+	 */
+	cam->xclk = DEFAULT_SENSOR_XCLK;	/* choose an arbitrary xclk frequency */
+	omap24xxcam_set_xclk(cam);
+
+	/* get the framebuffer parameters in case the sensor init routine
+	 * needs them
+	 */
+	/* the display controller video layer used for camera preview */
+	cam->vid_preview = OMAP2_VIDEO1;
+	omap2_disp_get_panel_size(omap2_disp_get_output_dev(cam->vid_preview),
+				  &(cam->fbuf.fmt.width),
+				  &(cam->fbuf.fmt.height));
+
+	/* select an arbitrary default capture frame rate of 15fps */
+	cam->nominal_timeperframe.numerator = 1;
+	cam->nominal_timeperframe.denominator = 15;
+
+	/* initialize the sensor and define a default capture format cam->pix */
+	cam->sensor = cam->cam_sensor->init(&cam->pix, &cam->pix2);
+	if (!cam->sensor) {
+		printk(KERN_ERR CAM_NAME ": cannot initialize sensor\n");
+		goto init_error;
+	}
+	printk(KERN_INFO "Sensor is %s\n", cam->cam_sensor->name);
+
+	/* calculate xclk based on the default capture format and default
+	 * frame rate
+	 */
+	cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
+					       &cam->nominal_timeperframe,
+					       cam->sensor);
+	omap24xxcam_adjust_xclk(cam);
+	cam->cparm.timeperframe = cam->nominal_timeperframe;
+
+	/* program the camera interface to generate the new xclk frequency */
+	omap24xxcam_set_xclk(cam);
+
+	/* initialize the image preview parameters based on the default capture
+	 * format
+	 */
+	omap24xxvout_new_format(&cam->pix, &cam->fbuf, &cam->crop, &cam->win);
+
+	/* program the sensor for the default capture format and rate */
+	cam->cam_sensor->configure(&cam->pix, cam->xclk,
+				   &cam->cparm.timeperframe, cam->sensor);
+	if (cam->cam_sensor->configure_still_capture)
+		cam->cam_sensor->configure_still_capture(&cam->pix2, cam->xclk,
+				   &cam->cparm.timeperframe, cam->sensor);
+
+	/* initialize the DMA driver */
+	omap24xxcam_dma_init(cam);
+
+	/* install the interrupt service routine */
+	if (request_irq(INT_24XX_CAMDMA_IRQ24, omap24xxcam_isr, 0, CAM_NAME, cam)) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not install interrupt service routine\n");
+		goto init_error;
+	}
+	cam->irq = INT_24XX_CAMDMA_IRQ24;
+
+	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not register Video for Linux device\n");
+		vfd->minor = -1;
+		goto init_error;
+	}
+	/* set driver specific data to use in power management functions */
+	platform_set_drvdata(pdev, cam);
+
+	printk(KERN_INFO CAM_NAME
+	       ": registered device video%d [v4l2]\n", vfd->minor);
+
+#undef CAMERA_TEST
+#ifdef CAMERA_TEST
+	if (cam->pix.sizeimage <= cam->overlay_size) {
+		printk(KERN_INFO CAM_NAME ": Camera test--enabling overlay\n");
+		/* turn on the video overlay */
+		omap2_disp_config_vlayer(cam->vid_preview, &cam->pix,
+					 &cam->crop, &cam->win, -1, 0);
+		omap2_disp_start_vlayer(cam->vid_preview, &cam->pix, &cam->crop,
+					cam->overlay_base_phys, -1, 0);
+		cam->previewing = (struct omap24xxcam_fh *) 1;
+		/* start the camera interface */
+		omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+		omap24xxcam_start_overlay_dma(cam);
+	} else {
+		printk(KERN_INFO CAM_NAME
+		       ": Can't start camera test--overlay buffer too"
+		       " small\n");
+	}
+#endif
+
+	return 0;
+
+      init_error:
+	omap24xxcam_cleanup();
+	return -ENODEV;
+}
+
+static int omap24xxcam_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap24xxcam_pdriver = {
+	.probe		= omap24xxcam_probe,
+	.remove		= omap24xxcam_remove,
+#ifdef CONFIG_PM
+	.suspend	= omap24xxcam_suspend,
+	.resume		= omap24xxcam_resume,
+#else
+	.suspend	= NULL,
+	.resume		= NULL,
+#endif
+	.shutdown	= NULL,
+	.driver {
+		.name	= CAM_NAME,
+	},
+};
+
+static struct platform_device omap24xxcam_dev = {
+	.name		= CAM_NAME,
+	.dev		=
+	{
+		.release	= NULL,
+	},
+	.id		= 0,
+};
+
+int __init 
+omap24xxcam_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&omap24xxcam_pdriver);
+	if (ret != 0)
+		return ret;
+	ret = platform_device_register(&omap24xxcam_dev);
+	if ( ret != 0) {
+		platform_driver_unregister(&omap24xxcam_pdriver);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void
+omap24xxcam_cleanup(void)
+{
+	struct omap24xxcam_device *cam = saved_cam;
+	struct video_device *vfd;
+
+	if (!cam)
+		return;
+	vfd = cam->vfd;
+
+	if (vfd) {
+		if (vfd->minor == -1) {
+			/* The device was never registered, so release the
+			 * video_device struct directly.
+			 */
+			video_device_release(vfd);
+		} else {
+			/* The unregister function will release the video_device
+			 * struct as well as unregistering it.
+			 */
+			video_unregister_device(vfd);
+		}
+		cam->vfd = NULL;
+	}
+
+	if (cam->irq) {
+		free_irq(cam->irq, cam);
+		cam->irq = 0;
+	}
+
+	omap24xxcam_dma_exit(cam);
+	if (cam->sensor)
+		cam->cam_sensor->cleanup(cam->sensor);
+	/* sensor allocated private data is gone */
+	cam->sensor = NULL;
+
+	if (cam->overlay_base) {
+		dma_free_coherent(NULL, cam->overlay_size,
+			(void *)cam->overlay_base, cam->overlay_base_phys);
+		cam->overlay_base = 0;
+	}
+	cam->overlay_base_phys = 0;
+
+	if (cam->cam_mmio_base) {
+		iounmap((void *) cam->cam_mmio_base);
+		cam->cam_mmio_base = 0;
+	}
+	if (cam->cam_mmio_base_phys) {
+		release_mem_region(cam->cam_mmio_base_phys, cam->cam_mmio_size);
+		cam->cam_mmio_base_phys = 0;
+	}
+	platform_device_unregister(&omap24xxcam_dev);
+	platform_driver_unregister(&omap24xxcam_pdriver);
+
+	/*clk_put(cam->cami);
+	clk_put(cam->camf);*/
+	clk_disable(cam->cami);
+	clk_disable(cam->camf);
+
+	kfree(cam);
+	saved_cam = NULL;
+}
+
+MODULE_AUTHOR("MontaVista Software, Inc.");
+MODULE_DESCRIPTION("OMAP24xx Video for Linux camera driver");
+MODULE_LICENSE("GPL");
+module_param(video_nr, int, 0);
+MODULE_PARM_DESC(video_nr,
+		"Minor number for video device (-1 ==> auto assign)");
+module_param(capture_mem, int, 0);
+MODULE_PARM_DESC(capture_mem,
+	"Maximum amount of memory for capture buffers (default 4800KB)");
+module_param(overlay_mem, int, 0);
+MODULE_PARM_DESC(overlay_mem,
+	"Preview overlay framebuffer size (default 600KB)");
+
+module_init(omap24xxcam_init);
+module_exit(omap24xxcam_cleanup);
diff --git a/drivers/media/video/omap/omap24xxcam.h b/drivers/media/video/omap/omap24xxcam.h
new file mode 100644
index 0000000..83d2886
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.h
@@ -0,0 +1,550 @@
+/*
+ * drivers/media/video/omap/omap24xxcam.h
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
+ * August 2005 - Modified for new display code.
+ * January 2006 - Enhanced to support new sensor interface
+ * Copyright (C) 2006 Texas Instruments, Inc.
+ *
+ */
+
+#ifndef OMAP24XXCAM_H
+#define OMAP24XXCAM_H
+
+/* physical memory map definitions */
+	/* camera subsystem */
+#define CAM_REG_BASE			0x48052000
+#define CAM_REG_SIZE			0x00001000
+	/* camera core */
+#define CC_REG_OFFSET			0x00000400
+	/* camera DMA */
+#define CAMDMA_REG_OFFSET		0x00000800
+	/* camera MMU */
+#define CAMMMU_REG_OFFSET		0x00000C00
+
+/* define camera subsystem register offsets */
+#define CAM_REVISION			0x000
+#define CAM_SYSCONFIG			0x010
+#define CAM_SYSSTATUS			0x014
+#define CAM_IRQSTATUS			0x018
+#define CAM_GPO			0x040
+#define CAM_GPI			0x050
+
+/* define camera core register offsets */
+#define CC_REVISION			0x000
+#define CC_SYSCONFIG			0x010
+#define CC_SYSSTATUS			0x014
+#define CC_IRQSTATUS			0x018
+#define CC_IRQENABLE			0x01C
+#define CC_CTRL			0x040
+#define CC_CTRL_DMA			0x044
+#define CC_CTRL_XCLK			0x048
+#define CC_FIFODATA			0x04C
+#define CC_TEST			0x050
+#define CC_GENPAR			0x054
+#define CC_CCPFSCR			0x058
+#define CC_CCPFECR			0x05C
+#define CC_CCPLSCR			0x060
+#define CC_CCPLECR			0x064
+#define CC_CCPDFR			0x068
+
+/* define camera dma register offsets */
+#define CAMDMA_REVISION		0x000
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
+#define CAMDMA_COLOR(n)		(0x0C4 + (n)*0x60)
+
+/* define camera mmu register offsets */
+#define CAMMMU_REVISION		0x000
+#define CAMMMU_SYSCONFIG		0x010
+#define CAMMMU_SYSSTATUS		0x014
+#define CAMMMU_IRQSTATUS		0x018
+#define CAMMMU_IRQENABLE		0x01C
+#define CAMMMU_WALKING_ST		0x040
+#define CAMMMU_CNTL			0x044
+#define CAMMMU_FAULT_AD		0x048
+#define CAMMMU_TTB			0x04C
+#define CAMMMU_LOCK			0x050
+#define CAMMMU_LD_TLB			0x054
+#define CAMMMU_CAM			0x058
+#define CAMMMU_RAM			0x05C
+#define CAMMMU_GFLUSH			0x060
+#define CAMMMU_FLUSH_ENTRY		0x064
+#define CAMMMU_READ_CAM		0x068
+#define CAMMMU_READ_RAM		0x06C
+#define CAMMMU_EMU_FAULT_AD		0x070
+
+/* Define bit fields within selected registers */
+#define CAM_REVISION_MAJOR		(15 << 4)
+#define CAM_REVISION_MAJOR_SHIFT	4
+#define CAM_REVISION_MINOR		(15 << 0)
+#define CAM_REVISION_MINOR_SHIFT	0
+
+#define CAM_SYSCONFIG_SOFTRESET	(1 <<  1)
+#define CAM_SYSCONFIG_AUTOIDLE		(1 <<  0)
+
+#define CAM_SYSSTATUS_RESETDONE	(1 <<  0)
+
+#define CAM_IRQSTATUS_CC_IRQ		(1 <<  4)
+#define CAM_IRQSTATUS_MMU_IRQ		(1 <<  3)
+#define CAM_IRQSTATUS_DMA_IRQ2		(1 <<  2)
+#define CAM_IRQSTATUS_DMA_IRQ1		(1 <<  1)
+#define CAM_IRQSTATUS_DMA_IRQ0		(1 <<  0)
+
+#define CAM_GPO_CAM_S_P_EN		(1 <<  1)
+#define CAM_GPO_CAM_CCP_MODE		(1 <<  0)
+
+#define CAM_GPI_CC_DMA_REQ1		(1 << 24)
+#define CAP_GPI_CC_DMA_REQ0		(1 << 23)
+#define CAP_GPI_CAM_MSTANDBY		(1 << 21)
+#define CAP_GPI_CAM_WAIT		(1 << 20)
+#define CAP_GPI_CAM_S_DATA		(1 << 17)
+#define CAP_GPI_CAM_S_CLK		(1 << 16)
+#define CAP_GPI_CAM_P_DATA		(0xFFF << 3)
+#define CAP_GPI_CAM_P_DATA_SHIFT	3
+#define CAP_GPI_CAM_P_VS		(1 <<  2)
+#define CAP_GPI_CAM_P_HS		(1 <<  1)
+#define CAP_GPI_CAM_P_CLK		(1 <<  0)
+
+#define CC_REVISION_MAJOR		(15 << 4)
+#define CC_REVISION_MAJOR_SHIFT	4
+#define CC_REVISION_MINOR		(15 << 0)
+#define CC_REVISION_MINOR_SHIFT	0
+
+#define CC_SYSCONFIG_SIDLEMODE		(3 <<  3)
+#define CC_SYSCONFIG_SIDLEMODE_FIDLE	(0 <<  3)
+#define CC_SYSCONFIG_SIDLEMODE_NIDLE	(1 <<  3)
+#define CC_SYSCONFIG_SOFTRESET		(1 <<  1)
+#define CC_SYSCONFIG_AUTOIDLE		(1 <<  0)
+
+#define CC_SYSSTATUS_RESETDONE		(1 <<  0)
+
+#define CC_IRQSTATUS_FS_IRQ		(1 << 19)
+#define CC_IRQSTATUS_LE_IRQ		(1 << 18)
+#define CC_IRQSTATUS_LS_IRQ		(1 << 17)
+#define CC_IRQSTATUS_FE_IRQ		(1 << 16)
+#define CC_IRQSTATUS_FW_ERR_IRQ	(1 << 10)
+#define CC_IRQSTATUS_FSC_ERR_IRQ	(1 <<  9)
+#define CC_IRQSTATUS_SSC_ERR_IRQ	(1 <<  8)
+#define CC_IRQSTATUS_FIFO_NOEMPTY_IRQ	(1 <<  4)
+#define CC_IRQSTATUS_FIFO_FULL_IRQ	(1 <<  3)
+#define CC_IRQSTATUS_FIFO_THR_IRQ	(1 <<  2)
+#define CC_IRQSTATUS_FIFO_OF_IRQ	(1 <<  1)
+#define CC_IRQSTATUS_FIFO_UF_IRQ	(1 <<  0)
+
+#define CC_IRQENABLE_FS_IRQ		(1 << 19)
+#define CC_IRQENABLE_LE_IRQ		(1 << 18)
+#define CC_IRQENABLE_LS_IRQ		(1 << 17)
+#define CC_IRQENABLE_FE_IRQ		(1 << 16)
+#define CC_IRQENABLE_FW_ERR_IRQ	(1 << 10)
+#define CC_IRQENABLE_FSC_ERR_IRQ	(1 <<  9)
+#define CC_IRQENABLE_SSC_ERR_IRQ	(1 <<  8)
+#define CC_IRQENABLE_FIFO_NOEMPTY_IRQ	(1 <<  4)
+#define CC_IRQENABLE_FIFO_FULL_IRQ	(1 <<  3)
+#define CC_IRQENABLE_FIFO_THR_IRQ	(1 <<  2)
+#define CC_IRQENABLE_FIFO_OF_IRQ	(1 <<  1)
+#define CC_IRQENABLE_FIFO_UF_IRQ	(1 <<  0)
+
+#define CC_CTRL_CC_RST			(1 << 18)
+#define CC_CTRL_CC_FRAME_TRIG		(1 << 17)
+#define CC_CTRL_CC_EN			(1 << 16)
+#define CC_CTRL_NOBT_SYNCHRO		(1 << 13)
+#define CC_CTRL_BT_CORRECT		(1 << 12)
+#define CC_CTRL_PAR_ORDERCAM		(1 << 11)
+#define CC_CTRL_PAR_CLK_POL		(1 << 10)
+#define CC_CTRL_NOBT_HS_POL_SHIFT	9
+#define CC_CTRL_NOBT_HS_POL		(1 <<  9)
+#define CC_CTRL_NOBT_VS_POL_SHIFT	8
+#define CC_CTRL_NOBT_VS_POL		(1 <<  8)
+#define CC_CTRL_PAR_MODE		(7 <<  1)
+#define CC_CTRL_PAR_MODE_SHIFT		1
+#define CC_CTRL_PAR_MODE_NOBT8		(0 <<  1)
+#define CC_CTRL_PAR_MODE_NOBT10	(1 <<  1)
+#define CC_CTRL_PAR_MODE_NOBT12	(2 <<  1)
+#define CC_CTRL_PAR_MODE_BT8		(4 <<  1)
+#define CC_CTRL_PAR_MODE_BT10		(5 <<  1)
+#define CC_CTRL_PAR_MODE_FIFOTEST	(7 <<  1)
+#define CC_CTRL_CCP_MODE		(1 <<  0)
+
+#define CC_CTRL_DMA_EN			(1 <<  8)
+#define CC_CTRL_DMA_FIFO_THRESHOLD	(0x7F << 0)
+#define CC_CTRL_DMA_FIFO_THRESHOLD_SHIFT	0
+
+#define CC_CTRL_XCLK_DIV		 	(0x1F << 0)
+#define CC_CTRL_XCLK_DIV_SHIFT		 	0
+#define CC_CTRL_XCLK_DIV_STABLE_LOW	 	(0 <<  0)
+#define CC_CTRL_XCLK_DIV_STABLE_HIGH	 	(1 <<  0)
+#define CC_CTRL_XCLK_DIV_BYPASS	 	(31 << 0)
+
+#define CC_TEST_FIFO_RD_POINTER	 	(0xFF << 24)
+#define CC_TEST_FIFO_RD_POINTER_SHIFT	 	24
+#define CC_TEST_FIFO_WR_POINTER	 	(0xFF << 16)
+#define CC_TEST_FIFO_WR_POINTER_SHIFT	 	16
+#define CC_TEST_FIFO_LEVEL		 	(0xFF <<  8)
+#define CC_TEST_FIFO_LEVEL_SHIFT		8
+#define CC_TEST_FIFO_LEVEL_PEAK		(0xFF <<  0)
+#define CC_TEST_FIFO_LEVEL_PEAK_SHIFT		0
+
+#define CC_GENPAR_FIFO_DEPTH			(7 <<  0)
+#define CC_GENPAR_FIFO_DEPTH_SHIFT		0
+
+#define CC_CCPDFR_ALPHA			(0xFF <<  8)
+#define CC_CCPDFR_ALPHA_SHIFT			8
+#define CC_CCPDFR_DATAFORMAT			(15 <<  0)
+#define CC_CCPDFR_DATAFORMAT_SHIFT		0
+#define CC_CCPDFR_DATAFORMAT_YUV422BE		( 0 <<  0)
+#define CC_CCPDFR_DATAFORMAT_YUV422		( 1 <<  0)
+#define CC_CCPDFR_DATAFORMAT_YUV420		( 2 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB444		( 4 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB565		( 5 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB888NDE		( 6 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RGB888		( 7 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW8NDE		( 8 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW8		( 9 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW10NDE		(10 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW10		(11 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW12NDE		(12 <<  0)
+#define CC_CCPDFR_DATAFORMAT_RAW12		(13 <<  0)
+#define CC_CCPDFR_DATAFORMAT_JPEG8		(15 <<  0)
+
+#define CAMDMA_REVISION_MAJOR			(15 << 4)
+#define CAMDMA_REVISION_MAJOR_SHIFT		4
+#define CAMDMA_REVISION_MINOR			(15 << 0)
+#define CAMDMA_REVISION_MINOR_SHIFT		0
+
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE			(3 << 12)
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE_FSTANDBY	(0 << 12)
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE_NSTANDBY	(1 << 12)
+#define CAMDMA_OCP_SYSCONFIG_MIDLEMODE_SSTANDBY	(2 << 12)
+#define CAMDMA_OCP_SYSCONFIG_FUNC_CLOCK		(1 <<  9)
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
+#define CAMDMA_GCR_MAX_CHANNEL_FIFO_DEPTH_SHIFT	0
+
+#define CAMDMA_CCR_SEL_SRC_DST_SYNC			(1 << 24)
+#define CAMDMA_CCR_PREFETCH				(1 << 23)
+#define CAMDMA_CCR_SUPERVISOR				(1 << 22)
+#define CAMDMA_CCR_SECURE				(1 << 21)
+#define CAMDMA_CCR_BS					(1 << 18)
+#define CAMDMA_CCR_TRANSPARENT_COPY_ENABLE		(1 << 17)
+#define CAMDMA_CCR_CONSTANT_FILL_ENABLE		(1 << 16)
+#define CAMDMA_CCR_DST_AMODE				(3 << 14)
+#define CAMDMA_CCR_DST_AMODE_CONST_ADDR		(0 << 14)
+#define CAMDMA_CCR_DST_AMODE_POST_INC			(1 << 14)
+#define CAMDMA_CCR_DST_AMODE_SGL_IDX			(2 << 14)
+#define CAMDMA_CCR_DST_AMODE_DBL_IDX			(3 << 14)
+#define CAMDMA_CCR_SRC_AMODE				(3 << 12)
+#define CAMDMA_CCR_SRC_AMODE_CONST_ADDR		(0 << 12)
+#define CAMDMA_CCR_SRC_AMODE_POST_INC			(1 << 12)
+#define CAMDMA_CCR_SRC_AMODE_SGL_IDX			(2 << 12)
+#define CAMDMA_CCR_SRC_AMODE_DBL_IDX			(3 << 12)
+#define CAMDMA_CCR_WR_ACTIVE				(1 << 10)
+#define CAMDMA_CCR_RD_ACTIVE				(1 <<  9)
+#define CAMDMA_CCR_SUSPEND_SENSITIVE			(1 <<  8)
+#define CAMDMA_CCR_ENABLE				(1 <<  7)
+#define CAMDMA_CCR_PRIO				(1 <<  6)
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
+#define CAMDMA_CSR_SYNC				(1 <<  6)
+#define CAMDMA_CSR_BLOCK				(1 <<  5)
+#define CAMDMA_CSR_LAST				(1 <<  4)
+#define CAMDMA_CSR_FRAME				(1 <<  3)
+#define CAMDMA_CSR_HALF				(1 <<  2)
+#define CAMDMA_CSR_DROP				(1 <<  1)
+
+#define CAMDMA_CSDP_SRC_ENDIANNESS			(1 << 21)
+#define CAMDMA_CSDP_SRC_ENDIANNESS_LOCK		(1 << 20)
+#define CAMDMA_CSDP_DST_ENDIANNESS			(1 << 19)
+#define CAMDMA_CSDP_DST_ENDIANNESS_LOCK		(1 << 18)
+#define CAMDMA_CSDP_WRITE_MODE				(3 << 16)
+#define CAMDMA_CSDP_WRITE_MODE_WRNP			(0 << 16)
+#define CAMDMA_CSDP_WRITE_MODE_POSTED			(1 << 16)
+#define CAMDMA_CSDP_WRITE_MODE_POSTED_LAST_WRNP	(2 << 16)
+#define CAMDMA_CSDP_DST_BURST_EN			(3 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_1			(0 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_16			(1 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_32			(2 << 14)
+#define CAMDMA_CSDP_DST_BURST_EN_64			(3 << 14)
+#define CAMDMA_CSDP_DST_PACKED				(1 << 13)
+#define CAMDMA_CSDP_WR_ADD_TRSLT			(15 << 9)
+#define CAMDMA_CSDP_WR_ADD_TRSLT_ENABLE_MREQADD	(3 <<  9)
+#define CAMDMA_CSDP_SRC_BURST_EN			(3 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_1			(0 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_16			(1 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_32			(2 <<  7)
+#define CAMDMA_CSDP_SRC_BURST_EN_64			(3 <<  7)
+#define CAMDMA_CSDP_SRC_PACKED				(1 <<  6)
+#define CAMDMA_CSDP_RD_ADD_TRSLT			(15 << 2)
+#define CAMDMA_CSDP_RD_ADD_TRSLT_ENABLE_MREQADD	(3 <<  2)
+#define CAMDMA_CSDP_DATA_TYPE				(3 <<  0)
+#define CAMDMA_CSDP_DATA_TYPE_8BITS			(0 <<  0)
+#define CAMDMA_CSDP_DATA_TYPE_16BITS			(1 <<  0)
+#define CAMDMA_CSDP_DATA_TYPE_32BITS			(2 <<  0)
+
+#define CAMMMU_SYSCONFIG_AUTOIDLE			(1 <<  0)
+
+struct omap24xx_cc_regs {
+	u32 revision;			/* 0x000 */
+	u32 res1[3];
+	u32 sysconfig;			/* 0x010 */
+	u32 sysstatus;			/* 0x014 */
+	u32 irqstatus;			/* 0x018 */
+	u32 irqenable;			/* 0x01C */
+	u32 res2[8];
+	u32 ctrl;			/* 0x040 */
+	u32 ctrl_dma;			/* 0x044 */
+	u32 ctrl_xclk;			/* 0x048 */
+	u32 fifodata;			/* 0x04C */
+	u32 test;			/* 0x050 */
+	u32 genpar;			/* 0x054 */
+	u32 ccpfscr;			/* 0x058 */
+	u32 ccpfecr;			/* 0x05C */
+	u32 ccplscr;			/* 0x060 */
+	u32 ccplecr;			/* 0x064 */
+	u32 ccpdfr;			/* 0x068 */
+};
+
+/* forward declarations */
+struct omap24xxcam_fh;
+struct omap24xxcam_device;
+
+
+/* camera DMA definitions */
+#define DMA_THRESHOLD 32 /* number of bytes transferred per DMA request */
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
+typedef void (*dma_callback_t)(struct omap24xxcam_device *cam, 
+	unsigned long status, void *arg);
+
+struct camdma_state {
+	dma_callback_t callback;
+	void *arg;
+};
+struct sgdma_state {
+	const struct scatterlist *sglist;
+	int sglen;		/* number of sglist entries */
+	int next_sglist;	/* index of next sglist entry to process */
+	int queued_sglist;	/* number of sglist entries queued for DMA */
+	unsigned long csr;	/* DMA return code */
+	dma_callback_t callback;
+	void *arg;
+};
+
+/* per-device data structure */
+struct omap24xxcam_device {
+	struct clk *cami;
+	struct clk *camf;
+	unsigned int irq;
+	
+	unsigned long cam_mmio_base;
+	unsigned long cam_mmio_base_phys;
+	unsigned long cam_mmio_size;
+	
+	unsigned long overlay_base;
+	unsigned long overlay_base_phys;
+	unsigned long overlay_size;
+
+	/* camera DMA management */
+	spinlock_t dma_lock;
+	/* While dma_stop!=0, an attempt to start a new DMA transfer will 
+	 * fail.
+	 */
+	int dma_stop;
+	int free_dmach;	/* number of dma channels free */
+	int next_dmach; /* index of next dma channel to use */
+	struct camdma_state camdma[NUM_CAMDMA_CHANNELS];
+	/* dma_notify is a pointer to a callback routine for notification when 
+	 * a DMA transfer has been started.
+	 */
+	void (*dma_notify)(struct omap24xxcam_device *cam);
+
+	/* frequncy (in Hz) of camera interface functional clock (MCLK) */
+	unsigned long mclk;
+
+	struct device dev;
+	struct video_device *vfd;
+
+	spinlock_t overlay_lock;	/* spinlock for overlay DMA counter */
+	int overlay_cnt;		/* count of queued overlay DMA xfers */
+	struct scatterlist overlay_sglist;
+
+	spinlock_t vbq_lock;		/* spinlock for videobuf queues */
+	struct videobuf_queue_ops vbq_ops;	/* videobuf queue operations */
+	unsigned long field_count;	/* field counter for videobuf_buffer */
+
+	/* scatter-gather DMA management */
+	spinlock_t sg_lock;
+	int free_sgdma;	/* number of free sg dma slots */
+	int next_sgdma;	/* index of next sg dma slot to use */
+	struct sgdma_state sgdma[NUM_SG_DMA];
+
+	/* The img_lock is used to serialize access to the image parameters for 
+	 * overlay and capture.
+	 */
+	spinlock_t img_lock;
+
+ 	/* Access to everything below here is locked by img_lock */
+ 	
+ 	/* We allow streaming from at most one filehandle at a time.  
+ 	 * non-NULL means streaming is in progress.
+ 	 */
+	struct omap24xxcam_fh *streaming;
+	/* We allow previewing from at most one filehandle at a time.  
+	 * non-NULL means previewing is in progress.
+	 */
+	struct omap24xxcam_fh *previewing;
+
+	/* capture parameters (frame rate, number of buffers) */
+	struct v4l2_captureparm cparm;
+	struct v4l2_captureparm cparm2;
+
+	/* This is the frame period actually requested by the user. */
+	struct v4l2_fract nominal_timeperframe;
+
+	/* frequency (in Hz) of camera interface xclk output */
+	unsigned long xclk;
+
+	/* pointer to camera sensor interface interface */
+	struct camera_sensor *cam_sensor;
+	/* blind pointer to private data structure for sensor */
+	void *sensor;
+	
+	/* pix defines the size and pixel format of the image captured by the 
+	 * sensor.  This also defines the size of the framebuffers.  The 
+	 * same pool of framebuffers is used for video capture and video 
+	 * overlay.  These parameters are set/queried by the 
+	 * VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with a CAPTURE buffer type.
+	 */
+	struct v4l2_pix_format pix;
+	struct v4l2_pix_format pix2;
+	int still_capture;
+
+	/* crop defines the size and offset of the video overlay source window 
+	 * within the framebuffer.  These parameters are set/queried by the 
+	 * VIDIOC_S_CROP/VIDIOC_G_CROP ioctls with an OVERLAY buffer type.  
+	 * The cropping rectangle allows a subset of the captured image to be 
+	 * previewed.  It only affects the portion of the image previewed, not 
+	 * captured; the entire camera image is always captured.
+	 */
+	struct v4l2_rect crop;
+
+	/* win defines the size and offset of the video overlay target window 
+	 * within the video display.  These parameters are set/queried by the 
+	 * VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with an OVERLAY buffer type.
+	 */
+	struct v4l2_window win;
+
+	/* fbuf reflects the size of the video display.  It is queried with the 
+	 * VIDIOC_G_FBUF ioctl.  The size of the video display cannot be 
+	 * changed with the VIDIOC_S_FBUF ioctl.
+	 */
+	struct v4l2_framebuffer fbuf;
+
+
+	/* value of CC_CTRL register required to support current capture 
+	 * format
+	 */
+	unsigned long cc_ctrl;
+
+	/* the display controller video layer for camera preview
+	 */
+	int vid_preview;
+
+	/* Power management suspend lockout */
+	int suspended;
+	wait_queue_head_t suspend_wq;
+
+};
+
+/* per-filehandle data structure */
+struct omap24xxcam_fh {
+	struct omap24xxcam_device *cam;
+	enum v4l2_buf_type type;
+	struct videobuf_queue vbq;
+};
+
+#endif	/* ifndef OMAP24XXCAM_H */
diff --git a/drivers/media/video/omap/omap24xxlib.c b/drivers/media/video/omap/omap24xxlib.c
new file mode 100644
index 0000000..4818909
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxlib.c
@@ -0,0 +1,269 @@
+/*
+ * drivers/media/video/omap/omap24xxlib.c
+ *
+ * Copyright (C) 2005 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * Based on the OMAP2 camera driver
+ * Video-for-Linux (Version 2) camera capture driver for 
+ * the OMAP24xx camera controller.
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/videodev.h>
+
+//#include "display.h"
+
+#include <asm/byteorder.h>
+#include <asm/semaphore.h>
+
+/* Return the default overlay cropping rectangle in crop given the image
+ * size in pix and the video display size in fbuf.  The default 
+ * cropping rectangle is the largest rectangle no larger than the capture size 
+ * that will fit on the display.  The default cropping rectangle is centered in 
+ * the image.  All dimensions and offsets are rounded down to even numbers.
+ */
+void
+omap24xxvout_default_crop(struct v4l2_pix_format *pix,
+			  struct v4l2_framebuffer *fbuf, struct v4l2_rect *crop)
+{
+	crop->width = (pix->width < fbuf->fmt.width) ?
+	    pix->width : fbuf->fmt.width;
+	crop->height = (pix->height < fbuf->fmt.height) ?
+	    pix->height : fbuf->fmt.height;
+	crop->width &= ~1;
+	crop->height &= ~1;
+	crop->left = ((pix->width - crop->width) >> 1) & ~1;
+	crop->top = ((pix->height - crop->height) >> 1) & ~1;
+}
+
+/* Given a new render window in new_win, adjust the window to the 
+ * nearest supported configuration.  The adjusted window parameters are 
+ * returned in new_win.
+ * Returns zero if succesful, or -EINVAL if the requested window is 
+ * impossible and cannot reasonably be adjusted.
+ */
+int
+omap24xxvout_try_window(struct v4l2_framebuffer *fbuf,
+			struct v4l2_window *new_win)
+{
+	struct v4l2_rect try_win;
+
+	/* make a working copy of the new_win rectangle */
+	try_win = new_win->w;
+
+	/* adjust the preview window so it fits on the display by clipping any 
+	 * offscreen areas
+	 */
+	if (try_win.left < 0) {
+		try_win.width += try_win.left;
+		try_win.left = 0;
+	}
+	if (try_win.top < 0) {
+		try_win.height += try_win.top;
+		try_win.top = 0;
+	}
+	try_win.width = (try_win.width < fbuf->fmt.width) ?
+	    try_win.width : fbuf->fmt.width;
+	try_win.height = (try_win.height < fbuf->fmt.height) ?
+	    try_win.height : fbuf->fmt.height;
+	if (try_win.left + try_win.width > fbuf->fmt.width)
+		try_win.width = fbuf->fmt.width - try_win.left;
+	if (try_win.top + try_win.height > fbuf->fmt.height)
+		try_win.height = fbuf->fmt.height - try_win.top;
+	try_win.width &= ~1;
+	try_win.height &= ~1;
+
+	if (try_win.width <= 0 || try_win.height <= 0)
+		return -EINVAL;
+
+	/* We now have a valid preview window, so go with it */
+	new_win->w = try_win;
+	new_win->field = V4L2_FIELD_NONE;
+	return 0;
+}
+
+/* Given a new render window in new_win, adjust the window to the 
+ * nearest supported configuration.  The image cropping window in crop 
+ * will also be adjusted if necessary.  Preference is given to keeping the 
+ * the window as close to the requested configuration as possible.  If 
+ * successful, new_win, vout->win, and crop are updated.
+ * Returns zero if succesful, or -EINVAL if the requested preview window is 
+ * impossible and cannot reasonably be adjusted.
+ */
+int
+omap24xxvout_new_window(struct v4l2_rect *crop,
+			struct v4l2_window *win,
+			struct v4l2_framebuffer *fbuf,
+			struct v4l2_window *new_win)
+{
+	int err;
+
+	err = omap24xxvout_try_window(fbuf, new_win);
+	if (err) {
+		return err;
+	}
+
+	/* update our preview window */
+	win->w = new_win->w;
+	win->field = new_win->field;
+	win->chromakey = new_win->chromakey;
+
+	/* adjust the cropping window to allow for resizing limitations */
+	if (crop->height / win->w.height >= 2) {
+		/* The maximum vertical downsizing ratio is 2:1 */
+		crop->height = win->w.height * 2;
+	}
+	if (crop->width / win->w.width >= 2) {
+		/* The maximum horizontal downsizing ratio is 2:1 */
+		crop->width = win->w.width * 2;
+	}
+	if (crop->width > 768) {
+		/* The OMAP2420 vertical resizing line buffer is 768 pixels 
+		 * wide.  If the cropped image is wider than 768 pixels then it 
+		 * cannot be vertically resized.
+		 */
+		if (crop->height != win->w.height)
+			crop->width = 768;
+	}
+	return 0;
+}
+
+/* Given a new cropping rectangle in new_crop, adjust the cropping rectangle to 
+ * the nearest supported configuration.  The image render window in win will 
+ * also be adjusted if necessary.  The preview window is adjusted such that the 
+ * horizontal and vertical rescaling ratios stay constant.  If the render 
+ * window would fall outside the display boundaries, the cropping rectangle will 
+ * also be adjusted to maintain the rescaling ratios.  If successful, crop 
+ * and win are updated.
+ * Returns zero if succesful, or -EINVAL if the requested cropping rectangle is 
+ * impossible and cannot reasonably be adjusted.
+ */
+int
+omap24xxvout_new_crop(struct v4l2_pix_format *pix,
+		      struct v4l2_rect *crop,
+		      struct v4l2_window *win,
+		      struct v4l2_framebuffer *fbuf,
+		      const struct v4l2_rect *new_crop)
+{
+	struct v4l2_rect try_crop;
+	unsigned long vresize, hresize;
+
+	/* make a working copy of the new_crop rectangle */
+	try_crop = *new_crop;
+
+	/* adjust the cropping rectangle so it fits in the image */
+	if (try_crop.left < 0) {
+		try_crop.width += try_crop.left;
+		try_crop.left = 0;
+	}
+	if (try_crop.top < 0) {
+		try_crop.height += try_crop.top;
+		try_crop.top = 0;
+	}
+	try_crop.width = (try_crop.width < pix->width) ?
+	    try_crop.width : pix->width;
+	try_crop.height = (try_crop.height < pix->height) ?
+	    try_crop.height : pix->height;
+	if (try_crop.left + try_crop.width > pix->width)
+		try_crop.width = pix->width - try_crop.left;
+	if (try_crop.top + try_crop.height > pix->height)
+		try_crop.height = pix->height - try_crop.top;
+	try_crop.width &= ~1;
+	try_crop.height &= ~1;
+	if (try_crop.width <= 0 || try_crop.height <= 0)
+		return -EINVAL;
+
+	if (crop->height != win->w.height) {
+		/* If we're resizing vertically, we can't support a crop width 
+		 * wider than 768 pixels.
+		 */
+		if (try_crop.width > 768)
+			try_crop.width = 768;
+	}
+	/* vertical resizing */
+	vresize = (1024 * crop->height) / win->w.height;
+	if (vresize > 2048)
+		vresize = 2048;
+	else if (vresize == 0)
+		vresize = 1;
+	win->w.height = ((1024 * try_crop.height) / vresize) & ~1;
+	if (win->w.height == 0)
+		win->w.height = 2;
+	if (win->w.height + win->w.top > fbuf->fmt.height) {
+		/* We made the preview window extend below the bottom of the 
+		 * display, so clip it to the display boundary and resize the 
+		 * cropping height to maintain the vertical resizing ratio.
+		 */
+		win->w.height = (fbuf->fmt.height - win->w.top) & ~1;
+		try_crop.height = ((vresize * win->w.height) / 1024) & ~1;
+		if (try_crop.height == 0)
+			try_crop.height = 2;
+	}
+	/* horizontal resizing */
+	hresize = (1024 * crop->width) / win->w.width;
+	if (hresize > 2048)
+		hresize = 2048;
+	else if (hresize == 0)
+		hresize = 1;
+	win->w.width = ((1024 * try_crop.width) / hresize) & ~1;
+	if (win->w.width == 0)
+		win->w.width = 2;
+	if (win->w.width + win->w.left > fbuf->fmt.width) {
+		/* We made the preview window extend past the right side of the  
+		 * display, so clip it to the display boundary and resize the 
+		 * cropping width to maintain the horizontal resizing ratio.
+		 */
+		win->w.width = (fbuf->fmt.width - win->w.left) & ~1;
+		try_crop.width = ((hresize * win->w.width) / 1024) & ~1;
+		if (try_crop.width == 0)
+			try_crop.width = 2;
+	}
+	/* update our cropping rectangle and we're done */
+	*crop = try_crop;
+	return 0;
+}
+
+/* Given a new format in pix and fbuf,  crop and win 
+ * structures are initialized to default values. crop 
+ * is initialized to the largest window size that will fit on the display.  The 
+ * crop window is centered in the image. win is initialized to 
+ * the same size as crop and is centered on the display.
+ * All sizes and offsets are constrained to be even numbers.  
+ */
+void
+omap24xxvout_new_format(struct v4l2_pix_format *pix,
+			struct v4l2_framebuffer *fbuf,
+			struct v4l2_rect *crop, struct v4l2_window *win)
+{
+	/* crop defines the preview source window in the image capture 
+	 * buffer
+	 */
+	omap24xxvout_default_crop(pix, fbuf, crop);
+
+	/* win defines the preview target window on the display */
+	win->w.width = crop->width;
+	win->w.height = crop->height;
+	win->w.left = ((fbuf->fmt.width - win->w.width) >> 1) & ~1;
+	win->w.top = ((fbuf->fmt.height - win->w.height) >> 1) & ~1;
+}
diff --git a/drivers/media/video/omap/omap24xxlib.h b/drivers/media/video/omap/omap24xxlib.h
new file mode 100644
index 0000000..6c1f906
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxlib.h
@@ -0,0 +1,34 @@
+/*
+ * drivers/media/video/omap/omap24xxlib.h
+ *
+ * Copyright (C) 2005 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ */
+
+#ifndef OMAP24XXLIB_VIDEO_H
+#define OMAP24XXLIB_VIDEO_H
+
+extern void
+ omap24xxvout_default_crop(struct v4l2_pix_format *pix,	struct v4l2_framebuffer *fbuf,
+				struct v4l2_rect *crop);
+
+extern int
+ omap24xxvout_new_crop(struct v4l2_pix_format *pix, struct v4l2_rect *crop,
+			struct v4l2_window *win, struct v4l2_framebuffer *fbuf,
+			const struct v4l2_rect *new_crop);
+
+extern int
+ omap24xxvout_try_window(struct v4l2_framebuffer *fbuf, struct v4l2_window *new_win);
+
+extern int
+ omap24xxvout_new_window(struct v4l2_rect *crop,struct v4l2_window *win,
+			struct v4l2_framebuffer *fbuf, struct v4l2_window *new_win);
+
+extern void
+ omap24xxvout_new_format(struct v4l2_pix_format *pix, struct v4l2_framebuffer *fbuf,
+			 struct v4l2_rect *crop, struct v4l2_window *win);
+#endif
diff --git a/drivers/media/video/omap/sensor_if.h b/drivers/media/video/omap/sensor_if.h
index 984ba55..e595ccf 100644
--- a/drivers/media/video/omap/sensor_if.h
+++ b/drivers/media/video/omap/sensor_if.h
@@ -2,7 +2,7 @@
 /*
  * drivers/media/video/omap/sensor_if.h
  *
- * Copyright (C) 2004 Texas Instruments, Inc. 
+ * Copyright (C) 2004-2005 Texas Instruments, Inc. 
  * 
  * Sensor interface to OMAP camera capture drivers
  * Sensor driver should implement this interface
@@ -21,29 +21,68 @@
  
 #define LEN_SENSOR_NAME		31
 
+#define PAR_MODE_NOBT8			0
+#define PAR_MODE_NOBT10		1
+#define PAR_MODE_NOBT12		2
+#define PAR_MODE_BT8			4
+#define PAR_MODE_BT10			5
+
+#define SYNC_ACTIVE_HIGH		0
+#define SYNC_ACTIVE_LOW		1
+
+#define V4L2_BUF_TYPE_STILL_CAPTURE 	V4L2_BUF_TYPE_PRIVATE
+
 struct camera_sensor {
 	unsigned int version;
 	char name[LEN_SENSOR_NAME + 1];
 
-	void *(*init)(struct v4l2_pix_format *);
+	int parallel_mode;  /* parallel I/F mode */
+	int hs_polarity;    /* horizontal sync polarity */ 	
+	int vs_polarity;    /* vertical sync polarity */
+	int image_swap;	    /* image swap or not */
+	int bt_correction;  /* BT correction enabled or not */
+
+	/* init the sensor with the passed pix format. A none zero private
+	   pointer must be returned on success. The same pointer is passed
+	   back for all other functions. This gives a sensor driver the
+	   chance to handle multiple sensor. */ 
+	void *(*init)(struct v4l2_pix_format *, struct v4l2_pix_format *);
+	/* clean up the sensor */
 	int (*cleanup)(void *);
 
+	/* These are for power management */
 	int (*power_on)(void *);
 	int (*power_off)(void *);
 
+	/* Handle V4L2 fmt IOCTLs */
 	int (*enum_pixformat)(struct v4l2_fmtdesc *, void *);
 	int (*try_format) (struct v4l2_pix_format *, void *);
 
+	/* Calculated the needed xclk for the pix format passed and the
+	   desired capture rate. */ 
 	unsigned long (*calc_xclk) (struct v4l2_pix_format *,
 		struct v4l2_fract *, void *);
 
+	/* Configure the sensor to generate the passed pix format at the
+	   passed capture rate with the passed xclk */   
 	int (*configure) (struct v4l2_pix_format *, unsigned long,
 					  struct v4l2_fract *, void *);
-
+	/* These handle V4L2 control IOCTLs */
 	int (*query_control) (struct v4l2_queryctrl *, void *);
 	int (*get_control) (struct  v4l2_control *, void *);
 	int (*set_control) (struct  v4l2_control *, void *);
 
+	/* These are only for those sensors that use a different sensor context
+	   for still image capture. A simple sensor driver doesn't have to
+	   implement them. */
+	int (*try_format_still_capture) (struct v4l2_pix_format *, void *);
+	int (*configure_still_capture) (struct v4l2_pix_format *, unsigned long,
+					  struct v4l2_fract *, void *);
+	unsigned long (*calc_xclk_still_capture) (struct v4l2_pix_format *,
+		struct v4l2_fract *, void *);
+	int (*enter_still_capture) (int, void *);
+	int (*exit_still_capture) (void *);
+
 };
 	
 #endif
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index 42098d9..4f47249 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -237,6 +237,7 @@
 #define INT_24XX_SDMA_IRQ1	13
 #define INT_24XX_SDMA_IRQ2	14
 #define INT_24XX_SDMA_IRQ3	15
+#define INT_24XX_CAM_MPU_IRQ	24
 #define INT_24XX_DSS_IRQ	25
 #define INT_24XX_GPIO_BANK1	29
 #define INT_24XX_GPIO_BANK2	30

--------------070003090305090504080104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070003090305090504080104--
