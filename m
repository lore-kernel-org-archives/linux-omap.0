From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [RFD] [PATCH] omap24xx vout and dispc library
Date: Thu, 15 Dec 2005 06:53:13 -0800 (PST)
Message-ID: <20051215145313.77779.qmail@web32906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-345937890-1134658393=:75527"
Content-Transfer-Encoding: 8bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-345937890-1134658393=:75527
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Imre/Tony,

I have attached the patch which includes (done by Jian and the team...)

o display functions library [display.[ch]].
  - Location: arch/arm/mach-omap2/display.c
  - common omap2 dispc exported functions can then be used by fb, vout
and camera preview code.

o V4L2 based Video out patch. [omap24xxvout.[ch]]
  o This framework implements
    o Dynamic use of video planes 
      e.g As per the 2.6.9-TI code,
      in camera driver V1 was fixed for preview.
      
      Now for camera preview _or_ video out on (LCD/TV) can
      dynamically take the plane which is free.
    o video plane linking 
    o and rotation/mirroring/colorkey...etc.

o omap24xxlib.[ch]
- It includes functions common between camera preview and vout.
(cropping/scaling)

Attached patch works with 2.6.9-TI omap24xxfb (considering that it uses
the display.[ch] library) driver.

I am *not* able to successfully test this driver along with
git-omap2-fb driver. See I have disabled request_irq, dispc
reset/initialisation in the omap2_disp_init(dispc.c) patch.

But as git-omap2-fb driver is checking FIFO_UNDERFLOW/SYNC_LOST
interrupts, which I am getting more than five times, which ultimately
disables the display irq (irq_status 0x4000, 0x40a2, 0x4002....), and
my test-application(e.g streaming yuv on v1) hangs the system after
that...

So, could you please have look at the patch, so that we can find better
way to integrate vout and display controller library functions into the
git tree. Thanx.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-345937890-1134658393=:75527
Content-Type: text/plain; name="vout-list.patch"
Content-Description: 672730804-vout-list.patch
Content-Disposition: inline; filename="vout-list.patch"

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4cc80f7..354819b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sram-fn.o memory.o prcm.o clock.o mux.o devices.o serial.o
+obj-y := irq.o id.o io.o sram-fn.o memory.o prcm.o clock.o mux.o devices.o serial.o display.o
 
 obj-$(CONFIG_OMAP_MPU_TIMER)		+= timer-gp.o
 
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
new file mode 100644
index 0000000..7dcfb14
--- /dev/null
+++ b/arch/arm/mach-omap2/display.c
@@ -0,0 +1,1777 @@
+/*
+ * linux/arch/arm/mach-omap2/display.c
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Leveraged code from the OMAP24xx camera driver
+ * Video-for-Linux (Version 2) camera capture driver for
+ * the OMAP24xx camera controller.
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/display.h>
+#include <asm/arch/venc.h>
+
+/*extern void omap24xx_ll_config_disp_clocks(int sleep_state);*/
+
+/* usage count for DSS power management */
+static int disp_usage;
+static int omap2_current_tvstandard;
+static spinlock_t dss_lock;
+
+struct omap2_disp_dma_params {
+	u32 ba0;
+	u32 ba1;
+	int row_inc;
+	int pix_inc;
+};
+
+static struct layer_t {
+	int output_dev;
+	int in_use;
+
+	/* one set of dma parameters each for LCD and TV */
+	struct omap2_disp_dma_params dma[2];
+
+	int size_x;
+	int size_y;
+} layer[3];
+
+#define MAX_ISR_NR   8
+static int omap2_disp_irq;
+static struct {
+	omap2_disp_isr_t isr;
+	void *arg;
+	unsigned int mask;
+} registered_isr[MAX_ISR_NR];
+
+
+/*
+ * DSS register I/O routines
+ */
+static __inline__ u32
+dss_reg_in(u32 offset)
+{
+        return  omap_readl(DSS_REG_BASE + DSS_REG_OFFSET + offset);
+}
+static __inline__ u32
+dss_reg_out(u32 offset, u32 val)
+{
+        omap_writel(val,DSS_REG_BASE + DSS_REG_OFFSET + offset);
+        return val;
+}
+static __inline__ u32
+dss_reg_merge(u32 offset, u32 val, u32 mask)
+{
+        u32 addr = DSS_REG_BASE + DSS_REG_OFFSET + offset;
+        u32 new_val = (omap_readl(addr) & ~mask) | (val & mask);
+
+        omap_writel(new_val, addr);
+        return new_val;
+}
+
+
+/*
+ * Display controller register I/O routines
+ */
+static __inline__ u32
+dispc_reg_in(u32 offset)
+{
+	return omap_readl(DSS_REG_BASE + DISPC_REG_OFFSET + offset);
+}
+
+static __inline__ u32
+dispc_reg_out(u32 offset, u32 val)
+{
+	omap_writel(val, DSS_REG_BASE + DISPC_REG_OFFSET + offset);
+	return val;
+}
+static __inline__ u32
+dispc_reg_merge(u32 offset, u32 val, u32 mask)
+{
+	u32 addr = DSS_REG_BASE + DISPC_REG_OFFSET + offset;
+	u32 new_val = (omap_readl(addr) & ~mask) | (val & mask);
+
+	omap_writel(new_val, addr);
+	return new_val;
+}
+
+/*
+ * VENC register I/O Routines
+ */
+static __inline__ u32
+venc_reg_in(u32 offset)
+{
+        return omap_readl(DSS_REG_BASE + VENC_REG_OFFSET + offset);
+}
+static __inline__ u32
+venc_reg_out(u32 offset, u32 val)
+{
+        omap_writel(val, DSS_REG_BASE + VENC_REG_OFFSET + offset);
+        return val;
+}
+static __inline__ u32
+venc_reg_merge(u32 offset, u32 val, u32 mask)
+{
+        u32 addr = DSS_REG_BASE + VENC_REG_OFFSET + offset;
+        u32 new_val = (omap_readl(addr) & ~mask) | (val & mask);
+
+        omap_writel(new_val, addr);
+        return new_val;
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
+omap2_disp_set_colorconv(int v, const short int mtx[3][3])
+{
+	unsigned long ccreg;
+
+	ccreg = (mtx[0][0] & 0x7ff) | ((mtx[0][1] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF0(v), ccreg);
+	ccreg = (mtx[0][2] & 0x7ff) | ((mtx[1][0] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF1(v), ccreg);
+	ccreg = (mtx[1][1] & 0x7ff) | ((mtx[1][2] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF2(v), ccreg);
+	ccreg = (mtx[2][0] & 0x7ff) | ((mtx[2][1] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF3(v), ccreg);
+	ccreg = mtx[2][2] & 0x7ff;
+	dispc_reg_out(DISPC_VID_CONV_COEF4(v), ccreg);
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
+omap2_disp_set_resize(int v, const short int vc[3][8], const short int hc[5][8])
+{
+	int i;
+	unsigned long reg;
+
+	for (i = 0; i < 8; i++) {
+		reg = (hc[0][i] & 0xff) | ((hc[1][i] & 0xff) << 8)
+			| ((hc[2][i] & 0xff) << 16) | ((hc[3][i] & 0xff) << 24);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v, i), reg);
+		reg = (hc[4][i] & 0xff) | ((vc[0][i] & 0xff) << 8)
+			| ((vc[1][i] & 0xff) << 16) | ((vc[2][i] & 0xff) << 24);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v, i), reg);
+	}
+}
+
+/*---------------------------------------------------------------------------*/
+
+void
+omap2_disp_get_panel_size(int output_dev, int *width, int *height)
+{
+	unsigned long size;
+
+	if (output_dev == OMAP2_OUTPUT_TV) {
+		size = dispc_reg_in(DISPC_SIZE_DIG);
+		*width = 1 + ((size & DISPC_SIZE_DIG_PPL)
+				>> DISPC_SIZE_DIG_PPL_SHIFT);
+		*height = 1 + ((size & DISPC_SIZE_DIG_LPP)
+				>> DISPC_SIZE_DIG_LPP_SHIFT);
+		*height = *height << 1;
+	}
+	else if (output_dev == OMAP2_OUTPUT_LCD) {
+		size = dispc_reg_in(DISPC_SIZE_LCD);
+		*width = 1 + ((size & DISPC_SIZE_LCD_PPL)
+				>> DISPC_SIZE_LCD_PPL_SHIFT);
+		*height = 1 + ((size & DISPC_SIZE_LCD_LPP)
+				>> DISPC_SIZE_LCD_LPP_SHIFT);
+	}
+}
+void
+omap2_disp_set_panel_size(int output_dev, int width, int height)
+{
+	unsigned long size;
+
+	if (output_dev == OMAP2_OUTPUT_TV) {
+		height = height >> 1;
+		size = ((width - 1) << DISPC_SIZE_DIG_PPL_SHIFT) &  DISPC_SIZE_DIG_PPL;
+		size |= ((height - 1) << DISPC_SIZE_DIG_LPP_SHIFT) & DISPC_SIZE_DIG_LPP;
+		dispc_reg_out(DISPC_SIZE_DIG, size);
+	}
+	else if (output_dev == OMAP2_OUTPUT_LCD) {
+		size = ((width - 1) << DISPC_SIZE_LCD_PPL_SHIFT) & DISPC_SIZE_LCD_PPL;
+		size |= ((height - 1) << DISPC_SIZE_LCD_LPP_SHIFT) & DISPC_SIZE_LCD_LPP;
+		dispc_reg_out(DISPC_SIZE_LCD, size);
+	}
+}
+
+
+/* Turn off the GFX, or video1, or video2 layer. */
+void
+omap2_disp_disable_layer(int ltype)
+{
+	unsigned long attributes;
+	int digital, v;
+
+
+	if (ltype == OMAP2_GRAPHICS) {
+		attributes = dispc_reg_merge(DISPC_GFX_ATTRIBUTES, 0,
+				DISPC_GFX_ATTRIBUTES_ENABLE);
+		digital = attributes & DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT;
+	}
+	else {
+		if (ltype == OMAP2_VIDEO1) v = 0;
+		else if (ltype == OMAP2_VIDEO2) v = 1;
+		else return;
+
+		attributes = dispc_reg_merge(DISPC_VID_ATTRIBUTES(v), 0,
+			DISPC_VID_ATTRIBUTES_ENABLE);
+		digital = attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT;
+	}
+	if (digital) {
+		/* digital output */
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+			DISPC_CONTROL_GODIGITAL);
+	}
+	else {
+		/* LCD */
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+			DISPC_CONTROL_GOLCD);
+	}
+}
+
+/* Turn on the GFX, or video1, or video2 layer. */
+void
+omap2_disp_enable_layer(int ltype)
+{
+	unsigned long attributes;
+	int digital, v;
+
+	if (ltype == OMAP2_GRAPHICS) {
+		attributes = dispc_reg_merge(DISPC_GFX_ATTRIBUTES,
+			DISPC_GFX_ATTRIBUTES_ENABLE, DISPC_GFX_ATTRIBUTES_ENABLE);
+		digital = attributes & DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT;
+	}
+	else {
+		if (ltype == OMAP2_VIDEO1) v = 0;
+		else if (ltype == OMAP2_VIDEO2) v = 1;
+		else return;
+
+		attributes = dispc_reg_merge(DISPC_VID_ATTRIBUTES(v),
+			DISPC_VID_ATTRIBUTES_ENABLE, DISPC_VID_ATTRIBUTES_ENABLE);
+		digital = attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT;
+	}
+	if (digital) {
+		/* digital output */
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+			DISPC_CONTROL_GODIGITAL);
+	}
+	else {
+		/* LCD */
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+			DISPC_CONTROL_GOLCD);
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
+void
+omap2_disp_start_vlayer(int ltype, struct v4l2_pix_format *pix,
+			struct v4l2_rect *crop, unsigned long fb_base_phys,
+			int rotation_deg, int mirroring)
+{
+	unsigned long cropped_base_phys;
+	int v, ps = 2,temp_ps=2;
+	int image_height=0, offset=0, image_width=0, ctop=0, cleft=0, line_length=0;
+	
+	if (ltype == OMAP2_VIDEO1) v = 0;
+	else if (ltype == OMAP2_VIDEO2) v = 1;
+	else return;
+	
+	/*
+	 * If pixel format is YUV then PS = 4, for RGB PS = 2
+	 */
+
+	if (V4L2_PIX_FMT_YUYV == pix->pixelformat ||
+		V4L2_PIX_FMT_UYVY == pix->pixelformat) {
+		if (rotation_deg >= 0 || mirroring == 1)
+			ps = 4;
+		else
+			ps = 2;
+	}
+
+	/*
+	 * If rotation is selected then compute the rotation parameters
+	 */
+	if (rotation_deg >= 0) {
+		line_length = MAX_PIXELS_PER_LINE;
+		image_height = pix->height / 32;	// 32 = # of rows in a tile
+		if (pix->height % 32)
+			image_height++;
+		image_height = image_height * 32;
+
+		image_width = pix->width / 16;	// 16 = # of pixels per row in a tile
+		if (pix->width % 16)
+			image_width++;
+		image_width = image_width * 16;
+
+		ctop = (pix->height - crop->height) - crop->top;
+		cleft = (pix->width - crop->width) - crop->left;
+	}
+
+	else {
+		line_length = pix->width;
+	}
+
+	switch (rotation_deg) {
+	case 90:
+		offset = (image_height - pix->height) * ps;
+		temp_ps = ps/(ps>>1);
+		if (mirroring == 0) {
+			cropped_base_phys = fb_base_phys + offset +
+				line_length * temp_ps * crop->left + ctop * temp_ps;
+		}
+		else{
+			cropped_base_phys =
+				fb_base_phys + offset +
+				line_length * temp_ps * crop->left + ctop * temp_ps +
+				(line_length * ( (crop->width/(ps >> 0x1)) - 1) * ps);
+		}
+		break;
+
+	case 180:
+		offset = (image_width - pix->width / (ps >> 0x1)) * ps +
+			(image_height - pix->height) * ps * line_length;
+		if (mirroring == 0) {
+			cropped_base_phys = fb_base_phys + offset +
+			(line_length * ps * ctop) + (cleft/(ps>>1)) * ps;
+		}
+		else {
+			cropped_base_phys =
+				fb_base_phys + offset + (line_length * ps * ctop) +
+				cleft * ps +
+				(line_length * (crop->height - 1) * ps);
+		}
+		break;
+
+	case 270:
+		offset = (image_width - pix->width / (ps >> 0x1)) * ps * line_length;
+		temp_ps = ps/(ps>>1);
+		if (mirroring == 0) {
+			cropped_base_phys = fb_base_phys + offset +
+			line_length * temp_ps * cleft + crop->top * ps;
+		}
+		else {
+			cropped_base_phys =
+			fb_base_phys + offset + line_length * temp_ps * cleft +
+			crop->top * ps +
+			(line_length * ( (crop->width/(ps >> 0x1)) - 1) * ps);
+		}
+		break;
+
+	case 0:
+		if (mirroring == 0) {
+			cropped_base_phys = fb_base_phys
+				+ (line_length * ps) * crop->top + (crop->left/(ps>>1)) * ps;
+		}
+		else {
+			cropped_base_phys =
+				fb_base_phys + (line_length * ps) * crop->top +
+				(crop->left/(ps>>1)) * ps +
+				(line_length * (crop->height - 1) * ps);
+		}
+		break;
+
+	default:
+		if (mirroring == 0) {
+			cropped_base_phys = fb_base_phys
+				+ line_length * ps * crop->top + crop->left * ps;
+		}
+		else {
+			cropped_base_phys = fb_base_phys
+				+ (line_length * ps * crop->top) / (ps >> 1) +
+				(crop->left * ps) / (ps >> 1) +
+				((crop->width / (ps >> 1)) - 1) * ps;
+		}
+		break;
+	}
+
+	/*
+	 * For LCD BA0 and BA1 are same
+	 */
+	layer[ltype].dma[0].ba0 = cropped_base_phys;
+	layer[ltype].dma[0].ba1 = cropped_base_phys;
+
+	/*
+	 * Store BA0 BA1 for TV, BA1 points to the alternate row
+	 */
+	layer[ltype].dma[1].ba0 = cropped_base_phys;
+	layer[ltype].dma[1].ba1 = cropped_base_phys + line_length * ps;
+
+	/* If output path is set to TV */
+	if (omap2_disp_get_output_dev(ltype) == OMAP2_OUTPUT_TV) {
+		dispc_reg_out(DISPC_VID_BA0(v), cropped_base_phys);
+		dispc_reg_out(DISPC_VID_BA1(v),
+			cropped_base_phys + line_length * ps);
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(v),
+			DISPC_VID_ATTRIBUTES_ENABLE,
+			DISPC_VID_ATTRIBUTES_ENABLE);
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+			DISPC_CONTROL_GODIGITAL);
+
+	}
+
+	/* If output path is set to LCD */
+	else {
+		dispc_reg_out(DISPC_VID_BA0(v), cropped_base_phys);
+		dispc_reg_out(DISPC_VID_BA1(v), cropped_base_phys);
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(v),
+			DISPC_VID_ATTRIBUTES_ENABLE,
+			DISPC_VID_ATTRIBUTES_ENABLE);
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+			DISPC_CONTROL_GOLCD);
+
+	}
+
+}
+
+/* Configure VIDEO1 or VIDEO2 layer parameters*/
+void
+omap2_disp_config_vlayer(int ltype, struct v4l2_pix_format *pix,
+			 struct v4l2_rect *crop, struct v4l2_window *win,
+			 int rotation_deg, int mirroring)
+{
+	int vid_position_x, vid_position_y, ps = 2;
+	unsigned long vid_position, vid_size, vid_picture_size;
+	unsigned long vid_attributes;
+	unsigned long firvinc, firhinc;
+	int winheight, winwidth, cropheight, cropwidth, pixheight, pixwidth;
+	int cleft, ctop;
+	int panelwidth, panelheight, row_inc_value=0, pixel_inc_value=0;
+
+	/* color space conversion matrices */
+	const static short int cc_bt601[3][3] =
+		{ {  298,  409,    0 },
+		  {  298, -208, -100 },
+		  {  298,    0,  517 } };
+	const static short int cc_bt709[3][3] =
+		{ {  298,  459,    0 },
+		  {  298, -137,  -55 },
+		  {  298,    0,  541 } };
+	const static short int cc_bt601_full[3][3] =
+		{ {  256,  351,    0 },
+		  {  256, -179,  -86 },
+		  {  256,    0,  443 } };
+	/* vertical resizing matrix */
+	const static short int vc[3][8] =
+		{ {   0,   3,  12,  32,   0,   7,   5,   2 },
+		  { 128, 123, 111,  89,  64,  89, 111, 123 },
+		  {   0,   2,   5,   7,  64,  32,  12,   3 } };
+	/* horizontal resizing matrix */
+	const static short int hc[5][8] =
+		{ {   0,  -1,  -2,  -5,   0,  -2,  -1,   0 },
+		  {   0,  13,  30,  51,  -9, -11, -11,  -8 },
+		  { 128, 124, 112,  95,  73,  95, 112, 124 },
+		  {   0,  -8, -11, -11,  73,  51,  30,  13 },
+		  {   0,   0,  -1,  -2,  -9,  -5,  -2,  -1 } };
+	int v;
+
+	if (ltype == OMAP2_VIDEO1) v = 0;
+	else if (ltype == OMAP2_VIDEO2) v = 1;
+	else return;
+
+	/* make sure the video overlay is disabled before we reconfigure it */
+	omap2_disp_disable_layer(ltype);
+
+	/* configure the video attributes register */
+	vid_attributes = 0;
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_YUYV:
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_YUV2;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE;
+		ps = 2;
+		if (mirroring == 1)
+			ps = 4;
+		if (rotation_deg >= 0) {
+			ps = 4;
+			vid_attributes |= ((rotation_deg / 90) << 12);
+			if (rotation_deg == 90 || rotation_deg == 270)
+				vid_attributes |= 1 << 18;
+			else
+				vid_attributes |= 0 << 18;
+		}
+
+		break;
+	case V4L2_PIX_FMT_UYVY:
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_UYVY;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE;
+		ps = 2;
+		if (mirroring == 1)
+			ps = 4;
+		if (rotation_deg >= 0) {
+			ps = 4;
+			vid_attributes |= ((rotation_deg / 90) << 12);
+			if (rotation_deg == 90 || rotation_deg == 270)
+				vid_attributes |= 1 << 18;
+		}
+		break;
+	case V4L2_PIX_FMT_RGB565:
+	default:
+		ps = 2;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB16;
+		vid_attributes |= ((dispc_reg_in(DISPC_GFX_ATTRIBUTES) &
+				DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE)<< 5);
+		break;
+	case V4L2_PIX_FMT_RGB565X:
+		ps = 2;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB16;
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDENDIANNESS;
+		vid_attributes |= ((dispc_reg_in(DISPC_GFX_ATTRIBUTES) &
+				DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE) << 5);
+		break;
+	}
+
+	if (omap2_disp_get_output_dev(ltype) == OMAP2_OUTPUT_TV)
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDCHANNELOUT;
+
+	vid_attributes |= ((dispc_reg_in(DISPC_GFX_ATTRIBUTES)
+			& DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE) << 8);
+	switch (pix->colorspace) {
+	case V4L2_COLORSPACE_SMPTE170M:
+	case V4L2_COLORSPACE_SMPTE240M:
+	case V4L2_COLORSPACE_BT878:
+	case V4L2_COLORSPACE_470_SYSTEM_M:
+	case V4L2_COLORSPACE_470_SYSTEM_BG:
+		/* luma (Y) range lower limit is 16, BT.601 standard */
+		omap2_disp_set_colorconv(v, cc_bt601);
+		break;
+	case V4L2_COLORSPACE_REC709:
+		/* luma (Y) range lower limit is 16, BT.709 standard */
+		omap2_disp_set_colorconv(v, cc_bt709);
+		break;
+	case V4L2_COLORSPACE_JPEG:
+	case V4L2_COLORSPACE_SRGB:
+		/* full luma (Y) range, assume BT.601 standard */
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDFULLRANGE;
+		omap2_disp_set_colorconv(v, cc_bt601_full);
+		break;
+	}
+
+	if (rotation_deg == 90 || rotation_deg == 270) {
+		winheight = win->w.width;
+		winwidth = win->w.height;
+		cropheight = crop->width;
+		cropwidth = crop->height;
+		pixheight = pix->width;
+		pixwidth = pix->height;
+		cleft = crop->top;
+		ctop = crop->left;
+	} else {
+		winwidth = win->w.width;
+		winheight = win->w.height;
+		cropwidth = crop->width;
+		cropheight = crop->height;
+		pixheight = pix->height;
+		pixwidth = pix->width;
+		ctop = crop->top;
+		cleft = crop->left;
+	}
+
+	if (winwidth != cropwidth) {
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_HRESIZE;
+		if (winwidth < cropwidth)
+			vid_attributes |= DISPC_VID_ATTRIBUTES_VIDHRESIZECONF;
+	}
+	if (winheight != cropheight) {
+		vid_attributes |= DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_VRESIZE;
+		if (winheight < cropheight)
+			vid_attributes |= DISPC_VID_ATTRIBUTES_VIDVRESIZECONF;
+	}
+	dispc_reg_out(DISPC_VID_ATTRIBUTES(v), vid_attributes);
+
+	/* initialize the resizing filter */
+	omap2_disp_set_resize(v, vc, hc);
+
+	dispc_reg_out(DISPC_VID_ACCU0(v), 0);
+	dispc_reg_out(DISPC_VID_ACCU1(v), 0);
+	firhinc = (1024 * (cropwidth - 1)) / (winwidth - 1);
+	if (firhinc < 1)
+		firhinc = 1;
+	else if (firhinc > 2047)
+		firhinc = 2047;
+	firvinc = (1024 * (cropheight - 1)) / (winheight - 1);
+	if (firvinc < 1)
+		firvinc = 1;
+	else if (firvinc > 2047)
+		firvinc = 2047;
+	dispc_reg_out(DISPC_VID_FIR(v), firhinc | (firvinc << 16));
+
+	omap2_disp_get_panel_size(omap2_disp_get_output_dev(ltype), &panelwidth,
+				  &panelheight);
+
+	/* configure the target window on the display */
+	switch (rotation_deg) {
+
+	case 90:
+		vid_position_y = win->w.left;
+		vid_position_x = (panelwidth - win->w.height) - win->w.top;
+		break;
+
+	case 180:
+		vid_position_x = (panelwidth - win->w.width) - win->w.left;
+		vid_position_y = (panelheight - win->w.height) - win->w.top;
+		break;
+
+	case 270:
+		vid_position_y = (panelheight - win->w.width) - win->w.left;
+		vid_position_x = win->w.top;
+		break;
+
+	default:
+		vid_position_x = win->w.left;
+		vid_position_y = win->w.top;
+		break;
+	}
+
+	vid_size = (((winwidth - 1) << DISPC_VID_SIZE_VIDSIZEX_SHIFT)
+			& DISPC_VID_SIZE_VIDSIZEX)
+			| (((winheight - 1) << DISPC_VID_SIZE_VIDSIZEY_SHIFT)
+			& DISPC_VID_SIZE_VIDSIZEY);
+
+	/* configure the source window in the framebuffer */
+	if (omap2_disp_get_output_dev(ltype) == OMAP2_OUTPUT_TV) {
+		vid_picture_size =
+			(((cropwidth -
+			1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+			& DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+			(((cropheight / 2 -
+			1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+			& DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+	}
+
+	else {
+		vid_picture_size =
+		(((cropwidth -
+			1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+			& DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+			(((cropheight -
+			1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+			& DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+	}
+
+	switch (mirroring) {
+	case 0:		/* No mirroring */
+		if (rotation_deg == 90 || rotation_deg == 270) {
+			row_inc_value =
+				1 + (MAX_PIXELS_PER_LINE - pixwidth + 
+				(pixwidth - cropwidth - cleft) + cleft) * ps;
+
+		}
+		else if (rotation_deg == 180 || rotation_deg == 0) {
+			if (V4L2_PIX_FMT_YUYV == pix->pixelformat
+				|| V4L2_PIX_FMT_UYVY == pix->pixelformat)
+				row_inc_value =
+					1 + (MAX_PIXELS_PER_LINE - 
+					(pixwidth/(ps >> 1)) + ((pixwidth - cropwidth - cleft)/(ps >> 1))
+					+ (cleft / (ps >> 1)) ) * ps;
+
+			else
+				row_inc_value =
+					1 + (MAX_PIXELS_PER_LINE - pixwidth +
+					(pixwidth -
+					cropwidth - cleft) + cleft) * ps;
+		} 
+		else {
+			row_inc_value = 1 + (pix->width * ps) - cropwidth * ps;
+		}
+		pixel_inc_value = 1;
+		break;
+
+	case 1:		/* Mirroring */
+		if (rotation_deg == 90 || rotation_deg == 270) {
+			row_inc_value = (-(MAX_PIXELS_PER_LINE + cropwidth) * ps) + 1;
+			pixel_inc_value = 1;
+		} else if (rotation_deg == 180 || rotation_deg == 0) {
+			row_inc_value = (-(MAX_PIXELS_PER_LINE + (cropwidth / (ps >> 1)))
+					 * ps) + 1;
+			pixel_inc_value = 1;
+		} else {
+			row_inc_value =
+				2 * ((cropwidth / (ps >> 1)) -
+				1) * ps + 1 +
+				((pix->width * ps) / (ps >> 1)) -
+				(cropwidth / (ps >> 1)) * ps;
+				pixel_inc_value = (-2 * ps) + 1;
+		}
+		break;
+	}			/* Mirroring Switch */
+
+	/*
+	 * For LCD row inc and pixel inc
+	 */
+
+	layer[ltype].dma[0].row_inc = row_inc_value;
+	layer[ltype].dma[0].pix_inc = pixel_inc_value;
+
+	if (omap2_disp_get_output_dev(ltype) == OMAP2_OUTPUT_LCD) {
+		dispc_reg_out(DISPC_VID_ROW_INC(v), row_inc_value);
+		dispc_reg_out(DISPC_VID_PIXEL_INC(v), pixel_inc_value);
+	}
+
+	else {
+		if (rotation_deg >= 0)
+			row_inc_value = row_inc_value + MAX_PIXELS_PER_LINE * ps;
+		else
+			row_inc_value = row_inc_value + pix->width * ps;
+
+		dispc_reg_out(DISPC_VID_ROW_INC(v), row_inc_value);
+		dispc_reg_out(DISPC_VID_PIXEL_INC(v), pixel_inc_value);
+	}
+
+	/*
+	 * Store BA0 BA1 for TV, BA1 points to the alternate row
+	 */
+	if (rotation_deg >= 0)
+		layer[ltype].dma[1].row_inc = row_inc_value + MAX_PIXELS_PER_LINE * ps;
+	else
+		layer[ltype].dma[1].row_inc = row_inc_value + pix->width * ps;
+
+	layer[ltype].dma[1].pix_inc = pixel_inc_value;
+	layer[ltype].size_x = cropwidth;
+	layer[ltype].size_y = cropheight;
+
+	vid_position = ((vid_position_x << DISPC_VID_POSITION_VIDPOSX_SHIFT)
+			& DISPC_VID_POSITION_VIDPOSX)
+			| ((vid_position_y << DISPC_VID_POSITION_VIDPOSY_SHIFT)
+			& DISPC_VID_POSITION_VIDPOSY);
+	dispc_reg_out(DISPC_VID_POSITION(v), vid_position);
+	dispc_reg_out(DISPC_VID_SIZE(v), vid_size);
+	dispc_reg_out(DISPC_VID_PICTURE_SIZE(v), vid_picture_size);
+}
+
+/*---------------------------------------------------------------------------*/
+
+/* Many display controller registers are shadowed. Setting the GO bit causes
+ * changes to these registers to take effect in hardware.
+ */
+void
+omap2_disp_reg_sync(int output_dev)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD)
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+				DISPC_CONTROL_GOLCD);
+	else
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+				DISPC_CONTROL_GODIGITAL);
+}
+
+/* This function provides the status of the GO bit. After the GO bit is set
+ * through software, register changes take affect at the next VFP (vertical
+ * front porch) or EVSYNC. Per the specs, no further register changes
+ * must be done until the GO bit is reset by hardware. This function allows
+ * drivers to poll the status of the GO bit, and wait until it is reset if they
+ * wish to.
+ */
+int
+omap2_disp_reg_sync_done(int output_dev)
+{
+	u32 control = dispc_reg_in(DISPC_CONTROL);
+
+	if (output_dev == OMAP2_OUTPUT_LCD)
+		return ~(control & DISPC_CONTROL_GOLCD);
+	else
+		return ~(control & DISPC_CONTROL_GODIGITAL);
+}
+
+
+/* Disable the display controller. May be called in interrupt or process
+ * context. However, this function should not be called with interrupts
+ * disabled as jiffies will not increment.
+ */
+void
+omap2_disp_disable(unsigned long timeout_ticks)
+{
+	unsigned long timeout;
+
+	if (dispc_reg_in(DISPC_CONTROL)
+		& (DISPC_CONTROL_DIGITALENABLE | DISPC_CONTROL_LCDENABLE))
+	{
+		/* disable the display controller */
+		dispc_reg_merge(DISPC_CONTROL, 0,
+			DISPC_CONTROL_DIGITALENABLE | DISPC_CONTROL_LCDENABLE);
+
+		/* wait for any frame in progress to complete */
+		dispc_reg_out(DISPC_IRQSTATUS,
+				DISPC_IRQSTATUS_FRAMEDONE);
+		timeout = jiffies + timeout_ticks;
+		while(!(dispc_reg_in(DISPC_IRQSTATUS)
+				& DISPC_IRQSTATUS_FRAMEDONE)
+			&& time_before(jiffies, timeout))
+		{
+			if (!in_interrupt()) {
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(1);
+			} else
+				udelay(100);
+		}
+		if (!(dispc_reg_in(DISPC_IRQSTATUS)
+		      & DISPC_IRQSTATUS_FRAMEDONE)) {
+			printk(KERN_WARNING "timeout waiting for "
+			       "frame-done interrupt\n");
+		}
+	}
+
+	return;
+}
+
+void
+omap2_disp_set_gfx_palette(u32 palette_ba)
+{
+	dispc_reg_out(DISPC_GFX_TABLE_BA, palette_ba);
+	dispc_reg_merge(DISPC_CONFIG, DISPC_CONFIG_LOADMODE_PGTABUSETB,
+			DISPC_CONFIG_LOADMODE_PGTABUSETB);
+}
+
+/* Configure Graphics layer parameters */
+void
+omap2_disp_config_gfxlayer(u32 size_x, u32 size_y, int color_depth)
+{
+	u32 config = 0, irqenable = 0;
+        u32 gfx_attributes = 0, gfx_fifo_threshold = 0, gfx_format = 0;
+	u32 gfx_position = 0, gfx_window_skip = 0;
+
+
+	irqenable = dispc_reg_in(DISPC_IRQENABLE);
+	config = dispc_reg_in(DISPC_CONFIG);
+
+	/* enable vsync interrupts */
+	irqenable |= (DISPC_IRQENABLE_EVSYNC_ODD |
+		      DISPC_IRQENABLE_EVSYNC_EVEN |
+		      DISPC_IRQENABLE_VSYNC);
+
+	config |= (DISPC_CONFIG_LOADMODE_PGTABUSETB |
+		   DISPC_CONFIG_LOADMODE_FRDATLEFR);
+
+	/* This driver doesn't currently support the video windows, so
+	 * we force the palette/gamma table to be a palette table and
+	 * force both video windows to be disabled.
+	 */
+	config &= ~DISPC_CONFIG_PALETTEGAMMATABLE;
+
+	gfx_attributes = DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE_BURST8X32;
+
+	/* enable the graphics window only if its size is not zero */
+	if (size_x > 0 && size_y > 0)
+		gfx_attributes |= DISPC_GFX_ATTRIBUTES_ENABLE;
+
+
+	gfx_fifo_threshold = (252 << DISPC_GFX_FIFO_THRESHOLD_HIGH_SHIFT)
+				  | (192 << DISPC_GFX_FIFO_THRESHOLD_LOW_SHIFT);
+	gfx_position = 0;
+	gfx_window_skip = 0;
+
+	switch(color_depth) {
+		case 1:
+			gfx_format = DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP1;
+			break;
+		case 2:
+			gfx_format = DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP2;
+			break;
+		case 4:
+			gfx_format = DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP4;
+			break;
+		case 8:
+			gfx_format = DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP8;
+			break;
+		case 12:
+			gfx_format = DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB12;
+			break;
+		case 16:
+			gfx_format = DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB16;
+			break;
+		case 24:
+			gfx_format = DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB24;
+			break;
+		default:
+			gfx_format = dispc_reg_in(DISPC_GFX_ATTRIBUTES)
+					& DISPC_GFX_ATTRIBUTES_GFXFORMAT;
+			break;
+	}
+
+	gfx_attributes |= gfx_format;
+
+	dispc_reg_out(DISPC_GFX_FIFO_THRESHOLD, gfx_fifo_threshold);
+	dispc_reg_out(DISPC_GFX_POSITION, gfx_position);
+	dispc_reg_out(DISPC_GFX_WINDOW_SKIP, gfx_window_skip);
+
+	dispc_reg_out(DISPC_IRQENABLE, irqenable);
+	dispc_reg_out(DISPC_CONFIG, config);
+	dispc_reg_out(DISPC_GFX_ATTRIBUTES, gfx_attributes);
+
+	layer[OMAP2_GRAPHICS].size_x = size_x;
+	layer[OMAP2_GRAPHICS].size_y = size_y;
+}
+
+/* Calculate the number of pixels sent to the display per pixel clock as
+ * (nom/den) pixels per clock.
+ */
+void
+omap2_disp_pixels_per_clock(unsigned int *nom, unsigned int *den)
+{
+	u32 dispc_control;
+
+	dispc_control = dispc_reg_in(DISPC_CONTROL);
+
+	if (dispc_control & DISPC_CONTROL_STNTFT) {
+		/* active display (TFT) */
+		if (dispc_control & DISPC_CONTROL_TDMENABLE) {
+			/* TFT with TDM */
+			switch (dispc_control & DISPC_CONTROL_TDMCYCLEFORMAT) {
+				case DISPC_CONTROL_TDMCYCLEFORMAT_1CYCPERPIX:
+					*nom = 1;
+					*den = 1;
+					break;
+				case DISPC_CONTROL_TDMCYCLEFORMAT_2CYCPERPIX:
+					*nom = 1;
+					*den = 2;
+					break;
+				case DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPERPIX:
+					*nom = 1;
+					*den = 3;
+					break;
+				case DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPER2PIX:
+					*nom = 2;
+					*den = 3;
+					break;
+			}
+		}
+		else {
+			/* TFT without TDM */
+			*nom = 1;
+			*den = 1;
+		}
+	}
+	else {
+		/* passive display (STN) */
+		if (dispc_control & DISPC_CONTROL_MONOCOLOR) {
+			/* STN mono */
+			if (dispc_control & DISPC_CONTROL_M8B) {
+				/* 8 pixels per pixclock */
+				*nom = 8;
+				*den = 1;
+			}
+			else {
+				/* 4 pixels per pixclock */
+				*nom = 4;
+				*den = 1;
+			}
+		}
+		else {
+			/* STN color--8 pixels per 3 pixclocks */
+			*nom = 8;
+			*den = 3;
+		}
+	}
+}
+
+/* Configure LCD parameters */
+void
+omap2_disp_config_lcd(u32 clkdiv,
+		      u32 hbp, u32 hfp, u32 hsw,
+		      u32 vbp, u32 vfp, u32 vsw,
+		      u32 hsync_high, u32 vsync_high)
+{
+	u32 control, divisor, timing_h, timing_v, pol_freq = 0;
+
+	divisor = (1 << DISPC_DIVISOR_LCD_SHIFT)
+		       | (clkdiv << DISPC_DIVISOR_PCD_SHIFT);
+
+	if (hbp > 255)
+		hbp = 255;
+        if (hfp > 255)
+		hfp = 255;
+        if (hsw > 63)
+		hsw = 63;
+
+	if (vbp > 255)
+		vbp = 255;
+	if (vfp > 255)
+		vfp = 255;
+	if (vsw > 63)
+		vsw = 63;
+
+	timing_h = (hbp << DISPC_TIMING_H_HBP_SHIFT)
+			| (hfp << DISPC_TIMING_H_HFP_SHIFT)
+			| (hsw << DISPC_TIMING_H_HSW_SHIFT);
+
+	timing_v = (vbp << DISPC_TIMING_V_VBP_SHIFT)
+			| (vfp << DISPC_TIMING_V_VFP_SHIFT)
+			| (vsw << DISPC_TIMING_V_VSW_SHIFT);
+
+	/* set the sync polarity */
+	if (!hsync_high)
+		pol_freq &=  ~DISPC_POL_FREQ_IHS;
+	else
+		pol_freq |=  DISPC_POL_FREQ_IHS;
+
+	if (!vsync_high)
+		pol_freq &= ~DISPC_POL_FREQ_IVS;
+	else
+		pol_freq |=  DISPC_POL_FREQ_IVS;
+
+	dispc_reg_out(DISPC_TIMING_H, timing_h);
+	dispc_reg_out(DISPC_TIMING_V, timing_v);
+	dispc_reg_out(DISPC_POL_FREQ, pol_freq);
+	dispc_reg_out(DISPC_DIVISOR, divisor);
+
+	control = dispc_reg_in(DISPC_CONTROL);
+
+	control |= DISPC_CONTROL_GPOUT1
+		| DISPC_CONTROL_GPOUT0
+		| DISPC_CONTROL_TFTDATALINES_OALSB16B
+		| DISPC_CONTROL_STNTFT;
+
+	dispc_reg_out(DISPC_CONTROL, control);
+}
+
+/* Set the pixel clock divisor for the LCD */
+void
+omap2_disp_set_pcd(u32 pcd)
+{
+	dispc_reg_out(DISPC_DIVISOR, (1 << DISPC_DIVISOR_LCD_SHIFT) |
+				     (pcd << DISPC_DIVISOR_PCD_SHIFT));
+}
+
+
+/* This function must be called by any driver that needs to use the display
+ * controller before calling any routine that accesses the display controller
+ * registers. It increments the count of the number of users of the display
+ * controller, and turns the clocks ON only when required.
+ */
+void
+omap2_disp_get_dss(void)
+{
+	u32 idle;
+
+	spin_lock(dss_lock);
+        if (disp_usage == 0) {
+	 	/* turn on DSS clock */
+		/*omap24xx_ll_config_disp_clocks(0);*/
+
+		/* remove smart idle */
+		idle = dispc_reg_in(DISPC_SYSCONFIG);
+		idle &= ~(DISPC_SYSCONFIG_MIDLEMODE | DISPC_SYSCONFIG_SIDLEMODE);
+		idle |= DISPC_SYSCONFIG_MIDLEMODE_NSTANDBY |
+			DISPC_SYSCONFIG_SIDLEMODE_NIDLE;
+		dispc_reg_out(DISPC_SYSCONFIG, idle);
+	}
+	disp_usage++;
+	spin_unlock(dss_lock);
+}
+
+/* This function must be called by a driver when it not going to use the
+ * display controller anymore. E.g., when a driver suspends, it must call
+ * omap2_disp_put_dss. When it wakes up, it must call omap2_disp_get_dss again.
+ * It decrements the count of the number of users of the display
+ * controller, and turns the clocks OFF when not required.
+ */
+void
+omap2_disp_put_dss(void)
+{
+	u32 idle;
+
+	spin_lock(dss_lock);
+	if (disp_usage == 0) {
+		printk(KERN_ERR "trying to put DSS when usage count is zero\n");
+		spin_unlock(dss_lock);
+		return;
+	}
+
+	disp_usage--;
+
+	if (disp_usage == 0) {
+		/* smart idle on */
+		idle = dispc_reg_in(DISPC_SYSCONFIG);
+		idle &= ~(DISPC_SYSCONFIG_MIDLEMODE | DISPC_SYSCONFIG_SIDLEMODE);
+                idle |= DISPC_SYSCONFIG_MIDLEMODE_SSTANDBY |
+			DISPC_SYSCONFIG_SIDLEMODE_SIDLE;
+		dispc_reg_out(DISPC_SYSCONFIG, idle);
+
+		/* turn off DSS clock */
+		/*omap24xx_ll_config_disp_clocks(1);*/
+	}
+	spin_unlock(dss_lock);
+}
+
+/* This function must be called by any driver that wishes to use a particular
+ * display pipeline (layer).
+ */
+int
+omap2_disp_request_layer(int ltype)
+{
+	int ret = 0;
+
+	spin_lock(dss_lock);
+        if (!layer[ltype].in_use) {
+		layer[ltype].in_use = 1;
+		ret = 1;
+	}
+	spin_unlock(dss_lock);
+
+	return ret;
+}
+
+/* This function must be called by a driver when it is done using a particular
+ * display pipeline (layer).
+ */
+void
+omap2_disp_release_layer(int ltype)
+{
+	spin_lock(dss_lock);
+	layer[ltype].in_use = 0;
+	spin_unlock(dss_lock);
+}
+
+/* Used to enable LCDENABLE or DIGITALENABLE of the display controller.
+ */
+void
+omap2_disp_enable_output_dev(int output_dev)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD) {
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_LCDENABLE,
+				DISPC_CONTROL_LCDENABLE);
+	}
+	else if (output_dev == OMAP2_OUTPUT_TV) {
+                dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_DIGITALENABLE,
+				DISPC_CONTROL_DIGITALENABLE);
+	}
+}
+
+/* Used to disable LCDENABLE or DIGITALENABLE of the display controller.
+ */
+void
+omap2_disp_disable_output_dev(int output_dev)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD) {
+		dispc_reg_merge(DISPC_CONTROL, ~DISPC_CONTROL_LCDENABLE,
+				DISPC_CONTROL_LCDENABLE);
+	}
+	else if (output_dev == OMAP2_OUTPUT_TV) {
+                dispc_reg_merge(DISPC_CONTROL, ~DISPC_CONTROL_DIGITALENABLE,
+				DISPC_CONTROL_DIGITALENABLE);
+	}
+}
+
+
+int
+omap2_disp_get_output_dev(int ltype)
+{
+	return layer[ltype].output_dev;
+}
+
+
+/* This is used to dynamically switch the output of a particular layer to
+ * either the LCD or TV.
+ */
+void
+omap2_disp_set_output_dev(int ltype, int output_dev)
+{
+	struct omap2_disp_dma_params *dma_param = 0;
+	int vid_pic_size = 0;
+	int val = (output_dev == OMAP2_OUTPUT_LCD) ? 0 : ~0;
+
+	layer[ltype].output_dev = output_dev;
+
+	switch(ltype) {
+	case OMAP2_GRAPHICS:
+		if (layer[ltype].in_use) {
+			if (output_dev == OMAP2_OUTPUT_LCD) {
+				int gfx_size = 0;
+				dma_param = &layer[OMAP2_GRAPHICS].dma[0];
+
+				gfx_size = (((layer[OMAP2_GRAPHICS].size_x - 1)
+						<< DISPC_GFX_SIZE_GFXSIZEX_SHIFT)
+					      & DISPC_GFX_SIZE_GFXSIZEX)
+					   | (((layer[OMAP2_GRAPHICS].size_y - 1)
+						<< DISPC_GFX_SIZE_GFXSIZEY_SHIFT)
+					      & DISPC_GFX_SIZE_GFXSIZEY);
+				dispc_reg_out(DISPC_GFX_SIZE, gfx_size);
+			}
+			else if (output_dev == OMAP2_OUTPUT_TV) {
+				int gfx_size = 0;
+				dma_param = &layer[OMAP2_GRAPHICS].dma[1];
+				/* dividing the size_y by two,
+				 * because TV operates in interleaved mode
+				 */
+				gfx_size = (((layer[OMAP2_GRAPHICS].size_x - 1)
+						<< DISPC_GFX_SIZE_GFXSIZEX_SHIFT)
+					      & DISPC_GFX_SIZE_GFXSIZEX)
+					   | (((layer[OMAP2_GRAPHICS].size_y/2 - 1)
+						<< DISPC_GFX_SIZE_GFXSIZEY_SHIFT)
+					      & DISPC_GFX_SIZE_GFXSIZEY);
+				dispc_reg_out(DISPC_GFX_SIZE, gfx_size);
+			}
+
+			dispc_reg_out(DISPC_GFX_BA0, dma_param->ba0);
+			dispc_reg_out(DISPC_GFX_BA1, dma_param->ba1);
+			dispc_reg_out(DISPC_GFX_ROW_INC, dma_param->row_inc);
+			dispc_reg_out(DISPC_GFX_PIXEL_INC, dma_param->pix_inc);
+		}
+		dispc_reg_merge(DISPC_GFX_ATTRIBUTES,
+				DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT & val,
+				DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT);
+
+		break;
+
+	case OMAP2_VIDEO1:
+		if (!layer[ltype].in_use){
+			if (output_dev == OMAP2_OUTPUT_LCD) {
+				dma_param = &layer[OMAP2_VIDEO1].dma[0];
+				vid_pic_size =
+					(((layer[OMAP2_VIDEO1].size_x -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO1].size_y -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(0), vid_pic_size);
+
+			} else if (output_dev == OMAP2_OUTPUT_TV) {
+				dma_param = &layer[OMAP2_VIDEO1].dma[1];
+				vid_pic_size =
+					(((layer[OMAP2_VIDEO1].size_x -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO1].size_y / 2 -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(0), vid_pic_size);
+			}
+
+			dispc_reg_out(DISPC_VID_BA0(0), dma_param->ba0);
+			dispc_reg_out(DISPC_VID_BA1(0), dma_param->ba1);
+			dispc_reg_out(DISPC_VID_ROW_INC(0), dma_param->row_inc);
+			dispc_reg_out(DISPC_VID_PIXEL_INC(0), dma_param->pix_inc);
+		}
+		
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(0),
+				DISPC_VID_ATTRIBUTES_VIDCHANNELOUT & val,
+				DISPC_VID_ATTRIBUTES_VIDCHANNELOUT);
+
+		break;
+	case OMAP2_VIDEO2:
+		if (!layer[ltype].in_use){
+			if (output_dev == OMAP2_OUTPUT_LCD) {
+				dma_param = &layer[OMAP2_VIDEO2].dma[0];
+				vid_pic_size =
+					(((layer[OMAP2_VIDEO2].size_x -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO2].size_y -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(1), vid_pic_size);
+
+			} else if (output_dev == OMAP2_OUTPUT_TV) {
+				dma_param = &layer[OMAP2_VIDEO2].dma[1];
+				vid_pic_size =
+					(((layer[OMAP2_VIDEO2].size_x -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO2].size_y / 2 -
+					1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					& DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(1), vid_pic_size);
+
+			}
+
+			dispc_reg_out(DISPC_VID_BA0(1), dma_param->ba0);
+			dispc_reg_out(DISPC_VID_BA1(1), dma_param->ba1);
+			dispc_reg_out(DISPC_VID_ROW_INC(1), dma_param->row_inc);
+			dispc_reg_out(DISPC_VID_PIXEL_INC(1), dma_param->pix_inc);
+		}
+
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(1),
+				DISPC_VID_ATTRIBUTES_VIDCHANNELOUT & val,
+				DISPC_VID_ATTRIBUTES_VIDCHANNELOUT);
+		break;
+	}
+
+	if (layer[ltype].in_use)
+		omap2_disp_reg_sync(output_dev);
+}
+
+/* Used to save the DMA parameter settings for a particular layer to be
+ * displayed on a particular output device. These values help the
+ * omap2_disp_set_output_dev() function to dynamically switch the output of a
+ * layer to any output device.
+ */
+void
+omap2_disp_set_dma_params(int ltype, int output_dev,
+			  u32 ba0, u32 ba1, u32 row_inc, u32 pix_inc)
+{
+        struct omap2_disp_dma_params *dma;
+
+	if (output_dev == OMAP2_OUTPUT_LCD)
+		dma = &layer[ltype].dma[0];
+	else
+		dma = &layer[ltype].dma[1];
+
+	dma->ba0 = ba0;
+	dma->ba1 = ba1;
+	dma->row_inc = row_inc;
+	dma->pix_inc = pix_inc;
+}
+
+void
+omap2_disp_start_gfxlayer(void)
+{
+	omap2_disp_set_output_dev(OMAP2_GRAPHICS, layer[OMAP2_GRAPHICS].output_dev);
+}
+
+/*---------------------------------------------------------------------------*/
+
+/* Sets the background color */
+void
+omap2_disp_set_bg_color(int output_dev, int color)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD)
+		dispc_reg_out(DISPC_DEFAULT_COLOR0, color);
+	else if (output_dev == OMAP2_OUTPUT_TV)
+		dispc_reg_out(DISPC_DEFAULT_COLOR1, color);
+
+	omap2_disp_reg_sync(output_dev);
+}
+
+/* Returns the current background color */
+void
+omap2_disp_get_bg_color(int output_dev, int *color)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD)
+		*color = dispc_reg_in(DISPC_DEFAULT_COLOR0);
+	else if (output_dev == OMAP2_OUTPUT_TV)
+		*color = dispc_reg_in(DISPC_DEFAULT_COLOR1);
+}
+
+static inline u32
+pages_per_side(u32 img_side, u32 page_exp)
+{
+	/* page_side = 2 ^ page_exp
+	 * (page_side - 1) is added for rounding up
+	 */
+	return (u32) (img_side + (1<<page_exp) - 1) >> page_exp;
+}
+
+/* Sets the SMS settings for rotation using the VRFB.
+ */
+int
+omap2_disp_set_vrfb(int context, u32 phy_addr,
+			u32 width, u32 height, u32 bytes_per_pixel)
+{
+	int page_width_exp, page_height_exp, pixel_size_exp;
+
+	if (bytes_per_pixel > 4)
+		return -EINVAL;
+
+	page_width_exp = PAGE_WIDTH_EXP;
+	page_height_exp = PAGE_HEIGHT_EXP;
+	pixel_size_exp = bytes_per_pixel >> 1;
+
+	width = ((1<<page_width_exp) *
+		 (pages_per_side(width * bytes_per_pixel, page_width_exp))
+		) >> pixel_size_exp;	// in pixels
+
+	height = (1<<page_height_exp) *
+		 (pages_per_side(height, page_height_exp));
+
+	SMS_ROT0_PHYSICAL_BA(context) = phy_addr;
+	SMS_ROT0_SIZE(context) = 0;
+	SMS_ROT0_SIZE(context)	|= (width << SMS_IMAGEWIDTH_OFFSET)
+				| (height << SMS_IMAGEHEIGHT_OFFSET);
+	SMS_ROT_CONTROL(context) = 0;
+	SMS_ROT_CONTROL(context) |= pixel_size_exp << SMS_PS_OFFSET
+			| (page_width_exp - pixel_size_exp) << SMS_PW_OFFSET
+			| page_height_exp << SMS_PH_OFFSET;
+
+	return 0;
+}
+
+/* Sets VENC registers for TV operation.
+*/
+static void
+config_venc(struct tv_standard_config *tvstd)
+{
+	venc_reg_out(VENC_F_CONTROL, F_CONTROL_GEN);
+	venc_reg_out(VENC_SYNC_CONTROL,SYNC_CONTROL_GEN);
+	venc_reg_out(VENC_LLEN, tvstd->venc_llen);
+	venc_reg_out(VENC_FLENS, tvstd->venc_flens);
+	venc_reg_out(VENC_HFLTR_CTRL, tvstd->venc_hfltr_ctrl);
+	venc_reg_out(VENC_CC_CARR_WSS_CARR, tvstd->venc_cc_carr_wss_carr);
+	venc_reg_out(VENC_C_PHASE, tvstd->venc_c_phase);
+	venc_reg_out(VENC_GAIN_U, tvstd->venc_gain_u);
+	venc_reg_out(VENC_GAIN_V, tvstd->venc_gain_v);
+	venc_reg_out(VENC_GAIN_Y, tvstd->venc_gain_y);
+	venc_reg_out(VENC_BLACK_LEVEL, tvstd->venc_black_level);
+	venc_reg_out(VENC_BLANK_LEVEL, tvstd->venc_blank_level);
+	venc_reg_out(VENC_X_COLOR, tvstd->venc_x_color);
+	venc_reg_out(VENC_M_CONTROL, tvstd->venc_m_control);
+	venc_reg_out(VENC_BSTAMP_WSS_DATA, tvstd->venc_bstamp_wss_data);
+	venc_reg_out(VENC_S_CARR, tvstd->venc_s_carr);
+	venc_reg_out(VENC_LINE21, tvstd->venc_line21);
+	venc_reg_out(VENC_LN_SEL, tvstd->venc_ln_sel);
+	venc_reg_out(VENC_L21_WC_CTL, tvstd->venc_l21_wc_ctl);
+	venc_reg_out(VENC_HTRIGGER_VTRIGGER, tvstd->venc_htrigger_vtrigger);
+	venc_reg_out(VENC_SAVID_EAVID, tvstd->venc_savid_eavid);
+	venc_reg_out(VENC_FLEN_FAL, tvstd->venc_flen_fal);
+	venc_reg_out(VENC_LAL_PHASE_RESET, tvstd->venc_lal_phase_reset);
+	venc_reg_out(VENC_HS_INT_START_STOP_X,
+			tvstd->venc_hs_int_start_stop_x);
+	venc_reg_out(VENC_HS_EXT_START_STOP_X,
+			tvstd->venc_hs_ext_start_stop_x);
+	venc_reg_out(VENC_VS_INT_START_X, tvstd->venc_vs_int_start_x);
+	venc_reg_out(VENC_VS_INT_STOP_X_VS_INT_START_Y,
+			tvstd-> venc_vs_int_stop_x_vs_int_start_y);
+	venc_reg_out(VENC_VS_INT_STOP_Y_VS_EXT_START_X,
+			tvstd->venc_vs_int_stop_y_vs_ext_start_x);
+	venc_reg_out(VENC_VS_EXT_STOP_X_VS_EXT_START_Y,
+			tvstd->venc_vs_ext_stop_x_vs_ext_start_y);
+	venc_reg_out(VENC_VS_EXT_STOP_Y, tvstd->venc_vs_ext_stop_y);
+	venc_reg_out(VENC_AVID_START_STOP_X, tvstd->venc_avid_start_stop_x);
+	venc_reg_out(VENC_AVID_START_STOP_Y, tvstd->venc_avid_start_stop_y);
+	venc_reg_out(VENC_FID_INT_START_X_FID_INT_START_Y,
+			tvstd-> venc_fid_int_start_x_fid_int_start_y);
+	venc_reg_out(VENC_FID_INT_OFFSET_Y_FID_EXT_START_X,
+			tvstd->venc_fid_int_offset_y_fid_ext_start_x);
+	venc_reg_out(VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y,
+			tvstd->venc_fid_ext_start_y_fid_ext_offset_y);
+	venc_reg_out(VENC_TVDETGP_INT_START_STOP_X,
+			tvstd->venc_tvdetgp_int_start_stop_x);
+	venc_reg_out(VENC_TVDETGP_INT_START_STOP_Y,
+			tvstd->venc_tvdetgp_int_start_stop_y);
+	venc_reg_out(VENC_GEN_CTRL, tvstd->venc_gen_ctrl);
+	venc_reg_out(VENC_DAC_TST, tvstd->venc_dac_tst);
+
+	/* its necessary to write to the VENC_DAC register */
+	venc_reg_out(VENC_DAC, venc_reg_in(VENC_DAC));
+}
+
+int
+omap2_disp_get_tvstandard(void)
+{
+	return(omap2_current_tvstandard);
+}
+
+void
+omap2_disp_set_tvstandard(int tvstandard)
+{
+	omap2_current_tvstandard = tvstandard;
+	switch (tvstandard) {
+	case PAL_BDGHI:
+		config_venc(&pal_bdghi_cfg);
+		break;
+	case PAL_NC:
+		config_venc(&pal_nc_cfg);
+		break;
+	case PAL_N:
+		config_venc(&pal_n_cfg);
+		break;
+	case PAL_M:
+		config_venc(&pal_m_cfg);
+		break;
+	case PAL_60:
+		config_venc(&pal_60_cfg);
+		break;
+	case NTSC_M:
+		config_venc(&ntsc_m_cfg);
+		break;
+	case NTSC_J:
+		config_venc(&ntsc_j_cfg);
+		break;
+	case NTSC_443:
+		config_venc(&ntsc_443_cfg);
+		break;
+	}
+}
+
+/* Sets the transparency color key type and value.
+*/
+void
+omap2_disp_set_colorkey(int output_dev, int key_type, int key_val)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD) {
+		if (key_type == OMAP2_VIDEO_SOURCE)
+			dispc_reg_merge(DISPC_CONFIG, DISPC_CONFIG_TCKLCDSELECTION,
+				DISPC_CONFIG_TCKLCDSELECTION);
+		else
+			dispc_reg_merge(DISPC_CONFIG, 0,
+				DISPC_CONFIG_TCKLCDSELECTION);
+		dispc_reg_out(DISPC_TRANS_COLOR0, key_val);
+	}
+	else if (output_dev == OMAP2_OUTPUT_TV) {
+		if (key_type == OMAP2_VIDEO_SOURCE)
+			dispc_reg_merge(DISPC_CONFIG, DISPC_CONFIG_TCKDIGSELECTION,
+				DISPC_CONFIG_TCKDIGSELECTION);
+		else
+			dispc_reg_merge(DISPC_CONFIG, 0,
+				DISPC_CONFIG_TCKDIGSELECTION);
+		dispc_reg_out(DISPC_TRANS_COLOR1, key_val);
+	}
+	
+	omap2_disp_reg_sync(output_dev);
+}
+
+/* Returns the current transparency color key type and value.
+*/
+void
+omap2_disp_get_colorkey(int output_dev, int *key_type, int *key_val)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD) {
+		if (dispc_reg_in(DISPC_CONFIG) & DISPC_CONFIG_TCKLCDSELECTION)
+			*key_type = OMAP2_VIDEO_SOURCE;
+		else
+			*key_type = OMAP2_GFX_DESTINATION;
+		*key_val = dispc_reg_in(DISPC_TRANS_COLOR0);
+	}
+	else if (output_dev == OMAP2_OUTPUT_TV) {
+		if (dispc_reg_in(DISPC_CONFIG) & DISPC_CONFIG_TCKDIGSELECTION)
+			*key_type = OMAP2_VIDEO_SOURCE;
+		else
+			*key_type = OMAP2_GFX_DESTINATION;
+		*key_val = dispc_reg_in(DISPC_TRANS_COLOR1);
+	}
+}
+
+void
+omap2_disp_enable_colorkey(int output_dev)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD)
+		dispc_reg_merge(DISPC_CONFIG, DISPC_CONFIG_TCKLCDENABLE,
+				DISPC_CONFIG_TCKLCDENABLE);
+	else if (output_dev == OMAP2_OUTPUT_TV)
+		dispc_reg_merge(DISPC_CONFIG, DISPC_CONFIG_TCKDIGENABLE,
+				DISPC_CONFIG_TCKDIGENABLE);
+	
+	omap2_disp_reg_sync(output_dev);
+}
+
+void
+omap2_disp_disable_colorkey(int output_dev)
+{
+	if (output_dev == OMAP2_OUTPUT_LCD)
+		dispc_reg_merge(DISPC_CONFIG, ~DISPC_CONFIG_TCKLCDENABLE,
+				DISPC_CONFIG_TCKLCDENABLE);
+	else if (output_dev == OMAP2_OUTPUT_TV)
+		dispc_reg_merge(DISPC_CONFIG, ~DISPC_CONFIG_TCKDIGENABLE,
+				DISPC_CONFIG_TCKDIGENABLE);
+	
+	omap2_disp_reg_sync(output_dev);
+}
+
+/* Display controller interrupts are handled first by this display library.
+ * Drivers that need to use certain interrupts should register their ISRs and
+ * interrupt enable mask with the display library.
+ */
+int
+omap2_disp_register_isr(omap2_disp_isr_t isr, void *arg, unsigned int mask)
+{
+	int i;
+        unsigned long flags;
+
+	if (omap2_disp_irq == 0 || isr == 0 || arg == 0 || mask == 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dss_lock, flags);
+	for (i = 0; i < MAX_ISR_NR; i++) {
+		if (registered_isr[i].isr == NULL) {
+			registered_isr[i].isr = isr;
+			registered_isr[i].arg = arg;
+			registered_isr[i].mask = mask;
+			spin_unlock_irqrestore(&dss_lock, flags);
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&dss_lock, flags);
+	return -EBUSY;
+}
+
+int
+omap2_disp_unregister_isr(omap2_disp_isr_t isr)
+{
+	int i;
+        unsigned long flags;
+
+	if (omap2_disp_irq == 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dss_lock, flags);
+	for (i = 0; i < MAX_ISR_NR; i++) {
+		if (registered_isr[i].isr == isr) {
+			registered_isr[i].isr = NULL;
+			registered_isr[i].arg = NULL;
+			registered_isr[i].mask = 0;
+			spin_unlock_irqrestore(&dss_lock, flags);
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&dss_lock, flags);
+	return -EINVAL;
+}
+
+/* DSS Interrupt master service routine. */
+static void
+omap2_disp_master_isr(int irq, void *arg, struct pt_regs *regs)
+{
+	unsigned long dispc_irqstatus = dispc_reg_in(DISPC_IRQSTATUS);
+	int i;
+
+	/* ack the interrupt */
+	dispc_reg_out(DISPC_IRQSTATUS, dispc_irqstatus);
+
+	for (i = 0; i < MAX_ISR_NR; i++) {
+		if (registered_isr[i].isr == NULL)
+			continue;
+		if (registered_isr[i].mask & dispc_irqstatus)
+			registered_isr[i].isr(registered_isr[i].arg, regs);
+	}
+}
+
+int __init
+omap2_disp_init(void)
+{
+	int rev;
+	u32 timeout;
+	u32 dss_control;
+
+#if 0 /* Done by FB driver */
+	/* disable the display controller */
+	omap2_disp_disable(HZ/5);
+
+	/* reset the display controller */
+	dispc_reg_out(DISPC_SYSCONFIG, DISPC_SYSCONFIG_SOFTRESET);
+	/* wait for reset to complete */
+	timeout = jiffies + HZ/5;
+	while (!(dispc_reg_in(DISPC_SYSSTATUS)
+			& DISPC_SYSSTATUS_RESETDONE)
+		&& time_before(jiffies, timeout))
+	{
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
+	}
+
+	if (!(dispc_reg_in(DISPC_SYSSTATUS) & DISPC_SYSSTATUS_RESETDONE))
+	{
+		printk(KERN_WARNING
+		       "omap2_disp: timeout waiting for display controller reset\n");
+	}
+	/* remove the reset */
+	dispc_reg_merge(DISPC_SYSCONFIG, 0, DISPC_SYSCONFIG_SOFTRESET);
+#endif
+
+	rev = dss_reg_in(DSS_REVISION);
+	printk(KERN_INFO "OMAP Display hardware version %d.%d\n",
+	       (rev & DISPC_REVISION_MAJOR) >> DISPC_REVISION_MAJOR_SHIFT,
+	       (rev & DISPC_REVISION_MINOR) >> DISPC_REVISION_MINOR_SHIFT);
+
+	/* Disable RFBI mode, which is not currently supported. */
+	dispc_reg_merge(DISPC_CONTROL, 0, DISPC_CONTROL_RFBIMODE);
+
+	/* enable DAC_DEMEN and VENC_4X_CLOCK in DSS for TV operation */
+	dss_control = dss_reg_in(DSS_CONTROL);
+	dss_control |= (DSS_CONTROL_DAC_DEMEN |
+			DSS_CONTROL_VENC_CLOCK_4X_ENABLE);
+	dss_control &= ~DSS_CONTROL_VENC_CLOCK_MODE;
+	dss_reg_out(DSS_CONTROL, dss_control);
+
+	/* By default, all layers go to LCD */
+	layer[OMAP2_GRAPHICS].output_dev = OMAP2_OUTPUT_LCD;
+	layer[OMAP2_VIDEO1].output_dev = OMAP2_OUTPUT_LCD;
+	layer[OMAP2_VIDEO2].output_dev = OMAP2_OUTPUT_LCD;
+
+	/* Set the default background color to be blue */
+	omap2_disp_set_bg_color(OMAP2_OUTPUT_LCD, 0x0000FF);
+	omap2_disp_set_bg_color(OMAP2_OUTPUT_TV, 0x0000FF);
+
+#if 0
+	if (request_irq(INT_24XX_DSS_IRQ, omap2_disp_master_isr, SA_SHIRQ,
+			"OMAP2 Display", registered_isr))
+	{
+		printk(KERN_WARNING "omap2_disp: request_irq failed\n");
+		omap2_disp_irq = 0;
+	}
+#endif
+	omap2_disp_irq = 1;
+	spin_lock_init(&dss_lock);
+
+	return 0;
+
+}
+__initcall(omap2_disp_init);
+
+
+EXPORT_SYMBOL(omap2_disp_request_layer);
+EXPORT_SYMBOL(omap2_disp_release_layer);
+EXPORT_SYMBOL(omap2_disp_disable_layer);
+EXPORT_SYMBOL(omap2_disp_enable_layer);
+EXPORT_SYMBOL(omap2_disp_config_vlayer);
+EXPORT_SYMBOL(omap2_disp_config_gfxlayer);
+EXPORT_SYMBOL(omap2_disp_start_vlayer);
+EXPORT_SYMBOL(omap2_disp_start_gfxlayer);
+
+EXPORT_SYMBOL(omap2_disp_set_bg_color);
+EXPORT_SYMBOL(omap2_disp_get_bg_color);
+EXPORT_SYMBOL(omap2_disp_get_panel_size);
+EXPORT_SYMBOL(omap2_disp_set_panel_size);
+EXPORT_SYMBOL(omap2_disp_disable_output_dev);
+EXPORT_SYMBOL(omap2_disp_enable_output_dev);
+EXPORT_SYMBOL(omap2_disp_set_tvstandard);
+EXPORT_SYMBOL(omap2_disp_get_tvstandard);
+EXPORT_SYMBOL(omap2_disp_config_lcd);
+EXPORT_SYMBOL(omap2_disp_set_pcd);
+
+EXPORT_SYMBOL(omap2_disp_set_dma_params);
+EXPORT_SYMBOL(omap2_disp_get_output_dev);
+EXPORT_SYMBOL(omap2_disp_set_output_dev);
+
+EXPORT_SYMBOL(omap2_disp_get_dss);
+EXPORT_SYMBOL(omap2_disp_put_dss);
+
+EXPORT_SYMBOL(omap2_disp_set_colorkey);
+EXPORT_SYMBOL(omap2_disp_get_colorkey);
+EXPORT_SYMBOL(omap2_disp_enable_colorkey);
+EXPORT_SYMBOL(omap2_disp_disable_colorkey);
+
+EXPORT_SYMBOL(omap2_disp_set_gfx_palette);
+EXPORT_SYMBOL(omap2_disp_pixels_per_clock);
+
+EXPORT_SYMBOL(omap2_disp_set_vrfb);
+
+EXPORT_SYMBOL(omap2_disp_reg_sync);
+EXPORT_SYMBOL(omap2_disp_reg_sync_done);
+EXPORT_SYMBOL(omap2_disp_disable);
+
+EXPORT_SYMBOL(omap2_disp_register_isr);
+EXPORT_SYMBOL(omap2_disp_unregister_isr);
+
diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index febce33..ec2e012 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -55,7 +55,7 @@ obj-$(CONFIG_VIDEO_BTCX)  += btcx-risc.o
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
 	
@@ -10,3 +14,9 @@ config VIDEO_CAMERA_SENSOR_OV9640
 	depends on VIDEO_OMAP_CAMERA
 	help
 	  OmniVision 9640 camera sensor support
+
+config VIDEO_OMAP2_OUT
+	tristate "OMAP2 TV/LCD Video Out support"
+	depends on VIDEO_OMAP && ARCH_OMAP2
+	help
+	  OMAP2 TV/LCD Video Out support
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index c4c5a81..532b779 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -2,12 +2,15 @@
 
 obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
 obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
+obj-$(CONFIG_VIDEO_OMAP2_OUT) += omapvout.o
 
-objs-yy := camera_core.o
+objs-y$(CONFIG_ARCH_OMAP16XX) += camera_core.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o
 objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
+objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_MACH_OMAP_H4) += omap24xxvout.o omap24xxlib.o
 
 omapcamera-objs := $(objs-yy)
+omapvout-objs := $(objs-yy)
 
 EXTRA_CFLAGS = -I$(src)/..
diff --git a/drivers/media/video/omap/omap24xxlib.c b/drivers/media/video/omap/omap24xxlib.c
new file mode 100644
index 0000000..ab5e2cb
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
+#include "display.h"
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
diff --git a/drivers/media/video/omap/omap24xxvout.c b/drivers/media/video/omap/omap24xxvout.c
new file mode 100644
index 0000000..abe8044
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxvout.c
@@ -0,0 +1,1568 @@
+/*
+ * drivers/media/video/omap/omap24xxvout.c
+ *
+ * Copyright (C) 2005 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * Leveraged code from the OMAP2 camera driver
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
+#include <linux/module.h>
+#include <linux/version.h>
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
+#include <linux/dma-mapping.h>
+#include <media/video-buf.h>
+#include <linux/input.h>
+
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+#include <asm/processor.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/display.h>
+
+#include "omap24xxlib.h"
+
+/*
+ * Un-comment this to use Debug Write call
+ */
+#define DEBUG_ALLOW_WRITE 
+
+#include "omap24xxvout.h"
+
+extern const char *global_mode_option;
+
+/* 
+ * Uncomment this if debugging support needs to be enabled
+ */
+
+/* #define DEBUG */
+
+#undef DEBUG
+#ifdef DEBUG
+#define DPRINTK(ARGS...)  printk("<%s>: ",__FUNCTION__);printk(ARGS)
+#else
+#define DPRINTK( x... )
+#endif
+
+/* 
+ * -1 means rotation support is disabled
+ * 0/90/180/270 are initial rotation angles 
+ */
+
+static int rotation_support = -1;
+
+/* configuration macros */
+#define VOUT_NAME		"omap24xxvout"
+#define V1OUT_NAME		"omap24xxvideo1"
+#define V2OUT_NAME		"omap24xxvideo2"
+
+#define VGA_WIDTH		640
+#define VGA_HEIGHT		480
+#define QQVGA_WIDTH		160
+#define QQVGA_HEIGHT		120
+#define BYTESPERPIXEL		2
+#define DMA_CHAN_ALLOTED	1
+#define DMA_CHAN_NOT_ALLOTED	0
+#define NUM_OF_VIDEO_CHANNELS	2
+#define VRF_SIZE		MAX_PIXELS_PER_LINE * MAX_LINES * 4
+#define SMS_RGB_PIXSIZE		2
+#define SMS_YUYV_PIXSIZE	4
+#define VRFB_TX_TIMEOUT		1000
+
+static struct omap24xxvout_device *saved_v1out, *saved_v2out;
+
+/* 
+ * this is the layer being linked to (slave layer). possible values are:
+ * OMAP2_VIDEO1:  V1 is linked to V2. V1 uses V2's pix and crop.
+ * OMAP2_VIDEO2:  V2 is linked to V1. V2 uses V1's pix and crop.
+ * -1: no link.
+ */
+
+static int vout_linked;
+static spinlock_t vout_link_lock;
+
+/* module parameters */
+
+/* 
+ * Maximum amount of memory to use for rendering buffers.
+ * Default is enough to double-buffer VGA. 
+ */
+
+static int render_mem = VGA_WIDTH * VGA_HEIGHT * SMS_YUYV_PIXSIZE;
+
+/* list of image formats supported by OMAP2 video pipelines */
+const static struct v4l2_fmtdesc omap2_formats[] = {
+{
+	/* Note:  V4L2 defines RGB565 as:
+	 *
+	 *      Byte 0                    Byte 1
+	 *      g2 g1 g0 r4 r3 r2 r1 r0   b4 b3 b2 b1 b0 g5 g4 g3
+	 *
+	 * We interpret RGB565 as:
+	 *
+	 *      Byte 0                    Byte 1
+	 *      g2 g1 g0 b4 b3 b2 b1 b0   r4 r3 r2 r1 r0 g5 g4 g3
+	 */
+	.description = "RGB565, le",
+	.pixelformat = V4L2_PIX_FMT_RGB565,
+},
+{
+	/* Note:  V4L2 defines RGB565X as:
+	 *
+	 *      Byte 0                    Byte 1
+	 *      b4 b3 b2 b1 b0 g5 g4 g3   g2 g1 g0 r4 r3 r2 r1 r0
+	 *
+	 * We interpret RGB565X as:
+	 *
+	 *      Byte 0                    Byte 1
+	 *      r4 r3 r2 r1 r0 g5 g4 g3   g2 g1 g0 b4 b3 b2 b1 b0
+	 */
+	.description = "RGB565, be",
+	.pixelformat = V4L2_PIX_FMT_RGB565X,
+},
+{
+	.description = "YUYV (YUV 4:2:2), packed",
+	.pixelformat = V4L2_PIX_FMT_YUYV,
+},
+{
+	.description = "UYVY, packed",
+	.pixelformat = V4L2_PIX_FMT_UYVY,
+},
+};
+
+#define NUM_OUTPUT_FORMATS (sizeof(omap2_formats)/sizeof(omap2_formats[0]))
+
+/* -------------------------------------------------------------------------- */
+
+static void
+try_format (struct v4l2_pix_format *pix)
+{
+	int ifmt;
+
+	if (pix->width > VGA_WIDTH)
+		pix->width = VGA_WIDTH;
+	if (pix->height > VGA_HEIGHT)
+		pix->height = VGA_HEIGHT;
+
+	for (ifmt = 0; ifmt < NUM_OUTPUT_FORMATS; ifmt++){
+		if (pix->pixelformat == omap2_formats[ifmt].pixelformat)
+			break;
+	}
+
+	if (ifmt == NUM_OUTPUT_FORMATS)
+		ifmt = 0;
+
+	pix->pixelformat = omap2_formats[ifmt].pixelformat;
+	pix->field = V4L2_FIELD_NONE;
+	pix->bytesperline = pix->width * BYTESPERPIXEL;
+	pix->sizeimage = pix->bytesperline * pix->height;
+	pix->priv = 0;
+
+	switch (pix->pixelformat){
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+	default:
+		pix->colorspace = V4L2_COLORSPACE_JPEG;
+	break;
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_RGB565X:
+		pix->colorspace = V4L2_COLORSPACE_SRGB;
+	break;
+	}
+}
+
+static void
+vrfb_dma_tx_callback (int lch, u16 ch_status, void *data)
+{
+	struct vid_vrfb_dma *t = (struct vid_vrfb_dma *) data;
+	t->tx_status = 1;
+	wake_up_interruptible (&t->wait);
+}
+
+static void
+omap24xxvout_sync (struct omap24xxvout_device *dest,
+		   struct omap24xxvout_device *src)
+{
+	/* 
+	 * once linked, dest shares src's framebuffer, pix and crop 
+	 */
+
+	dest->pix = src->pix;
+	dest->crop = src->crop;
+
+	if (src->streaming)
+		omap2_disp_config_vlayer (dest->vid, &dest->pix, &dest->crop, &dest->win,
+			dest->rotation, dest->mirror);
+}
+
+static int
+omap24xxvout_do_ioctl (struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
+{
+	struct omap24xxvout_fh *fh = (struct omap24xxvout_fh *)file->private_data;
+	struct omap24xxvout_device *vout = fh->vout;
+	int err;
+
+	switch (cmd){
+	case VIDIOC_ENUMOUTPUT:
+	{
+		struct v4l2_output *output = (struct v4l2_output *) arg;
+		int index = output->index;
+
+		if (index > 0)
+			return -EINVAL;
+
+		memset (output, 0, sizeof (*output));
+		output->index = index;
+
+		strncpy (output->name, "video out", sizeof (output->name));
+		output->type = V4L2_OUTPUT_TYPE_MODULATOR;
+		return 0;
+	}
+
+	case VIDIOC_G_OUTPUT:
+	{
+		unsigned int *output = arg;
+		*output = 0;
+		return 0;
+	}
+
+	case VIDIOC_S_OUTPUT:
+	{
+		unsigned int *output = arg;
+
+		if (*output > 0)
+			return -EINVAL;
+		return 0;
+	}
+
+	case VIDIOC_QUERYCAP:
+	{
+		struct v4l2_capability *cap = (struct v4l2_capability *) arg;
+		memset (cap, 0, sizeof (*cap));
+		strncpy (cap->driver, VOUT_NAME, sizeof (cap->driver));
+		strncpy (cap->card, vout->vfd->name, sizeof (cap->card));
+		cap->bus_info[0] = '\0';
+		cap->version = KERNEL_VERSION (2,4,20);
+		cap->capabilities = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_OUTPUT;
+		return 0;
+	}
+	case VIDIOC_ENUM_FMT:
+	{
+		struct v4l2_fmtdesc *fmt = arg;
+		int index = fmt->index;
+		enum v4l2_buf_type type = fmt->type;
+		memset (fmt, 0, sizeof (*fmt));
+		fmt->index = index;
+		fmt->type = type;
+
+		switch (fmt->type){
+			case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+	  		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+			if (index >= NUM_OUTPUT_FORMATS)
+				return -EINVAL;
+			break;
+			default:
+			return -EINVAL;
+		}
+
+		fmt->flags = omap2_formats[index].flags;
+		strncpy (fmt->description, omap2_formats[index].description,
+			sizeof (fmt->description));
+		fmt->pixelformat = omap2_formats[index].pixelformat;
+
+		return 0;
+	}
+	case VIDIOC_G_FMT:
+	{
+		struct v4l2_format *f = (struct v4l2_format *) arg;
+
+		switch (f->type){
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			struct v4l2_pix_format *pix = &f->fmt.pix;
+			memset (pix, 0, sizeof (*pix));
+			*pix = vout->pix;
+			return 0;
+		}
+
+		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		{
+			struct v4l2_window *win = &f->fmt.win;
+			memset (win, 0, sizeof (*win));
+
+			/* 
+			 * The API has a bit of a problem here. 
+			 * We're returning a v4l2_window 
+			 * structure, but that structure 
+			 * contains pointers to variable-sized 
+			 * objects for clipping rectangles and 
+			 * clipping bitmaps.  We will just 
+			 * return NULLs for those pointers.
+			 */
+
+			win->w = vout->win.w;
+			win->field = vout->win.field;
+			win->chromakey = vout->win.chromakey;
+			return 0;
+		}
+		default:
+		return -EINVAL;
+		}
+	}
+	case VIDIOC_TRY_FMT:
+	{
+		struct v4l2_format *f = (struct v4l2_format *) arg;
+
+		if (vout->streaming)
+			return -EBUSY;
+		switch (f->type){
+
+		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		{
+			struct v4l2_window *win = &f->fmt.win;
+			err = omap24xxvout_try_window (&vout->fbuf, win);
+			return err;
+		}
+
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			/* don't allow to change img for the linked layer */
+			if (vout->vid == vout_linked)
+				return -EINVAL;
+			if (vout->buffer_allocated)
+				return -EBUSY;
+			try_format (&f->fmt.pix);
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_S_FMT:
+	{
+		struct v4l2_format *f = (struct v4l2_format *) arg;
+		if (vout->streaming)
+			return -EBUSY;
+
+		/* get the framebuffer parameters */
+		if(vout->rotation == 90 || vout->rotation == 270){
+			omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
+				&(vout->fbuf.fmt.height),&(vout->fbuf.fmt.width));
+		}
+		else{
+			omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
+				&(vout->fbuf.fmt.width), &(vout->fbuf.fmt.height));
+			
+		}
+
+		switch (f->type){
+		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		{
+			struct v4l2_window *win = &f->fmt.win;
+
+
+			err = omap24xxvout_new_window (&vout->crop, &vout->win, 
+				&vout->fbuf, win);
+			return err;
+		}
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			/* 
+			 * don't allow to change img for the linked layer 
+			 */
+			if (vout->vid == vout_linked)
+				return -EINVAL;
+			if (vout->buffer_allocated)
+				return -EBUSY;
+
+			/* try & set the new output format */
+			try_format (&f->fmt.pix);
+			vout->pix = f->fmt.pix;
+
+			/* set default crop and win */
+			omap24xxvout_new_format (&vout->pix, &vout->fbuf, &vout->crop,
+				&vout->win);
+
+			return 0;
+		}
+
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_CROPCAP:
+	{
+		struct v4l2_cropcap *cropcap = (struct v4l2_cropcap *) arg;
+		enum v4l2_buf_type type = cropcap->type;
+
+		memset (cropcap, 0, sizeof (*cropcap));
+		cropcap->type = type;
+		switch (type){
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			struct v4l2_pix_format *pix = &vout->pix;
+			cropcap->bounds.width = pix->width & ~1;
+			cropcap->bounds.height = pix->height & ~1;
+			omap24xxvout_default_crop (&vout->pix, &vout->fbuf,
+					 &cropcap->defrect);
+			cropcap->pixelaspect.numerator = 1;
+			cropcap->pixelaspect.denominator = 1;
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_G_CROP:
+	{
+		struct v4l2_crop *crop = (struct v4l2_crop *) arg;
+
+		switch (crop->type) {
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			crop->c = vout->crop;
+			return 0;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_S_CROP:
+	{
+		struct v4l2_crop *crop = (struct v4l2_crop *) arg;
+		if (vout->streaming)
+			return -EBUSY;
+
+		/* get the framebuffer parameters */
+		if(vout->rotation == 90 || vout->rotation == 270){
+			omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
+				&(vout->fbuf.fmt.height),&(vout->fbuf.fmt.width));
+		}
+		else{
+			omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
+				&(vout->fbuf.fmt.width), &(vout->fbuf.fmt.height));
+			
+		}
+
+		switch (crop->type){
+		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
+		{
+			err =
+			omap24xxvout_new_crop (&vout->pix, &vout->crop, &vout->win,
+				&vout->fbuf, &crop->c);
+			return err;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case VIDIOC_REQBUFS:
+	{
+		struct v4l2_requestbuffers *req = (struct v4l2_requestbuffers *) arg;
+		struct videobuf_queue *q = &fh->vbq;
+		unsigned int phy_addr, virt_addr;
+		unsigned int count, i;
+
+		/* don't allow to buffer request for the linked layer */
+		if (vout->vid == vout_linked)
+			return -EINVAL;
+
+		/* we allow reg->count == 0 */
+		if ((req->type != V4L2_BUF_TYPE_VIDEO_OUTPUT) || (req->count < 0))
+			return -EINVAL;
+
+		if (req->memory != V4L2_MEMORY_MMAP)
+			return -EINVAL;
+
+		if (vout->streaming)
+			return -EBUSY;
+
+		/* 
+		 * We allow re-request as long as old buffers are not mmaped.
+		 * We will need to free old buffers first.
+		 */
+
+		if (vout->buffer_allocated){
+			if (vout->mmap_count)
+				return -EBUSY;
+			down (&q->lock);
+			for (i = 0; i < vout->buffer_allocated; i++){
+				dma_free_coherent ( NULL,
+						    vout->pix.sizeimage,
+						    (void *) q->bufs[i]->dma.vmalloc,
+			 			    q->bufs[i]->dma.bus_addr);
+				kfree (q->bufs[i]);
+				q->bufs[i] = NULL;
+			}
+			vout->buffer_allocated = 0;
+			up (&q->lock);
+		}
+
+		down (&q->lock);
+		count = req->count;
+		while (vout->pix.sizeimage * count > render_mem)
+			count--;
+
+		for (i = 0; i < count; i++) {
+			virt_addr =
+			(unsigned int) dma_alloc_coherent (NULL, vout->pix.sizeimage,
+						   (dma_addr_t *) &phy_addr,
+						   GFP_KERNEL | GFP_DMA);
+			if (!virt_addr)
+				break;
+			memset ((void *) virt_addr, 0, vout->pix.sizeimage);
+
+			DPRINTK
+			("REQBUFS: buffer %d: virt=0x%x, phy=0x%x, size=0x%x\n",
+				i, virt_addr, phy_addr, vout->pix.sizeimage);
+
+			q->bufs[i] = videobuf_alloc (q->msize);
+			if (q->bufs[i] == NULL){
+				dma_free_coherent (NULL,
+						   vout->pix.sizeimage,
+						   (void *) virt_addr,
+						   (dma_addr_t) phy_addr);
+				break;
+			}
+			q->bufs[i]->i = i;
+			q->bufs[i]->input = UNSET;
+			q->bufs[i]->memory = req->memory;
+			q->bufs[i]->bsize = vout->pix.sizeimage;
+			q->bufs[i]->boff = PAGE_ALIGN (vout->pix.sizeimage) * i;
+			q->bufs[i]->dma.vmalloc = (void *) (virt_addr);
+			q->bufs[i]->dma.bus_addr = phy_addr;
+			q->bufs[i]->state = STATE_PREPARED;
+
+			vout->buffer_allocated++;
+		}
+
+		/* return -ENOMEM if we are not able to allocate a single buffer
+		 * we have to seperate the case which user requests 0 buffer which
+		 * means user wants to free the already allocated buffers
+		 */
+
+		if (vout->buffer_allocated == 0 && req->count != 0){
+			up (&q->lock);
+			return -ENOMEM;
+		}
+		req->count = vout->buffer_allocated;
+		up (&q->lock);
+		return 0;
+	}
+	case VIDIOC_QUERYBUF:
+		return videobuf_querybuf (&fh->vbq, arg);
+
+	case VIDIOC_QBUF:
+	{
+		struct v4l2_buffer *buffer = (struct v4l2_buffer *) arg;
+		struct videobuf_queue *q = &fh->vbq;
+		struct omap24xxvout_device *dest;
+		int dest_frame_index = 0, src_element_index = 0;
+		int dest_element_index = 0, src_frame_index = 0;
+		int elem_count = 0, frame_count = 0, pixsize = 2;
+
+		/* don't allow to queue buffer for the linked layer */
+		if (vout->vid == vout_linked)
+			return -EINVAL;
+
+		if (buffer->index >= vout->buffer_allocated)
+			return -EINVAL;
+
+		if (vout->rotation >= 0
+			&& vout->vrfb_dma_tx.req_status == DMA_CHAN_NOT_ALLOTED)
+			return -EINVAL;
+
+		DPRINTK ("queuing buffer %d ...\n", buffer->index);
+
+		if (!vout->streaming)
+			return -EINVAL;
+
+		down (&q->lock);
+
+		/* 
+		 * If rotation is enabled then copy the image data from the  
+		 * MMAPPED area to SMS area 
+		 */
+
+		if (vout->rotation >= 0){
+			if (V4L2_PIX_FMT_YUYV == vout->pix.pixelformat
+				|| V4L2_PIX_FMT_UYVY == vout->pix.pixelformat){
+				pixsize = SMS_YUYV_PIXSIZE;
+			}
+			else{
+				pixsize = SMS_RGB_PIXSIZE;
+			}
+
+			/*
+			 * DMA transfer in double index mode
+			 */
+	
+			/* Frame index */
+			dest_frame_index =
+				((MAX_PIXELS_PER_LINE * pixsize) - (vout->pix.width * BYTESPERPIXEL)) + 1;
+
+			/* Source and destination parameters */
+			src_element_index = 0;
+			src_frame_index = 0;
+			dest_element_index = 1;
+
+			/* Number of elements per frame */
+			elem_count = vout->pix.width * BYTESPERPIXEL;
+			frame_count = vout->pix.height;
+			vout->vrfb_dma_tx.tx_status = 0;
+
+			omap_set_dma_transfer_params (vout->vrfb_dma_tx.dma_ch,
+				OMAP_DMA_DATA_TYPE_S8,elem_count, frame_count, 
+				OMAP_DMA_SYNC_ELEMENT,vout->vrfb_dma_tx.dev_id, 0x0);
+
+			omap_set_dma_src_params (vout->vrfb_dma_tx.dma_ch,
+				0, OMAP_DMA_AMODE_POST_INC,q->bufs[buffer->index]->dma.bus_addr,
+				src_element_index, src_frame_index);
+
+			omap_set_dma_dest_params (vout->vrfb_dma_tx.dma_ch,
+						  0, OMAP_DMA_AMODE_DOUBLE_IDX,
+				vout->sms_rot_phy[0],dest_element_index, dest_frame_index);
+
+			omap_start_dma (vout->vrfb_dma_tx.dma_ch);
+
+			interruptible_sleep_on_timeout (&vout->vrfb_dma_tx.wait,
+					    VRFB_TX_TIMEOUT);
+
+			if (vout->vrfb_dma_tx.tx_status == 0){
+				omap_stop_dma (vout->vrfb_dma_tx.dma_ch);
+				up (&q->lock);
+				return -EINVAL;
+			}
+
+			if (vout->mirror == 1){
+				switch (vout->rotation){
+				case 0:
+					omap2_disp_start_vlayer (vout->vid,&vout->pix, &vout->crop,
+						vout->sms_rot_phy[180 / 90], 180, vout->mirror);
+				break;
+				case 90:
+					omap2_disp_start_vlayer (vout->vid, &vout->pix, &vout->crop,
+						vout->sms_rot_phy[270 / 90], 270,vout->mirror);
+				break;
+
+				case 180:
+					omap2_disp_start_vlayer (vout->vid,&vout->pix, &vout->crop,
+						vout->sms_rot_phy[0 / 90], 0,vout->mirror);
+				break;
+
+				case 270:
+					omap2_disp_start_vlayer (vout-> vid,&vout->pix, &vout->crop,
+						vout->sms_rot_phy[90 / 90], 90,vout->mirror);
+				break;
+				}		/* switch */
+			}
+
+			else{
+				omap2_disp_start_vlayer (vout->vid,&vout->pix,&vout->crop,
+				vout->sms_rot_phy[vout->rotation/90], vout->rotation, vout->mirror);
+			}
+		}
+		/*if rotation */
+		else{
+			omap2_disp_start_vlayer (vout->vid, &vout->pix, &vout->crop,
+				q->bufs[buffer->index]->dma.bus_addr,vout->rotation, vout->mirror);
+		}
+
+		up (&q->lock);
+
+		/* start slave layer if V1 and V2 are linked */
+		if (vout_linked != -1){
+			dest = (vout_linked == OMAP2_VIDEO1) ? saved_v1out : saved_v2out;
+			if (dest->streaming){
+				if (dest->rotation >= 0){
+					if (dest->mirror == 1){
+					switch (dest->rotation)	{
+					case 0:
+						omap2_disp_start_vlayer(dest->vid,&dest->pix, 
+						&dest->crop, vout->sms_rot_phy[180 / 90], 180,
+						dest->mirror);
+					break;
+
+					case 90:
+						omap2_disp_start_vlayer(dest->vid,&dest->pix,
+						&dest->crop,vout->sms_rot_phy[270 / 90], 270,
+						dest->mirror);
+					break;
+
+					case 180:
+						omap2_disp_start_vlayer(dest->vid, &dest->pix, 
+						&dest->crop,vout->sms_rot_phy[0 / 90], 0, 
+						dest->mirror);
+					break;
+
+					case 270:
+						omap2_disp_start_vlayer(dest->vid, &dest->pix, 
+						&dest->crop,vout->sms_rot_phy[90 / 90], 90, 
+						dest->mirror);
+					break;
+					}/* switch */
+					}
+					/* if rotation and mirroring */
+					else{
+						omap2_disp_start_vlayer(dest->vid,&dest->pix,
+						&dest->crop,vout->sms_rot_phy[dest->rotation / 90], 
+						dest->rotation,dest->mirror);
+					}/* if no mirroring but rotation */
+				}
+				else {
+					omap2_disp_start_vlayer (dest-> vid, &dest->pix, &dest-> crop,
+					q->bufs[buffer->index]->dma.bus_addr, dest->rotation,
+					dest->mirror);
+				}		/* if no rotation and mirroring */
+			}
+		}
+		return 0;
+	}
+	case VIDIOC_DQBUF:
+	{
+		/* don't allow to dequeue buffer for the linked layer */
+		if (vout->vid == vout_linked)
+			return -EINVAL;
+		return 0;
+	}
+	case VIDIOC_STREAMON:
+	{
+		if (vout->streaming)
+			return -EBUSY;
+		/* 
+		 * If rotation mode is selected then allocate a 
+		 *  dummy or hidden buffer to map the SMS virtual space 
+		 */
+
+		if (vout->vid != vout_linked){
+			if (vout->rotation >= 0){
+			/* Allocate the actual physical space for VRFB */
+		
+			/* 
+			 * The allocation is rounded to tile size as we are 
+			 * taking care of the offset while reading the data 
+			 * and also we will always fill the 0 degree space with 
+			 * the image data and read the data requested space (rotation degree)
+			 */
+
+			if (V4L2_PIX_FMT_YUYV == vout->pix.pixelformat
+				|| V4L2_PIX_FMT_UYVY == vout->pix.pixelformat){
+
+				vout->smsshado_virt_addr =
+				   	(unsigned int) dma_alloc_coherent (
+							NULL,
+							vout->pix.sizeimage * 2,
+							(dma_addr_t *)&vout->smsshado_phy_addr,
+							GFP_KERNEL | GFP_DMA);
+
+				if (!vout->smsshado_virt_addr)
+					return -ENOMEM;
+	
+				omap2_disp_set_vrfb (vout->vid, vout->smsshado_phy_addr, 
+					vout->pix.width, vout->pix.height, BYTESPERPIXEL * 2);
+			}
+			else{
+				vout->smsshado_virt_addr =
+				   	(unsigned int) dma_alloc_coherent (
+							NULL,
+							vout->pix.sizeimage,
+							(dma_addr_t *)&vout->smsshado_phy_addr,
+							GFP_KERNEL | GFP_DMA);
+		
+				if (!vout->smsshado_virt_addr)
+					return -ENOMEM;
+				omap2_disp_set_vrfb (vout->vid, vout->smsshado_phy_addr, 
+					vout->pix.width, vout->pix.height, BYTESPERPIXEL);
+			}
+			}
+		}
+
+		/* set flag here. Next QBUF will start DMA */
+		vout->streaming = fh;
+
+		/* DMA will be started by QBUF */
+		omap2_disp_config_vlayer (vout->vid, &vout->pix, &vout->crop,
+				  &vout->win, vout->rotation, vout->mirror);
+		return 0;
+	}
+
+	case VIDIOC_STREAMOFF:
+	{
+		/* 
+		 * only allow the file handler that started streaming to
+		 * stop streaming
+		 */
+
+		if (vout->streaming == fh){
+			omap2_disp_disable_layer (vout->vid);
+			vout->streaming = NULL;
+
+			/* stop the slave layer */
+			if (vout_linked != -1 && vout_linked != vout->vid){
+			omap2_disp_disable_layer ((vout->vid == OMAP2_VIDEO1)
+					  ? OMAP2_VIDEO2 : OMAP2_VIDEO1);
+			}
+
+			if (vout->rotation >= 0){
+			if (vout_linked != vout->vid){
+				if (V4L2_PIX_FMT_YUYV == vout->pix.pixelformat
+				|| V4L2_PIX_FMT_UYVY == vout->pix.pixelformat){
+					dma_free_coherent ( NULL,
+						    vout->pix.sizeimage * 2,
+						 (void *)vout->smsshado_virt_addr,
+						 (dma_addr_t)vout->smsshado_phy_addr);
+				}
+				else{
+					dma_free_coherent ( NULL,
+						    vout->pix.sizeimage,
+						 (void *)vout->smsshado_virt_addr,
+						 (dma_addr_t)vout->smsshado_phy_addr);
+				}
+			}
+			}
+			return 0;
+		}
+		else
+			return -EINVAL;
+	}
+
+	case VIDIOC_S_OMAP2_LINK:
+	{
+		int *link = arg;
+
+		spin_lock (&vout_link_lock);
+
+		if ((*link == 0) && (vout_linked == vout->vid))
+			vout_linked = -1;
+
+		if ((*link == 1) && (vout_linked == -1 || vout_linked == vout->vid)){
+			vout_linked = vout->vid;
+
+			if (vout_linked == OMAP2_VIDEO2){
+				/* sync V2 to V1 for img and crop */
+				omap24xxvout_sync (saved_v2out, saved_v1out);
+			}
+			else{
+				/* sync V1 to V2 */
+				omap24xxvout_sync (saved_v1out, saved_v2out);
+			}
+		}
+
+		spin_unlock (&vout_link_lock);
+		return 0;
+	}
+	case VIDIOC_G_OMAP2_LINK:
+	{
+		int *link = arg;
+
+		spin_lock (&vout_link_lock);
+		if (vout_linked == vout->vid) *link = 1;
+		else *link = 0;
+		spin_unlock (&vout_link_lock);
+		return 0;
+	}
+	case VIDIOC_S_OMAP2_MIRROR:
+	{
+		int *mirror = arg;
+		if ((*mirror == 0) && (vout->mirror == 1)){
+			vout->mirror = 0;
+			return 0;
+		}
+		else if ((*mirror == 1) && (vout->mirror == 0)){
+			vout->mirror = 1;
+			return 0;
+		}
+		return -EINVAL;
+	}
+	case VIDIOC_G_OMAP2_MIRROR:
+	{
+		int *mirror = arg;
+		*mirror = vout->mirror;
+		return 0;
+	}
+
+	case VIDIOC_S_OMAP2_ROTATION:
+	{
+		int *rotation = arg;
+		if (vout->rotation == -1)
+			return -EINVAL;
+
+		if ((*rotation == 0) || (*rotation == 90) || (*rotation == 180)
+			|| (*rotation == 270)){
+			vout->rotation = *rotation;
+			rotation_support = vout->rotation;
+			return 0;
+		}
+		else
+			return -EINVAL;
+	}
+	case VIDIOC_G_OMAP2_ROTATION:
+	{
+		int *rotation = arg;
+		if (vout->rotation == -1)
+			return -EINVAL;
+		*rotation = vout->rotation;
+		return 0;
+	}
+	case VIDIOC_S_OMAP2_COLORKEY:
+	{
+		struct omap24xxvout_colorkey *colorkey =
+		(struct omap24xxvout_colorkey *) arg;
+
+		if ((colorkey->output_dev != OMAP2_OUTPUT_LCD &&
+			colorkey->output_dev != OMAP2_OUTPUT_TV) ||
+			(colorkey->key_type != OMAP2_GFX_DESTINATION
+			&& colorkey->key_type != OMAP2_VIDEO_SOURCE))
+			return -EINVAL;
+
+		omap2_disp_set_colorkey (colorkey->output_dev, colorkey->key_type,
+			colorkey->key_val);
+		return 0;
+
+	}
+	case VIDIOC_G_OMAP2_COLORKEY:
+	{
+		struct omap24xxvout_colorkey *colorkey =
+		(struct omap24xxvout_colorkey *) arg;
+
+		if (colorkey->output_dev != OMAP2_OUTPUT_LCD
+			&& colorkey->output_dev != OMAP2_OUTPUT_TV)
+		return -EINVAL;
+		omap2_disp_get_colorkey (colorkey->output_dev, &colorkey->key_type,
+				 &colorkey->key_val);
+		return 0;
+
+	}
+	case VIDIOC_S_OMAP2_BGCOLOR:
+	{
+		struct omap24xxvout_bgcolor *bgcolor =
+		(struct omap24xxvout_bgcolor *) arg;
+
+		if (bgcolor->output_dev != OMAP2_OUTPUT_LCD
+			&& bgcolor->output_dev != OMAP2_OUTPUT_TV)
+			return -EINVAL;
+
+		omap2_disp_set_bg_color (bgcolor->output_dev, bgcolor->color);
+		return 0;
+	}
+	case VIDIOC_G_OMAP2_BGCOLOR:
+	{
+		struct omap24xxvout_bgcolor *bgcolor =
+			(struct omap24xxvout_bgcolor *) arg;
+
+		if (bgcolor->output_dev != OMAP2_OUTPUT_LCD
+			&& bgcolor->output_dev != OMAP2_OUTPUT_TV)
+		return -EINVAL;
+
+		omap2_disp_get_bg_color (bgcolor->output_dev, &bgcolor->color);
+		return 0;
+	}
+	case VIDIOC_OMAP2_COLORKEY_ENABLE:
+	{
+		int *output_dev = arg;
+
+		if (*output_dev != OMAP2_OUTPUT_LCD && *output_dev != OMAP2_OUTPUT_TV)
+		return -EINVAL;
+
+		omap2_disp_enable_colorkey (*output_dev);
+		return 0;
+	}
+
+	case VIDIOC_OMAP2_COLORKEY_DISABLE:
+	{
+		int *output_dev = arg;
+
+		if (*output_dev != OMAP2_OUTPUT_LCD && *output_dev != OMAP2_OUTPUT_TV)
+			return -EINVAL;
+		omap2_disp_disable_colorkey (*output_dev);
+		return 0;
+	}
+
+	default:
+		/* unrecognized ioctl */
+		return -ENOIOCTLCMD;
+
+	}				/* switch */
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+
+/*
+ *  file operations
+ */
+
+#ifdef DEBUG_ALLOW_WRITE
+
+static ssize_t
+omap24xxvout_write (struct file *file, const char *data, size_t count,
+		    loff_t * ppos)
+{
+	struct omap24xxvout_fh *fh = file->private_data;
+	struct omap24xxvout_device *vout = fh->vout;
+
+	if ((*ppos) >= vout->pix.sizeimage)
+		return 0;
+	if (count + (*ppos) > vout->pix.sizeimage)
+		count = vout->pix.sizeimage - (*ppos);
+	if (copy_from_user
+		((void *) (vout->framebuffer_base + (*ppos)), data, count)){
+		printk ("error in copying data");
+	}
+	*ppos += count;
+
+	#if 1
+		if (*ppos == vout->pix.sizeimage)
+		mdelay (5000);
+	#endif
+	return count;
+}
+
+#endif
+
+static void
+omap24xxvout_vm_open (struct vm_area_struct *vma)
+{
+	struct omap24xxvout_device *vout = vma->vm_private_data;
+	DPRINTK ("vm_open [vma=%08lx-%08lx]\n", vma->vm_start, vma->vm_end);
+	vout->mmap_count++;
+}
+
+static void
+omap24xxvout_vm_close (struct vm_area_struct *vma)
+{
+	struct omap24xxvout_device *vout = vma->vm_private_data;
+	DPRINTK ("vm_close [vma=%08lx-%08lx]\n", vma->vm_start, vma->vm_end);
+	vout->mmap_count--;
+}
+
+static struct vm_operations_struct omap24xxvout_vm_ops = {
+	.open = omap24xxvout_vm_open,
+	.close = omap24xxvout_vm_close,
+};
+
+static int
+omap24xxvout_mmap (struct file *file, struct vm_area_struct *vma)
+{
+	struct omap24xxvout_fh *fh = file->private_data;
+	struct omap24xxvout_device *vout = fh->vout;
+	struct videobuf_queue *q = &fh->vbq;
+	int size, i;
+
+	DPRINTK ("pgoff=0x%x, start=0x%x, end=0x%x\n", vma->vm_pgoff, 
+		vma->vm_start,  vma->vm_end);
+
+	size = vma->vm_end - vma->vm_start;
+
+	down (&q->lock);
+
+	/* look for the buffer to map */
+	for (i = 0; i < VIDEO_MAX_FRAME; i++){
+		if (NULL == q->bufs[i])	continue;
+		if (V4L2_MEMORY_MMAP != q->bufs[i]->memory)
+			continue;
+		if (q->bufs[i]->boff == (vma->vm_pgoff << PAGE_SHIFT))
+			break;
+	}
+
+	if (VIDEO_MAX_FRAME == i){
+		DPRINTK ("offset invalid [offset=0x%lx]\n",
+	       (vma->vm_pgoff << PAGE_SHIFT));
+		up (&q->lock);
+		return -EINVAL;
+	}
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = pgprot_writecombine (vma->vm_page_prot);
+	vma->vm_ops = &omap24xxvout_vm_ops;
+	vma->vm_private_data = (void *) vout;
+
+	if (io_remap_pfn_range
+	     (vma, vma->vm_start, q->bufs[i]->dma.bus_addr, size, vma->vm_page_prot)){
+		up (&q->lock);
+		return -EAGAIN;
+	}
+
+	up (&q->lock);
+	vout->mmap_count++;
+	return 0;
+}
+
+static int
+omap24xxvout_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
+		    unsigned long arg)
+{
+	struct omap24xxvout_fh *fh = file->private_data;
+	struct omap24xxvout_device *vout = fh->vout;
+
+	return video_usercopy (inode, file, cmd, arg, omap24xxvout_do_ioctl);
+}
+
+static int
+omap24xxvout_release (struct inode *inode, struct file *file)
+{
+	struct omap24xxvout_fh *fh = file->private_data;
+	struct omap24xxvout_device *vout;
+	struct videobuf_queue *q;
+	int i;
+
+	DPRINTK ("entering\n");
+
+	if (fh == 0)
+		return 0;
+	if ((vout = fh->vout) == 0)
+		return 0;
+	q = &fh->vbq;
+
+
+	/* 
+	 * Check if the hidden buffer transfer is happening with DMA
+	 * if yes then stop it
+	 */
+	
+	if (vout->rotation != -1){
+		if (vout->vrfb_dma_tx.tx_status == 0){
+
+			/* 
+			 * DMA will be stopped once here and again after wakeup to 
+			 * avoid race conditions due to time taken to wakeup the 
+			 * sleeping process
+			 */
+			
+			omap_stop_dma (vout->vrfb_dma_tx.dma_ch);
+			wake_up_interruptible(&vout->vrfb_dma_tx.wait);	
+		}
+	}
+
+	omap2_disp_disable_layer (vout->vid);
+
+	if ((vout_linked != -1) && (vout->vid != vout_linked))
+	omap2_disp_disable_layer ((vout->vid ==
+			       OMAP2_VIDEO1) ? OMAP2_VIDEO2 : OMAP2_VIDEO1);
+
+#ifdef DEBUG_ALLOW_WRITE
+	if (vout->framebuffer_base){
+		dma_free_coherent (NULL, vout->framebuffer_size,
+				(void *) vout->framebuffer_base,
+				 vout->framebuffer_base_phys);
+		vout->framebuffer_base = 0;
+	}
+	vout->framebuffer_base_phys = 0;
+#endif
+
+	if (vout->streaming == fh) vout->streaming = NULL;
+	down (&q->lock);
+	for (i = 0; i < vout->buffer_allocated; i++) {
+		dma_free_coherent (NULL, vout->pix.sizeimage,
+				(void *) q->bufs[i]->dma.vmalloc,
+				 q->bufs[i]->dma.bus_addr);
+		kfree (q->bufs[i]);
+		q->bufs[i] = NULL;
+	}
+	vout->buffer_allocated = 0;
+	up (&q->lock);
+
+	if (vout->mmap_count != 0){
+		vout->mmap_count = 0;
+		printk("mmap count is not zero!\n");
+	}
+
+	omap2_disp_release_layer (vout->vid);
+	omap2_disp_put_dss ();
+	vout->opened -= 1;
+	file->private_data = NULL;
+	kfree (fh);
+
+	/* need to remove the link when the either slave or master is gone */
+	spin_lock (&vout_link_lock);
+	if (vout_linked != -1) {
+		vout_linked = -1;
+	}
+	spin_unlock (&vout_link_lock);
+
+	return 0;
+}
+
+static int
+omap24xxvout_open (struct inode *inode, struct file *file)
+{
+	int minor = MINOR (file->f_dentry->d_inode->i_rdev);
+	struct omap24xxvout_device *vout = NULL;
+	struct omap24xxvout_fh *fh;
+
+	DPRINTK ("entering\n");
+
+	if (saved_v1out && saved_v1out->vfd && (saved_v1out->vfd->minor == minor)){
+		vout = saved_v1out;
+	}
+
+	if (vout == NULL){
+		if (saved_v2out && saved_v2out->vfd
+			&& (saved_v2out->vfd->minor == minor)){
+		vout = saved_v2out;
+		}
+	}
+
+	if (vout == NULL)
+		return -ENODEV;
+
+	/* for now, we only support single open */
+	if (vout->opened)
+		return -EBUSY;
+
+	vout->opened += 1;
+	if (!omap2_disp_request_layer (vout->vid)){
+		vout->opened -= 1;
+		return -ENODEV;
+	}
+
+	omap2_disp_get_dss ();
+	
+	/* allocate per-filehandle data */
+	fh = kmalloc (sizeof (*fh), GFP_KERNEL);
+	if (NULL == fh){
+		omap2_disp_release_layer (vout->vid);
+		omap2_disp_put_dss ();
+		vout->opened -= 1;
+		return -ENOMEM;
+	}
+
+	file->private_data = fh;
+	fh->vout = vout;
+	fh->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
+
+#ifdef DEBUG_ALLOW_WRITE
+	vout->framebuffer_size = VGA_HEIGHT * VGA_HEIGHT * 2;
+	vout->framebuffer_base =
+	(unsigned int) dma_alloc_coherent (NULL, 
+		vout->framebuffer_size,	
+		(dma_addr_t *) & vout->framebuffer_base_phys,
+	       	GFP_KERNEL | GFP_DMA);
+
+	if (!vout->framebuffer_base){
+		kfree (fh);
+		omap2_disp_release_layer (vout->vid);
+		omap2_disp_put_dss ();
+		vout->opened -= 1;
+		return -ENOMEM;
+	}
+	memset ((void *) vout->framebuffer_base, 0, vout->framebuffer_size);
+		omap2_disp_config_vlayer (vout->vid, &vout->pix, &vout->crop, &vout->win,
+		vout->rotation, vout->mirror);
+	omap2_disp_start_vlayer (vout->vid, &vout->pix, &vout->crop,
+		vout->framebuffer_base_phys, vout->rotation,
+		vout->mirror);
+#endif
+	videobuf_queue_init (&fh->vbq, NULL, NULL, &vout->vbq_lock,
+		fh->type, V4L2_FIELD_NONE,
+		sizeof (struct videobuf_buffer), NULL);
+	return 0;
+}
+
+static struct file_operations omap24xxvout_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+#ifdef DEBUG_ALLOW_WRITE
+	.write = omap24xxvout_write,
+#endif
+	.ioctl = omap24xxvout_ioctl,
+	.mmap = omap24xxvout_mmap,
+	.open = omap24xxvout_open,
+	.release = omap24xxvout_release,
+};
+
+/* -------------------------------------------------------------------------- */
+static void
+cleanup_vout_device (int vid)
+{
+	struct video_device *vfd;
+	struct omap24xxvout_device *vout;
+
+	vout = (vid == OMAP2_VIDEO1) ? saved_v1out : saved_v2out;
+	if (!vout)
+		return;
+	vfd = vout->vfd;
+
+	if (vfd){
+		if (vfd->minor == -1){
+			/* 
+			 * The device was never registered, so release the 
+			 * video_device struct directly. 
+			 */
+			video_device_release (vfd);
+		}
+		else{
+			/* 
+			 * The unregister function will release the video_device
+			 * struct as well as unregistering it. 
+			 */
+			video_unregister_device (vfd);
+		}
+	}
+
+	release_mem_region (vout->sms_rot_phy[3], VRF_SIZE);
+	release_mem_region (vout->sms_rot_phy[2], VRF_SIZE);
+	release_mem_region (vout->sms_rot_phy[1], VRF_SIZE);
+	release_mem_region (vout->sms_rot_phy[0], VRF_SIZE);
+
+	if (vout->vrfb_dma_tx.req_status == DMA_CHAN_ALLOTED){
+		vout->vrfb_dma_tx.req_status = DMA_CHAN_NOT_ALLOTED;
+		omap_free_dma (vout->vrfb_dma_tx.dma_ch);
+	}
+	
+	kfree (vout);
+
+	if (vid == OMAP2_VIDEO1)
+		saved_v1out = NULL;
+	else
+		saved_v2out = NULL;
+}
+
+static struct omap24xxvout_device *
+init_vout_device (int vid)
+{
+	int r;
+	struct omap24xxvout_device *vout;
+	struct video_device *vfd;
+	struct v4l2_pix_format *pix;
+
+	vout = kmalloc (sizeof (struct omap24xxvout_device), GFP_KERNEL);
+	if (!vout){
+		printk (KERN_ERR VOUT_NAME ": could not allocate memory\n");
+		return NULL;
+	}
+
+	memset (vout, 0, sizeof (struct omap24xxvout_device));
+	vout->vid = vid;
+	vout->rotation = rotation_support;
+
+	/* set the default pix */
+	pix = &vout->pix;
+	pix->width = QQVGA_WIDTH;
+	pix->height = QQVGA_HEIGHT;
+
+	pix->pixelformat = V4L2_PIX_FMT_RGB565;
+	pix->field = V4L2_FIELD_NONE;
+	pix->bytesperline = pix->width * 2;
+	pix->sizeimage = pix->bytesperline * pix->height;
+	pix->priv = 0;
+	pix->colorspace = V4L2_COLORSPACE_JPEG;
+
+	/* get the screen parameters */
+	omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
+		&(vout->fbuf.fmt.width),&(vout->fbuf.fmt.height));
+	/* set default crop and win */
+	omap24xxvout_new_format (pix, &vout->fbuf, &vout->crop, &vout->win);
+
+	/* initialize the video_device struct */
+	vfd = vout->vfd = video_device_alloc ();
+	if (!vfd){
+		printk (KERN_ERR VOUT_NAME": could not allocate video device struct\n");
+		kfree (vout);
+		return NULL;
+	}
+	vfd->release = video_device_release;
+
+	strncpy (vfd->name, VOUT_NAME, sizeof (vfd->name));
+	vfd->type = VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
+	/* need to register for a VID_HARDWARE_* ID in videodev.h */
+	vfd->hardware = 0;
+	vfd->fops = &omap24xxvout_fops;
+	video_set_drvdata (vfd, vout);
+	vfd->minor = -1;
+	if (vout->rotation != -1){
+		/* SMS memory starts from 0x70000000 - 256 MB region */
+		vout->sms_rot_phy[0] = (vid == OMAP2_VIDEO1) ? 0x74000000 : 0x78000000;
+		vout->sms_rot_phy[1] = (vid == OMAP2_VIDEO1) ? 0x75000000 : 0x79000000;
+		vout->sms_rot_phy[2] = (vid == OMAP2_VIDEO1) ? 0x76000000 : 0x7A000000;
+		vout->sms_rot_phy[3] = (vid == OMAP2_VIDEO1) ? 0x77000000 : 0x7B000000;
+
+		/* let's request memory region for them */
+		/* request the mem region for the SMS space */
+		if (!request_mem_region (vout->sms_rot_phy[0], VRF_SIZE, vfd->name)){
+			printk (KERN_ERR VOUT_NAME": cannot reserve sms I/O region - 0 \n");
+			goto init_error;
+		}
+		if (!request_mem_region (vout->sms_rot_phy[1], VRF_SIZE, vfd->name)){
+			printk (KERN_ERR VOUT_NAME ": cannot reserve sms I/O region - 1\n");
+			goto rotation_sms_free_0;
+		}
+		if (!request_mem_region (vout->sms_rot_phy[2], VRF_SIZE, vfd->name)){
+			printk (KERN_ERR VOUT_NAME ": cannot reserve sms I/O region - 2\n");
+			goto rotation_sms_free_90;
+		}
+		if (!request_mem_region (vout->sms_rot_phy[3], VRF_SIZE, vfd->name)){
+			printk (KERN_ERR VOUT_NAME ": cannot reserve sms I/O region - 3\n");
+			goto rotation_sms_free_180;	
+			/* free them in reverse order - otherewise you will free
+			   extra stuff and get caught */
+		}
+	}
+
+	vout->suspended = 0;
+	init_waitqueue_head (&vout->suspend_wq);
+
+	if (video_register_device (vfd, VFL_TYPE_GRABBER, -1) < 0){
+		printk (KERN_ERR VOUT_NAME": could not register Video for Linux device\n");
+		vfd->minor = -1;
+		if (vout->rotation != -1)
+			goto rotation_sms_free_270;
+		else
+			goto init_error;
+	}
+
+	/*
+	 * Request and Initialize DMA, for DMA based VRFB transfer
+	 */
+	if (vout->rotation != -1){
+		vout->vrfb_dma_tx.dev_id = OMAP_DMA_NO_DEVICE;
+		vout->vrfb_dma_tx.dma_ch = -1;
+		vout->vrfb_dma_tx.req_status = DMA_CHAN_ALLOTED;
+		r = omap_request_dma (vout->vrfb_dma_tx.dev_id,
+		"VRFB DMA TX", vrfb_dma_tx_callback,(void *) &vout->vrfb_dma_tx,
+			&vout->vrfb_dma_tx.dma_ch);
+		if (r)
+			vout->vrfb_dma_tx.req_status = DMA_CHAN_NOT_ALLOTED;
+		init_waitqueue_head (&vout->vrfb_dma_tx.wait);
+	}
+	/*if rotation support */
+	printk (KERN_INFO VOUT_NAME ": registered device video%d [v4l2]\n",
+		vfd->minor);
+	return vout;
+
+rotation_sms_free_270:
+	release_mem_region (vout->sms_rot_phy[3], VRF_SIZE);
+rotation_sms_free_180:
+	release_mem_region (vout->sms_rot_phy[2], VRF_SIZE);
+rotation_sms_free_90:
+	release_mem_region (vout->sms_rot_phy[1], VRF_SIZE);
+rotation_sms_free_0:
+	release_mem_region (vout->sms_rot_phy[0], VRF_SIZE);
+
+init_error:
+	video_device_release (vfd);
+	kfree (vout);
+	return NULL;
+}
+
+static int __init
+omap24xxvout_init (void)
+{
+	saved_v1out = init_vout_device (OMAP2_VIDEO1);
+	if (saved_v1out == NULL)
+		return -ENODEV;
+
+	saved_v2out = init_vout_device (OMAP2_VIDEO2);
+	if (saved_v2out == NULL){
+		cleanup_vout_device (OMAP2_VIDEO1);
+		return -ENODEV;
+	}
+	vout_linked = -1;
+	spin_lock_init (&vout_link_lock);
+	return 0;
+}
+
+static void
+omap24xxvout_cleanup (void)
+{
+	cleanup_vout_device (OMAP2_VIDEO1);
+	cleanup_vout_device (OMAP2_VIDEO2);
+}
+
+#ifndef MODULE
+/*
+ *	omap24xxvout_setup - process command line options
+ *	@options: string of options
+ *
+ *	NOTE: This function is a __setup and __init function.
+ *
+ *	Returns zero.
+ */
+int __init
+omap24xxvout_setup (char *options)
+{
+	char *this_opt;
+	int i;
+
+	if (!options || !*options)return 0;
+
+	DPRINTK ("Options \"%s\"\n", options);
+	i = strlen (VOUT_NAME);
+	if (!strncmp (options, VOUT_NAME, i) && options[i] == ':'){
+		this_opt = options + i + 1;
+		if (!this_opt || !*this_opt)
+			return 0;
+
+		if (!strncmp (this_opt, "rotation=", 9)){
+			int deg = simple_strtoul (this_opt + 9, NULL, 0);
+			switch (deg){
+			case 0:
+			case 90:
+			case 180:
+			case 270:
+				rotation_support = deg;
+			break;
+			default:
+				rotation_support = -1;
+			break;
+			}
+			printk (KERN_INFO VOUT_NAME ": Rotation %s\n",
+			(rotation_support == -1) ? "none (supported: \"rotation=[0|90|180|270]\")" :
+			this_opt + 9);
+		}
+		else
+			printk (KERN_INFO VOUT_NAME ": Invalid parameter \"%s\" "
+			"(supported: \"rotation=[0|90|180|270]\")\n", this_opt);
+			return 0;
+	}
+
+	/*
+	 * If we get here no fb was specified.
+	 * We consider the argument to be a global video mode option.
+	 */
+	global_mode_option = options;
+	return 0;
+}
+
+__setup ("videoout=", omap24xxvout_setup);
+#endif
+
+MODULE_AUTHOR ("Texas Instruments.");
+MODULE_DESCRIPTION ("OMAP24xx Video for Linux Video out driver");
+MODULE_LICENSE ("GPL");
+MODULE_PARM (render_mem, "i");
+MODULE_PARM_DESC (render_mem,
+		  "Maximum rendering memory size (default 1.2MB)");
+
+module_init (omap24xxvout_init);
+module_exit (omap24xxvout_cleanup);
diff --git a/drivers/media/video/omap/omap24xxvout.h b/drivers/media/video/omap/omap24xxvout.h
new file mode 100644
index 0000000..e298d63
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxvout.h
@@ -0,0 +1,107 @@
+/*
+ * drivers/media/video/omap24xxvout.h
+ *
+ * Copyright (C) 2005 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#ifndef OMAP24XXVOUT_H
+#define OMAP24XXVOUT_H
+
+
+/* 
+ * This structure is used to store the DMA transfer parameters 
+ * for VRFB hidden buffer
+ */
+struct vid_vrfb_dma
+{
+        int dev_id;
+        int dma_ch;
+        int req_status;
+        int tx_status;
+        wait_queue_head_t wait;
+};
+
+
+
+/* per-device data structure */
+struct omap24xxvout_device {
+	struct device dev;
+	struct video_device *vfd;
+	int vid;
+	int opened;
+
+	/* Power management suspend lockout stuff */
+	int suspended;
+	wait_queue_head_t suspend_wq;
+
+#ifdef DEBUG_ALLOW_WRITE
+	unsigned long framebuffer_base;
+	unsigned long framebuffer_base_phys;
+	unsigned long framebuffer_size;
+#endif
+
+	/* we don't allow to change image fmt/size once buffer has been allocated */
+	int buffer_allocated;
+	/* we don't allow to request new buffer when old buffers are still mmaped */
+	int mmap_count;
+
+	spinlock_t vbq_lock;		/* spinlock for videobuf queues */
+	struct videobuf_queue_ops vbq_ops;	/* videobuf queue operations */
+	unsigned long field_count;	/* field counter for videobuf_buffer */
+ 	
+ 	/* non-NULL means streaming is in progress. */
+	struct omap24xxvout_fh *streaming;
+
+	struct v4l2_pix_format pix;
+	struct v4l2_rect crop;
+	struct v4l2_window win;
+	struct v4l2_framebuffer fbuf;
+
+	/* rotation variablse goes here */
+	unsigned long sms_rot_virt[4]; /* virtual addresss for four angles */
+	dma_addr_t sms_rot_phy[4];     /* four angles */
+
+	int mirror;
+	int rotation;
+	struct vid_vrfb_dma vrfb_dma_tx;
+	unsigned int smsshado_phy_addr;
+	unsigned int smsshado_virt_addr;
+};
+
+/* per-filehandle data structure */
+struct omap24xxvout_fh {
+	struct omap24xxvout_device *vout;
+	enum v4l2_buf_type type;
+	struct videobuf_queue vbq;
+};
+
+struct omap24xxvout_colorkey {
+	unsigned int output_dev;
+	unsigned int key_type;
+	unsigned int key_val;
+};
+
+struct omap24xxvout_bgcolor {
+	unsigned int color;
+	unsigned int output_dev;
+};
+
+/* non-standard V4L2 ioctls that are specific to OMAP2 */
+#define VIDIOC_S_OMAP2_MIRROR		_IOW ('V', 1,  int)
+#define VIDIOC_G_OMAP2_MIRROR		_IOR ('V', 2,  int)
+#define VIDIOC_S_OMAP2_ROTATION		_IOW ('V', 3,  int)
+#define VIDIOC_G_OMAP2_ROTATION		_IOR ('V', 4,  int)
+#define VIDIOC_S_OMAP2_LINK		_IOW ('V', 5,  int)
+#define VIDIOC_G_OMAP2_LINK		_IOR ('V', 6,  int)
+#define VIDIOC_S_OMAP2_COLORKEY		_IOW ('V', 7,  struct omap24xxvout_colorkey)
+#define VIDIOC_G_OMAP2_COLORKEY		_IOR ('V', 8,  struct omap24xxvout_colorkey)
+#define VIDIOC_S_OMAP2_BGCOLOR		_IOW ('V', 9,  struct omap24xxvout_bgcolor)
+#define VIDIOC_G_OMAP2_BGCOLOR		_IOR ('V', 10, struct omap24xxvout_bgcolor)
+#define VIDIOC_OMAP2_COLORKEY_ENABLE	_IOW ('V', 11, int)
+#define VIDIOC_OMAP2_COLORKEY_DISABLE	_IOW ('V', 12, int)
+
+#endif	/* ifndef OMAP24XXVOUT_H */
diff --git a/include/asm-arm/arch-omap/display.h b/include/asm-arm/arch-omap/display.h
new file mode 100644
index 0000000..e2f2e74
--- /dev/null
+++ b/include/asm-arm/arch-omap/display.h
@@ -0,0 +1,619 @@
+/* include/asm-arm/mach-omap2/display.h */
+/*
+ * include/asm-arm/arch-omap24xx/display.h
+ *
+ * Copyright (C) 2004-2005 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+
+ * Leveraged from original Linux 2.6 framebuffer driver for OMAP24xx
+ * Author: Andy Lowe (source@mvista.com)
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ *
+ */
+
+#ifndef	__ASM_ARCH_OMAP2_DISP_H
+#define	__ASM_ARCH_OMAP2_DISP_H
+
+/* physical memory map definitions */
+	/* display subsystem */
+#define DSS_REG_BASE		0x48050000
+#define DSS_REG_SIZE		0x00001000
+	/* DSS */
+#define DSS_REG_OFFSET		0x00000000
+	/* display controller */
+#define DISPC_REG_OFFSET	0x00000400
+	/* remote framebuffer interface */
+#define RFBI_REG_OFFSET	0x00000800
+	/* video encoder */
+#define VENC_REG_OFFSET	0x00000C00
+
+/* define display subsystem register offsets */
+#define DSS_REVISION			0x000
+#define DSS_CONTROL			0x040
+#define DSS_PSA_LCD_REG_1		0x050
+#define DSS_PSA_LCD_REG_2		0x054
+#define DSS_PSA_VIDEO_REG		0x058
+#define DSS_STATUS			0x05C
+
+#define DSS_CONTROL_DAC_DEMEN				(1 << 4)
+#define DSS_CONTROL_VENC_CLOCK_4X_ENABLE		(1 << 3)
+#define DSS_CONTROL_VENC_CLOCK_MODE			(1 << 2)
+#define DSS_CONTROL_CLK					(1 << 0)
+#define DSS_CONTROL_APLL_CLK				1
+#define DSS_CONTROL_DPLL_CLK				0
+
+/* define display controller register offsets */
+#define DISPC_REVISION			0x000
+#define DISPC_SYSCONFIG		0x010
+#define DISPC_SYSSTATUS		0x014
+#define DISPC_IRQSTATUS		0x018
+#define DISPC_IRQENABLE		0x01C
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
+#define DISPC_VID_ATTRIBUTES(n)	(0x0CC + (n)*0x90)
+#define DISPC_VID_FIFO_THRESHOLD(n)	(0x0D0 + (n)*0x90)
+#define DISPC_VID_FIFO_SIZE(n)		(0x0D4 + (n)*0x90)
+#define DISPC_VID_ROW_INC(n)		(0x0D8 + (n)*0x90)
+#define DISPC_VID_PIXEL_INC(n)		(0x0DC + (n)*0x90)
+#define DISPC_VID_FIR(n)		(0x0E0 + (n)*0x90)
+#define DISPC_VID_PICTURE_SIZE(n)	(0x0E4 + (n)*0x90)
+#define DISPC_VID_ACCU0(n)		(0x0E8 + (n)*0x90)
+#define DISPC_VID_ACCU1(n)		(0x0EC + (n)*0x90)
+
+/* The FIR coefficients are parameterized by the video pipeline index n = {0, 1}
+ * and the coefficient index i = {0, 1, 2, 3, 4, 5, 6, 7}.
+ */
+#define DISPC_VID_FIR_COEF_H(n, i)	(0x0F0 + (i)*0x8 + (n)*0x90)
+#define DISPC_VID_FIR_COEF_HV(n, i)	(0x0F4 + (i)*0x8 + (n)*0x90)
+#define DISPC_VID_CONV_COEF0(n)	(0x130 + (n)*0x90)
+#define DISPC_VID_CONV_COEF1(n)	(0x134 + (n)*0x90)
+#define DISPC_VID_CONV_COEF2(n)	(0x138 + (n)*0x90)
+#define DISPC_VID_CONV_COEF3(n)	(0x13C + (n)*0x90)
+#define DISPC_VID_CONV_COEF4(n)	(0x140 + (n)*0x90)
+
+#define DISPC_DATA_CYCLE1		0x1D4
+#define DISPC_DATA_CYCLE2		0x1D8
+#define DISPC_DATA_CYCLE3		0x1DC
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
+#define DISPC_SYSCONFIG_SIDLEMODE_FIDLE		(0 <<  3)
+#define DISPC_SYSCONFIG_SIDLEMODE_NIDLE		(1 <<  3)
+#define DISPC_SYSCONFIG_SIDLEMODE_SIDLE		(2 <<  3)
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
+#define DISPC_CONTROL_TDMCYCLEFORMAT_1CYCPERPIX	(0 << 23)
+#define DISPC_CONTROL_TDMCYCLEFORMAT_2CYCPERPIX	(1 << 23)
+#define DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPERPIX	(2 << 23)
+#define DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPER2PIX	(3 << 23)
+#define DISPC_CONTROL_TDMPARALLELMODE			(3 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_8BPARAINT	(0 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_9BPARAINT	(1 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_12BPARAINT	(2 << 21)
+#define DISPC_CONTROL_TDMPARALLELMODE_16BPARAINT	(3 << 21)
+#define DISPC_CONTROL_TDMENABLE			(1 << 20)
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
+#define DISPC_CONTROL_GODIGITAL			(1 <<  6)
+#define DISPC_CONTROL_GOLCD				(1 <<  5)
+#define DISPC_CONTROL_M8B				(1 <<  4)
+#define DISPC_CONTROL_STNTFT				(1 <<  3)
+#define DISPC_CONTROL_MONOCOLOR			(1 <<  2)
+#define DISPC_CONTROL_DIGITALENABLE			(1 <<  1)
+#define DISPC_CONTROL_LCDENABLE			(1 <<  0)
+
+#define DISPC_CONFIG_TCKDIGSELECTION			(1 << 13)
+#define DISPC_CONFIG_TCKDIGENABLE			(1 << 12)
+#define DISPC_CONFIG_TCKLCDSELECTION			(1 << 11)
+#define DISPC_CONFIG_TCKLCDENABLE			(1 << 10)
+#define DISPC_CONFIG_FUNCGATED				(1 <<  9)
+#define DISPC_CONFIG_ACBIASGATED			(1 <<  8)
+#define DISPC_CONFIG_VSYNCGATED			(1 <<  7)
+#define DISPC_CONFIG_HSYNCGATED			(1 <<  6)
+#define DISPC_CONFIG_PIXELCLOCKGATED			(1 <<  5)
+#define DISPC_CONFIG_PIXELDATAGATED			(1 <<  4)
+#define DISPC_CONFIG_PALETTEGAMMATABLE			(1 <<  3)
+#define DISPC_CONFIG_LOADMODE_FRDATLEFR		(1 <<  2)
+#define DISPC_CONFIG_LOADMODE_PGTABUSETB		(1 <<  1)
+#define DISPC_CONFIG_PIXELGATED			(1 <<  0)
+
+#define DISPC_CAPABLE_GFXGAMMATABLECAPABLE		(1 <<  9)
+#define DISPC_CAPABLE_GFXLAYERCAPABLE			(1 <<  8)
+#define DISPC_CAPABLE_GFXTRANSDSTCAPABLE		(1 <<  7)
+#define DISPC_CAPABLE_STNDITHERINGCAPABLE		(1 <<  6)
+#define DISPC_CAPABLE_TFTDITHERINGCAPABLE		(1 <<  5)
+#define DISPC_CAPABLE_VIDTRANSSRCCAPABLE		(1 <<  4)
+#define DISPC_CAPABLE_VIDLAYERCAPABLE			(1 <<  3)
+#define DISPC_CAPABLE_VIDVERTFIRCAPABLE		(1 <<  2)
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
+#define DISPC_DIVISOR_LCD_SHIFT			16
+#define DISPC_DIVISOR_PCD				0xFF
+#define DISPC_DIVISOR_PCD_SHIFT			0
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
+#define DISPC_GFX_SIZE_GFXSIZEY			(0x7FF << 16)
+#define DISPC_GFX_SIZE_GFXSIZEY_SHIFT			16
+#define DISPC_GFX_SIZE_GFXSIZEX			0x7FF
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
+#define DISPC_VID_SIZE_VIDSIZEY			(0x7FF << 16)
+#define DISPC_VID_SIZE_VIDSIZEY_SHIFT			16
+#define DISPC_VID_SIZE_VIDSIZEX			0x7FF
+#define DISPC_VID_SIZE_VIDSIZEX_SHIFT			0
+
+#define DISPC_VID_ATTRIBUTES_VIDROWREPEATENABLE	(1 << 18)
+#define DISPC_VID_ATTRIBUTES_VIDENDIANNESS		(1 << 17)
+#define DISPC_VID_ATTRIBUTES_VIDCHANNELOUT		(1 << 16)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE		(3 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE_BURST4X32	(0 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE_BURST8X32	(1 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDBURSTSIZE_BURST16X32	(2 << 14)
+#define DISPC_VID_ATTRIBUTES_VIDROTATION(n)		((n) << 12)
+#define DISPC_VID_ATTRIBUTES_VIDFULLRANGE		(1 << 11)
+#define DISPC_VID_ATTRIBUTES_VIDREPLICATIONENABLE	(1 << 10)
+#define DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE	(1 <<  9)
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
+
+/* VENC register offsets */
+#define VENC_F_CONTROL				0x0008
+#define VENC_VIDOUT_CTRL			0x0010
+#define VENC_SYNC_CONTROL			0x0014
+#define VENC_LLEN				0x001C
+#define VENC_FLENS				0x0020
+#define VENC_HFLTR_CTRL				0x0024
+#define VENC_CC_CARR_WSS_CARR			0x0028
+#define VENC_C_PHASE				0x002C
+#define VENC_GAIN_U				0x0030
+#define VENC_GAIN_V				0x0034
+#define VENC_GAIN_Y				0x0038
+#define VENC_BLACK_LEVEL			0x003C
+#define VENC_BLANK_LEVEL			0x0040
+#define VENC_X_COLOR				0x0044
+#define VENC_M_CONTROL				0x0048
+#define VENC_BSTAMP_WSS_DATA			0x004C
+#define VENC_S_CARR				0x0050
+#define VENC_LINE21				0x0054
+#define VENC_LN_SEL				0x0058
+#define VENC_L21_WC_CTL				0x005C
+#define VENC_HTRIGGER_VTRIGGER			0x0060
+#define VENC_SAVID_EAVID			0x0064
+#define VENC_FLEN_FAL				0x0068
+#define VENC_LAL_PHASE_RESET			0x006C
+#define VENC_HS_INT_START_STOP_X		0x0070
+#define VENC_HS_EXT_START_STOP_X		0x0074
+#define VENC_VS_INT_START_X			0x0078
+#define VENC_VS_INT_STOP_X_VS_INT_START_Y	0x007C
+#define VENC_VS_INT_STOP_Y_VS_EXT_START_X	0x0080
+#define VENC_VS_EXT_STOP_X_VS_EXT_START_Y	0x0084
+#define VENC_VS_EXT_STOP_Y			0x0088
+#define VENC_AVID_START_STOP_X			0x0090
+#define VENC_AVID_START_STOP_Y			0x0094
+#define VENC_FID_INT_START_X_FID_INT_START_Y	0x00A0
+#define VENC_FID_INT_OFFSET_Y_FID_EXT_START_X	0x00A4
+#define VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y	0x00A8
+#define VENC_TVDETGP_INT_START_STOP_X		0x00B0
+#define VENC_TVDETGP_INT_START_STOP_Y		0x00B4
+#define VENC_GEN_CTRL				0x00B8
+#define VENC_DAC_TST				0x00C4
+#define VENC_DAC				0x00C8
+
+/*----------- following are exposed values and APIs -------------------------*/
+
+struct omap24xx_dispc_regs {
+	u32 revision;			/* 0x000 */
+	u32 res1[3];
+	u32 sysconfig;			/* 0x010 */
+	u32 sysstatus;			/* 0x014 */
+	u32 irqstatus;			/* 0x018 */
+	u32 irqenable;			/* 0x01C */
+	u32 res2[8];
+	u32 control;			/* 0x040 */
+	u32 config;			/* 0x044 */
+	u32 capable;			/* 0x048 */
+	u32 default_color0;		/* 0x04C */
+	u32 default_color1;		/* 0x050 */
+	u32 trans_color0;		/* 0x054 */
+	u32 trans_color1;		/* 0x058 */
+	u32 line_status;		/* 0x05C */
+	u32 line_number;		/* 0x060 */
+	u32 timing_h;			/* 0x064 */
+	u32 timing_v;			/* 0x068 */
+	u32 pol_freq;			/* 0x06C */
+	u32 divisor;			/* 0x070 */
+	u32 res3[1];
+	u32 size_dig;			/* 0x078 */
+	u32 size_lcd;			/* 0x07C */
+	u32 gfx_ba0;			/* 0x080 */
+	u32 gfx_ba1;			/* 0x084 */
+	u32 gfx_position;		/* 0x088 */
+	u32 gfx_size;			/* 0x08C */
+	u32 res4[4];
+	u32 gfx_attributes;		/* 0x0A0 */
+	u32 gfx_fifo_threshold;		/* 0x0A4 */
+	u32 gfx_fifo_size;		/* 0x0A8 */
+	u32 gfx_row_inc;		/* 0x0AC */
+	u32 gfx_pixel_inc;		/* 0x0B0 */
+	u32 gfx_window_skip;		/* 0x0B4 */
+	u32 gfx_table_ba;		/* 0x0B8 */
+	u32 vid1_ba0;			/* 0x0BC */
+	u32 vid1_ba1;			/* 0x0C0 */
+	u32 vid1_position;		/* 0x0C4 */
+	u32 vid1_size;			/* 0x0C8 */
+	u32 vid1_attributes;		/* 0x0CC */
+	u32 vid1_fifo_threshold;	/* 0x0D0 */
+	u32 vid1_fifo_size;		/* 0x0D4 */
+	u32 vid1_row_inc;		/* 0x0D8 */
+	u32 vid1_pixel_inc;		/* 0x0DC */
+	u32 vid1_fir;			/* 0x0E0 */
+	u32 vid1_picture_size;		/* 0x0E4 */
+	u32 vid1_accu0;			/* 0x0E8 */
+	u32 vid1_accu1;			/* 0x0EC */
+	u32 vid1_fir_coef_h0;		/* 0x0F0 */
+	u32 vid1_fir_coef_hv0;		/* 0x0F4 */
+	u32 vid1_fir_coef_h1;		/* 0x0F8 */
+	u32 vid1_fir_coef_hv1;		/* 0x0FC */
+	u32 vid1_fir_coef_h2;		/* 0x100 */
+	u32 vid1_fir_coef_hv2;		/* 0x104 */
+	u32 vid1_fir_coef_h3;		/* 0x108 */
+	u32 vid1_fir_coef_hv3;		/* 0x10C */
+	u32 vid1_fir_coef_h4;		/* 0x110 */
+	u32 vid1_fir_coef_hv4;		/* 0x114 */
+	u32 vid1_fir_coef_h5;		/* 0x118 */
+	u32 vid1_fir_coef_hv5;		/* 0x11C */
+	u32 vid1_fir_coef_h6;		/* 0x120 */
+	u32 vid1_fir_coef_hv6;		/* 0x124 */
+	u32 vid1_fir_coef_h7;		/* 0x128 */
+	u32 vid1_fir_coef_hv7;		/* 0x12C */
+	u32 vid1_conv_coef0;		/* 0x130 */
+	u32 vid1_conv_coef1;		/* 0x134 */
+	u32 vid1_conv_coef2;		/* 0x138 */
+	u32 vid1_conv_coef3;		/* 0x13C */
+	u32 vid1_conv_coef4;		/* 0x140 */
+	u32 res5[2];
+	u32 vid2_ba0;			/* 0x14C */
+	u32 vid2_ba1;			/* 0x150 */
+	u32 vid2_position;		/* 0x154 */
+	u32 vid2_size;			/* 0x158 */
+	u32 vid2_attributes;		/* 0x15C */
+	u32 vid2_fifo_threshold;	/* 0x160 */
+	u32 vid2_fifo_size;		/* 0x164 */
+	u32 vid2_row_inc;		/* 0x168 */
+	u32 vid2_pixel_inc;		/* 0x16C */
+	u32 vid2_fir;			/* 0x170 */
+	u32 vid2_picture_size;		/* 0x174 */
+	u32 vid2_accu0;			/* 0x178 */
+	u32 vid2_accu1;			/* 0x17C */
+	u32 vid2_fir_coef_h0;		/* 0x180 */
+	u32 vid2_fir_coef_hv0;		/* 0x184 */
+	u32 vid2_fir_coef_h1;		/* 0x188 */
+	u32 vid2_fir_coef_hv1;		/* 0x18C */
+	u32 vid2_fir_coef_h2;		/* 0x190 */
+	u32 vid2_fir_coef_hv2;		/* 0x194 */
+	u32 vid2_fir_coef_h3;		/* 0x198 */
+	u32 vid2_fir_coef_hv3;		/* 0x19C */
+	u32 vid2_fir_coef_h4;		/* 0x1A0 */
+	u32 vid2_fir_coef_hv4;		/* 0x1A4 */
+	u32 vid2_fir_coef_h5;		/* 0x1A8 */
+	u32 vid2_fir_coef_hv5;		/* 0x1AC */
+	u32 vid2_fir_coef_h6;		/* 0x1B0 */
+	u32 vid2_fir_coef_hv6;		/* 0x1B4 */
+	u32 vid2_fir_coef_h7;		/* 0x1B8 */
+	u32 vid2_fir_coef_hv7;		/* 0x1BC */
+	u32 vid2_conv_coef0;		/* 0x1C0 */
+	u32 vid2_conv_coef1;		/* 0x1C4 */
+	u32 vid2_conv_coef2;		/* 0x1C8 */
+	u32 vid2_conv_coef3;		/* 0x1CC */
+	u32 vid2_conv_coef4;		/* 0x1D0 */
+	u32 data_cycle1;		/* 0x1D4 */
+	u32 data_cycle2;		/* 0x1D8 */
+	u32 data_cycle3;		/* 0x1DC */
+};
+
+/*----------- following are exposed values and APIs -------------------------*/
+/* Rotation using VRFB */
+#define OMAP2420_SMS_BASE 		0x680080000
+#define SMS_ROT_VIRT_BASE(context, degree)	0x70000000 		\
+						| 0x4000000 * (context)	\
+						| 0x1000000 * (degree/90)
+#define	SMS_ROT_CONTROL(context)	__REG32(OMAP2420_SMS_BASE + 0x100 \
+						+ 0x10 * context)
+#define	SMS_IMAGEHEIGHT_OFFSET			16
+#define	SMS_IMAGEWIDTH_OFFSET			0
+#define	SMS_ROT0_SIZE(context)		__REG32(OMAP2420_SMS_BASE + 0x104 \
+						+ 0x10 * context)
+#define	SMS_PH_OFFSET				8
+#define	SMS_PW_OFFSET				4
+#define	SMS_PS_OFFSET				0
+#define	SMS_ROT0_PHYSICAL_BA(context)	__REG32(OMAP2420_SMS_BASE + 0x108 \
+						+ 0x10 * context)
+#define OMAP2_GRAPHICS		0
+#define OMAP2_VIDEO1		1
+#define OMAP2_VIDEO2		2
+
+#define OMAP2_OUTPUT_LCD	4
+#define OMAP2_OUTPUT_TV	5
+
+/* TVOUT Definitions */
+#define TVOUT_CLKS_ENABLE  	1
+#define TVOUT_CLKS_DISABLE 	0
+#define NTSC		   	1
+#define PAL		   	0
+#define TVOUT_ON	   	1
+#define TVOUT_OFF	   	0
+
+/* TVOUT Definitions */
+#define PAL_BDGHI		20
+#define PAL_NC			21
+#define PAL_N			22
+#define PAL_M			23
+#define PAL_60			24
+#define NTSC_M 			25
+#define NTSC_J 			26
+#define NTSC_443 		27
+
+/* transparent color key types */
+#define OMAP2_GFX_DESTINATION 	100
+#define OMAP2_VIDEO_SOURCE	101
+
+/* SDRAM page size parameters used for VRFB settings */
+#define PAGE_WIDTH_EXP		5	/* page width = 1 << PAGE_WIDTH_EXP */
+#define PAGE_HEIGHT_EXP		5	/* page height = 1 << PAGE_HEIGHT_EXP */
+
+/* 2048 x 2048 is max res supported by OMAP24xx display controller */
+#define MAX_PIXELS_PER_LINE	2048
+#define MAX_LINES		2048
+
+#define TV_OFF		   	0
+#define TV_ON		   	1
+#define LCD_OFF			0
+#define LCD_ON			1
+
+/* transparnet color key types */
+#define OMAP2_GFX_DESTINATION 	100
+#define OMAP2_VIDEO_SOURCE	101
+
+/* input layer APIs */
+extern int omap2_disp_request_layer(int ltype);
+extern void omap2_disp_release_layer(int ltype);
+extern void omap2_disp_disable_layer(int ltype);
+extern void omap2_disp_enable_layer(int ltype);
+extern void omap2_disp_config_vlayer(int ltype, struct v4l2_pix_format *pix,
+			struct v4l2_rect *crop, struct v4l2_window *win,
+			int rotation_deg, int mirroring);
+extern void omap2_disp_config_gfxlayer(u32 size_x, u32 size_y, int color_depth);
+extern void omap2_disp_start_vlayer(int ltype, struct v4l2_pix_format *pix,
+			struct v4l2_rect *crop, unsigned long
+			fb_base_phys, int rotation_deg, int mirroring);
+extern void omap2_disp_start_gfxlayer(void);
+
+/* output device APIs */
+extern void omap2_disp_set_bg_color(int output_dev, int color);
+extern void omap2_disp_get_bg_color(int output_dev, int *color);
+extern void omap2_disp_get_panel_size(int output_dev, int *witdth, int *height);
+extern void omap2_disp_set_panel_size(int output_dev, int witdth, int height);
+extern void omap2_disp_disable_output_dev(int output_dev);
+extern void omap2_disp_enable_output_dev(int output_dev);
+extern void omap2_disp_config_venc(int tvstandard, unsigned short int outputwidth,
+		       unsigned short int outputheight);
+extern void omap2_disp_config_lcd(u32 clkdiv,
+			      u32 hbp, u32 hfp, u32 hsw,
+			      u32 vbp, u32 vfp, u32 vsw,
+			      u32 hsync_high, u32 vsync_high);
+
+/* connection of input layers to output devices */
+extern int omap2_disp_get_output_dev(int ltype);
+extern void omap2_disp_set_output_dev(int ltype, int output_dev);
+
+/* DSS power management */
+extern void omap2_disp_get_dss(void);
+extern void omap2_disp_put_dss(void);
+
+/* transparent color key */
+extern void omap2_disp_set_colorkey(int output_dev, int key_type, int key_val);
+extern void omap2_disp_get_colorkey(int output_dev, int *key_type, int *key_val);
+extern void omap2_disp_enable_colorkey(int output_dev);
+extern void omap2_disp_disable_colorkey(int output_dev);
+
+/* other helpers */
+extern void omap2_disp_set_gfx_palette(u32 palette_ba);
+extern void omap2_disp_pixels_per_clock(unsigned int *nom, unsigned int *den);
+
+/* rotation APIs */
+extern int omap2_disp_set_vrfb(int context, u32 phy_addr,
+			u32 width, u32 height, u32 bytes_per_pixel);
+
+/* should not be here. need to remove */
+extern void omap2_disp_enable(unsigned long timeout_ticks);
+extern void omap2_disp_disable(unsigned long timeout_ticks);
+
+/* interrupt handling */
+typedef void (*omap2_disp_isr_t) (void *arg, struct pt_regs * regs);
+extern int omap2_disp_register_isr(omap2_disp_isr_t isr, void *arg,
+				   unsigned int mask);
+extern int omap2_disp_unregister_isr(omap2_disp_isr_t isr);
+
+/*----------- end of exposed values and APIs -------------------------*/
+
+#include <linux/videodev.h>
+
+#endif	/* __ASM_ARCH_OMAP2_DISP_H */
diff --git a/include/asm-arm/arch-omap/venc.h b/include/asm-arm/arch-omap/venc.h
new file mode 100644
index 0000000..4092a2a
--- /dev/null
+++ b/include/asm-arm/arch-omap/venc.h
@@ -0,0 +1,573 @@
+/*
+ * include/asm-arm/arch-omap24xx/venc.h
+ *
+ * Copyright (C) 2004-2005 Texas Instruments, Inc.
+ * TV Standard configuration for Video Encoder in OMAP24XX
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+
+/* TV Encoder initialization for PAL and NTSC */
+
+/* Typical encoder values for different TV tests */
+#define VENC_HFLTR_CTRL_EN			0x00000000
+#define VENC_X_COLOR_VAL			0x00000000
+
+#define VENC_LINE21_VAL				0x00000000
+#define VENC_LN_SEL_VAL				0x00000015
+#define VENC_HTRIGGER_VTRIGGER_VAL		0x00000000
+
+#define VENC_TVDETGP_INT_START_STOP_X_VAL	0x00140001
+#define VENC_TVDETGP_INT_START_STOP_Y_VAL	0x00010001
+#define VENC_GEN_CTRL_VAL			0x00FF0000
+#define VENC_GEN_CTRL_PAL_VAL			0x00F90000
+
+/* DAC enable and in normal operation */
+#define VENC_DAC_ENABLE				0x00000002
+
+/* Values that are same for NTSC, PAL-M AND PAL-60 */
+#define F_CONTROL_GEN				0x00000000
+#define SYNC_CONTROL_GEN			0x00001040
+#define VENC_LLEN_GEN				0x00000359
+#define VENC_FLENS_GEN                  	0x0000020C
+#define VENC_C_PHASE_GEN                	0x00000000
+#define VENC_CC_CARR_WSS_CARR_GEN       	0x000025ed
+#define VENC_L21_WC_CTL_GEN             	0x00170000
+#define VENC_SAVID_EAVID_GEN            	0x069300F4
+#define VENC_FLEN_FAL_GEN             		0x0016020C
+#define VENC_HS_EXT_START_STOP_X_GEN    	0x000F0359
+#define VENC_VS_INT_START_X_GEN         	0x01A00000
+#define VENC_VS_EXT_STOP_X_VS_EXT_START_Y_GEN   0x020D01AC
+#define VENC_VS_EXT_STOP_Y_GEN			0x00000006
+#define VENC_FID_INT_START_X_FID_INT_START_Y_GEN  0x0001008A
+#define VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_GEN 0x01AC0106
+#define VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN 0x01060006
+
+
+/* Values that are same for PAL-BDGHI, PAL-N, PAL-NC */
+
+#define VENC_LLEN_PAL				0x0000035F
+#define VENC_FLENS_PAL				0x00000270
+
+#define VENC_LLEN_PAL_M				0x00000359
+#define VENC_FLENS_PAL_M			0x0000020C
+
+#define VENC_C_PHASE_PAL		       	0x000000F0 /* BDGHI & N */
+#define VENC_C_PHASE_PAL_NC		       	0x00000000
+
+#define VENC_CC_CARR_WSS_CARR_PAL		0x000025ED
+
+#define VENC_L21_WC_CTL_PAL			0x00000000
+
+#define VENC_SAVID_EAVID_PAL			0x06A70108
+#define VENC_FLEN_FAL_PAL			0x00170270
+#define VENC_HS_EXT_START_STOP_X_PAL		0x000F035F
+#define VENC_VS_INT_START_X_PAL			0x01A70000
+#define VENC_VS_EXT_STOP_Y_PAL			0x00000005
+
+#define VENC_VS_EXT_STOP_X_VS_EXT_START_Y_PAL	0x027101AF
+
+#define VENC_GAIN_U_PAL_BDGHI			0x00000130
+
+
+#define VENC_GAIN_U_PAL_N			0x000000FD
+#define VENC_GAIN_U_PAL_NC			0x00000130
+#define VENC_GAIN_U_PAL_M			0x00000140
+#define VENC_GAIN_U_PAL_60			0x00000140
+
+#define VENC_GAIN_V_PAL_BDGHI			0x000001B0
+
+#define VENC_GAIN_V_PAL_N			0x00000165
+#define VENC_GAIN_V_PAL_NC			0x000001B0
+#define VENC_GAIN_V_PAL_M			0x00000190
+#define VENC_GAIN_V_PAL_60			0x00000190
+
+#define VENC_GAIN_Y_PAL_BDGHI			0x000001B0
+#define VENC_GAIN_Y_PAL_N			0x00000177
+#define VENC_GAIN_Y_PAL_NC			0x000001B0
+#define VENC_GAIN_Y_PAL_M			0x000001C0
+#define VENC_GAIN_Y_PAL_60			0x000001C0
+
+#define VENC_BLACK_LEVEL_PAL_BDGHI		0x00000067
+
+#define VENC_BLANK_LEVEL_PAL_BDGHI		0x00000067
+#define VENC_BLACK_LEVEL_PAL_NC			0x00000063
+#define VENC_BLANK_LEVEL_PAL_NC			0x00000063
+
+#define VENC_BLACK_LEVEL_PAL_N			0x00000060
+#define VENC_BLANK_LEVEL_PAL_N			0x00000053
+
+#define VENC_BLACK_LEVEL_PAL_M			0x00000069
+#define VENC_BLANK_LEVEL_PAL_M			0x0000005C
+
+#define VENC_BLACK_LEVEL_PAL_60			0x00000069
+#define VENC_BLANK_LEVEL_PAL_60			0x0000005C
+
+#define VENC_M_CONTROL_PAL			0x00000002
+#define VENC_M_CONTROL_PAL_M			0x00000003
+#define VENC_M_CONTROL_PAL_60			0x00000003
+
+#define VENC_BSTAMP_WSS_DATA_PAL_BDGHI		0x00000043
+
+#define VENC_BSTAMP_WSS_DATA_PAL_N		0x00000038
+#define VENC_BSTAMP_WSS_DATA_PAL_M		0x0000003F
+#define VENC_BSTAMP_WSS_DATA_PAL_NC		0x00000041
+#define VENC_BSTAMP_WSS_DATA_PAL_60		0x0000003F
+
+#define VENC_S_CARR_PAL_M			0x21E6EFE3
+#define VENC_S_CARR_PAL_NC			0x21E6EFE3
+#define VENC_S_CARR_PAL_BDGHI			0x2A098ACB
+#define VENC_S_CARR_PAL_60			0x2A098ACB
+
+
+
+#define VENC_LAL_PHASE_RESET_PAL		0x00040136 /* BDGHI & N */
+#define VENC_LAL_PHASE_RESET_PAL_NC		0x00040135
+#define VENC_LAL_PHASE_RESET_PAL_2		0x00040107 /* PAL-M & PAL-60 */
+
+#define VENC_HS_INT_START_STOP_X_PAL		0x00920358 /* BDGHI & N */
+#define VENC_HS_INT_START_STOP_X_NC		0x00880358
+#define VENC_HS_INT_START_STOP_X_PAL_2		0x007e034e /* PAL-M & PAL-60 */
+
+#define VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL	0x000601A7
+#define VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL_2	0x020901a0 /* PAL-M & PAL-60*/
+#define VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL_NC 0x026F01A7
+
+#define VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL	0x01AF0036
+#define VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL_2	0x01ac0022 /* PAL-M & PAL-60 */
+#define VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL_NC 0x01AF002E
+
+#define VENC_AVID_START_STOP_X_PAL		0x03530082 /* BDGHI & N */
+#define VENC_AVID_START_STOP_X_PAL_NC		0x03530083
+#define VENC_AVID_START_STOP_X_PAL_2		0x03530082 /* PAL-M & PAL-60 */
+
+#define VENC_AVID_START_STOP_Y_PAL		0x0270002E
+#define VENC_AVID_START_STOP_Y_PAL_2		0x0270002E /* PAL-M & PAL-60 */
+#define VENC_AVID_START_STOP_Y_PAL_NC		0x026E002E
+
+#define VENC_FID_INT_START_X_FID_INT_START_Y_PAL 0x0005008A
+
+#define VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_PAL 0x002E0138
+
+
+#define VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_PAL 0x01380005
+
+/* NTSC */
+#define VENC_GAIN_U_NTSC_M			0x00000102
+#define VENC_GAIN_U_NTSC_J			0x00000100
+#define VENC_GAIN_U_NTSC_443			0x00000140
+
+#define VENC_GAIN_V_NTSC_M			0x0000016C
+#define VENC_GAIN_V_NTSC_J			0x0000016D
+#define VENC_GAIN_V_NTSC_443			0x00000190
+
+#define VENC_GAIN_Y_NTSC_M			0x0000012F
+#define VENC_GAIN_Y_NTSC_J			0x00000196
+#define VENC_GAIN_Y_NTSC_443			0x000001C0
+
+#define VENC_BLACK_LEVEL_NTSC_443		0x00000069
+#define VENC_BLANK_LEVEL_NTSC_443		0x0000005C
+
+#define VENC_BLACK_LEVEL_NTSC_M			0x00000043
+#define VENC_BLANK_LEVEL_NTSC_M			0x00000038
+
+#define VENC_BLACK_LEVEL_NTSC_J			0x00000053
+#define VENC_BLANK_LEVEL_NTSC_J			0x00000053
+
+#define VENC_M_CONTROL_NTSC			0x00000001
+
+#define VENC_BSTAMP_WSS_DATA_NTSC		0x00000038
+#define VENC_BSTAMP_WSS_DATA_NTSC_443		0x0000003F
+
+#define VENC_S_CARR_NTSC_443			0x2A098ACB
+#define VENC_S_CARR_NTSC			0x21F07C1F
+
+#define VENC_HTRIGGER_VTRIGGER_VAL		0x00000000
+
+#define VENC_FLEN_FAL_NTSC			0x0001020C
+
+#define VENC_LAL_PHASE_RESET_NTSC		0x00060107
+
+#define VENC_HS_INT_START_STOP_X_NTSC		0x007E034E
+
+#define VENC_HS_INT_START_STOP_X_443		0x007e034e
+
+#define VENC_VS_INT_STOP_X_VS_INT_START_Y_NTSC	0x020901A0
+#define VENC_VS_INT_STOP_X_VS_INT_START_Y_NTSC_443 0x020901a0
+
+#define VENC_VS_INT_STOP_Y_VS_EXT_START_X_NTSC	0x01AC0022
+#define VENC_VS_INT_STOP_Y_VS_EXT_START_X_NTSC_443 0x01ac0022
+
+#define VENC_AVID_START_STOP_X_NTSC		0x032000A0
+#define VENC_AVID_START_STOP_X_NTSC_443		0x03480079
+
+#define VENC_AVID_START_STOP_Y_NTSC		0x02060026
+#define VENC_AVID_START_STOP_Y_NTSC_443		0x02040024
+
+#define VENC_TVDETGP_INT_START_STOP_X_GEN	0x00140001
+#define VENC_TVDETGP_INT_START_STOP_Y_GEN	0x00010001
+
+
+struct tv_standard_config{
+	u32 venc_llen;
+	u32 venc_flens;
+	u32 venc_hfltr_ctrl;
+	u32 venc_cc_carr_wss_carr;
+	u32 venc_c_phase;
+	u32 venc_gain_u;
+	u32 venc_gain_v;
+	u32 venc_gain_y;
+	u32 venc_black_level;
+	u32 venc_blank_level;
+	u32 venc_x_color;
+	u32 venc_m_control;
+	u32 venc_bstamp_wss_data;
+	u32 venc_s_carr;
+	u32 venc_line21;
+	u32 venc_ln_sel;
+	u32 venc_l21_wc_ctl;
+	u32 venc_htrigger_vtrigger;
+	u32 venc_savid_eavid;
+	u32 venc_flen_fal;
+	u32 venc_lal_phase_reset;
+	u32 venc_hs_int_start_stop_x;
+	u32 venc_hs_ext_start_stop_x;
+	u32 venc_vs_int_start_x;
+	u32 venc_vs_int_stop_x_vs_int_start_y;
+	u32 venc_vs_int_stop_y_vs_ext_start_x;
+	u32 venc_vs_ext_stop_x_vs_ext_start_y;
+	u32 venc_vs_ext_stop_y;
+	u32 venc_avid_start_stop_x;
+	u32 venc_avid_start_stop_y;
+	u32 venc_fid_int_start_x_fid_int_start_y;
+	u32 venc_fid_int_offset_y_fid_ext_start_x;
+	u32 venc_fid_ext_start_y_fid_ext_offset_y;
+	u32 venc_tvdetgp_int_start_stop_x;
+	u32 venc_tvdetgp_int_start_stop_y;
+	u32 venc_gen_ctrl;
+	u32 venc_dac_tst;
+};
+
+static struct tv_standard_config pal_bdghi_cfg = {
+	VENC_LLEN_PAL,
+	VENC_FLENS_PAL,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_PAL,
+	VENC_C_PHASE_PAL,
+	VENC_GAIN_U_PAL_BDGHI,
+	VENC_GAIN_V_PAL_BDGHI,
+	VENC_GAIN_Y_PAL_BDGHI,
+	VENC_BLACK_LEVEL_PAL_BDGHI,
+	VENC_BLANK_LEVEL_PAL_BDGHI,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_PAL,
+	VENC_BSTAMP_WSS_DATA_PAL_BDGHI,
+	VENC_S_CARR_PAL_BDGHI,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_PAL,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_PAL,
+	VENC_FLEN_FAL_PAL,
+	VENC_LAL_PHASE_RESET_PAL,
+	VENC_HS_INT_START_STOP_X_PAL,
+	VENC_HS_EXT_START_STOP_X_PAL,
+	VENC_VS_INT_START_X_PAL,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_PAL,
+	VENC_VS_EXT_STOP_Y_PAL,
+	VENC_AVID_START_STOP_X_PAL,
+	VENC_AVID_START_STOP_Y_PAL,
+	VENC_FID_INT_START_X_FID_INT_START_Y_PAL,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_PAL,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_PAL_VAL,
+	VENC_DAC_ENABLE
+};
+
+static struct tv_standard_config pal_n_cfg = {
+	VENC_LLEN_PAL,
+	VENC_FLENS_PAL,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_PAL,
+	VENC_C_PHASE_PAL,
+	VENC_GAIN_U_PAL_N,
+	VENC_GAIN_V_PAL_N,
+	VENC_GAIN_Y_PAL_N,
+	VENC_BLACK_LEVEL_PAL_N,
+	VENC_BLANK_LEVEL_PAL_N,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_PAL,
+	VENC_BSTAMP_WSS_DATA_PAL_BDGHI,
+	VENC_S_CARR_PAL_BDGHI,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_PAL,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_PAL,
+	VENC_FLEN_FAL_PAL,
+	VENC_LAL_PHASE_RESET_PAL,
+	VENC_HS_INT_START_STOP_X_PAL,
+	VENC_HS_EXT_START_STOP_X_PAL,
+	VENC_VS_INT_START_X_PAL,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_PAL,
+	VENC_VS_EXT_STOP_Y_PAL,
+	VENC_AVID_START_STOP_X_PAL,
+	VENC_AVID_START_STOP_Y_PAL,
+	VENC_FID_INT_START_X_FID_INT_START_Y_PAL,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_PAL,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_PAL_VAL,
+	VENC_DAC_ENABLE
+};
+
+static struct tv_standard_config pal_nc_cfg = {
+	VENC_LLEN_PAL,
+	VENC_FLENS_PAL,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_PAL,
+	VENC_C_PHASE_PAL,
+	VENC_GAIN_U_PAL_NC,
+	VENC_GAIN_V_PAL_NC,
+	VENC_GAIN_Y_PAL_NC,
+	VENC_BLACK_LEVEL_PAL_NC,
+	VENC_BLANK_LEVEL_PAL_NC,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_PAL,
+	VENC_BSTAMP_WSS_DATA_PAL_NC,
+	VENC_S_CARR_PAL_NC,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_PAL,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_PAL,
+	VENC_FLEN_FAL_PAL,
+	VENC_LAL_PHASE_RESET_PAL_NC,
+	VENC_HS_INT_START_STOP_X_NC,
+	VENC_HS_EXT_START_STOP_X_PAL,
+	VENC_VS_INT_START_X_PAL,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL_NC,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL_NC,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_PAL,
+	VENC_VS_EXT_STOP_Y_PAL,
+	VENC_AVID_START_STOP_X_PAL_NC,
+	VENC_AVID_START_STOP_Y_PAL_NC,
+	VENC_FID_INT_START_X_FID_INT_START_Y_PAL,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_PAL,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_PAL_VAL,
+	VENC_DAC_ENABLE
+};
+
+static struct tv_standard_config pal_m_cfg = {
+	VENC_LLEN_PAL_M,
+	VENC_FLENS_PAL_M,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_GEN,
+	VENC_C_PHASE_GEN,
+	VENC_GAIN_U_PAL_M,
+	VENC_GAIN_V_PAL_M,
+	VENC_GAIN_Y_PAL_M,
+	VENC_BLACK_LEVEL_PAL_M,
+	VENC_BLANK_LEVEL_PAL_M,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_PAL_M,
+	VENC_BSTAMP_WSS_DATA_PAL_M,
+	VENC_S_CARR_PAL_M,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_GEN,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_GEN,
+	VENC_FLEN_FAL_GEN,
+	VENC_LAL_PHASE_RESET_PAL_2,
+	VENC_HS_INT_START_STOP_X_PAL_2,
+	VENC_HS_EXT_START_STOP_X_GEN,
+	VENC_VS_INT_START_X_GEN,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL_2,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL_2,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_GEN,
+	VENC_VS_EXT_STOP_Y_GEN,
+	VENC_AVID_START_STOP_X_PAL_2,
+	VENC_AVID_START_STOP_Y_PAL_2,
+	VENC_FID_INT_START_X_FID_INT_START_Y_GEN,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_GEN,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_VAL,
+	VENC_DAC_ENABLE
+};
+
+static struct tv_standard_config pal_60_cfg = {
+	VENC_LLEN_GEN,
+	VENC_FLENS_GEN,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_GEN,
+	VENC_C_PHASE_GEN,
+	VENC_GAIN_U_PAL_60,
+	VENC_GAIN_V_PAL_60,
+	VENC_GAIN_Y_PAL_60,
+	VENC_BLACK_LEVEL_PAL_60,
+	VENC_BLANK_LEVEL_PAL_60,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_PAL_60,
+	VENC_BSTAMP_WSS_DATA_PAL_60,
+	VENC_S_CARR_PAL_60,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_GEN,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_GEN,
+	VENC_FLEN_FAL_GEN,
+	VENC_LAL_PHASE_RESET_PAL_2,
+	VENC_HS_INT_START_STOP_X_PAL_2,
+	VENC_HS_EXT_START_STOP_X_GEN,
+	VENC_VS_INT_START_X_GEN,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_PAL_2,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_PAL_2,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_GEN,
+	VENC_VS_EXT_STOP_Y_GEN,
+	VENC_AVID_START_STOP_X_PAL_2,
+	VENC_AVID_START_STOP_Y_PAL_2,
+	VENC_FID_INT_START_X_FID_INT_START_Y_GEN,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_GEN,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_VAL,
+	VENC_DAC_ENABLE
+};
+
+static struct tv_standard_config ntsc_m_cfg  = {
+	VENC_LLEN_GEN,
+	VENC_FLENS_GEN,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_GEN,
+	VENC_C_PHASE_GEN,
+	VENC_GAIN_U_NTSC_M,
+	VENC_GAIN_V_NTSC_M,
+	VENC_GAIN_Y_NTSC_M,
+	VENC_BLACK_LEVEL_NTSC_M,
+	VENC_BLANK_LEVEL_NTSC_M,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_NTSC,
+	VENC_BSTAMP_WSS_DATA_NTSC,
+	VENC_S_CARR_NTSC,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_GEN,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_GEN,
+	VENC_FLEN_FAL_GEN,
+	VENC_LAL_PHASE_RESET_NTSC,
+	VENC_HS_INT_START_STOP_X_NTSC,
+	VENC_HS_EXT_START_STOP_X_GEN,
+	VENC_VS_INT_START_X_GEN,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_NTSC,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_NTSC,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_GEN,
+	VENC_VS_EXT_STOP_Y_GEN,
+	VENC_AVID_START_STOP_X_NTSC,
+	VENC_AVID_START_STOP_Y_NTSC,
+	VENC_FID_INT_START_X_FID_INT_START_Y_GEN,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_GEN,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_VAL,
+	VENC_DAC_ENABLE
+};
+
+static struct tv_standard_config ntsc_443_cfg = {
+	VENC_LLEN_GEN,
+	VENC_FLENS_GEN,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_GEN,
+	VENC_C_PHASE_GEN,
+	VENC_GAIN_U_NTSC_443,
+	VENC_GAIN_V_NTSC_443,
+	VENC_GAIN_Y_NTSC_443,
+	VENC_BLACK_LEVEL_NTSC_443,
+	VENC_BLANK_LEVEL_NTSC_443,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_NTSC,
+	VENC_BSTAMP_WSS_DATA_NTSC_443,
+	VENC_S_CARR_NTSC_443,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_GEN,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_GEN,
+	VENC_FLEN_FAL_GEN,
+	VENC_LAL_PHASE_RESET_NTSC,
+	VENC_HS_INT_START_STOP_X_443,
+	VENC_HS_EXT_START_STOP_X_GEN,
+	VENC_VS_INT_START_X_GEN,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_NTSC_443,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_NTSC_443,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_GEN,
+	VENC_VS_EXT_STOP_Y_GEN,
+	VENC_AVID_START_STOP_X_NTSC_443,
+	VENC_AVID_START_STOP_Y_NTSC_443,
+	VENC_FID_INT_START_X_FID_INT_START_Y_GEN,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_GEN,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_VAL,
+	VENC_DAC_ENABLE
+};
+
+static struct tv_standard_config ntsc_j_cfg = {
+	VENC_LLEN_GEN,
+	VENC_FLENS_GEN,
+	VENC_HFLTR_CTRL_EN,
+	VENC_CC_CARR_WSS_CARR_GEN,
+	VENC_C_PHASE_GEN,
+	VENC_GAIN_U_NTSC_J,
+	VENC_GAIN_V_NTSC_J,
+	VENC_GAIN_Y_NTSC_J,
+	VENC_BLACK_LEVEL_NTSC_J,
+	VENC_BLANK_LEVEL_NTSC_J,
+	VENC_X_COLOR_VAL,
+	VENC_M_CONTROL_NTSC,
+	VENC_BSTAMP_WSS_DATA_NTSC,
+	VENC_S_CARR_NTSC,
+	VENC_LINE21_VAL,
+	VENC_LN_SEL_VAL,
+	VENC_L21_WC_CTL_GEN,
+	VENC_HTRIGGER_VTRIGGER_VAL,
+	VENC_SAVID_EAVID_GEN,
+	VENC_FLEN_FAL_GEN,
+	VENC_LAL_PHASE_RESET_NTSC,
+	VENC_HS_INT_START_STOP_X_NTSC,
+	VENC_HS_EXT_START_STOP_X_GEN,
+	VENC_VS_INT_START_X_GEN,
+	VENC_VS_INT_STOP_X_VS_INT_START_Y_NTSC,
+	VENC_VS_INT_STOP_Y_VS_EXT_START_X_NTSC,
+	VENC_VS_EXT_STOP_X_VS_EXT_START_Y_GEN,
+	VENC_VS_EXT_STOP_Y_GEN,
+	VENC_AVID_START_STOP_X_NTSC,
+	VENC_AVID_START_STOP_Y_NTSC,
+	VENC_FID_INT_START_X_FID_INT_START_Y_GEN,
+	VENC_FID_INT_OFFSET_Y_FID_EXT_START_X_GEN,
+	VENC_FID_EXT_START_Y_FID_EXT_OFFSET_Y_GEN,
+	VENC_TVDETGP_INT_START_STOP_X_GEN,
+	VENC_TVDETGP_INT_START_STOP_Y_GEN,
+	VENC_GEN_CTRL_VAL,
+	VENC_DAC_ENABLE
+};

--0-345937890-1134658393=:75527
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-345937890-1134658393=:75527--
