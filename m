From: David Cohen <david.cohen@indt.org.br>
Subject: [PATCH] Re: omap24xxcam status (Was: v4l2 camera test app)
Date: Mon, 20 Mar 2006 17:20:54 -0400
Message-ID: <441F1CB6.3060901@indt.org.br>
References: <304D2A85A9643F4A991BDDF8D297BBA602A10CB5@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080209090509050400040103"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA602A10CB5@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Zhang, Jian" <jzhang@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080209090509050400040103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I am sending a new patch with support for the new sensor interface
(kernel 2.6.10 TI already did it). I have made also some updates
according to Komal comments. :)

Regards,

David Cohen

ext Zhang, Jian wrote:
> David,
>
> I don't see the new sensor interface incorporated in your patch. It is
> likely that Micron 2MP camera MT9D111 will be used by more people. The
> new sensor interface supports double-context which is an advanced
> feature of micron camera.
>
> Regards,
> Jian    
>
> -----Original Message-----
> From: David Cohen [mailto:david.cohen@indt.org.br] 
> Sent: Monday, March 20, 2006 10:10 AM
> To: ext Komal Shah
> Cc: Ola Helm; Linux-omap-open-source@linux.omap.com; Zhang, Jian
> Subject: Re: omap24xxcam status (Was: v4l2 camera test app)
>
> Hi,
>
> I just sent a code that should be compilable and working. I guess the
> mainly target is to apply this patch to the public tree. After that, as
> Komal said, could be interesting to update the dma code to the omap api
> to be easier future reviews.
>
> Regards,
>
> David Cohen
>
> ext Komal Shah wrote:
>
>   
>> --- Ola Helm <ola.hel@gmail.com> wrote:
>>
>>  
>>
>>     
>>> Hi,
>>>
>>> Have you got some idea what's the situation of the 24xx camera driver
>>> at the
>>> moment? AFAIK the patch David sent in last month is not included to
>>> tree,
>>> propably since there were some opposite opinions about the way of
>>> implementation and at least I did not have one file mentioned in
>>> patch (I
>>> think you mentioned about the same issue)
>>>    
>>>
>>>       
>> 24xx camera driver is now in David's hand. I just review the code now,
>> as not able to work on camera stuff anymore.
>>
>> Following strategy can work out meanwhile as I had offline discussion
>> with David :)
>>
>> o Separate 24xx CamDMA code from omap24xxcam.c to new file as 
>>  exported apis (Suggested by David)
>>
>> o Keep the old omap24xxcam driver interface(2.6.8 TI kernel days), 
>>  having video out code part of the camera driver itself. As new 
>>  separated video out code depends upon the common display controller  
>>  library, which requires to change fb driver in git tree to adopt 
>>  that interface, so that video out, and fb driver can 
>>  utilize the same code. But video out patches submitted by me didn't 
>>  generated any discussion on the list in that direction. 
>>
>> o So, to have 24xx camera code in git tree, we can use the old camera 
>>  driver interface as of now, if everyone agrees.
>>
>> ---Komal Shah
>> http://komalshah.blogspot.com/
>>
>> __________________________________________________
>> Do You Yahoo!?
>> Tired of spam?  Yahoo! Mail has the best spam protection around 
>> http://mail.yahoo.com 
>>  
>>
>>     
>
>   


--------------080209090509050400040103
Content-Type: text/plain;
 name="diff_omap24xxcam_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff_omap24xxcam_v2.patch"

diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index c4c5a81..3027af6 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -3,9 +3,8 @@
 obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
 obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
 
-objs-yy := camera_core.o
-
-objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o
+objs-y$(CONFIG_ARCH_OMAP16XX) += camera_core.o omap16xxcam.o
+objs-y$(CONFIG_ARCH_OMAP24XX) += omap24xxcam.o
 objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
 
 omapcamera-objs := $(objs-yy)
diff --git a/drivers/media/video/omap/omap24xxcam.c b/drivers/media/video/omap/omap24xxcam.c
new file mode 100644
index 0000000..e46ce15
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.c
@@ -0,0 +1,3381 @@
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
+ * 2006/mar - David Cohen <david.cohen@indt.org.br>
+ *            * Updated the driver for the Linux Device Model
+ *            * Updated some obsolete functions of V4L2
+ *            * Some others small fixes
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
+#include <linux/i2c.h>
+#include <linux/videodev.h>
+#include <linux/pci.h>		/* needed for videobufs */
+#include <media/video-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/scatterlist.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+#include <asm/processor.h>
+#include <asm/arch/clock.h>
+
+#include "omap24xxcam.h"
+#include "sensor_if.h"
+
+/* configuration macros */
+#define CAM_NAME 	"omap24xxcam"
+
+/* Should be moved from here */
+#define INT_CAM_MPU_IRQ 24
+
+//#define DEBUG_CAM
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
+extern struct camera_sensor camera_sensor_if;
+
+void omap24xxcam_cleanup(void);
+
+/* global variables */
+static struct omap24xxcam_device *saved_cam;
+
+/* module parameters */
+static int video_nr = -1;	/* video device minor (-1 ==> auto assign) */
+/* Maximum amount of memory to use for capture buffers.
+ * Default is 4800KB, enough to double-buffer SXGA.
+ */
+static int capture_mem = 1280 * 960 * 2 * 2;
+/* Size of video overlay framebuffer.  This determines the maximum image size 
+ * that can be previewed.  Default is 600KB, enough for VGA.
+ */
+static int overlay_mem = 640 * 480 * 2;
+/* Size of video2_mem framebuffer. This determines the maximum image size which
+ * video2_layer can support. Default is 300 KB. Size of LCD or 320*240.
+*/
+static int video2_mem = 320 * 240 * 2;
+
+static struct clk *cam_fck;
+static struct clk *cam_ick;
+
+/* -------------------------------------------------------------------------- */
+
+/* Set the value of the CC_CTRL register in cam->cc_ctrl that is required to 
+ * support the currently selected capture format in cam->pix.  The CC_CTRL bits 
+ * which must be configured are:  NOBT_SYNCHRO, BT_CORRECT, PAR_ORDERCAM, 
+ * PAR_CLK_POL, NOBT_HS_POL, NOBT_VS_POL, PAR_MODE, and CCP_MODE.  The CC_RST, 
+ * CC_FRAME_TRIG, and CC_EN bits are actively managed by the driver and should 
+ * be set to zero by this routine.
+ */
+static void omap24xxcam_sensor_cc_ctrl(struct omap24xxcam_device *cam)
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
+	  (sensor->parallel_mode == PAR_MODE_BT10)) {
+		/* BT correction enable */
+		cam->cc_ctrl |= (sensor->bt_correction ? CC_CTRL_BT_CORRECT : 0);
+		cam->cc_ctrl |= ((sensor->parallel_mode == PAR_MODE_BT8) ? CC_CTRL_PAR_MODE_BT8 : CC_CTRL_PAR_MODE_BT10);
+	}
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
+void cc_init(const struct omap24xxcam_device *cam)
+{
+	DBG;
+	/* Setting the camera core AUTOIDLE bit causes problems with frame 
+	 * synchronization, so we will clear the AUTOIDLE bit instead.
+	 */
+	//cc_reg_out(cam, CC_SYSCONFIG, 0);
+	cc_reg_out(cam, CC_SYSCONFIG, CC_SYSCONFIG_AUTOIDLE);
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
+void cammmu_init(const struct omap24xxcam_device *cam)
+{
+	DBG;
+	/* set the camera MMU autoidle bit */
+	cammmu_reg_out(cam, CAMMMU_SYSCONFIG, CAMMMU_SYSCONFIG_AUTOIDLE);
+}
+
+/*
+ * camera DMA register I/O routines
+ */
+
+__inline__ u32 
+camdma_reg_in(const struct omap24xxcam_device *cam, u32 offset)
+{
+	return readl(cam->cam_mmio_base + CAMDMA_REG_OFFSET + offset);
+}
+
+__inline__ u32 
+camdma_reg_out(const struct omap24xxcam_device *cam, u32 offset, u32 val)
+{
+	writel(val, cam->cam_mmio_base + CAMDMA_REG_OFFSET + offset);
+	return val;
+}
+
+__inline__ u32 
+camdma_reg_merge(const struct omap24xxcam_device *cam, u32 offset, 
+		u32 val, u32 mask)
+{
+	u32 addr = cam->cam_mmio_base + CAMDMA_REG_OFFSET + offset;
+	u32 new_val = (readl(addr) & ~mask) | (val & mask);
+
+	writel(new_val, addr);
+	return new_val;
+}
+
+void
+camdma_init(const struct omap24xxcam_device *cam)
+{
+	DBG;
+	camdma_reg_out(cam, CAMDMA_OCP_SYSCONFIG, 
+		CAMDMA_OCP_SYSCONFIG_MIDLEMODE_NSTANDBY 
+	      | CAMDMA_OCP_SYSCONFIG_SIDLEMODE_FIDLE
+	      | CAMDMA_OCP_SYSCONFIG_AUTOIDLE);
+
+	camdma_reg_merge(cam, CAMDMA_GCR, 0x10, 
+		CAMDMA_GCR_MAX_CHANNEL_FIFO_DEPTH);
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
+	DBG;
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
+	if (!(cam_reg_in(cam, CAM_SYSSTATUS) & CAM_SYSSTATUS_RESETDONE)) {
+		printk(KERN_WARNING CAM_NAME
+		       ": timeout waiting for camera subsystem reset\n");
+	}
+
+	return;
+}
+
+/* Initialize the camera subsystem (camera core, camera DMA, and camera MMU) */
+void cam_init(const struct omap24xxcam_device *cam)
+{
+	DBG;
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
+/*
+ * display controller register I/O routines
+ */
+
+static __inline__ u32
+dispc_reg_in(const struct omap24xxcam_device *cam, u32 offset)
+{
+	return readl(cam->dispc_mmio_base + DISPC_REG_OFFSET + offset);
+}
+
+static __inline__ u32
+dispc_reg_out(const struct omap24xxcam_device *cam, u32 offset, u32 val)
+{
+	writel(val, cam->dispc_mmio_base + DISPC_REG_OFFSET + offset);
+	return val;
+}
+
+static __inline__ u32
+dispc_reg_merge(const struct omap24xxcam_device *cam, u32 offset,
+		u32 val, u32 mask)
+{
+	u32 addr = cam->dispc_mmio_base + DISPC_REG_OFFSET + offset;
+	u32 new_val = (readl(addr) & ~mask) | (val & mask);
+
+	writel(new_val, addr);
+	return new_val;
+}
+
+/* -------------------------------------------------------------------------- */
+
+/* Turn off the video overlay window. */
+static void omap24xxcam_disable_vlayer(struct omap24xxcam_device *cam, int v)
+{
+	unsigned long vid_attributes;
+
+	DBG;
+
+	vid_attributes = dispc_reg_merge(cam, DISPC_VID_ATTRIBUTES(v), 0,
+					 DISPC_VID_ATTRIBUTES_ENABLE);
+	if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+		/* digital output */
+		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+				DISPC_CONTROL_GODIGITAL);
+	} else {
+		/* LCD */
+		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+				DISPC_CONTROL_GOLCD);
+	}
+}
+
+/* Flip the video overlay framebuffer.  The video overlay window may initially 
+ * be either enabled or disabled.  The overlay window will be enabled by this 
+ * routine.  fb_base_phys is the physical base address of the framebuffer for 
+ * the video overlay.  The address programmed into the base address register of 
+ * the video overlay window is calculated based on the cropped size and the full
+ * size of the overlay framebuffer. 
+ */
+static void
+omap24xxcam_flip_overlay(struct omap24xxcam_device *cam,
+			 unsigned long fb_base_phys)
+{
+	unsigned long vid_attributes;
+	int v = cam->vid1;
+	unsigned long cropped_base_phys;
+	struct v4l2_rect *crop = &cam->crop;
+	struct v4l2_pix_format *pix = &cam->pix;
+
+	DBG;
+
+	cropped_base_phys = fb_base_phys
+	    + pix->bytesperline * crop->top + crop->left * 2;
+	dispc_reg_out(cam, DISPC_VID_BA0(v), cropped_base_phys);
+	dispc_reg_out(cam, DISPC_VID_BA1(v), cropped_base_phys);
+
+	vid_attributes = dispc_reg_merge(cam, DISPC_VID_ATTRIBUTES(v),
+					 DISPC_VID_ATTRIBUTES_ENABLE,
+					 DISPC_VID_ATTRIBUTES_ENABLE);
+	if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+		/* digital output */
+		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+				DISPC_CONTROL_GODIGITAL);
+	} else {
+		/* LCD */
+		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+				DISPC_CONTROL_GOLCD);
+	}
+}
+
+/* Get the framebuffer parameters by reading the display controller registers 
+ * for the graphics window.
+ */
+static void omap24xxcam_g_fbuf(struct omap24xxcam_device *cam)
+{
+	struct v4l2_framebuffer *fbuf = &cam->fbuf;
+	unsigned long gfx_size, gfx_position;
+
+	DBG;
+
+	/* This routine makes some assumptions about the framebuffer driver.  
+	 * First, the entire contents of the graphics framebuffer must be 
+	 * displayed, i.e. a configuration in which part of the graphics 
+	 * framebuffer is offscreen is not supported.  The graphics 
+	 * window must not be resized or repositioned while capture preview is 
+	 * active.  The rotation capabilities of the display controller must 
+	 * not be used to rotate the graphics window.
+	 */
+	fbuf->capability = V4L2_FBUF_CAP_EXTERNOVERLAY
+	    | V4L2_FBUF_CAP_CHROMAKEY;
+	gfx_size = dispc_reg_in(cam, DISPC_GFX_SIZE);
+	fbuf->fmt.width = 1 + ((gfx_size & DISPC_GFX_SIZE_GFXSIZEX)
+			       >> DISPC_GFX_SIZE_GFXSIZEX_SHIFT);
+	fbuf->fmt.height = 1 + ((gfx_size & DISPC_GFX_SIZE_GFXSIZEY)
+				>> DISPC_GFX_SIZE_GFXSIZEY_SHIFT);
+	gfx_position = dispc_reg_in(cam, DISPC_GFX_POSITION);
+	cam->gfx_position_x = (gfx_position & DISPC_GFX_POSITION_GFXPOSX)
+	    >> DISPC_GFX_POSITION_GFXPOSX_SHIFT;
+	cam->gfx_position_y = (gfx_position & DISPC_GFX_POSITION_GFXPOSY)
+	    >> DISPC_GFX_POSITION_GFXPOSY_SHIFT;
+	cam->gfx_attributes = dispc_reg_in(cam, DISPC_GFX_ATTRIBUTES);
+}
+
+/* Return the default overlay cropping rectangle in crop given the image capture
+ * size in cam->pix and the video display size in cam->fbuf.  The default 
+ * cropping rectangle is the largest rectangle no larger than the capture size 
+ * that will fit on the display.  The default cropping rectangle is centered in 
+ * the captured image.  All dimensions and offsets are rounded down to even 
+ * numbers.
+ */
+static void
+omap24xxcam_default_crop_rect(struct omap24xxcam_device *cam,
+			      struct v4l2_rect *crop)
+{
+	struct v4l2_pix_format *pix = &cam->pix;
+	struct v4l2_framebuffer *fbuf = &cam->fbuf;
+
+	DBG;
+
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
+/* Given a new cropping rectangle in new_crop, adjust the cropping rectangle to 
+ * the nearest supported configuration.  The image preview window cam->win will 
+ * also be adjusted if necessary.  The preview window is adjusted such that the 
+ * horizontal and vertical rescaling ratios stay constant.  If the preview 
+ * window would fall outside the display boundaries, the cropping rectangle will 
+ * also be adjusted to maintain the rescaling ratios.  If successful, cam->crop 
+ * and cam->win are updated.
+ * Returns zero if succesful, or -EINVAL if the requested cropping rectangle is 
+ * impossible and cannot reasonably be adjusted.
+ */
+static int
+omap24xxcam_new_crop_rect(struct omap24xxcam_device *cam,
+			  const struct v4l2_rect *new_crop)
+{
+	struct v4l2_pix_format *pix = &cam->pix;
+	struct v4l2_window *win = &cam->win;
+	struct v4l2_framebuffer *fbuf = &cam->fbuf;
+	struct v4l2_rect *crop = &cam->crop;
+	struct v4l2_rect try_crop;
+	unsigned long vresize, hresize;
+
+	DBG;
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
+/* Given a new preview window in new_win, adjust the preview window to the 
+ * nearest supported configuration.  The adjusted preview window parameters are 
+ * returned in new_win.
+ * Returns zero if succesful, or -EINVAL if the requested preview window is 
+ * impossible and cannot reasonably be adjusted.
+ */
+static int
+omap24xxcam_try_preview_window(struct omap24xxcam_device *cam,
+			       struct v4l2_window *new_win)
+{
+	struct v4l2_framebuffer *fbuf = &cam->fbuf;
+	struct v4l2_rect try_win;
+
+	DBG;
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
+	if (try_win.width <= 0 || try_win.height <= 0)
+		return -EINVAL;
+
+	/* We now have a valid preview window, so go with it */
+	new_win->w = try_win;
+	new_win->field = V4L2_FIELD_NONE;
+	return 0;
+}
+
+/* Given a new preview window in new_win, adjust the preview window to the 
+ * nearest supported configuration.  The image cropping window cam->crop 
+ * will also be adjusted if necessary.  Preference is given to keeping the 
+ * preview window as close to the requested configuration as possible.  If 
+ * successful, new_win, cam->win, and cam->crop are updated.
+ * Returns zero if succesful, or -EINVAL if the requested preview window is 
+ * impossible and cannot reasonably be adjusted.
+ */
+static int
+omap24xxcam_new_preview_window(struct omap24xxcam_device *cam,
+			       struct v4l2_window *new_win)
+{
+	struct v4l2_window *win = &cam->win;
+	struct v4l2_rect *crop = &cam->crop;
+	int err;
+
+	DBG;
+
+	err = omap24xxcam_try_preview_window(cam, new_win);
+	if (err)
+		return err;
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
+/* Given a capture format in cam->pix, the cam->crop, cam->win, and cam->fbuf 
+ * structures are initialized to default values.  cam->fbuf is initialized by 
+ * reading the display controller registers for the graphics window.  cam->crop 
+ * is initialized to the largest window size that will fit on the display.  The 
+ * crop window is centered in the captured image.  cam->win is initialized to 
+ * the same size as cam->crop and is centered on the display.
+ * All sizes and offsets are constrained to be even numbers.  
+ */
+static void omap24xxcam_new_capture_format(struct omap24xxcam_device *cam)
+{
+	struct v4l2_rect *crop = &cam->crop;
+	struct v4l2_window *win = &cam->win;
+	struct v4l2_framebuffer *fbuf = &cam->fbuf;
+
+	DBG;
+
+	/* get the framebuffer parameters */
+	omap24xxcam_g_fbuf(cam);
+
+	/* crop defines the preview source window in the image capture 
+	 * buffer
+	 */
+	omap24xxcam_default_crop_rect(cam, crop);
+
+	/* win defines the preview target window on the display */
+	win->w.width = crop->width;
+	win->w.height = crop->height;
+	win->w.left = ((fbuf->fmt.width - win->w.width) >> 1) & ~1;
+	win->w.top = ((fbuf->fmt.height - win->w.height) >> 1) & ~1;
+}
+
+/* Program the camera interface xclk for the frequency cam->xclk based on 
+ * the functional clock frequency cam->mclk.  If the specifed cam->xclk 
+ * frequency is not possible based on the value of cam->mclk, then the 
+ * closest xclk frequency lower than the specified xclk will be selected.  
+ * The actual xclk frequency is returned in cam->xclk.  If cam->xclk is zero, 
+ * then xclk is turned off (stable low value).
+ */
+static void omap24xxcam_set_xclk(struct omap24xxcam_device *cam)
+{
+	unsigned long divisor;
+
+	DBG;
+
+	if (cam->mclk == 0)
+		cam->mclk = 96000000;	/* supply a default mclk */
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
+	if (divisor > 30)
+		divisor = 30;
+	cam->xclk = cam->mclk / divisor;
+	if (divisor == 1)
+		cc_reg_out(cam, CC_CTRL_XCLK, CC_CTRL_XCLK_DIV_BYPASS);
+	else
+		cc_reg_out(cam, CC_CTRL_XCLK, divisor);
+}
+
+/* Write the color space conversion coefficients to the display controller 
+ * registers.  Each coefficient is a signed 11-bit integer in the range 
+ * [-1024, 1023].  The matrix coefficients are:
+ *	[ RY  RCr  RCb ]
+ *	[ GY  GCr  GCb ]
+ *	[ BY  BCr  BCb ]
+ */
+static void
+omap24xxcam_set_colorconv(struct omap24xxcam_device *cam,
+			  const short int mtx[3][3], int v)
+{
+	unsigned long ccreg;
+
+	DBG;
+
+	ccreg = (mtx[0][0] & 0x7ff) | ((mtx[0][1] & 0x7ff) << 16);
+	dispc_reg_out(cam, DISPC_VID_CONV_COEF0(v), ccreg);
+	ccreg = (mtx[0][2] & 0x7ff) | ((mtx[1][0] & 0x7ff) << 16);
+	dispc_reg_out(cam, DISPC_VID_CONV_COEF1(v), ccreg);
+	ccreg = (mtx[1][1] & 0x7ff) | ((mtx[1][2] & 0x7ff) << 16);
+	dispc_reg_out(cam, DISPC_VID_CONV_COEF2(v), ccreg);
+	ccreg = (mtx[2][0] & 0x7ff) | ((mtx[2][1] & 0x7ff) << 16);
+	dispc_reg_out(cam, DISPC_VID_CONV_COEF3(v), ccreg);
+	ccreg = mtx[2][2] & 0x7ff;
+	dispc_reg_out(cam, DISPC_VID_CONV_COEF4(v), ccreg);
+}
+
+/* Write the horizontal and vertical resizing coefficients to the display 
+ * controller registers.  Each coefficient is a signed 8-bit integer in the 
+ * range [-128, 127] except for the middle coefficient (vc[1][i] and hc[3][i]) 
+ * which is an unsigned 8-bit integer in the range [0, 255].  The first index of
+ * the matrix is the coefficient number (0 to 2 vertical or 0 to 4 horizontal) 
+ * and the second index is the phase (0 to 7).
+ */
+static void
+omap24xxcam_set_resize(struct omap24xxcam_device *cam,
+		       const short int vc[3][8], const short int hc[5][8],
+		       int v)
+{
+	int i;
+	unsigned long reg;
+
+	DBG;
+
+	for (i = 0; i < 8; i++) {
+		reg = (hc[0][i] & 0xff) | ((hc[1][i] & 0xff) << 8)
+		    | ((hc[2][i] & 0xff) << 16) | ((hc[3][i] & 0xff) << 24);
+		dispc_reg_out(cam, DISPC_VID_FIR_COEF_H(v, i), reg);
+		reg = (hc[4][i] & 0xff) | ((vc[0][i] & 0xff) << 8)
+		    | ((vc[1][i] & 0xff) << 16) | ((vc[2][i] & 0xff) << 24);
+		dispc_reg_out(cam, DISPC_VID_FIR_COEF_HV(v, i), reg);
+	}
+}
+
+static void
+omap24xxcam_configure_overlay(struct omap24xxcam_device *cam,
+			      struct omap24xx_vid2_format *vid2_format)
+{
+	int v;
+	struct v4l2_window *win = &cam->win;
+	struct v4l2_rect *crop = &cam->crop;
+	struct v4l2_pix_format *pix;
+	struct v4l2_framebuffer *fbuf = &cam->fbuf;
+	int vid_position_x, vid_position_y;
+	unsigned long vid_position, vid_size, vid_picture_size;
+	unsigned long vid_attributes;
+	unsigned long firvinc, firhinc;
+	/* color space conversion matrices */
+	const static short int cc_bt601[3][3] = {
+		{298, 409, 0},
+		{298, -208, -100},
+		{298, 0, 517}
+	};
+	const static short int cc_bt709[3][3] = {
+		{298, 459, 0},
+		{298, -137, -55},
+		{298, 0, 541}
+	};
+	const static short int cc_bt601_full[3][3] = {
+		{256, 351, 0},
+		{256, -179, -86},
+		{256, 0, 443}
+	};
+	/* vertical resizing matrix */
+	const static short int vc[3][8] = {
+		{0, 3, 12, 32, 0, 7, 5, 2},
+		{128, 123, 111, 89, 64, 89, 111, 123},
+		{0, 2, 5, 7, 64, 32, 12, 3}
+	};
+	/* horizontal resizing matrix */
+	const static short int hc[5][8] = {
+		{0, -1, -2, -5, 0, -2, -1, 0},
+		{0, 13, 30, 51, -9, -11, -11, -8},
+		{128, 124, 112, 95, 73, 95, 112, 124},
+		{0, -8, -11, -11, 73, 51, 30, 13},
+		{0, 0, -1, -2, -9, -5, -2, -1}
+	};
+
+	DBG;
+
+	if (vid2_format) {
+		pix = &vid2_format->pix;
+		v = cam->vid2;
+	} else {
+		pix = &cam->pix;
+		v = cam->vid1;
+	}
+	/* make sure the video overlay is disabled before we reconfigure it */
+	omap24xxcam_disable_vlayer(cam, v);
+
+	/* configure the video attributes register */
+	vid_attributes = 0;
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_YUYV:
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_YUV2;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE;
+		break;
+	case V4L2_PIX_FMT_UYVY:
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_UYVY;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE;
+		break;
+	case V4L2_PIX_FMT_RGB565:
+	default:
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB16;
+		vid_attributes |= ((cam->gfx_attributes &
+				    DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE)
+				   << 5);
+		break;
+	case V4L2_PIX_FMT_RGB565X:
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB16;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDENDIANNESS;
+		vid_attributes |= ((cam->gfx_attributes &
+				    DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE)
+				   << 5);
+		break;
+	}
+	if (cam->gfx_attributes & DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT)
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDCHANNELOUT;
+	vid_attributes |= ((cam->gfx_attributes
+			    & DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE) << 8);
+	switch (pix->colorspace) {
+	case V4L2_COLORSPACE_SMPTE170M:
+	case V4L2_COLORSPACE_SMPTE240M:
+	case V4L2_COLORSPACE_BT878:
+	case V4L2_COLORSPACE_470_SYSTEM_M:
+	case V4L2_COLORSPACE_470_SYSTEM_BG:
+		/* luma (Y) range lower limit is 16, BT.601 standard */
+		omap24xxcam_set_colorconv(cam, cc_bt601, v);
+		break;
+	case V4L2_COLORSPACE_REC709:
+		/* luma (Y) range lower limit is 16, BT.709 standard */
+		omap24xxcam_set_colorconv(cam, cc_bt709, v);
+		break;
+	case V4L2_COLORSPACE_JPEG:
+	case V4L2_COLORSPACE_SRGB:
+		/* full luma (Y) range, assume BT.601 standard */
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFULLRANGE;
+		omap24xxcam_set_colorconv(cam, cc_bt601_full, v);
+		break;
+	}
+	if (!vid2_format) {	/* use win and crop if it is for overlay */
+		if (win->w.width != crop->width) {
+			vid_attributes |=
+			    DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_HRESIZE;
+			if (win->w.width < crop->width)
+				vid_attributes |=
+				    DISPC_VID_ATTRIBUTES_VIDHRESIZECONF;
+		}
+		if (win->w.height != crop->height) {
+			vid_attributes |=
+			    DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_VRESIZE;
+			if (win->w.height < crop->height)
+				vid_attributes |=
+				    DISPC_VID_ATTRIBUTES_VIDVRESIZECONF;
+		}
+	}
+	dispc_reg_out(cam, DISPC_VID_ATTRIBUTES(v), vid_attributes);
+
+	/* configure transparency color key */
+	if (fbuf->flags & V4L2_FBUF_FLAG_CHROMAKEY) {
+		/* enable chromakey */
+		if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+			/* digital output channel */
+			dispc_reg_out(cam, DISPC_TRANS_COLOR1, win->chromakey);
+			dispc_reg_merge(cam, DISPC_CONFIG,
+					DISPC_CONFIG_TCKDIGENABLE,
+					DISPC_CONFIG_TCKDIGSELECTION
+					| DISPC_CONFIG_TCKDIGENABLE);
+		} else {
+			/* LCD */
+			dispc_reg_out(cam, DISPC_TRANS_COLOR0, win->chromakey);
+			dispc_reg_merge(cam, DISPC_CONFIG,
+					DISPC_CONFIG_TCKLCDENABLE,
+					DISPC_CONFIG_TCKLCDSELECTION
+					| DISPC_CONFIG_TCKLCDENABLE);
+		}
+	} else {
+		/* disable chromakey */
+		if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+			/* digital output channel */
+			dispc_reg_merge(cam, DISPC_CONFIG, 0,
+					DISPC_CONFIG_TCKDIGSELECTION
+					| DISPC_CONFIG_TCKDIGENABLE);
+		} else {
+			/* LCD */
+			dispc_reg_merge(cam, DISPC_CONFIG, 0,
+					DISPC_CONFIG_TCKLCDSELECTION
+					| DISPC_CONFIG_TCKLCDENABLE);
+		}
+	}
+
+	/* initialize the resizing filter */
+	omap24xxcam_set_resize(cam, vc, hc, v);
+
+	if (!vid2_format) {	/* use win and crop if it is for overlay */
+		dispc_reg_out(cam, DISPC_VID_ACCU0(v), 0);
+		dispc_reg_out(cam, DISPC_VID_ACCU1(v), 0);
+		firhinc = (1024 * (crop->width - 1)) / (win->w.width - 1);
+		if (firhinc < 1)
+			firhinc = 1;
+		else if (firhinc > 2047)
+			firhinc = 2047;
+		firvinc = (1024 * (crop->height - 1)) / (win->w.height - 1);
+		if (firvinc < 1)
+			firvinc = 1;
+		else if (firvinc > 2047)
+			firvinc = 2047;
+		dispc_reg_out(cam, DISPC_VID_FIR(v), firhinc | (firvinc << 16));
+
+		/* configure the target window on the display */
+		vid_position_x = cam->gfx_position_x + win->w.left;
+		vid_position_y = cam->gfx_position_y + win->w.top;
+		vid_size =
+		    (((win->w.width - 1) << DISPC_VID_SIZE_VIDSIZEX_SHIFT)
+		     & DISPC_VID_SIZE_VIDSIZEX)
+		    | (((win->w.height - 1) << DISPC_VID_SIZE_VIDSIZEY_SHIFT)
+		       & DISPC_VID_SIZE_VIDSIZEY);
+
+		/* configure the source window in the framebuffer */
+		vid_picture_size =
+		    (((crop->width -
+		       1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+		     & DISPC_VID_PICTURE_SIZE_VIDORGSIZEX)
+		    |
+		    (((crop->height -
+		       1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+		     & DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+		dispc_reg_out(cam, DISPC_VID_ROW_INC(v),
+			      1 + pix->bytesperline - crop->width * 2);
+	} else {		/* video 2 layer configuration */
+		struct v4l2_framebuffer *fbuf = &cam->fbuf;
+		int row_inc;
+		/* in video2 layer we won't be down or up scaling */
+		dispc_reg_out(cam, DISPC_VID_FIR(v), 0x400 | (0x400 << 16));
+		if (pix->width + vid2_format->left > fbuf->fmt.width) {
+			vid_position_x = fbuf->fmt.width < pix->width ? 0 :
+			    cam->gfx_position_x + fbuf->fmt.width - pix->width;
+		} else {
+			vid_position_x = cam->gfx_position_x +
+			    vid2_format->left;
+
+		}
+
+		if (pix->height + vid2_format->top > fbuf->fmt.height) {
+			vid_position_y = fbuf->fmt.height < pix->height ? 0 :
+			    cam->gfx_position_y +
+			    fbuf->fmt.height - pix->height;
+		} else {
+			vid_position_y = cam->gfx_position_y + vid2_format->top;
+		}
+
+		vid_size = ((((pix->width > fbuf->fmt.width ? fbuf->fmt.width
+			       : pix->width) - 1)
+			     << DISPC_VID_SIZE_VIDSIZEX_SHIFT)
+			    & DISPC_VID_SIZE_VIDSIZEX)
+		    | ((((pix->height > fbuf->fmt.height ? fbuf->fmt.height
+			  : pix->height) - 1) << DISPC_VID_SIZE_VIDSIZEY_SHIFT)
+		       & DISPC_VID_SIZE_VIDSIZEY);
+		vid_picture_size = vid_size;
+		row_inc = ((pix->width -
+			    ((vid_size >> DISPC_VID_SIZE_VIDSIZEX_SHIFT)
+			     & DISPC_VID_SIZE_VIDSIZEX)) * 2)
+		    - 1;
+		/* we are subtracting 1 instead of adding because vid_size 
+		 ** is 1 less than the pix width 
+		 */
+		dispc_reg_out(cam, DISPC_VID_ROW_INC(v), row_inc);
+	}
+	vid_position = ((vid_position_x << DISPC_VID_POSITION_VIDPOSX_SHIFT)
+			& DISPC_VID_POSITION_VIDPOSX)
+	    | ((vid_position_y << DISPC_VID_POSITION_VIDPOSY_SHIFT)
+	       & DISPC_VID_POSITION_VIDPOSY);
+	dispc_reg_out(cam, DISPC_VID_POSITION(v), vid_position);
+	dispc_reg_out(cam, DISPC_VID_SIZE(v), vid_size);
+	dispc_reg_out(cam, DISPC_VID_PICTURE_SIZE(v), vid_picture_size);
+	dispc_reg_out(cam, DISPC_VID_PIXEL_INC(v), 1);
+
+	if (vid2_format) {
+		unsigned long vid2_base_phys;
+		vid2_base_phys = cam->video2_base_phys;
+		//+ pix->bytesperline*crop->top + crop->left*2;
+		dispc_reg_out(cam, DISPC_VID_BA0(v), vid2_base_phys);
+		dispc_reg_out(cam, DISPC_VID_BA1(v), vid2_base_phys);
+		vid_attributes = dispc_reg_merge(cam, DISPC_VID_ATTRIBUTES(v),
+						 DISPC_VID_ATTRIBUTES_ENABLE,
+						 DISPC_VID_ATTRIBUTES_ENABLE);
+		if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+			/* digital output */
+			dispc_reg_merge(cam, DISPC_CONTROL,
+					DISPC_CONTROL_GODIGITAL,
+					DISPC_CONTROL_GODIGITAL);
+		} else {
+			/* LCD */
+			dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+					DISPC_CONTROL_GOLCD);
+		}
+	}
+}
+
+/* -------------------------------------------------------------------------- */
+
+/* Start a DMA transfer from the camera to memory.
+ * Returns zero if the transfer was successfully started, or non-zero if all 
+ * DMA channels are already in use or starting is currently inhibited.
+ */
+int
+omap24xxcam_dma_start(struct omap24xxcam_device *cam, dma_addr_t start, 
+	unsigned long len, dma_callback_t callback, void *arg)
+{
+	unsigned long irqflags;
+	int dmach;
+	void (*dma_notify)(struct omap24xxcam_device *cam);
+
+	DBG;
+
+	spin_lock_irqsave(&cam->dma_lock, irqflags);
+
+	if (!cam->free_dmach || cam->dma_stop) {
+		spin_unlock_irqrestore(&cam->dma_lock, irqflags);
+		DBG_MID(3);
+		return -EBUSY;
+	}
+
+	dmach = cam->next_dmach;
+
+	cam->camdma[dmach].callback = callback;
+	cam->camdma[dmach].arg = arg;
+
+	camdma_reg_out(cam, CAMDMA_CCR(dmach), 
+		CAMDMA_CCR_SEL_SRC_DST_SYNC
+	      | CAMDMA_CCR_BS
+	      | CAMDMA_CCR_DST_AMODE_POST_INC
+	      | CAMDMA_CCR_SRC_AMODE_POST_INC
+	      | CAMDMA_CCR_FS
+	      | CAMDMA_CCR_WR_ACTIVE
+	      | CAMDMA_CCR_RD_ACTIVE
+	      | CAMDMA_CCR_SYNCHRO_CAMERA);
+	camdma_reg_out(cam, CAMDMA_CLNK_CTRL(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CEN(dmach), len);
+	camdma_reg_out(cam, CAMDMA_CFN(dmach), 1);
+	camdma_reg_out(cam, CAMDMA_CSDP(dmach), 
+		CAMDMA_CSDP_WRITE_MODE_POSTED 
+	      | CAMDMA_CSDP_DST_BURST_EN_64
+	      | CAMDMA_CSDP_DST_PACKED
+	      | CAMDMA_CSDP_SRC_BURST_EN_64
+	      | CAMDMA_CSDP_SRC_PACKED
+	      | CAMDMA_CSDP_DATA_TYPE_8BITS);
+	camdma_reg_out(cam, CAMDMA_CSSA(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CDSA(dmach), start);
+	camdma_reg_out(cam, CAMDMA_CSEI(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CSFI(dmach), DMA_THRESHOLD);
+	camdma_reg_out(cam, CAMDMA_CDEI(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CDFI(dmach), 0);
+	camdma_reg_out(cam, CAMDMA_CSR(dmach), 
+		CAMDMA_CSR_MISALIGNED_ERR
+	      | CAMDMA_CSR_SUPERVISOR_ERR
+	      | CAMDMA_CSR_SECURE_ERR
+	      | CAMDMA_CSR_TRANS_ERR
+	      | CAMDMA_CSR_BLOCK
+	      | CAMDMA_CSR_DROP);
+	camdma_reg_out(cam, CAMDMA_CICR(dmach), 
+		CAMDMA_CICR_MISALIGNED_ERR_IE
+	      | CAMDMA_CICR_SUPERVISOR_ERR_IE
+	      | CAMDMA_CICR_SECURE_ERR_IE
+	      | CAMDMA_CICR_TRANS_ERR_IE
+	      | CAMDMA_CICR_BLOCK_IE
+	      | CAMDMA_CICR_DROP_IE);
+
+	/* We're ready to start the DMA transfer. */
+
+	if (cam->free_dmach < NUM_CAMDMA_CHANNELS) {
+		/* A transfer is already in progress, so try to chain to it. */
+		int prev_dmach, ch;
+
+		if (dmach == 0)
+			prev_dmach = NUM_CAMDMA_CHANNELS - 1;
+		else
+			prev_dmach = dmach - 1;
+		camdma_reg_out(cam, CAMDMA_CLNK_CTRL(prev_dmach), 
+			CAMDMA_CLNK_CTRL_ENABLE_LNK | dmach);
+		/* Did we chain the DMA transfer before the previous one 
+		 * finished?
+		 */
+		ch = (dmach + cam->free_dmach) % NUM_CAMDMA_CHANNELS;
+		DBG_MID(1);
+		while (!(camdma_reg_in(cam, CAMDMA_CCR(ch))
+			 & CAMDMA_CCR_ENABLE))
+		{
+			if (ch == dmach) {
+				/* The previous transfer has ended and this one 
+				 * hasn't started, so we must not have chained 
+				 * to the previous one in time.  We'll have to 
+				 * start it now.
+				 */
+				camdma_reg_out(cam, CAMDMA_CCR(dmach), 
+					CAMDMA_CCR_SEL_SRC_DST_SYNC
+				      | CAMDMA_CCR_BS
+				      | CAMDMA_CCR_DST_AMODE_POST_INC
+				      | CAMDMA_CCR_SRC_AMODE_POST_INC
+				      | CAMDMA_CCR_ENABLE
+				      | CAMDMA_CCR_FS
+				      | CAMDMA_CCR_SYNCHRO_CAMERA);
+				break;
+			} else
+				ch = (ch + 1) % NUM_CAMDMA_CHANNELS;
+		}
+		DBG_MID(2);
+	}
+	else {
+		/* No transfer is in progress, so we'll just start this one 
+		 * now.
+		 */
+		camdma_reg_out(cam, CAMDMA_CCR(dmach), 
+			CAMDMA_CCR_SEL_SRC_DST_SYNC
+		      | CAMDMA_CCR_BS
+		      | CAMDMA_CCR_DST_AMODE_POST_INC
+		      | CAMDMA_CCR_SRC_AMODE_POST_INC
+		      | CAMDMA_CCR_ENABLE
+		      | CAMDMA_CCR_FS
+		      | CAMDMA_CCR_SYNCHRO_CAMERA);
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
+		(*dma_notify)(cam);
+
+	DBG_END;
+
+	return 0;
+}
+
+/* DMA completion routine for the scatter-gather DMA fragments. */
+static void
+omap24xxcam_sg_dma_callback(struct omap24xxcam_device *cam, unsigned long csr,
+			    void *arg)
+{
+	int sgslot = (int)arg;
+	struct sgdma_state *sgdma;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	DBG;
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
+static void omap24xxcam_sg_dma_process(struct omap24xxcam_device *cam)
+{
+	unsigned long irqflags;
+	int queued_sgdma, sgslot;
+	struct sgdma_state *sgdma;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	DBG;
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
+						  (void *)sgslot)) {
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
+	DBG_END;
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
+	DBG;
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
+	DBG;
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
+				CAMDMA_CLNK_CTRL_ENABLE_LNK);
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
+	DBG;
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
+	DBG;
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
+/* This routine is not needed at the moment, but we'll keep it around just in 
+ * case.
+ */
+#if 0
+/* Stop the DMA controller, aborting any DMA transfers in progress.  Any queued 
+ * scatter-gather DMA transactions are cancelled.  The DMA controller will be 
+ * idle after this routine completes, and the scatter-gather DMA queue will 
+ * be empty.  csr is the completion status passed to the completion routines 
+ * for any DMA transfers that are aborted.  It should have at least one error 
+ * bit set.
+ */
+static void
+omap24xxcam_sg_dma_stop(struct omap24xxcam_device *cam, unsigned long csr)
+{
+	unsigned long irqflags;
+	int queued_sgdma, sgslot;
+	struct sgdma_state *sgdma;
+	dma_callback_t callback;
+	void *arg;
+
+	/* stop any DMA transfers in progress */
+	omap24xxcam_dma_stop(cam, csr);
+
+	spin_lock_irqsave(&cam->sg_lock, irqflags);
+
+	queued_sgdma = NUM_SG_DMA - cam->free_sgdma;
+	sgslot = (cam->next_sgdma + cam->free_sgdma) % NUM_SG_DMA;
+	while (queued_sgdma > 0) {
+		sgdma = cam->sgdma + sgslot;
+		callback = sgdma->callback;
+		arg = sgdma->arg;
+		cam->free_sgdma++;
+		sgdma->queued_sglist = 0;
+		if (callback) {
+			/* leave interrupts masked */
+			spin_unlock(&cam->sg_lock);
+			(*callback) (cam, csr, arg);
+			spin_lock(&cam->sg_lock);
+		}
+		queued_sgdma--;
+		sgslot = (sgslot + 1) % NUM_SG_DMA;
+	}
+
+	spin_unlock_irqrestore(&cam->sg_lock, irqflags);
+}
+#endif				/* if 0 */
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
+	DBG;
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
+static void omap24xxcam_dma_isr(struct omap24xxcam_device *cam)
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
+
+	if (cam->free_dmach == NUM_CAMDMA_CHANNELS) {
+		/* A camera DMA interrupt occurred while all channels are idle, 
+		 * so we'll acknowledge the interrupt in the IRQSTATUS register 
+		 * and exit.
+		 */
+		for (i = 0; i< 4; ++i) {
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
+static void omap24xxcam_dma_exit(struct omap24xxcam_device *cam)
+{
+	int ch;
+
+	DBG;
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
+static void omap24xxcam_dma_init(struct omap24xxcam_device *cam)
+{
+	int ch, sg;
+
+	DBG;
+
+	/* group all channels on DMA IRQ0 and unmask irq */
+
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
+	DBG;
+
+	spin_lock_irqsave(&cam->overlay_lock, irqflags);
+
+	if (cam->overlay_cnt > 0)
+		--cam->overlay_cnt;
+
+	if (!cam->previewing || (csr & csr_error)) {
+		printk(KERN_INFO CAM_NAME
+		       ": overlay_callback error. csr = 0x%08x\n", (u16)csr);
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
+static void omap24xxcam_start_overlay_dma(struct omap24xxcam_device *cam)
+{
+	int err;
+	unsigned long irqflags;
+
+	DBG;
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
+static void omap24xxcam_cc_enable(struct omap24xxcam_device *cam)
+{
+	DBG;
+	/* Get the CC_CTRL register value for the current capture format. */
+	omap24xxcam_sensor_cc_ctrl(cam);
+
+	/* program the camera interface DMA packet size */
+	cc_reg_out(cam, CC_CTRL_DMA, CC_CTRL_DMA_EN | (DMA_THRESHOLD / 4 - 1));
+
+	/* enable camera core error interrupts */
+	cc_reg_out(cam, CC_IRQENABLE, CC_IRQENABLE_FW_ERR_IRQ
+		   | CC_IRQENABLE_FSC_ERR_IRQ | CC_IRQENABLE_SSC_ERR_IRQ
+		   | CC_IRQENABLE_FIFO_OF_IRQ /*| CC_IRQENABLE_FIFO_FULL_IRQ */
+		   );
+
+	/* enable the camera interface */
+	cc_reg_out(cam, CC_CTRL, cam->cc_ctrl | CC_CTRL_CC_EN);
+}
+
+/* Error recovery for DMA errors and camera interface errors. */
+static void omap24xxcam_error_handler(struct omap24xxcam_device *cam)
+{
+	DBG;
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
+#if 1
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
+#endif
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
+	omap24xxcam_start_overlay_dma(cam);
+
+	/* Restart the scatter-gather DMA queue. */
+	omap24xxcam_sg_dma_process(cam);
+}
+
+/* Interrupt service routine for camera core interrupts. */
+static void omap24xxcam_cc_isr(struct omap24xxcam_device *cam)
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
+static irqreturn_t omap24xxcam_isr(int irq, void *arg, struct pt_regs *regs)
+{
+	struct omap24xxcam_device *cam = (struct omap24xxcam_device *)arg;
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
+static void omap24xxcam_adjust_xclk(struct omap24xxcam_device *cam)
+{
+	unsigned long divisor;
+
+	DBG;
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
+	struct videobuf_buffer *vb = (struct videobuf_buffer *)arg;
+	const unsigned long csr_error = CAMDMA_CSR_MISALIGNED_ERR
+	    | CAMDMA_CSR_SUPERVISOR_ERR | CAMDMA_CSR_SECURE_ERR
+	    | CAMDMA_CSR_TRANS_ERR | CAMDMA_CSR_DROP;
+
+	DBG;
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
+omap24xxcam_vbq_release(struct videobuf_queue *vbq, struct videobuf_buffer *vb)
+{
+	DBG;
+
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
+omap24xxcam_vbq_setup(struct videobuf_queue *vbq, unsigned int *cnt,
+		      unsigned int *size)
+{
+	struct omap24xxcam_fh *fh = vbq->priv_data;
+	struct omap24xxcam_device *cam = fh->cam;
+
+	DBG;
+
+	if (*cnt <= 0)
+		*cnt = VIDEO_MAX_FRAME;	/* supply a default number of buffers */
+
+	if (*cnt > VIDEO_MAX_FRAME)
+		*cnt = VIDEO_MAX_FRAME;
+
+	spin_lock(&cam->img_lock);
+
+	if (cam->still_capture && cam->cam_sensor->try_format_still_capture)
+		*size = cam->pix2.sizeimage;
+	else
+		*size = cam->pix.sizeimage;
+
+	spin_unlock(&cam->img_lock);
+
+	while (*size * *cnt > capture_mem)
+		(*cnt)--;
+
+	return 0;
+}
+
+static int
+omap24xxcam_vbq_prepare(struct videobuf_queue *vbq, struct videobuf_buffer *vb,
+			enum v4l2_field field)
+{
+	struct omap24xxcam_fh *fh = vbq->priv_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	int err = 0;
+	unsigned int size;
+
+	DBG;
+
+	spin_lock(&cam->img_lock);
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
+				spin_unlock(&cam->img_lock);
+				omap24xxcam_vbq_release(vbq, vb);
+				spin_lock(&cam->img_lock);
+				vb->size = size;
+			}
+		} else {
+			/* We need to allocate a new kernel bounce buffer. */
+			vb->size = size;
+		}
+	}
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
+	spin_unlock(&cam->img_lock);
+
+	if (err)
+		return err;
+
+	if (vb->state == STATE_NEEDS_INIT)
+		err = videobuf_iolock(NULL, vb, NULL);
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
+	struct omap24xxcam_fh *fh = vbq->priv_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	enum videobuf_state state = vb->state;
+	int err;
+
+	DBG;
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
+	int err;
+
+	DBG;
+
+	switch (cmd) {
+		/* for time being below IOCTL cmd is here */
+
+	case VIDIOC_ENUMINPUT:
+		{
+			/* default handler assumes 1 video input (the camera) */
+			struct v4l2_input *input = (struct v4l2_input *)arg;
+			int index = input->index;
+
+			memset(input, 0, sizeof(*input));
+			input->index = index;
+
+			if (index > 0)
+				return -EINVAL;
+
+			strlcpy(input->name, "camera", sizeof(input->name));
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
+			    (struct v4l2_capability *)arg;
+
+			memset(cap, 0, sizeof(*cap));
+			strlcpy(cap->driver, CAM_NAME, sizeof(cap->driver));
+			strlcpy(cap->card, cam->vfd->name, sizeof(cap->card));
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
+			struct v4l2_format *f = (struct v4l2_format *)arg;
+
+			switch (f->type) {
+			case V4L2_BUF_TYPE_STILL_CAPTURE:
+				{
+					if (cam->cam_sensor->try_format_still_capture){
+						struct v4l2_pix_format *pix =
+							&f->fmt.pix;
+						memset(pix, 0, sizeof (*pix));
+						spin_lock(&cam->img_lock);
+						*pix = cam->pix2;
+						spin_unlock(&cam->img_lock);
+						return 0;
+					}
+					/* else fall through */
+				}
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					struct v4l2_pix_format *pix =
+					    &f->fmt.pix;
+					memset(pix, 0, sizeof(*pix));
+					spin_lock(&cam->img_lock);
+					*pix = cam->pix;
+					spin_unlock(&cam->img_lock);
+					return 0;
+				}
+
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_window *win = &f->fmt.win;
+					memset(win, 0, sizeof(*win));
+					/* The API has a bit of a problem here. 
+					 * We're returning a v4l2_window 
+					 * structure, but that structure 
+					 * contains pointers to variable-sized 
+					 * objects for clipping rectangles and 
+					 * clipping bitmaps.  We will just 
+					 * return NULLs for those pointers.
+					 */
+					spin_lock(&cam->img_lock);
+					win->w = cam->win.w;
+					win->field = cam->win.field;
+					win->chromakey = cam->win.chromakey;
+					spin_unlock(&cam->img_lock);
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
+			struct v4l2_format *f = (struct v4l2_format *)arg;
+
+			switch (f->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_window *win = &f->fmt.win;
+
+					spin_lock(&cam->img_lock);
+					err =
+					    omap24xxcam_try_preview_window(cam,
+									   win);
+					spin_unlock(&cam->img_lock);
+					return err;
+				}
+
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
+			struct v4l2_format *f = (struct v4l2_format *)arg;
+
+			switch (f->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_window *win = &f->fmt.win;
+
+					spin_lock(&cam->img_lock);
+					if (cam->previewing) {
+						spin_unlock(&cam->img_lock);
+						return -EBUSY;
+					}
+					err =
+					    omap24xxcam_new_preview_window(cam,
+									   win);
+					spin_unlock(&cam->img_lock);
+					return err;
+				}
+
+			case V4L2_BUF_TYPE_STILL_CAPTURE:
+				{
+					if (cam->cam_sensor->try_format_still_capture &&
+							cam->cam_sensor->configure_still_capture) {
+						spin_lock(&cam->img_lock);
+						cam->cam_sensor->try_format_still_capture(&f->fmt.pix,
+								cam->
+								sensor);
+						/* set the new capture format */
+						cam->pix2 = f->fmt.pix;
+						spin_unlock(&cam->img_lock);
+						err =
+							cam->cam_sensor->configure_still_capture
+							(&cam->
+							 pix2,
+							 cam->
+							 xclk,
+							 &cam->
+							 cparm.
+							 timeperframe,
+							 cam->
+							 sensor);
+						return err;
+					}
+					/* else fall through */
+				}
+				
+			case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+				{
+					spin_lock(&cam->img_lock);
+					if (cam->streaming || cam->previewing) {
+						spin_unlock(&cam->img_lock);
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
+					/* intialize the preview parameters */
+					omap24xxcam_new_capture_format(cam);
+					spin_unlock(&cam->img_lock);
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
+			    (struct v4l2_framebuffer *)arg;
+
+			spin_lock(&cam->img_lock);
+			*fbuf = cam->fbuf;
+			spin_unlock(&cam->img_lock);
+			return 0;
+		}
+
+	case VIDIOC_S_FBUF:
+		{
+			struct v4l2_framebuffer *fbuf =
+			    (struct v4l2_framebuffer *)arg;
+			unsigned int flags = fbuf->flags;
+
+			/* The only field the user is allowed to change is 
+			 * fbuf->flags.
+			 */
+			spin_lock(&cam->img_lock);
+			if (cam->previewing) {
+				spin_unlock(&cam->img_lock);
+				return -EBUSY;
+			}
+			if (flags & V4L2_FBUF_FLAG_CHROMAKEY)
+				cam->fbuf.flags |= V4L2_FBUF_FLAG_CHROMAKEY;
+			else
+				cam->fbuf.flags &= ~V4L2_FBUF_FLAG_CHROMAKEY;
+			spin_unlock(&cam->img_lock);
+			return 0;
+		}
+
+	case VIDIOC_CROPCAP:
+		{
+			struct v4l2_cropcap *cropcap =
+			    (struct v4l2_cropcap *)arg;
+			enum v4l2_buf_type type = cropcap->type;
+
+			memset(cropcap, 0, sizeof(*cropcap));
+			cropcap->type = type;
+			switch (type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					struct v4l2_pix_format *pix = &cam->pix;
+
+					spin_lock(&cam->img_lock);
+					cropcap->bounds.width = pix->width & ~1;
+					cropcap->bounds.height =
+					    pix->height & ~1;
+					omap24xxcam_default_crop_rect(cam,
+								      &cropcap->
+								      defrect);
+					spin_unlock(&cam->img_lock);
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
+					spin_lock(&cam->img_lock);
+					cropcap->bounds.width = cam->pix.width;
+					cropcap->bounds.height =
+					    cam->pix.height;
+					spin_unlock(&cam->img_lock);
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
+			struct v4l2_crop *crop = (struct v4l2_crop *)arg;
+
+			switch (crop->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					spin_lock(&cam->img_lock);
+					crop->c = cam->crop;
+					spin_unlock(&cam->img_lock);
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
+			struct v4l2_crop *crop = (struct v4l2_crop *)arg;
+
+			switch (crop->type) {
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+				{
+					spin_lock(&cam->img_lock);
+					if (cam->previewing) {
+						spin_unlock(&cam->img_lock);
+						return -EBUSY;
+					}
+					err = omap24xxcam_new_crop_rect(cam,
+									&crop->
+									c);
+					spin_unlock(&cam->img_lock);
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
+			    (struct v4l2_streamparm *)arg;
+			enum v4l2_buf_type type = parm->type;
+
+			memset(parm, 0, sizeof(*parm));
+			parm->type = type;
+			if (type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+				return -EINVAL;
+			spin_lock(&cam->img_lock);
+			parm->parm.capture = cam->cparm;
+			spin_unlock(&cam->img_lock);
+			return 0;
+		}
+
+	case VIDIOC_S_PARM:
+		{
+			struct v4l2_streamparm *parm =
+			    (struct v4l2_streamparm *)arg;
+			struct v4l2_captureparm *cparm = &parm->parm.capture;
+
+			if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+				return -EINVAL;
+			spin_lock(&cam->img_lock);
+			if (cam->streaming || cam->previewing) {
+				spin_unlock(&cam->img_lock);
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
+				spin_unlock(&cam->img_lock);
+				/* program xclk */
+				omap24xxcam_set_xclk(cam);
+				/* program the sensor */
+				err =
+				    cam->cam_sensor->configure(&cam->pix,
+							       cam->xclk,
+							       &cam->cparm.
+							       timeperframe,
+							       cam->sensor);
+			} else {
+				spin_unlock(&cam->img_lock);
+			}
+			return 0;
+		}
+
+	case VIDIOC_OVERLAY:
+		{
+			int *on = arg;
+
+			spin_lock(&cam->img_lock);
+
+			if (!cam->previewing && *on) {
+				if (cam->pix.sizeimage <= cam->overlay_size) {
+					/* Turn on the overlay window */
+					omap24xxcam_configure_overlay(cam,
+								      NULL);
+					omap24xxcam_flip_overlay(cam,
+								 cam->
+								 overlay_base_phys);
+					cam->previewing = fh;
+					spin_unlock(&cam->img_lock);
+					/* start the camera interface */
+					omap24xxcam_dma_notify(cam,
+							       omap24xxcam_cc_enable);
+					omap24xxcam_start_overlay_dma(cam);
+				} else {
+					/* Image size is bigger than overlay 
+					 * buffer.
+					 */
+					omap24xxcam_disable_vlayer(cam,
+								   cam->vid1);
+					spin_unlock(&cam->img_lock);
+					return -EINVAL;
+				}
+			} else if (!*on) {
+				/* turn overlay off */
+				omap24xxcam_disable_vlayer(cam, cam->vid1);
+				cam->previewing = NULL;
+				spin_unlock(&cam->img_lock);
+			} else
+				spin_unlock(&cam->img_lock);
+
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
+		return videobuf_dqbuf(&fh->vbq, arg,
+				      file->f_flags & O_NONBLOCK);
+
+	case VIDIOC_STREAMON:
+		{
+			spin_lock(&cam->img_lock);
+			if (cam->streaming) {
+				spin_unlock(&cam->img_lock);
+				return -EBUSY;
+			} else
+				cam->streaming = fh;
+			spin_unlock(&cam->img_lock);
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
+			spin_lock(&cam->img_lock);
+			if (cam->streaming == fh)
+				cam->streaming = NULL;
+			spin_unlock(&cam->img_lock);
+			return 0;
+		}
+
+	case VIDIOC_G_CTRL:
+	case VIDIOC_S_CTRL:
+	case VIDIOC_QUERYCTRL:
+	case VIDIOC_QUERYMENU:
+		{
+			/* no controls have been implemented yet */
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
+	case VIDIOC_S_VID2:
+		{
+			/* this api will set the parameters of video layer 2
+			 ** of DISPC to display to use video 2 layer pipeline
+			 ** to use hardware color conversion block to display
+			 ** YUV422 format data on LCD
+			 **/
+			struct omap24xx_vid2_format *vid2_format =
+			    (struct omap24xx_vid2_format *)arg;
+
+			omap24xxcam_configure_overlay(cam, vid2_format);
+			return 0;
+		}
+
+	case VIDIOC_S_VID2_DISABLE:
+		{
+			omap24xxcam_disable_vlayer(cam, cam->vid2);
+			return 0;
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
+int omap24xxcam_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+	struct videobuf_buffer *vb;
+	enum v4l2_field field;
+
+	DBG;
+
+	spin_lock(&cam->img_lock);
+
+	if (cam->streaming == fh) {
+		spin_unlock(&cam->img_lock);
+		/* streaming capture */
+		if (list_empty(&fh->vbq.stream))
+			return POLLERR;
+		vb = list_entry(fh->vbq.stream.next, struct videobuf_buffer,
+				stream);
+	} else if (cam->streaming) {
+		/* streaming I/O is in progress on another file descriptor */
+		spin_unlock(&cam->img_lock);
+		return POLLERR;
+	} else {
+		/* read() capture */
+		spin_unlock(&cam->img_lock);
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
+			omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+			fh->vbq.ops->buf_queue(&fh->vbq, fh->vbq.read_buf);
+			fh->vbq.read_off = 0;
+		}
+		up(&fh->vbq.lock);
+		vb = (struct videobuf_buffer *)fh->vbq.read_buf;
+	}
+
+	omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
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
+	int err;
+
+	DBG;
+
+	spin_lock(&cam->img_lock);
+	if (cam->streaming) {
+		spin_unlock(&cam->img_lock);
+		return -EBUSY;
+	}
+	cam->still_capture = 1;
+	spin_unlock(&cam->img_lock);
+
+	if (cam->cam_sensor->enter_still_capture)
+		cam->cam_sensor->enter_still_capture(16, cam->sensor);
+	omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+
+	/*  **HACK**for some strange reason, dma'ing directly to user 
+	 ** buffer gives syncing error, we will use kernel bounce buffer 
+	 ** to capture the image pretending that we want to read one pixel
+	 ** less than the actual image size.
+	 */
+	err =
+	    videobuf_read_one(&fh->vbq, data, count - 2, ppos,
+			      file->f_flags & O_NONBLOCK);
+
+	spin_lock(&cam->img_lock);
+	cam->still_capture = 0;
+	spin_unlock(&cam->img_lock);
+	
+	if (cam->cam_sensor->exit_still_capture)
+		cam->cam_sensor->exit_still_capture(cam->sensor);
+	
+	DBG_END;
+
+	return err;
+}
+static ssize_t
+omap24xxcam_write(struct file *file, const char *data, size_t count,
+		  loff_t * ppos)
+{
+	unsigned long vid_attributes;
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+
+	DBG;
+
+	vid_attributes = dispc_reg_merge(cam, DISPC_VID_ATTRIBUTES(1),
+					 DISPC_VID_ATTRIBUTES_ENABLE,
+					 DISPC_VID_ATTRIBUTES_ENABLE);
+	if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+		/* digital output */
+		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+				DISPC_CONTROL_GODIGITAL);
+	} else {
+		/* LCD */
+		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+				DISPC_CONTROL_GOLCD);
+	}
+	if (copy_from_user((void *)cam->video2_base, data, count)) {
+		printk("error in copying data");
+	}
+	return count;
+}
+
+static int omap24xxcam_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+
+	return videobuf_mmap_mapper(&fh->vbq, vma);
+}
+
+static int
+omap24xxcam_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		  unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, omap24xxcam_do_ioctl);
+}
+
+/*
+ * Do some sanity check, set clock rate, starts it and
+ *  turn codec audio on 
+ */
+int omap24xxcam_clock_on(void)
+{
+
+	clk_enable(cam_fck);
+	clk_enable(cam_ick);
+
+	printk(KERN_DEBUG
+	       "FCLK = %d [%d], usecount = %d\n",
+	       (uint) clk_get_rate(cam_fck), CAM_CLOCK,
+	       clk_get_usecount(cam_fck));
+
+	return 0;
+}
+
+/*
+ * Do some sanity check, turn clock off and then turn
+ *  codec audio off
+ */
+int omap24xxcam_clock_off(void)
+{
+	if (clk_get_usecount(cam_fck) > 0) {
+		if (clk_get_rate(cam_fck) != CAM_CLOCK) {
+			printk(KERN_WARNING
+			       "FCLK for camera should be %d Hz. But is %d Hz\n",
+			       (uint) clk_get_rate(cam_fck), CAM_CLOCK);
+		}
+
+		clk_disable(cam_fck);
+		clk_disable(cam_ick);
+	}
+
+	return 0;
+}
+
+static int omap24xxcam_release(struct inode *inode, struct file *file)
+{
+	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_device *cam = fh->cam;
+
+	DBG;
+
+	spin_lock(&cam->img_lock);
+	/* turn off overlay */
+	if (cam->previewing == fh) {
+		cam->previewing = NULL;
+		spin_unlock(&cam->img_lock);
+		omap24xxcam_disable_vlayer(cam, cam->vid1);
+		spin_lock(&cam->img_lock);
+	}
+
+	/* stop streaming capture */
+	if (cam->streaming == fh) {
+		cam->streaming = NULL;
+		spin_unlock(&cam->img_lock);
+		videobuf_streamoff(&fh->vbq);
+		spin_lock(&cam->img_lock);
+	}
+	spin_unlock(&cam->img_lock);
+
+	/* release read_buf videobuf_buffer struct */
+	if (fh->vbq.read_buf) {
+		omap24xxcam_vbq_release(&fh->vbq, fh->vbq.read_buf);
+		kfree(fh->vbq.read_buf);
+	}
+
+	file->private_data = NULL;
+	kfree(fh);
+
+	return 0;
+}
+
+static int omap24xxcam_open(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	struct omap24xxcam_device *cam = saved_cam;
+	struct omap24xxcam_fh *fh;
+
+	DBG;
+
+	if (!cam || !cam->vfd || (cam->vfd->minor != minor))
+		return -ENODEV;
+
+	/* allocate per-filehandle data */
+	fh = kmalloc(sizeof(*fh), GFP_KERNEL);
+	if (NULL == fh)
+		return -ENOMEM;
+	file->private_data = fh;
+	fh->cam = cam;
+	fh->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+	videobuf_queue_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
+			    fh->type, V4L2_FIELD_NONE,
+			    sizeof(struct videobuf_buffer), fh);
+
+	return 0;
+}
+
+static struct file_operations omap24xxcam_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = omap24xxcam_read,
+	.write = omap24xxcam_write,
+	.poll = omap24xxcam_poll,
+	.ioctl = omap24xxcam_ioctl,
+	.mmap = omap24xxcam_mmap,
+	.open = omap24xxcam_open,
+	.release = omap24xxcam_release,
+};
+
+/* -------------------------------------------------------------------------- */
+static int omap24xxcam_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+
+	DBG;
+
+	/* disable previewing */
+	spin_lock(&cam->img_lock);
+	if (cam->previewing) {
+		/* turn overlay off */
+		omap24xxcam_disable_vlayer(cam, cam->vid1);
+		cam->previewing = NULL;
+	}
+	spin_unlock(&cam->img_lock);
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
+	/* stop XCLK */
+	cc_reg_out(cam, CC_CTRL_XCLK, CC_CTRL_XCLK_DIV_STABLE_LOW);
+
+	/* power down the sensor */
+	cam->cam_sensor->power_off(cam->sensor);
+
+	return 0;
+}
+static int omap24xxcam_resume(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+
+	DBG;
+
+	/* power up the sensor */
+	cam->cam_sensor->power_on(cam->sensor);
+
+	/* set XCLK */
+	omap24xxcam_set_xclk(cam);
+
+	if (cam->streaming) {
+		/* capture was in progress, so we need to register 
+		 * our routine to restart the camera interface the next time a 
+		 * DMA transfer is queued.
+		 */
+		omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
+	}
+
+	/* Restart the scatter-gather DMA queue. */
+	omap24xxcam_sg_dma_process(cam);
+
+	/* camera interface will be enabled through dma_notify function
+	 ** automatically when new dma starts 
+	 */
+
+	return 0;
+}
+
+static int omap24xxcam_probe(struct platform_device *pdev)
+{
+	struct omap24xxcam_device *cam;
+	struct video_device *vfd;
+
+	DBG;
+
+	cam = kzalloc(sizeof(struct omap24xxcam_device), GFP_KERNEL);
+	if (!cam) {
+		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
+		goto init_error;
+	}
+	saved_cam = cam;
+
+	/* initialize the video_device struct */
+	vfd = cam->vfd = video_device_alloc();
+	if (!vfd) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not allocate video device struct\n");
+		goto init_error;
+	}
+	vfd->release = video_device_release;
+#ifdef FIXME_FIXME
+/*  If the dev fields are not initlized (parent and such) sysfs will crash you
+ *  when it tries to set you up....most drivers seem to chain in the info their 
+ *  parent bus gave them.  Getting this associated right is likely necessary for power 
+ *  mangement.
+ */
+	vfd->dev = &cam->dev;
+#endif
+	strlcpy(vfd->name, CAM_NAME, sizeof(vfd->name));
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
+	if (capture_mem < 320 * 240 * 2 * 2)
+		capture_mem = 320 * 240 * 2 * 2;
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
+	/* Map the display controller registers.
+	 * Note that we do not request the memory region first, because the 
+	 * framebuffer driver will already have claimed this region and the 
+	 * request would fail.
+	 */
+	cam->dispc_mmio_base_phys = DSS_REG_BASE;
+	cam->dispc_mmio_size = DSS_REG_SIZE;
+	cam->dispc_mmio_base = (unsigned long)
+	    ioremap(cam->dispc_mmio_base_phys, cam->dispc_mmio_size);
+	if (!cam->dispc_mmio_base) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot map display controller register I/O region\n");
+		goto init_error;
+	}
+
+	/* allocate coherent memory for the overlay framebuffer */
+	cam->overlay_size = overlay_mem;
+	if (cam->overlay_size > 0) {
+		cam->overlay_base = (unsigned long)dma_alloc_coherent(NULL,
+								      cam->
+								      overlay_size,
+								      (dma_addr_t
+								       *) &
+								      cam->
+								      overlay_base_phys,
+								      GFP_KERNEL
+								      |
+								      GFP_DMA);
+		if (!cam->overlay_base) {
+			printk(KERN_ERR CAM_NAME
+			       ": cannot allocate overlay framebuffer\n");
+			goto init_error;
+		}
+	}
+	memset((void *)cam->overlay_base, 0, cam->overlay_size);
+
+	cam->video2_size = video2_mem;
+	if (cam->video2_size > 0) {
+		cam->video2_base = (unsigned long)dma_alloc_coherent(NULL,
+								     cam->
+								     video2_size,
+								     (dma_addr_t
+								      *) & cam->
+								     video2_base_phys,
+								     GFP_KERNEL
+								     | GFP_DMA);
+		if (!cam->video2_base) {
+			printk(KERN_ERR CAM_NAME
+			       ": cannot allocate video2 layer memory\n");
+			goto init_error;
+
+		}
+	}
+	memset((void *)cam->video2_base, 0, cam->video2_size);
+
+	/* initialize the overlay spinlock  */
+	spin_lock_init(&cam->overlay_lock);
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
+	cam->mclk = 96000000;	/* 96MHz */
+	cam_fck = clk_get(0, "cam_fck");
+	cam_ick = clk_get(0, "cam_ick");
+	omap24xxcam_clock_on();
+
+	/* initialize the streaming capture parameters */
+	cam->cparm.readbuffers = 1;
+	cam->cparm.capability = V4L2_CAP_TIMEPERFRAME;
+
+	/* Enable the xclk output.  The sensor may (and does, in the case of 
+	 * the OV9640) require an xclk input in order for its initialization 
+	 * routine to work.
+	 */
+	cam->xclk = 12000000;	/* choose an arbitrary xclk frequency */
+	omap24xxcam_set_xclk(cam);
+
+	/* get the framebuffer parameters in case the sensor init routine 
+	 * needs them
+	 */
+	omap24xxcam_g_fbuf(cam);
+
+	/* select an arbitrary default capture frame rate of 5fps */
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
+	omap24xxcam_new_capture_format(cam);
+
+	/* program the sensor for the default capture format and rate */
+	cam->cam_sensor->configure(&cam->pix, cam->xclk,
+				   &cam->cparm.timeperframe, cam->sensor);
+	if (cam->cam_sensor->configure_still_capture)
+		cam->cam_sensor->configure_still_capture(&cam->pix2, cam->xclk,
+				   &cam->cparm.timeperframe, cam->sensor);
+
+	/* use display controller video window 0 for preview */
+	cam->vid1 = 0;
+	cam->vid2 = 1;
+
+	/* initialize the DMA driver */
+	omap24xxcam_dma_init(cam);
+
+	/* install the interrupt service routine */
+	if (request_irq(INT_CAM_MPU_IRQ, omap24xxcam_isr, 0, CAM_NAME, cam)) {
+		printk(KERN_ERR CAM_NAME
+		       ": could not install interrupt service routine\n");
+		goto init_error;
+	}
+	cam->irq = INT_CAM_MPU_IRQ;
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
+//#define CAMERA_TEST
+#ifdef CAMERA_TEST
+	if (cam->pix.sizeimage <= cam->overlay_size) {
+		printk(KERN_INFO CAM_NAME ": Camera test--enabling overlay\n");
+		/* turn on the video overlay */
+		omap24xxcam_configure_overlay(cam, NULL);
+		omap24xxcam_flip_overlay(cam, cam->overlay_base_phys);
+		cam->previewing = (struct omap24xxcam_fh *)1;
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
+	.driver {
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
+	ret = platform_device_register(&omap24xxcam_dev);
+	if (ret != 0) {
+		platform_driver_unregister(&omap24xxcam_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
+void omap24xxcam_cleanup(void)
+{
+	struct omap24xxcam_device *cam = saved_cam;
+	struct video_device *vfd;
+
+	DBG;
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
+	cam->cam_sensor->cleanup(cam->sensor);
+	/* sensor allocated private data is gone */
+	cam->sensor = NULL;
+
+	if (cam->video2_base) {
+		dma_free_coherent(NULL, cam->video2_size,
+				  (void *)cam->video2_base,
+				  cam->video2_base_phys);
+		cam->video2_base = 0;
+	}
+	cam->video2_base_phys = 0;
+
+	if (cam->overlay_base) {
+		dma_free_coherent(NULL, cam->overlay_size,
+				  (void *)cam->overlay_base,
+				  cam->overlay_base_phys);
+		cam->overlay_base = 0;
+	}
+	cam->overlay_base_phys = 0;
+
+	if (cam->dispc_mmio_base) {
+		iounmap((void *)cam->dispc_mmio_base);
+		cam->dispc_mmio_base = 0;
+	}
+	cam->dispc_mmio_base_phys = 0;
+
+	if (cam->cam_mmio_base) {
+		iounmap((void *)cam->cam_mmio_base);
+		cam->cam_mmio_base = 0;
+	}
+	if (cam->cam_mmio_base_phys) {
+		release_mem_region(cam->cam_mmio_base_phys, cam->cam_mmio_size);
+		cam->cam_mmio_base_phys = 0;
+	}
+
+	platform_device_unregister(&omap24xxcam_dev);
+	platform_driver_unregister(&omap24xxcam_driver);
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
+		 "Minor number for video device (-1 ==> auto assign)");
+module_param(capture_mem, int, 0);
+MODULE_PARM_DESC(capture_mem,
+		 "Maximum amount of memory for capture buffers (default 4800KB)");
+module_param(overlay_mem, int, 0);
+MODULE_PARM_DESC(overlay_mem,
+		 "Preview overlay framebuffer size (default 600KB)");
+
+module_init(omap24xxcam_init);
+module_exit(omap24xxcam_cleanup);
diff --git a/drivers/media/video/omap/omap24xxcam.h b/drivers/media/video/omap/omap24xxcam.h
new file mode 100644
index 0000000..85c10e6
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxcam.h
@@ -0,0 +1,869 @@
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
+#define CC_CTRL_NOBT_HS_POL_SHIFT			9
+#define CC_CTRL_NOBT_HS_POL				(1 <<  9)
+#define CC_CTRL_NOBT_VS_POL_SHIFT			8
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
+
+/* camera DMA definitions */
+#define DMA_THRESHOLD 32	/* number of bytes transferred per DMA request */
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
+typedef void (*dma_callback_t) (struct omap24xxcam_device * cam,
+				unsigned long status, void *arg);
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
+	unsigned int irq;
+
+	unsigned long cam_mmio_base;
+	unsigned long cam_mmio_base_phys;
+	unsigned long cam_mmio_size;
+
+	unsigned long dispc_mmio_base;
+	unsigned long dispc_mmio_base_phys;
+	unsigned long dispc_mmio_size;
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
+	int free_dmach;		/* number of dma channels free */
+	int next_dmach;		/* index of next dma channel to use */
+	struct camdma_state camdma[NUM_CAMDMA_CHANNELS];
+	/* dma_notify is a pointer to a callback routine for notification when 
+	 * a DMA transfer has been started.
+	 */
+	void (*dma_notify) (struct omap24xxcam_device * cam);
+
+	/* frequncy (in Hz) of camera interface functional clock (MCLK) */
+	unsigned long mclk;
+
+	struct device dev;
+	struct video_device *vfd;
+
+	spinlock_t overlay_lock;	/* spinlock for overlay DMA counter */
+	int overlay_cnt;	/* count of queued overlay DMA xfers */
+	struct scatterlist overlay_sglist;
+
+	spinlock_t vbq_lock;	/* spinlock for videobuf queues */
+	struct videobuf_queue_ops vbq_ops;	/* videobuf queue operations */
+	unsigned long field_count;	/* field counter for videobuf_buffer */
+
+	/* scatter-gather DMA management */
+	spinlock_t sg_lock;
+	int free_sgdma;		/* number of free sg dma slots */
+	int next_sgdma;		/* index of next sg dma slot to use */
+	struct sgdma_state sgdma[NUM_SG_DMA];
+
+	/* The img_lock is used to serialize access to the image parameters for 
+	 * overlay and capture.
+	 */
+	spinlock_t img_lock;
+
+	/* Access to everything below here is locked by img_lock */
+
+	/* We allow streaming from at most one filehandle at a time.  
+	 * non-NULL means streaming is in progress.
+	 */
+	struct omap24xxcam_fh *streaming;
+	/* We allow previewing from at most one filehandle at a time.  
+	 * non-NULL means previewing is in progress.
+	 */
+	struct omap24xxcam_fh *previewing;
+
+	/* capture parameters (frame rate, number of buffers) */
+	struct v4l2_captureparm cparm;
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
+	/* value of CC_CTRL register required to support current capture 
+	 * format
+	 */
+	unsigned long cc_ctrl;
+
+	/* display controller video window (0 or 1) to use for capture 
+	 * preview
+	 */
+	int vid1;
+
+	/* gfx_position x and y are the offset of the display controller 
+	 * graphics window with respect to the display
+	 */
+	int gfx_position_x;
+	int gfx_position_y;
+	/* value of GFX_ATTRIBUTES register from display controller */
+	unsigned long gfx_attributes;
+
+	/* video 2 layer of the display controller is also configured through
+	 ** it */
+	int vid2;
+	unsigned long video2_base;
+	unsigned long video2_base_phys;
+	unsigned long video2_size;
+};
+
+/* per-filehandle data structure */
+struct omap24xxcam_fh {
+	struct omap24xxcam_device *cam;
+	enum v4l2_buf_type type;
+	struct videobuf_queue vbq;
+};
+
+/* Selected register definitions from the framebuffer driver for the 
+ * OMAP2420 display controller are repeated here.
+ */
+#ifndef OMAP24XXFB_H
+
+/* physical memory map definitions */
+	/* display subsystem */
+#define DSS_REG_BASE		0x48050000
+#define DSS_REG_SIZE		0x00001000
+	/* display controller */
+#define DISPC_REG_OFFSET	0x00000400
+
+/* define display controller register offsets */
+#define DISPC_REVISION			0x000
+#define DISPC_SYSCONFIG			0x010
+#define DISPC_SYSSTATUS			0x014
+#define DISPC_IRQSTATUS			0x018
+#define DISPC_IRQENABLE			0x01C
+#define DISPC_CONTROL			0x040
+#define DISPC_CONFIG			0x044
+#define DISPC_CAPABLE			0x048
+#define DISPC_DEFAULT_COLOR0		0x04C
+#define DISPC_DEFAULT_COLOR1		0x050
+#define DISPC_TRANS_COLOR0		0x054
+#define DISPC_TRANS_COLOR1		0x058
+#define DISPC_LINE_STATUS		0x05C
+#define DISPC_LINE_NUMBER		0x060
+#define DISPC_TIMING_H			0x064
+#define DISPC_TIMING_V			0x068
+#define DISPC_POL_FREQ			0x06C
+#define DISPC_DIVISOR			0x070
+#define DISPC_SIZE_DIG			0x078
+#define DISPC_SIZE_LCD			0x07C
+#define DISPC_GFX_BA0			0x080
+#define DISPC_GFX_BA1			0x084
+#define DISPC_GFX_POSITION		0x088
+#define DISPC_GFX_SIZE			0x08C
+#define DISPC_GFX_ATTRIBUTES		0x0A0
+#define DISPC_GFX_FIFO_THRESHOLD	0x0A4
+#define DISPC_GFX_FIFO_SIZE		0x0A8
+#define DISPC_GFX_ROW_INC		0x0AC
+#define DISPC_GFX_PIXEL_INC		0x0B0
+#define DISPC_GFX_WINDOW_SKIP		0x0B4
+#define DISPC_GFX_TABLE_BA		0x0B8
+
+/* The registers for the video pipelines are parameterized by the video pipeline
+ * index: n=0 for VID1 and n=1 for VID2.
+ */
+#define DISPC_VID_BA0(n)		(0x0BC + (n)*0x90)
+#define DISPC_VID_BA1(n)		(0x0C0 + (n)*0x90)
+#define DISPC_VID_POSITION(n)		(0x0C4 + (n)*0x90)
+#define DISPC_VID_SIZE(n)		(0x0C8 + (n)*0x90)
+#define DISPC_VID_ATTRIBUTES(n)		(0x0CC + (n)*0x90)
+#define DISPC_VID_FIFO_THRESHOLD(n)	(0x0D0 + (n)*0x90)
+#define DISPC_VID_FIFO_SIZE(n)		(0x0D4 + (n)*0x90)
+#define DISPC_VID_ROW_INC(n)		(0x0D8 + (n)*0x90)
+#define DISPC_VID_PIXEL_INC(n)		(0x0DC + (n)*0x90)
+#define DISPC_VID_FIR(n)		(0x0E0 + (n)*0x90)
+#define DISPC_VID_PICTURE_SIZE(n)	(0x0E4 + (n)*0x90)
+#define DISPC_VID_ACCU0(n)		(0x0E8 + (n)*0x90)
+#define DISPC_VID_ACCU1(n)		(0x0EC + (n)*0x90)
+/* The FIR coefficients are parameterized by the video pipeline index n = {0, 1}
+ * and the coefficient index i = {0, 1, 2, 3, 4, 5, 6, 7}.
+ */
+#define DISPC_VID_FIR_COEF_H(n, i)	(0x0F0 + (i)*0x8 + (n)*0x90)
+#define DISPC_VID_FIR_COEF_HV(n, i)	(0x0F4 + (i)*0x8 + (n)*0x90)
+#define DISPC_VID_CONV_COEF0(n)		(0x130 + (n)*0x90)
+#define DISPC_VID_CONV_COEF1(n)		(0x134 + (n)*0x90)
+#define DISPC_VID_CONV_COEF2(n)		(0x138 + (n)*0x90)
+#define DISPC_VID_CONV_COEF3(n)		(0x13C + (n)*0x90)
+#define DISPC_VID_CONV_COEF4(n)		(0x140 + (n)*0x90)
+
+/* Define bit fields within selected registers */
+#define DISPC_REVISION_MAJOR				(15 << 4)
+#define DISPC_REVISION_MAJOR_SHIFT			4
+#define DISPC_REVISION_MINOR				(15 << 0)
+#define DISPC_REVISION_MINOR_SHIFT			0
+
+#define DISPC_SYSCONFIG_MIDLEMODE			(3 << 12)
+#define DISPC_SYSCONFIG_MIDLEMODE_FSTANDBY		(0 << 12)
+#define DISPC_SYSCONFIG_MIDLEMODE_NSTANDBY		(1 << 12)
+#define DISPC_SYSCONFIG_MIDLEMODE_SSTANDBY		(2 << 12)
+#define DISPC_SYSCONFIG_SIDLEMODE			(3 <<  3)
+#define DISPC_SYSCONFIG_SIDLEMODE_FIDLE			(0 <<  3)
+#define DISPC_SYSCONFIG_SIDLEMODE_NIDLE			(1 <<  3)
+#define DISPC_SYSCONFIG_SIDLEMODE_SIDLE			(2 <<  3)
+#define DISPC_SYSCONFIG_SOFTRESET			(1 <<  1)
+#define DISPC_SYSCONFIG_AUTOIDLE			(1 <<  0)
+
+#define DISPC_SYSSTATUS_RESETDONE			(1 << 0)
+
+#define DISPC_IRQSTATUS_SYNCLOST			(1 << 14)
+#define DISPC_IRQSTATUS_VID2ENDWINDOW			(1 << 13)
+#define DISPC_IRQSTATUS_VID2FIFOUNDERFLOW		(1 << 12)
+#define DISPC_IRQSTATUS_VID1ENDWINDOW			(1 << 11)
+#define DISPC_IRQSTATUS_VID1FIFOUNDERFLOW		(1 << 10)
+#define DISPC_IRQSTATUS_OCPERROR			(1 <<  9)
+#define DISPC_IRQSTATUS_PALETTEGAMMALOADING		(1 <<  8)
+#define DISPC_IRQSTATUS_GFXENDWINDOW			(1 <<  7)
+#define DISPC_IRQSTATUS_GFXFIFOUNDERFLOW		(1 <<  6)
+#define DISPC_IRQSTATUS_PROGRAMMEDLINENUMBER		(1 <<  5)
+#define DISPC_IRQSTATUS_ACBIASCOUNTSTATUS		(1 <<  4)
+#define DISPC_IRQSTATUS_EVSYNC_ODD			(1 <<  3)
+#define DISPC_IRQSTATUS_EVSYNC_EVEN			(1 <<  2)
+#define DISPC_IRQSTATUS_VSYNC				(1 <<  1)
+#define DISPC_IRQSTATUS_FRAMEDONE			(1 <<  0)
+
+#define DISPC_IRQENABLE_SYNCLOST			(1 << 14)
+#define DISPC_IRQENABLE_VID2ENDWINDOW			(1 << 13)
+#define DISPC_IRQENABLE_VID2FIFOUNDERFLOW		(1 << 12)
+#define DISPC_IRQENABLE_VID1ENDWINDOW			(1 << 11)
+#define DISPC_IRQENABLE_VID1FIFOUNDERFLOW		(1 << 10)
+#define DISPC_IRQENABLE_OCPERROR			(1 <<  9)
+#define DISPC_IRQENABLE_PALETTEGAMMALOADING		(1 <<  8)
+#define DISPC_IRQENABLE_GFXENDWINDOW			(1 <<  7)
+#define DISPC_IRQENABLE_GFXFIFOUNDERFLOW		(1 <<  6)
+#define DISPC_IRQENABLE_PROGRAMMEDLINENUMBER		(1 <<  5)
+#define DISPC_IRQENABLE_ACBIASCOUNTSTATUS		(1 <<  4)
+#define DISPC_IRQENABLE_EVSYNC_ODD			(1 <<  3)
+#define DISPC_IRQENABLE_EVSYNC_EVEN			(1 <<  2)
+#define DISPC_IRQENABLE_VSYNC				(1 <<  1)
+#define DISPC_IRQENABLE_FRAMEDONE			(1 <<  0)
+
+#define DISPC_CONTROL_TDMUNUSEDBITS			(3 << 25)
+#define DISPC_CONTROL_TDMUNUSEDBITS_LOWLEVEL		(0 << 25)
+#define DISPC_CONTROL_TDMUNUSEDBITS_HIGHLEVEL		(1 << 25)
+#define DISPC_CONTROL_TDMUNUSEDBITS_UNCHANGED		(2 << 25)
+#define DISPC_CONTROL_TDMCYCLEFORMAT			(3 << 23)
+#define DISPC_CONTROL_TDMCYCLEFORMAT_1CYCPERPIX		(0 << 23)
+#define DISPC_CONTROL_TDMCYCLEFORMAT_2CYCPERPIX		(1 << 23)
+#define DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPERPIX		(2 << 23)
+#define DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPER2PIX	(3 << 23)
+#define DISPC_CONTROL_TDMPARALLELMODE			(3 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_8BPARAINT		(0 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_9BPARAINT		(1 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_12BPARAINT	(2 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_16BPARAINT	(3 << 21)
+#define DISPC_CONTROL_TDMENABLE				(1 << 20)
+#define DISPC_CONTROL_HT				(7 << 17)
+#define DISPC_CONTROL_HT_SHIFT				17
+#define DISPC_CONTROL_GPOUT1				(1 << 16)
+#define DISPC_CONTROL_GPOUT0				(1 << 15)
+#define DISPC_CONTROL_GPIN1				(1 << 14)
+#define DISPC_CONTROL_GPIN0				(1 << 13)
+#define DISPC_CONTROL_OVERLAYOPTIMIZATION		(1 << 12)
+#define DISPC_CONTROL_RFBIMODE				(1 << 11)
+#define DISPC_CONTROL_SECURE				(1 << 10)
+#define DISPC_CONTROL_TFTDATALINES			(3 <<  8)
+#define DISPC_CONTROL_TFTDATALINES_OALSB12B		(0 <<  8)
+#define DISPC_CONTROL_TFTDATALINES_OALSB16B		(1 <<  8)
+#define DISPC_CONTROL_TFTDATALINES_OALSB18B		(2 <<  8)
+#define DISPC_CONTROL_TFTDATALINES_OALSB24B		(3 <<  8)
+#define DISPC_CONTROL_TFTDITHERENABLE			(1 <<  7)
+#define DISPC_CONTROL_GODIGITAL				(1 <<  6)
+#define DISPC_CONTROL_GOLCD				(1 <<  5)
+#define DISPC_CONTROL_M8B				(1 <<  4)
+#define DISPC_CONTROL_STNTFT				(1 <<  3)
+#define DISPC_CONTROL_MONOCOLOR				(1 <<  2)
+#define DISPC_CONTROL_DIGITALENABLE			(1 <<  1)
+#define DISPC_CONTROL_LCDENABLE				(1 <<  0)
+
+#define DISPC_CONFIG_TCKDIGSELECTION			(1 << 13)
+#define DISPC_CONFIG_TCKDIGENABLE			(1 << 12)
+#define DISPC_CONFIG_TCKLCDSELECTION			(1 << 11)
+#define DISPC_CONFIG_TCKLCDENABLE			(1 << 10)
+#define DISPC_CONFIG_FUNCGATED				(1 <<  9)
+#define DISPC_CONFIG_ACBIASGATED			(1 <<  8)
+#define DISPC_CONFIG_VSYNCGATED				(1 <<  7)
+#define DISPC_CONFIG_HSYNCGATED				(1 <<  6)
+#define DISPC_CONFIG_PIXELCLOCKGATED			(1 <<  5)
+#define DISPC_CONFIG_PIXELDATAGATED			(1 <<  4)
+#define DISPC_CONFIG_PALETTEGAMMATABLE			(1 <<  3)
+#define DISPC_CONFIG_LOADMODE_FRDATLEFR			(1 <<  2)
+#define DISPC_CONFIG_LOADMODE_PGTABUSETB		(1 <<  1)
+#define DISPC_CONFIG_PIXELGATED				(1 <<  0)
+
+#define DISPC_CAPABLE_GFXGAMMATABLECAPABLE		(1 <<  9)
+#define DISPC_CAPABLE_GFXLAYERCAPABLE			(1 <<  8)
+#define DISPC_CAPABLE_GFXTRANSDSTCAPABLE		(1 <<  7)
+#define DISPC_CAPABLE_STNDITHERINGCAPABLE		(1 <<  6)
+#define DISPC_CAPABLE_TFTDITHERINGCAPABLE		(1 <<  5)
+#define DISPC_CAPABLE_VIDTRANSSRCCAPABLE		(1 <<  4)
+#define DISPC_CAPABLE_VIDLAYERCAPABLE			(1 <<  3)
+#define DISPC_CAPABLE_VIDVERTFIRCAPABLE			(1 <<  2)
+#define DISPC_CAPABLE_VIDHORFIRCAPABLE			(1 <<  1)
+#define DISPC_CAPABLE_VIDCAPABLE			(1 <<  0)
+
+#define DISPC_POL_FREQ_ONOFF				(1 << 17)
+#define DISPC_POL_FREQ_RF				(1 << 16)
+#define DISPC_POL_FREQ_IEO				(1 << 15)
+#define DISPC_POL_FREQ_IPC				(1 << 14)
+#define DISPC_POL_FREQ_IHS				(1 << 13)
+#define DISPC_POL_FREQ_IVS				(1 << 12)
+#define DISPC_POL_FREQ_ACBI				(15 << 8)
+#define DISPC_POL_FREQ_ACBI_SHIFT			8
+#define DISPC_POL_FREQ_ACB				0xFF
+#define DISPC_POL_FREQ_ACB_SHIFT			0
+
+#define DISPC_TIMING_H_HBP				(0xFF << 20)
+#define DISPC_TIMING_H_HBP_SHIFT			20
+#define DISPC_TIMING_H_HFP				(0xFF << 8)
+#define DISPC_TIMING_H_HFP_SHIFT			8
+#define DISPC_TIMING_H_HSW				(0x3F << 0)
+#define DISPC_TIMING_H_HSW_SHIFT			0
+
+#define DISPC_TIMING_V_VBP				(0xFF << 20)
+#define DISPC_TIMING_V_VBP_SHIFT			20
+#define DISPC_TIMING_V_VFP				(0xFF << 8)
+#define DISPC_TIMING_V_VFP_SHIFT			8
+#define DISPC_TIMING_V_VSW				(0x3F << 0)
+#define DISPC_TIMING_V_VSW_SHIFT			0
+
+#define DISPC_DIVISOR_LCD				(0xFF << 16)
+#define DISPC_DIVISOR_LCD_SHIFT				16
+#define DISPC_DIVISOR_PCD				0xFF
+#define DISPC_DIVISOR_PCD_SHIFT				0
+
+#define DISPC_SIZE_LCD_LPP				(0x7FF << 16)
+#define DISPC_SIZE_LCD_LPP_SHIFT			16
+#define DISPC_SIZE_LCD_PPL				0x7FF
+#define DISPC_SIZE_LCD_PPL_SHIFT			0
+
+#define DISPC_SIZE_DIG_LPP				(0x7FF << 16)
+#define DISPC_SIZE_DIG_LPP_SHIFT			16
+#define DISPC_SIZE_DIG_PPL				0x7FF
+#define DISPC_SIZE_DIG_PPL_SHIFT			0
+
+#define DISPC_GFX_POSITION_GFXPOSY			(0x7FF << 16)
+#define DISPC_GFX_POSITION_GFXPOSY_SHIFT		16
+#define DISPC_GFX_POSITION_GFXPOSX			0x7FF
+#define DISPC_GFX_POSITION_GFXPOSX_SHIFT		0
+
+#define DISPC_GFX_SIZE_GFXSIZEY				(0x7FF << 16)
+#define DISPC_GFX_SIZE_GFXSIZEY_SHIFT			16
+#define DISPC_GFX_SIZE_GFXSIZEX				0x7FF
+#define DISPC_GFX_SIZE_GFXSIZEX_SHIFT			0
+
+#define DISPC_GFX_ATTRIBUTES_GFXENDIANNESS		(1 << 10)
+#define DISPC_GFX_ATTRIBUTES_GFXNIBBLEMODE		(1 <<  9)
+#define DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT		(1 <<  8)
+#define DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE		(3 <<  6)
+#define DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE_BURST4X32	(0 <<  6)
+#define DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE_BURST8X32	(1 <<  6)
+#define DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE_BURST16X32	(2 <<  6)
+#define DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE	(1 <<  5)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT			(15 << 1)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP1		(0 <<  1)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP2		(1 <<  1)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP4		(2 <<  1)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP8		(3 <<  1)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB12		(4 <<  1)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB16		(6 <<  1)
+#define DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB24		(8 <<  1)
+#define DISPC_GFX_ATTRIBUTES_ENABLE			(1 <<  0)
+
+#define DISPC_GFX_FIFO_THRESHOLD_HIGH			(0x1FF << 16)
+#define DISPC_GFX_FIFO_THRESHOLD_HIGH_SHIFT		16
+#define DISPC_GFX_FIFO_THRESHOLD_LOW			0x1FF
+#define DISPC_GFX_FIFO_THRESHOLD_LOW_SHIFT		0
+
+#define DISPC_VID_POSITION_VIDPOSY			(0x7FF << 16)
+#define DISPC_VID_POSITION_VIDPOSY_SHIFT		16
+#define DISPC_VID_POSITION_VIDPOSX			0x7FF
+#define DISPC_VID_POSITION_VIDPOSX_SHIFT		0
+
+#define DISPC_VID_SIZE_VIDSIZEY				(0x7FF << 16)
+#define DISPC_VID_SIZE_VIDSIZEY_SHIFT			16
+#define DISPC_VID_SIZE_VIDSIZEX				0x7FF
+#define DISPC_VID_SIZE_VIDSIZEX_SHIFT			0
+
+#define DISPC_VID_ATTRIBUTES_VIDROWREPEATENABLE		(1 << 18)
+#define DISPC_VID_ATTRIBUTES_VIDENDIANNESS		(1 << 17)
+#define DISPC_VID_ATTRIBUTES_VIDCHANNELOUT		(1 << 16)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE		(3 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE_BURST4X32	(0 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE_BURST8X32	(1 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE_BURST16X32	(2 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDROTATION		(3 << 12)
+#define DISPC_VID_ATTRIBUTES_VIDROTATION_NOROT		(0 << 12)
+#define DISPC_VID_ATTRIBUTES_VIDROTATION_ROT90		(1 << 12)
+#define DISPC_VID_ATTRIBUTES_VIDROTATION_ROT180		(2 << 12)
+#define DISPC_VID_ATTRIBUTES_VIDROTATION_ROT270		(3 << 12)
+#define DISPC_VID_ATTRIBUTES_VIDFULLRANGE		(1 << 11)
+#define DISPC_VID_ATTRIBUTES_VIDREPLICATIONENABLE	(1 << 10)
+#define DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE		(1 <<  9)
+#define DISPC_VID_ATTRIBUTES_VIDVRESIZECONF		(1 <<  8)
+#define DISPC_VID_ATTRIBUTES_VIDHRESIZECONF		(1 <<  7)
+#define DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_VRESIZE	(1 <<  6)
+#define DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_HRESIZE	(1 <<  5)
+#define DISPC_VID_ATTRIBUTES_VIDFORMAT			(15 << 1)
+#define DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB16		(6  << 1)
+#define DISPC_VID_ATTRIBUTES_VIDFORMAT_YUV2		(10 << 1)
+#define DISPC_VID_ATTRIBUTES_VIDFORMAT_UYVY		(11 << 1)
+#define DISPC_VID_ATTRIBUTES_ENABLE			(1 <<  0)
+
+#define DISPC_VID_PICTURE_SIZE_VIDORGSIZEY		(0x7FF << 16)
+#define DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT	16
+#define DISPC_VID_PICTURE_SIZE_VIDORGSIZEX		0x7FF
+#define DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT	0
+#define VIDIOC_S_VID2          _IOWR ('V', 90, struct omap24xx_vid2_format)
+#define VIDIOC_S_VID2_DISABLE     _IOWR ('V', 91, int)
+
+#endif				/* ifndef OMAP24XXFB_H */
+
+#endif				/* ifndef OMAP24XXCAM_H */
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

--------------080209090509050400040103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080209090509050400040103--
