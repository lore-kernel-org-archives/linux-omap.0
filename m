From: Brian Swetland <swetland@google.com>
Subject: [PATCH] omapfb vsync support
Date: Mon, 27 Feb 2006 13:59:23 -0800
Message-ID: <20060227215923.GA27791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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
List-Id: linux-omap@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here's a patch that provides the FBIO_WAITFORVSYNC ioctl
(same one used by the ati and nvidia drivers) to the omapfb
driver.  We could use the omap-specific ioctl, but it seemed
to make more sense to use an existing one.  Opinions?

Brian


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="omapfb_vsync.patch"

diff -u linux-omap-2.6/drivers/video/omap/lcdc.c linux-omap-work/drivers/video/omap/lcdc.c
--- linux-omap-2.6/drivers/video/omap/lcdc.c	2006-02-27 12:07:17.000000000 -0800
+++ linux-omap-work/drivers/video/omap/lcdc.c	2006-02-27 12:39:25.000000000 -0800
@@ -294,6 +294,12 @@
 		}
 	}
 
+	if (status & OMAP_LCDC_STAT_VSYNC) {
+		struct omapfb_device* fbdev = (struct omapfb_device*)dev_id;
+		fbdev->vblank.count++;
+		wake_up_interruptible(&fbdev->vblank.wait);
+	}
+	
 	/* Clear these interrupt status bits.
 	 * Sync_lost, FUF bits were cleared by disabling the LCD controller
 	 * LOADED_PALETTE can be cleared this way only in palette only
@@ -899,6 +905,22 @@
 	clk_put(omap_lcdc.lcd_ck);
 }
 
+static void omap_lcdc_enable_vsync_irq(void)
+{
+	if (!(omap_lcdc.irq_mask & OMAP_LCDC_IRQ_VSYNC)) {
+		enable_irqs(OMAP_LCDC_IRQ_VSYNC);
+		enable_controller();
+	}
+}
+
+static void omap_lcdc_disable_vsync_irq(void)
+{
+	if (omap_lcdc.irq_mask & OMAP_LCDC_IRQ_VSYNC) {
+		disable_irqs(OMAP_LCDC_IRQ_VSYNC);
+		enable_controller();
+	}
+}
+
 struct lcd_ctrl omap1_int_ctrl = {
 	.name			= "internal",
 	.init			= omap_lcdc_init,
@@ -913,6 +935,9 @@
 	.setup_plane		= omap_lcdc_setup_plane,
 	.enable_plane		= omap_lcdc_enable_plane,
 	.setcolreg		= omap_lcdc_setcolreg,
+	.set_color_key		= NULL,
+	.enable_vsync_irq	= omap_lcdc_enable_vsync_irq,
+	.disable_vsync_irq	= omap_lcdc_disable_vsync_irq
 };
 
 MODULE_DESCRIPTION("TI OMAP LCDC controller");
diff -u linux-omap-2.6/drivers/video/omap/omapfb_main.c linux-omap-work/drivers/video/omap/omapfb_main.c
--- linux-omap-2.6/drivers/video/omap/omapfb_main.c	2006-02-27 12:07:17.000000000 -0800
+++ linux-omap-work/drivers/video/omap/omapfb_main.c	2006-02-27 12:39:25.000000000 -0800
@@ -119,6 +119,10 @@
 	up(&fbdev->rqueue_sema);
 }
 
+#ifndef FBIO_WAITFORVSYNC
+#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
+#endif
+
 /*
  * ---------------------------------------------------------------------------
  * LCD controller and LCD DMA
@@ -547,6 +551,34 @@
 	return r;
 }
 
+static int omapfb_wait_for_vsync(struct omapfb_device *fbdev, unsigned int crtc)
+{
+	struct omap_interrupt *vbl;
+	struct lcd_ctrl *ctrl;
+	unsigned int count;
+	int r;
+
+	if (crtc != 0)
+		return -ENODEV;
+
+	vbl = &fbdev->vblank;
+	ctrl = fbdev->ctrl;
+
+	if (ctrl->enable_vsync_irq == NULL) 
+		return -ENODEV;
+	
+	count = vbl->count;
+
+	/* enable the vsync irq the first time */
+	ctrl->enable_vsync_irq();
+		
+	r = wait_event_interruptible_timeout(vbl->wait, count != vbl->count, HZ/10);
+	if (r == 0)
+		r = -ETIMEDOUT;
+
+	return r;
+}
+
 /* Check values in var, try to adjust them in case of out of bound values if
  * possible, or return error.
  */
@@ -797,6 +829,7 @@
 		enum omapfb_update_mode		update_mode;
 		unsigned long		caps;
 		unsigned int		mirror;
+		unsigned int		crtc;
 	} p;
 	int r = 0;
 
@@ -804,6 +837,13 @@
 	DBGPRINT(2, "cmd=%010x\n", cmd);
 	switch (cmd)
 	{
+	case FBIO_WAITFORVSYNC:
+		if (get_user(p.crtc, (unsigned int __user *)arg))
+			r = -EFAULT;
+		else 
+			r = omapfb_wait_for_vsync(fbdev, p.crtc);
+		break;
+
 	case OMAPFB_MIRROR:
 		if (get_user(p.mirror, (int __user *)arg))
 			r = -EFAULT;
@@ -1275,6 +1315,9 @@
 
 	init_MUTEX(&fbdev->rqueue_sema);
 
+	init_waitqueue_head(&fbdev->vblank.wait);
+	fbdev->vblank.count = 0;
+
 #ifdef CONFIG_ARCH_OMAP1
 	fbdev->int_ctrl = &omap1_int_ctrl;
 #ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
diff -u linux-omap-2.6/include/asm-arm/arch-omap/omapfb.h linux-omap-work/include/asm-arm/arch-omap/omapfb.h
--- linux-omap-2.6/include/asm-arm/arch-omap/omapfb.h	2006-02-27 12:06:29.000000000 -0800
+++ linux-omap-work/include/asm-arm/arch-omap/omapfb.h	2006-02-27 12:39:26.000000000 -0800
@@ -139,6 +139,7 @@
 #define OMAP_LCDC_SIGNAL_MASK		0x003f
 
 #define OMAP_LCDC_PANEL_TFT		0x0100
+#define OMAP_LCDC_PANEL_INIT_AFTER_LCDC 0x0200
 
 #ifdef CONFIG_ARCH_OMAP1
 #define OMAPFB_PLANE_NUM		1
@@ -257,6 +258,8 @@
 					   int update_hw_mem);
 	int		(*set_color_key)  (struct omapfb_color_key *ck);
 
+	void		(*enable_vsync_irq)(void);
+	void		(*disable_vsync_irq)(void);
 };
 
 enum omapfb_state {
@@ -265,6 +268,11 @@
 	OMAPFB_ACTIVE	= 100
 };
 
+struct omap_interrupt {
+	wait_queue_head_t	wait;
+	unsigned int		count;
+};
+
 struct omapfb_device {
 	int			state;
 	int                     ext_lcdc;               /* Using external
@@ -287,6 +295,8 @@
 							   interface */
 	struct fb_info		*fb_info;
 
+	struct omap_interrupt vblank;
+
 	struct device		*dev;
 };
 

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--azLHFNyN32YCQGCU--
