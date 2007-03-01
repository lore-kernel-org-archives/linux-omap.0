From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Display Controller Library for OMAP2420/2430/3430 platforms.
Date: Thu, 1 Mar 2007 15:12:12 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C475C9ECE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi Tony,

I didn't see any comments for this patch. If there are no issues
associated with the same, can you please push this in?=20

I will not enable this for now. I have more work to do on top of this
patch.

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D
diff -purN linux-omap/arch/arm/plat-omap/display.c
lin_for_twl/arch/arm/plat-omap/display.c
--- linux-omap/arch/arm/plat-omap/display.c	1969-12-31
18:00:00.000000000 -0600
+++ lin_for_twl/arch/arm/plat-omap/display.c	2007-02-26
10:27:49.000000000 -0600
@@ -0,0 +1,2640 @@
+/*
+ * arch/arm/plat-omap/display.c
+ *
+ * Copyright (C) 2005-2006-2007 Texas Instruments, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public
License
+ * version 2. This program is licensed "as is" without any warranty of
any
+ * kind, whether express or implied.
+ *
+ * Leveraged code from the OMAP24xx camera driver
+ * Video-for-Linux (Version 2) camera capture driver for
+ * the OMAP24xx camera controller.
+ * Andy Lowe (source@mvista.com)
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
+#include <asm/arch/hardware.h>
+#include <asm/arch/platform.h>
+#include <asm/arch/display.h>
+#include <asm/arch/venc.h>
+#include <asm/arch/clock.h>
+
+/* usage count for DSS power management */
+static int disp_usage;
+static int omap2_current_tvstandard;
+static spinlock_t dss_lock;
+short int current_colorconv_values[2][3][3];
+static struct omap24xx_dispc_regs dispc;
+static struct clk *dss1f_scale;
+static struct clk *dss1f, *dss1i, *dss2f, *aclkf;
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
+/* VRFB offset computation parameters */
+#define SIDE_H		1
+#define SIDE_W		0
+
+/*
+ * DSS register I/O routines
+ */
+static __inline__ u32
+dss_reg_in(u32 offset)
+{
+	return  omap_readl(DSS_REG_BASE + DSS_REG_OFFSET + offset);
+}
+static __inline__ u32
+dss_reg_out(u32 offset, u32 val)
+{
+	omap_writel(val,DSS_REG_BASE + DSS_REG_OFFSET + offset);
+	return val;
+}
+static __inline__ u32
+dss_reg_merge(u32 offset, u32 val, u32 mask)
+{
+	u32 addr =3D DSS_REG_BASE + DSS_REG_OFFSET + offset;
+	u32 new_val =3D (omap_readl(addr) & ~mask) | (val & mask);
+
+	omap_writel(new_val, addr);
+	return new_val;
+}
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
+	u32 addr =3D DSS_REG_BASE + DISPC_REG_OFFSET + offset;
+	u32 new_val =3D (omap_readl(addr) & ~mask) | (val & mask);
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
+	return omap_readl(DSS_REG_BASE + VENC_REG_OFFSET + offset);
+}
+static __inline__ u32
+venc_reg_out(u32 offset, u32 val)
+{
+	omap_writel(val, DSS_REG_BASE + VENC_REG_OFFSET + offset);
+	return val;
+}
+static __inline__ u32
+venc_reg_merge(u32 offset, u32 val, u32 mask)
+{
+	u32 addr =3D DSS_REG_BASE + VENC_REG_OFFSET + offset;
+	u32 new_val =3D (omap_readl(addr) & ~mask) | (val & mask);
+
+	omap_writel(new_val, addr);
+	return new_val;
+}
+
+/* Write the color space conversion coefficients to the display
controller
+ * registers.  Each coefficient is a signed 11-bit integer in the range
+ * [-1024, 1023].  The matrix coefficients are:
+ *	[ RY  RCr  RCb ]
+ *	[ GY  GCr  GCb ]
+ *	[ BY  BCr  BCb ]
+ */
+
+static void
+set_colorconv(int v,int colorspace)
+{
+	unsigned long ccreg;
+	short int mtx[3][3];
+	int i,j;
+	for(i=3D0;i<3;i++)
+		for(j=3D0;j<3;j++) {
+			 mtx[i][j] =3D current_colorconv_values[v][i][j];
+		}
+
+	ccreg =3D (mtx[0][0] & 0x7ff) | ((mtx[0][1] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF0(v), ccreg);
+	ccreg =3D (mtx[0][2] & 0x7ff) | ((mtx[1][0] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF1(v), ccreg);
+	ccreg =3D (mtx[1][1] & 0x7ff) | ((mtx[1][2] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF2(v), ccreg);
+	ccreg =3D (mtx[2][0] & 0x7ff) | ((mtx[2][1] & 0x7ff) << 16);
+	dispc_reg_out(DISPC_VID_CONV_COEF3(v), ccreg);
+	ccreg =3D mtx[2][2] & 0x7ff;
+	dispc_reg_out(DISPC_VID_CONV_COEF4(v), ccreg);
+
+	if (colorspace =3D=3D V4L2_COLORSPACE_JPEG || colorspace =3D=3D
V4L2_COLORSPACE_SRGB) {
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(v),
+		DISPC_VID_ATTRIBUTES_VIDFULLRANGE,
DISPC_VID_ATTRIBUTES_VIDFULLRANGE);
+	}
+}
+
+static void
+update_colorconv_mtx(int v,const short int mtx[3][3])
+{
+	int i,j;
+	for(i=3D0;i<3;i++)
+		for(j=3D0;j<3;j++)
+			current_colorconv_values[v][i][j] =3D mtx[i][j];
+}
+
+void
+omap2_disp_set_default_colorconv(int ltype, struct v4l2_pix_format
*pix)
+{
+	int v;
+
+	if (ltype =3D=3D OMAP2_VIDEO1) v =3D 0;
+	else if (ltype =3D=3D OMAP2_VIDEO2) v =3D 1;
+	else return;
+
+	switch (pix->colorspace) {
+	case V4L2_COLORSPACE_SMPTE170M:
+	case V4L2_COLORSPACE_SMPTE240M:
+	case V4L2_COLORSPACE_BT878:
+	case V4L2_COLORSPACE_470_SYSTEM_M:
+	case V4L2_COLORSPACE_470_SYSTEM_BG:
+		/* luma (Y) range lower limit is 16, BT.601 standard */
+		update_colorconv_mtx(v,cc_bt601);
+		set_colorconv(v,pix->colorspace);
+		break;
+	case V4L2_COLORSPACE_REC709:
+		/* luma (Y) range lower limit is 16, BT.709 standard */
+		update_colorconv_mtx(v,cc_bt709);
+		set_colorconv(v,pix->colorspace);
+		break;
+	case V4L2_COLORSPACE_JPEG:
+	case V4L2_COLORSPACE_SRGB:
+		/* full luma (Y) range, assume BT.601 standard */
+		update_colorconv_mtx(v,cc_bt601_full);
+		set_colorconv(v,pix->colorspace);
+		break;
+	}
+}
+
+void
+omap2_disp_set_colorconv(int ltype, struct v4l2_pix_format *pix)
+{
+	int v;
+
+	if (ltype =3D=3D OMAP2_VIDEO1) v =3D 0;
+	else if (ltype =3D=3D OMAP2_VIDEO2) v =3D 1;
+	else return;
+
+	set_colorconv(v,pix->colorspace);
+}
+
+/* Write the horizontal and vertical resizing coefficients to the
display
+ * controller registers.  Each coefficient is a signed 8-bit integer in
the
+ * range [-128, 127] except for the middle coefficient (vc[1][i] and
hc[3][i])
+ * which is an unsigned 8-bit integer in the range [0, 255].  The first
index of
+ * the matrix is the coefficient number (0 to 2 vertical or 0 to 4
horizontal)
+ * and the second index is the phase (0 to 7).
+ */
+static void
+omap2_disp_set_resize(int v, const short int vc[3][8], const short int
hc[5][8])
+{
+	int i;
+	unsigned long reg;
+
+	for (i =3D 0; i < 8; i++) {
+		reg =3D (hc[0][i] & 0xff) | ((hc[1][i] & 0xff) << 8)
+			| ((hc[2][i] & 0xff) << 16) | ((hc[3][i] & 0xff)
<< 24);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v, i), reg);
+		reg =3D (hc[4][i] & 0xff) | ((vc[0][i] & 0xff) << 8)
+			| ((vc[1][i] & 0xff) << 16) | ((vc[2][i] & 0xff)
<< 24);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v, i), reg);
+	}
+}
+
+/*---------------------------------------------------------------------
------*/
+
+void
+omap2_disp_get_panel_size(int output_dev, int *width, int *height)
+{
+	unsigned long size;
+
+	if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+		size =3D dispc_reg_in(DISPC_SIZE_DIG);
+		*width =3D 1 + ((size & DISPC_SIZE_DIG_PPL)
+				>> DISPC_SIZE_DIG_PPL_SHIFT);
+		*height =3D 1 + ((size & DISPC_SIZE_DIG_LPP)
+				>> DISPC_SIZE_DIG_LPP_SHIFT);
+		*height =3D *height << 1;
+	}
+	else if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+		size =3D dispc_reg_in(DISPC_SIZE_LCD);
+		*width =3D 1 + ((size & DISPC_SIZE_LCD_PPL)
+				>> DISPC_SIZE_LCD_PPL_SHIFT);
+		*height =3D 1 + ((size & DISPC_SIZE_LCD_LPP)
+				>> DISPC_SIZE_LCD_LPP_SHIFT);
+	}
+}
+void
+omap2_disp_set_panel_size(int output_dev, int width, int height)
+{
+	unsigned long size;
+
+	if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+		height =3D height >> 1;
+		size =3D ((width - 1) << DISPC_SIZE_DIG_PPL_SHIFT) &
DISPC_SIZE_DIG_PPL;
+		size |=3D ((height - 1) << DISPC_SIZE_DIG_LPP_SHIFT)
+			& DISPC_SIZE_DIG_LPP;
+		dispc_reg_out(DISPC_SIZE_DIG, size);
+	}
+	else if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+		size =3D ((width - 1) << DISPC_SIZE_LCD_PPL_SHIFT) &
DISPC_SIZE_LCD_PPL;
+		size |=3D ((height - 1) << DISPC_SIZE_LCD_LPP_SHIFT)
+			& DISPC_SIZE_LCD_LPP;
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
+	if (ltype =3D=3D OMAP2_GRAPHICS) {
+		attributes =3D dispc_reg_merge(DISPC_GFX_ATTRIBUTES, 0,
+				DISPC_GFX_ATTRIBUTES_ENABLE);
+		digital =3D attributes &
DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT;
+	}
+	else {
+		if (ltype =3D=3D OMAP2_VIDEO1) v =3D 0;
+		else if (ltype =3D=3D OMAP2_VIDEO2) v =3D 1;
+		else return;
+
+		attributes =3D dispc_reg_merge(DISPC_VID_ATTRIBUTES(v), 0,
+			DISPC_VID_ATTRIBUTES_ENABLE);
+		digital =3D attributes &
DISPC_VID_ATTRIBUTES_VIDCHANNELOUT;
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
+
+}
+
+/* Turn on the GFX, or video1, or video2 layer. */
+void
+omap2_disp_enable_layer(int ltype)
+{
+	unsigned long attributes;
+	int digital, v;
+
+	if (ltype =3D=3D OMAP2_GRAPHICS) {
+		attributes =3D dispc_reg_merge(DISPC_GFX_ATTRIBUTES,
+			DISPC_GFX_ATTRIBUTES_ENABLE,
DISPC_GFX_ATTRIBUTES_ENABLE);
+		digital =3D attributes &
DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT;
+	}
+	else {
+		if (ltype =3D=3D OMAP2_VIDEO1) v =3D 0;
+		else if (ltype =3D=3D OMAP2_VIDEO2) v =3D 1;
+		else return;
+
+		attributes =3D dispc_reg_merge(DISPC_VID_ATTRIBUTES(v),
+			DISPC_VID_ATTRIBUTES_ENABLE,
DISPC_VID_ATTRIBUTES_ENABLE);
+		digital =3D attributes &
DISPC_VID_ATTRIBUTES_VIDCHANNELOUT;
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
+/*
+ * Save the DSS state before doing a GO LCD/DIGITAL
+ */
+
+void
+omap2_disp_save_initstate(int layer)
+{
+	unsigned long flags =3D0;
+	int v1=3D0, v2=3D1;
+	spin_lock_irqsave(&dss_lock, flags);
+
+	dispc.revision		=3D dispc_reg_in(DISPC_REVISION);
+	dispc.sysconfig		=3D dispc_reg_in(DISPC_SYSCONFIG);
+	dispc.sysstatus		=3D dispc_reg_in(DISPC_SYSSTATUS);
+	dispc.irqstatus		=3D dispc_reg_in(DISPC_IRQSTATUS);
+	dispc.irqenable		=3D dispc_reg_in(DISPC_IRQENABLE);
+	dispc.control		=3D dispc_reg_in(DISPC_CONTROL);
+	dispc.config		=3D dispc_reg_in(DISPC_CONFIG);
+	dispc.capable		=3D dispc_reg_in(DISPC_CAPABLE);
+	dispc.default_color0	=3D dispc_reg_in(DISPC_DEFAULT_COLOR0);
+	dispc.default_color1	=3D dispc_reg_in(DISPC_DEFAULT_COLOR1);
+	dispc.trans_color0	=3D dispc_reg_in(DISPC_TRANS_COLOR0);
+	dispc.trans_color1	=3D dispc_reg_in(DISPC_TRANS_COLOR1);
+	dispc.line_status	=3D dispc_reg_in(DISPC_LINE_STATUS);
+	dispc.line_number	=3D dispc_reg_in(DISPC_LINE_NUMBER);
+	dispc.data_cycle1	=3D dispc_reg_in(DISPC_DATA_CYCLE1);
+	dispc.data_cycle2	=3D dispc_reg_in(DISPC_DATA_CYCLE2);
+	dispc.data_cycle3	=3D dispc_reg_in(DISPC_DATA_CYCLE3);
+	dispc.timing_h		=3D dispc_reg_in(DISPC_TIMING_H);
+	dispc.timing_v		=3D dispc_reg_in(DISPC_TIMING_V);
+	dispc.pol_freq		=3D dispc_reg_in(DISPC_POL_FREQ);
+	dispc.divisor		=3D dispc_reg_in(DISPC_DIVISOR);
+	dispc.size_lcd		=3D dispc_reg_in(DISPC_SIZE_LCD);
+	dispc.size_dig		=3D dispc_reg_in(DISPC_SIZE_DIG);
+
+	switch(layer) {
+	case OMAP2_GRAPHICS:
+		dispc.gfx_ba0		=3D dispc_reg_in(DISPC_GFX_BA0);
+		dispc.gfx_ba1		=3D dispc_reg_in(DISPC_GFX_BA1);
+		dispc.gfx_position	=3D
dispc_reg_in(DISPC_GFX_POSITION);
+		dispc.gfx_size		=3D dispc_reg_in(DISPC_GFX_SIZE);
+		dispc.gfx_attributes	=3D
dispc_reg_in(DISPC_GFX_ATTRIBUTES);
+		dispc.gfx_fifo_size	=3D
dispc_reg_in(DISPC_GFX_FIFO_SIZE);
+		dispc.gfx_fifo_threshold=3D
dispc_reg_in(DISPC_GFX_FIFO_THRESHOLD);
+		dispc.gfx_row_inc	=3D
dispc_reg_in(DISPC_GFX_ROW_INC);
+		dispc.gfx_pixel_inc	=3D
dispc_reg_in(DISPC_GFX_PIXEL_INC);
+		dispc.gfx_window_skip	=3D
dispc_reg_in(DISPC_GFX_WINDOW_SKIP);
+		dispc.gfx_table_ba	=3D
dispc_reg_in(DISPC_GFX_TABLE_BA);
+	break;
+
+	case OMAP2_VIDEO1:
+		dispc.vid1_ba0		=3D
dispc_reg_in(DISPC_VID_BA0(v1));
+		dispc.vid1_ba1		=3D
dispc_reg_in(DISPC_VID_BA0(v1));
+		dispc.vid1_position	=3D
dispc_reg_in(DISPC_VID_POSITION(v1));
+		dispc.vid1_size		=3D
dispc_reg_in(DISPC_VID_SIZE(v1));
+		dispc.vid1_attributes	=3D
dispc_reg_in(DISPC_VID_ATTRIBUTES(v1));
+		dispc.vid1_fifo_size	=3D
dispc_reg_in(DISPC_VID_FIFO_SIZE(v1));
+		dispc.vid1_fifo_threshold =3D
dispc_reg_in(DISPC_VID_FIFO_THRESHOLD(v1));
+		dispc.vid1_row_inc	=3D
dispc_reg_in(DISPC_VID_ROW_INC(v1));
+		dispc.vid1_pixel_inc	=3D
dispc_reg_in(DISPC_VID_PIXEL_INC(v1));
+		dispc.vid1_fir		=3D
dispc_reg_in(DISPC_VID_FIR(v1));
+		dispc.vid1_accu0	=3D
dispc_reg_in(DISPC_VID_ACCU0(v1));
+		dispc.vid1_accu1	=3D
dispc_reg_in(DISPC_VID_ACCU1(v1));
+		dispc.vid1_picture_size	=3D
dispc_reg_in(DISPC_VID_PICTURE_SIZE(v1));
+		dispc.vid1_fir_coef_h0	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,0));
+		dispc.vid1_fir_coef_h1	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,1));
+		dispc.vid1_fir_coef_h2	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,2));
+		dispc.vid1_fir_coef_h3	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,3));
+		dispc.vid1_fir_coef_h4	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,4));
+		dispc.vid1_fir_coef_h5	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,5));
+		dispc.vid1_fir_coef_h6	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,6));
+		dispc.vid1_fir_coef_h7	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v1,7));
+		dispc.vid1_fir_coef_hv0	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,0));
+		dispc.vid1_fir_coef_hv1	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,1));
+		dispc.vid1_fir_coef_hv2	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,2));
+		dispc.vid1_fir_coef_hv3	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,3));
+		dispc.vid1_fir_coef_hv4	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,4));
+		dispc.vid1_fir_coef_hv5	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,5));
+		dispc.vid1_fir_coef_hv6	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,6));
+		dispc.vid1_fir_coef_hv7	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v1,7));
+		dispc.vid1_conv_coef0	=3D
dispc_reg_in(DISPC_VID_CONV_COEF0(v1));
+		dispc.vid1_conv_coef1	=3D
dispc_reg_in(DISPC_VID_CONV_COEF1(v1));
+		dispc.vid1_conv_coef2	=3D
dispc_reg_in(DISPC_VID_CONV_COEF2(v1));
+		dispc.vid1_conv_coef3	=3D
dispc_reg_in(DISPC_VID_CONV_COEF3(v1));
+		dispc.vid1_conv_coef4	=3D
dispc_reg_in(DISPC_VID_CONV_COEF4(v1));
+	break;
+
+	case OMAP2_VIDEO2:
+		dispc.vid2_ba0		=3D
dispc_reg_in(DISPC_VID_BA0(v2));
+		dispc.vid2_ba1		=3D
dispc_reg_in(DISPC_VID_BA1(v2));
+		dispc.vid2_position	=3D
dispc_reg_in(DISPC_VID_POSITION(v2));
+		dispc.vid2_size		=3D
dispc_reg_in(DISPC_VID_SIZE(v2));
+		dispc.vid2_attributes	=3D
dispc_reg_in(DISPC_VID_ATTRIBUTES(v2));
+		dispc.vid2_fifo_size	=3D
dispc_reg_in(DISPC_VID_FIFO_SIZE(v2));
+		dispc.vid2_fifo_threshold =3D
dispc_reg_in(DISPC_VID_FIFO_THRESHOLD(v2));
+		dispc.vid2_row_inc	=3D
dispc_reg_in(DISPC_VID_ROW_INC(v2));
+		dispc.vid2_pixel_inc	=3D
dispc_reg_in(DISPC_VID_PIXEL_INC(v2));
+		dispc.vid2_fir		=3D
dispc_reg_in(DISPC_VID_FIR(v2));
+		dispc.vid2_accu0	=3D
dispc_reg_in(DISPC_VID_ACCU0(v2));
+		dispc.vid2_accu1	=3D
dispc_reg_in(DISPC_VID_ACCU1(v2));
+		dispc.vid2_picture_size	=3D
dispc_reg_in(DISPC_VID_PICTURE_SIZE(v2));
+		dispc.vid2_fir_coef_h0	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,0));
+		dispc.vid2_fir_coef_h1	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,1));
+		dispc.vid2_fir_coef_h2	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,2));
+		dispc.vid2_fir_coef_h3	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,3));
+		dispc.vid2_fir_coef_h4	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,4));
+		dispc.vid2_fir_coef_h5	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,5));
+		dispc.vid2_fir_coef_h6	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,6));
+		dispc.vid2_fir_coef_h7	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_H(v2,7));
+		dispc.vid2_fir_coef_hv0	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,0));
+		dispc.vid2_fir_coef_hv1	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,1));
+		dispc.vid2_fir_coef_hv2	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,2));
+		dispc.vid2_fir_coef_hv3	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,3));
+		dispc.vid2_fir_coef_hv4	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,4));
+		dispc.vid2_fir_coef_hv5	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,5));
+		dispc.vid2_fir_coef_hv6	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,6));
+		dispc.vid2_fir_coef_hv7	=3D
dispc_reg_in(DISPC_VID_FIR_COEF_HV(v2,7));
+		dispc.vid2_conv_coef0	=3D
dispc_reg_in(DISPC_VID_CONV_COEF0(v2));
+		dispc.vid2_conv_coef1	=3D
dispc_reg_in(DISPC_VID_CONV_COEF1(v2));
+		dispc.vid2_conv_coef2	=3D
dispc_reg_in(DISPC_VID_CONV_COEF2(v2));
+		dispc.vid2_conv_coef3	=3D
dispc_reg_in(DISPC_VID_CONV_COEF3(v2));
+		dispc.vid2_conv_coef4	=3D
dispc_reg_in(DISPC_VID_CONV_COEF4(v2));
+	break;
+	}
+	spin_unlock_irqrestore(&dss_lock, flags);
+}
+
+void
+omap2_disp_restore_initstate(int layer)
+{
+	int v1=3D0, v2=3D1;
+
+	dispc_reg_out(DISPC_SYSCONFIG, dispc.sysconfig);
+	dispc_reg_out(DISPC_IRQENABLE, dispc.irqenable);
+	dispc_reg_out(DISPC_CONFIG, dispc.config);
+	dispc_reg_out(DISPC_DEFAULT_COLOR0, dispc.default_color0);
+	dispc_reg_out(DISPC_DEFAULT_COLOR1, dispc.default_color1);
+	dispc_reg_out(DISPC_TRANS_COLOR0, dispc.trans_color0);
+	dispc_reg_out(DISPC_TRANS_COLOR1, dispc.trans_color1);
+	dispc_reg_out(DISPC_LINE_NUMBER, dispc.line_number);
+	dispc_reg_out(DISPC_DATA_CYCLE1, dispc.data_cycle1);
+	dispc_reg_out(DISPC_DATA_CYCLE2, dispc.data_cycle2);
+	dispc_reg_out(DISPC_DATA_CYCLE3, dispc.data_cycle3);
+	dispc_reg_out(DISPC_TIMING_H, dispc.timing_h);
+	dispc_reg_out(DISPC_TIMING_V, dispc.timing_v);
+	dispc_reg_out(DISPC_POL_FREQ, dispc.pol_freq);
+	dispc_reg_out(DISPC_DIVISOR, dispc.divisor);
+	dispc_reg_out(DISPC_SIZE_LCD, dispc.size_lcd);
+	dispc_reg_out(DISPC_SIZE_DIG, dispc.size_dig);
+
+	switch(layer) {
+	case OMAP2_GRAPHICS:
+		dispc_reg_out(DISPC_GFX_BA0, dispc.gfx_ba0);
+		dispc_reg_out(DISPC_GFX_BA1, dispc.gfx_ba1);
+		dispc_reg_out(DISPC_GFX_POSITION, dispc.gfx_position);
+		dispc_reg_out(DISPC_GFX_SIZE, dispc.gfx_size);
+		dispc_reg_out(DISPC_GFX_ATTRIBUTES,
dispc.gfx_attributes);
+		dispc_reg_out(DISPC_GFX_FIFO_SIZE,dispc.gfx_fifo_size);
+		dispc_reg_out(DISPC_GFX_FIFO_THRESHOLD,
dispc.gfx_fifo_threshold);
+		dispc_reg_out(DISPC_GFX_ROW_INC, dispc.gfx_row_inc);
+		dispc_reg_out(DISPC_GFX_PIXEL_INC, dispc.gfx_pixel_inc);
+		dispc_reg_out(DISPC_GFX_WINDOW_SKIP,
dispc.gfx_window_skip);
+		dispc_reg_out(DISPC_GFX_TABLE_BA, dispc.gfx_table_ba);
+
+	break;
+
+	case OMAP2_VIDEO1:
+		dispc_reg_out(DISPC_VID_BA0(v1), dispc.vid1_ba0);
+		dispc_reg_out(DISPC_VID_BA1(v1), dispc.vid1_ba1);
+		dispc_reg_out(DISPC_VID_POSITION(v1),
dispc.vid1_position);
+		dispc_reg_out(DISPC_VID_SIZE(v1), dispc.vid1_size);
+		dispc_reg_out(DISPC_VID_ATTRIBUTES(v1),
dispc.vid1_attributes);
+
dispc_reg_out(DISPC_VID_FIFO_THRESHOLD(v1),dispc.vid1_fifo_threshold);
+		dispc_reg_out(DISPC_VID_ROW_INC(v1),
dispc.vid1_row_inc);
+		dispc_reg_out(DISPC_VID_PIXEL_INC(v1),
dispc.vid1_pixel_inc);
+		dispc_reg_out(DISPC_VID_FIR(v1), dispc.vid1_fir);
+		dispc_reg_out(DISPC_VID_ACCU0(v1), dispc.vid1_accu0);
+		dispc_reg_out(DISPC_VID_ACCU1(v1), dispc.vid1_accu1);
+		dispc_reg_out(DISPC_VID_PICTURE_SIZE(v1),
dispc.vid1_picture_size);
+
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,0),
dispc.vid1_fir_coef_h0);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,1),
dispc.vid1_fir_coef_h1);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,2),
dispc.vid1_fir_coef_h2);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,3),
dispc.vid1_fir_coef_h3);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,4),
dispc.vid1_fir_coef_h4);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,5),
dispc.vid1_fir_coef_h5);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,6),
dispc.vid1_fir_coef_h6);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v1,7),
dispc.vid1_fir_coef_h7);
+
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,0),
dispc.vid1_fir_coef_hv0);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,1),
dispc.vid1_fir_coef_hv1);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,2),
dispc.vid1_fir_coef_hv2);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,3),
dispc.vid1_fir_coef_hv3);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,4),
dispc.vid1_fir_coef_hv4);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,5),
dispc.vid1_fir_coef_hv5);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,6),
dispc.vid1_fir_coef_hv6);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v1,7),
dispc.vid1_fir_coef_hv7);
+
+		dispc_reg_out(DISPC_VID_CONV_COEF0(v1),
dispc.vid1_conv_coef0);
+		dispc_reg_out(DISPC_VID_CONV_COEF1(v1),
dispc.vid1_conv_coef1);
+		dispc_reg_out(DISPC_VID_CONV_COEF2(v1),
dispc.vid1_conv_coef2);
+		dispc_reg_out(DISPC_VID_CONV_COEF3(v1),
dispc.vid1_conv_coef3);
+		dispc_reg_out(DISPC_VID_CONV_COEF4(v1),
dispc.vid1_conv_coef4);
+	break;
+	case OMAP2_VIDEO2:
+		dispc_reg_out(DISPC_VID_BA0(v2), dispc.vid2_ba0);
+		dispc_reg_out(DISPC_VID_BA1(v2), dispc.vid2_ba1);
+		dispc_reg_out(DISPC_VID_POSITION(v2),
dispc.vid2_position);
+		dispc_reg_out(DISPC_VID_SIZE(v2), dispc.vid2_size);
+		dispc_reg_out(DISPC_VID_ATTRIBUTES(v2),
dispc.vid2_attributes);
+
dispc_reg_out(DISPC_VID_FIFO_THRESHOLD(v2),dispc.vid2_fifo_threshold);
+		dispc_reg_out(DISPC_VID_ROW_INC(v2),
dispc.vid2_row_inc);
+		dispc_reg_out(DISPC_VID_PIXEL_INC(v2),
dispc.vid2_pixel_inc);
+		dispc_reg_out(DISPC_VID_FIR(v2), dispc.vid2_fir);
+		dispc_reg_out(DISPC_VID_ACCU0(v2), dispc.vid2_accu0);
+		dispc_reg_out(DISPC_VID_ACCU1(v2), dispc.vid2_accu1);
+		dispc_reg_out(DISPC_VID_PICTURE_SIZE(v2),
dispc.vid2_picture_size);
+
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,0),
dispc.vid2_fir_coef_h0);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,1),
dispc.vid2_fir_coef_h1);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,2),
dispc.vid2_fir_coef_h2);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,3),
dispc.vid2_fir_coef_h3);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,4),
dispc.vid2_fir_coef_h4);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,5),
dispc.vid2_fir_coef_h5);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,6),
dispc.vid2_fir_coef_h6);
+		dispc_reg_out(DISPC_VID_FIR_COEF_H(v2,7),
dispc.vid2_fir_coef_h7);
+
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,0),
dispc.vid2_fir_coef_hv0);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,1),
dispc.vid2_fir_coef_hv1);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,2),
dispc.vid2_fir_coef_hv2);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,3),
dispc.vid2_fir_coef_hv3);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,4),
dispc.vid2_fir_coef_hv4);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,5),
dispc.vid2_fir_coef_hv5);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,6),
dispc.vid2_fir_coef_hv6);
+		dispc_reg_out(DISPC_VID_FIR_COEF_HV(v2,7),
dispc.vid2_fir_coef_hv7);
+
+		dispc_reg_out(DISPC_VID_CONV_COEF0(v2),
dispc.vid2_conv_coef0);
+		dispc_reg_out(DISPC_VID_CONV_COEF1(v2),
dispc.vid2_conv_coef1);
+		dispc_reg_out(DISPC_VID_CONV_COEF2(v2),
dispc.vid2_conv_coef2);
+		dispc_reg_out(DISPC_VID_CONV_COEF3(v2),
dispc.vid2_conv_coef3);
+		dispc_reg_out(DISPC_VID_CONV_COEF4(v2),
dispc.vid2_conv_coef4);
+	break;
+	}
+}
+
+/*
+ * Sync Lost interrupt handler
+ */
+static void
+omap2_synclost_isr(void *arg, struct pt_regs *regs)
+{
+	unsigned long timeout=3D0;
+
+	printk(KERN_WARNING "Sync Lost LCD
%x\n",dispc_reg_in(DISPC_IRQSTATUS));
+	arg =3D NULL; regs =3D NULL;
+
+	/*
+	 * Disable and Clear all the interrupts before we start
+	 */
+	dispc_reg_out(DISPC_IRQENABLE, 0x00000000);
+	dispc_reg_out(DISPC_IRQSTATUS, 0x0000FFFF);
+
+	/* disable the display controller */
+	omap2_disp_disable(HZ/5);
+
+	/* reset the display subsystem */
+	dss_reg_out(DSS_SYSCONFIG, DSS_SYSCONFIG_SOFTRESET);
+
+	/* wait for reset to complete */
+	 timeout =3D jiffies + HZ/5;
+	 while (!(dss_reg_in(DSS_SYSSTATUS)
+		& DSS_SYSSTATUS_RESETDONE) && time_before(jiffies,
timeout))
+	{
+		udelay(100);
+	}
+
+	if (!(dss_reg_in(DSS_SYSSTATUS) & DSS_SYSSTATUS_RESETDONE))
+	{
+		printk(KERN_WARNING
+			"omap2_disp_sub_system: timeout waiting for DSS
reset\n");
+
+		/* remove the reset */
+		dss_reg_merge(DSS_SYSCONFIG, 0,
DSS_SYSCONFIG_SOFTRESET);
+	}
+
+	/*
+	 * Update the state of the display controller.
+	 */
+	dispc.sysconfig &=3D ~DISPC_SYSCONFIG_SOFTRESET;
+	dispc.control   &=3D ~(DISPC_CONTROL_GODIGITAL |
DISPC_CONTROL_GOLCD);
+
+	/* Configure the VENC for the default standard */
+	omap2_disp_set_tvstandard(NTSC_M);
+
+	/* Restore the registers */
+	omap2_disp_restore_initstate(OMAP2_GRAPHICS);
+	omap2_disp_restore_initstate(OMAP2_VIDEO1);
+	omap2_disp_restore_initstate(OMAP2_VIDEO2);
+
+	/* enable the display controller */
+	dispc_reg_out(DISPC_CONTROL, dispc.control);
+	omap2_disp_reg_sync(OMAP2_OUTPUT_LCD);
+	omap2_disp_reg_sync(OMAP2_OUTPUT_TV);
+}
+
+static inline u32
+pages_per_side(u32 img_side, u32 page_exp)
+{
+	/*  page_side =3D 2 ^ page_exp
+	 * (page_side - 1) is added for rounding up
+	 */
+	return (u32) (img_side + (1<<page_exp) - 1) >> page_exp;
+}
+
+static int get_vrfb_offset(u32 img_len, u32 bytes_per_pixel,int side)
+{
+	int page_width_exp, page_height_exp, pixel_size_exp,offset =3D0;
+
+	/* Maximum supported is 4 bytes (RGB32) */
+	if (bytes_per_pixel > 4)
+		return -EINVAL;
+
+	page_width_exp  =3D PAGE_WIDTH_EXP;
+	page_height_exp =3D PAGE_HEIGHT_EXP;
+	pixel_size_exp  =3D bytes_per_pixel >> 1;
+
+	if (side =3D=3D SIDE_W) {
+		offset =3D ((1<<page_width_exp) *
+			 (pages_per_side(img_len * bytes_per_pixel,
page_width_exp))
+			) >> pixel_size_exp;	/* in pixels */
+	}
+	else{
+		offset =3D (1<<page_height_exp) *
+		 (pages_per_side(img_len, page_height_exp));
+	}
+
+	return (offset);
+}
+
+/* Flip the video overlay framebuffer.  The video overlay window may
initially
+ * be either enabled or disabled.  The overlay window will be enabled
by this
+ * routine.  fb_base_phys is the physical base address of the
framebuffer for
+ * the video overlay.  The address programmed into the base address
register of
+ * the video overlay window is calculated based on the cropped size and
the full
+ * size of the overlay framebuffer.
+ */
+void
+omap2_disp_start_vlayer(int ltype, struct v4l2_pix_format *pix,
+			struct v4l2_rect *crop, unsigned long
fb_base_phys,
+			int rotation_deg, int mirroring)
+{
+	unsigned long cropped_base_phys;
+	int v, ps =3D 2,temp_ps=3D2,vr_ps =3D 1;
+	int offset=3D0, ctop=3D0, cleft=3D0, line_length=3D0;
+	if (ltype =3D=3D OMAP2_VIDEO1) v =3D 0;
+	else if (ltype =3D=3D OMAP2_VIDEO2) v =3D 1;
+	else return;
+
+	/*
+	 * If pixel format is YUV then PS =3D 4, for RGB16 PS =3D 2 RGB24
Unpack PS =3D4
+	 */
+
+	if (V4L2_PIX_FMT_YUYV =3D=3D pix->pixelformat ||
+		V4L2_PIX_FMT_UYVY =3D=3D pix->pixelformat) {
+		if (rotation_deg >=3D 0 || mirroring =3D=3D 1) {
+			/*
+			 * ps	- Actual pixel size for YUYV/UYVY for
VRFB/Mirroring is 4 bytes
+			 * vr_ps - Virtually pixel size for YUYV/UYVY
is 2 bytes
+			 */
+			ps	=3D 4;
+			vr_ps =3D 2;
+		}
+		else
+			ps =3D 2; /* otherwise the pixel size is 2 byte */
+	}
+	else if (V4L2_PIX_FMT_RGB32 =3D=3D pix->pixelformat) ps =3D 4;
+	else if (V4L2_PIX_FMT_RGB24 =3D=3D pix->pixelformat) ps =3D 3;
+
+	/*
+	 * If rotation is selected then compute the rotation parameters
+	 */
+	if (rotation_deg >=3D 0) {
+		line_length =3D MAX_PIXELS_PER_LINE;
+		ctop  =3D (pix->height - crop->height) - crop->top;
+		cleft =3D (pix->width - crop->width) - crop->left;
+	}
+	else {
+		line_length =3D pix->width;
+	}
+	switch (rotation_deg) {
+	case 90:
+		offset =3D (get_vrfb_offset(pix->width,ps,SIDE_H) -
(pix->width/vr_ps)) * ps * line_length;
+		temp_ps =3D ps/vr_ps;
+		if (mirroring =3D=3D 0) {
+			cropped_base_phys =3D fb_base_phys + offset +
+				line_length * temp_ps * cleft +
crop->top * temp_ps;
+		}
+		else{
+			cropped_base_phys =3D
+				fb_base_phys + offset +
+				line_length * temp_ps * cleft +
crop->top * temp_ps +
+				(line_length * ( (crop->width/(vr_ps)) -
1) * ps);
+		}
+		break;
+
+	case 180:
+		offset =3D (get_vrfb_offset(pix->height,ps,SIDE_H) -
pix->height) * ps * line_length +
+			(get_vrfb_offset(pix->width,ps,SIDE_W) -
(pix->width/vr_ps)) * ps;
+		if (mirroring =3D=3D 0) {
+			cropped_base_phys =3D fb_base_phys + offset +
+			(line_length * ps * ctop) + (cleft/vr_ps) * ps;
+		}
+		else {
+			cropped_base_phys =3D
+				fb_base_phys + offset + (line_length *
ps * ctop) +
+				(cleft/vr_ps) * ps +
+				(line_length * (crop->height - 1) * ps);
+		}
+		break;
+
+	case 270:
+		offset =3D (get_vrfb_offset(pix->height,ps,SIDE_W) -
pix->height) * ps;
+		temp_ps =3D ps/vr_ps;
+		if (mirroring =3D=3D 0) {
+			cropped_base_phys =3D fb_base_phys + offset +
+			line_length * temp_ps * crop->left + ctop * ps;
+		}
+		else {
+			cropped_base_phys =3D
+			fb_base_phys + offset + line_length * temp_ps *
crop->left +
+			ctop * ps +
+			(line_length * ( (crop->width/vr_ps) - 1) * ps);
+		}
+		break;
+
+	case 0:
+		if (mirroring =3D=3D 0) {
+			cropped_base_phys =3D fb_base_phys
+				+ (line_length * ps) * crop->top +
(crop->left/vr_ps) * ps;
+		}
+		else {
+			cropped_base_phys =3D
+				fb_base_phys + (line_length * ps) *
crop->top +
+				(crop->left/vr_ps) * ps +
+				(line_length * (crop->height - 1) * ps);
+		}
+		break;
+
+	default:
+		if (mirroring =3D=3D 0) {
+			cropped_base_phys =3D fb_base_phys
+				+ line_length * ps * crop->top +
crop->left * ps;
+		}
+		else {
+			cropped_base_phys =3D fb_base_phys
+				+ (line_length * ps * crop->top) / vr_ps
+
+				(crop->left * ps) / vr_ps +
+				((crop->width / vr_ps) - 1) * ps;
+		}
+		break;
+	}
+
+	/*
+	  * We store the information in the layer structure for : If
user
+	  * dynamically switches the pipeline from LCD to TV or vice
versa
+	  * we should have the necessary configurations for the output
device
+	  * (LCD/TV)
+	  */
+
+	/*
+	 * For LCD BA0 and BA1 are same
+	 */
+	layer[ltype].dma[0].ba0 =3D cropped_base_phys;
+	layer[ltype].dma[0].ba1 =3D cropped_base_phys;
+
+	/*
+	 * Store BA0 BA1 for TV, BA1 points to the alternate row
+	 */
+	layer[ltype].dma[1].ba0 =3D cropped_base_phys;
+
+	if (rotation_deg >=3D 0) {
+		if (mirroring =3D=3D 1)layer[ltype].dma[1].ba1 =3D
+					cropped_base_phys - line_length
* ps;
+		else layer[ltype].dma[1].ba1 =3D cropped_base_phys +
line_length * ps;
+	}
+	else {
+		if (mirroring =3D=3D 1)layer[ltype].dma[1].ba1 =3D
cropped_base_phys +
+			line_length * ps/vr_ps;
+		else layer[ltype].dma[1].ba1 =3D cropped_base_phys +
line_length * ps;
+	}
+
+	/* If output path is set to TV */
+	if (omap2_disp_get_output_dev(ltype) =3D=3D OMAP2_OUTPUT_TV) {
+		dispc_reg_out(DISPC_VID_BA0(v), cropped_base_phys);
+		if (rotation_deg >=3D 0) {
+			if (mirroring =3D=3D 1)
+				dispc_reg_out(DISPC_VID_BA1(v),
cropped_base_phys -
+						line_length * ps);
+			else
+				dispc_reg_out(DISPC_VID_BA1(v),
cropped_base_phys +
+						line_length * ps);
+		}
+		else{
+			if (mirroring =3D=3D1)
+				dispc_reg_out(DISPC_VID_BA1(v),
cropped_base_phys +
+						line_length * ps/vr_ps);
+			else
+				dispc_reg_out(DISPC_VID_BA1(v),
cropped_base_phys +
+						line_length * ps);
+		}
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(v),
+			DISPC_VID_ATTRIBUTES_ENABLE,
+			DISPC_VID_ATTRIBUTES_ENABLE);
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+			DISPC_CONTROL_GODIGITAL);
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
+			 struct v4l2_rect *crop, struct v4l2_window
*win,
+			 int rotation_deg, int mirroring)
+{
+	int vid_position_x, vid_position_y, ps =3D 2,vr_ps =3D 1;
+	unsigned long vid_position, vid_size, vid_picture_size;
+	unsigned long vid_attributes;
+	unsigned long firvinc, firhinc;
+	int winheight, winwidth, cropheight, cropwidth, pixheight,
pixwidth;
+	int cleft, ctop;
+	int panelwidth, panelheight, row_inc_value=3D0, pixel_inc_value=3D0;
+
+	/* vertical resizing matrix */
+	const static short int vc[3][8] =3D
+		{ {   0,	3,	12,	32,	0,	7,
5,	2 },
+		  { 128,	123,	111,	89,	64,	89,
111,	123 },
+		  {   0,	2,	5,	7,	64,	32,
12,	3 } };
+	/* horizontal resizing matrix */
+	const static short int hc[5][8] =3D
+		{ {   0,	-1,	-2,	-5,	0,	-2,
-1,	0 },
+		  {   0,	13,	30,	51,	-9,	-11,
-11,	-8 },
+		  { 128,	124,	112,	95,	73,	95,
112,	124 },
+		  {   0,	-8,	-11,	-11,	73,	51,
30,	13 },
+		  {   0,	0,	-1,	-2,	-9,	-5,
-2,	-1 } };
+	int v;
+
+	if (ltype =3D=3D OMAP2_VIDEO1) v =3D 0;
+	else if (ltype =3D=3D OMAP2_VIDEO2) v =3D 1;
+	else return;
+
+	/* make sure the video overlay is disabled before we reconfigure
it */
+	omap2_disp_disable_layer(ltype);
+
+	/* configure the video attributes register */
+	vid_attributes =3D 0;
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+		if (pix->pixelformat =3D=3D V4L2_PIX_FMT_YUYV) {
+			vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDFORMAT_YUV2;
+			vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE;
+		}
+		else{
+			vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDFORMAT_UYVY;
+			vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDCOLORCONVENABLE;
+		}
+
+		if (mirroring =3D=3D 1 || rotation_deg >=3D0) {
+			/*
+			 * ps	  - In VRFB space the pixel size for
YUYV/UYVY is 4 bytes
+			 * vr_ps - Actual pixel size for YUYV/UYVY  is 2
bytes
+			 */
+			ps =3D 4;vr_ps =3D 2;
+		}
+		if (rotation_deg >=3D 0) {
+			if (mirroring =3D=3D 1) {
+				vid_attributes |=3D (rotation_deg =3D=3D 90)?
+					((0x3) <<
DISPC_VID_ATTRIBUTES_VIDROT):
+					(rotation_deg =3D=3D 270)?((0x1) <<
DISPC_VID_ATTRIBUTES_VIDROT):
+					(rotation_deg =3D=3D 0)?(0x2 <<
DISPC_VID_ATTRIBUTES_VIDROT):
+
(0<<DISPC_VID_ATTRIBUTES_VIDROT);
+			}
+			else{
+				vid_attributes |=3D (rotation_deg =3D=3D 90)?
+					((0x3) <<
DISPC_VID_ATTRIBUTES_VIDROT):
+					(rotation_deg =3D=3D 270)?((0x1) <<
DISPC_VID_ATTRIBUTES_VIDROT):
+					((rotation_deg / 90) <<
DISPC_VID_ATTRIBUTES_VIDROT);
+			}
+			vid_attributes |=3D (rotation_deg =3D=3D 90 ||
rotation_deg =3D=3D 270)?
+						(1 <<
DISPC_VID_ATTRIBUTES_VIDROWREPEAT):
+							(0 <<
DISPC_VID_ATTRIBUTES_VIDROWREPEAT);
+		}
+		if (mirroring =3D=3D 1 && rotation_deg =3D=3D -1) {
+			vid_attributes |=3D (0x2 <<
DISPC_VID_ATTRIBUTES_VIDROT);
+		}
+
+	break;
+	case V4L2_PIX_FMT_RGB24:
+		ps =3D 3; /* pixel size is 3 bytes */
+		vid_attributes |=3D DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB24P;
+		vid_attributes |=3D ((dispc_reg_in(DISPC_GFX_ATTRIBUTES) &
+
DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE)
+					<<
DISPC_GFX_ATTRIBUTES_GFXREPEN);
+	break;
+	case V4L2_PIX_FMT_RGB32:
+		ps =3D 4; /* pixel size is 4 bytes */
+		vid_attributes |=3D DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB24;
+		vid_attributes |=3D ((dispc_reg_in(DISPC_GFX_ATTRIBUTES) &
+
DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE)
+					<<
DISPC_GFX_ATTRIBUTES_GFXREPEN);
+	break;
+	case V4L2_PIX_FMT_RGB565:
+	default:
+		ps =3D 2; /* pixel size is 2 bytes */
+		vid_attributes |=3D DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB16;
+		vid_attributes |=3D ((dispc_reg_in(DISPC_GFX_ATTRIBUTES) &
+
DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE)
+					<<
DISPC_GFX_ATTRIBUTES_GFXREPEN);
+		break;
+	case V4L2_PIX_FMT_RGB565X:
+		ps =3D 2; /* pixel size is 2 bytes */
+		vid_attributes |=3D DISPC_VID_ATTRIBUTES_VIDFORMAT_RGB16;
+		vid_attributes |=3D DISPC_VID_ATTRIBUTES_VIDENDIANNESS;
+		vid_attributes |=3D ((dispc_reg_in(DISPC_GFX_ATTRIBUTES) &
+
DISPC_GFX_ATTRIBUTES_GFXREPLICATIONENABLE)
+					<<
DISPC_GFX_ATTRIBUTES_GFXREPEN);
+		break;
+	}
+
+	if (omap2_disp_get_output_dev(ltype) =3D=3D OMAP2_OUTPUT_TV)
+		vid_attributes |=3D DISPC_VID_ATTRIBUTES_VIDCHANNELOUT;
+
+	/* Enable 16 x 32 burst size */
+	vid_attributes |=3D DISPC_VID_ATTRIBUTES_VIDBURSTSIZE_BURST16X32;
+
+	/* Set FIFO threshold to 0xFF (high) and 0xFF - (16x4bytes) =3D
0xC0 (low)*/
+	dispc_reg_out(DISPC_VID_FIFO_THRESHOLD(v),0x00FF00C0);
+
+	/* Set the color converion parameters */
+	set_colorconv(v,pix->colorspace);
+
+	if (rotation_deg =3D=3D 90 || rotation_deg =3D=3D 270) {
+		winheight	=3D win->w.width;
+		winwidth	=3D win->w.height;
+		cropheight	=3D crop->width;
+		cropwidth	=3D crop->height;
+		pixheight	=3D pix->width;
+		pixwidth	=3D pix->height;
+		cleft		=3D crop->top;
+		ctop		=3D crop->left;
+	} else {
+		winwidth	=3D win->w.width;
+		winheight	=3D win->w.height;
+		cropwidth	=3D crop->width;
+		cropheight	=3D crop->height;
+		pixheight	=3D pix->height;
+		pixwidth	=3D pix->width;
+		ctop		=3D crop->top;
+		cleft		=3D crop->left;
+	}
+
+	if (winwidth !=3D cropwidth) {
+		vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_HRESIZE;
+		if (winwidth < cropwidth)
+			vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDHRESIZECONF;
+	}
+	if (winheight !=3D cropheight) {
+		vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDRESIZEENABLE_VRESIZE;
+		if (winheight < cropheight)
+			vid_attributes |=3D
DISPC_VID_ATTRIBUTES_VIDVRESIZECONF;
+	}
+	dispc_reg_out(DISPC_VID_ATTRIBUTES(v), vid_attributes);
+
+	/* initialize the resizing filter */
+	omap2_disp_set_resize(v, vc, hc);
+
+	dispc_reg_out(DISPC_VID_ACCU0(v), 0);
+	dispc_reg_out(DISPC_VID_ACCU1(v), 0);
+	firhinc =3D (1024 * (cropwidth - 1)) / (winwidth - 1);
+	if (firhinc < 1)
+		firhinc =3D 1;
+	else if (firhinc > 2047)
+		firhinc =3D 2047;
+	firvinc =3D (1024 * (cropheight - 1)) / (winheight - 1);
+	if (firvinc < 1)
+		firvinc =3D 1;
+	else if (firvinc > 2047)
+		firvinc =3D 2047;
+	dispc_reg_out(DISPC_VID_FIR(v), firhinc | (firvinc << 16));
+
+	omap2_disp_get_panel_size(omap2_disp_get_output_dev(ltype),
&panelwidth,
+				  &panelheight);
+
+	/* configure the target window on the display */
+	switch (rotation_deg) {
+
+	case 90:
+		vid_position_y =3D (panelheight - win->w.width) -
win->w.left;
+		vid_position_x =3D win->w.top;
+		break;
+
+	case 180:
+		vid_position_x =3D (panelwidth - win->w.width) -
win->w.left;
+		vid_position_y =3D (panelheight - win->w.height) -
win->w.top;
+		break;
+
+	case 270:
+		vid_position_y =3D win->w.left;
+		vid_position_x =3D (panelwidth - win->w.height) -
win->w.top;
+		break;
+
+	default:
+		vid_position_x =3D win->w.left;
+		vid_position_y =3D win->w.top;
+		break;
+	}
+
+	if (omap2_disp_get_output_dev(ltype) =3D=3D OMAP2_OUTPUT_TV)
+		vid_position_y =3D vid_position_y/2;
+
+	/*
+	 * 	If Scaling is enabled for TV then the window height
should be divided by two
+	 */
+
+	if ((omap2_disp_get_output_dev(ltype) =3D=3D OMAP2_OUTPUT_TV) &&
+			(winheight !=3D cropheight) ) {
+		vid_size =3D (((winwidth - 1) <<
DISPC_VID_SIZE_VIDSIZEX_SHIFT)
+			& DISPC_VID_SIZE_VIDSIZEX)
+			| ((((winheight - 1)/2) <<
DISPC_VID_SIZE_VIDSIZEY_SHIFT)
+			& DISPC_VID_SIZE_VIDSIZEY);
+	}
+
+	else{
+		vid_size =3D (((winwidth - 1) <<
DISPC_VID_SIZE_VIDSIZEX_SHIFT)
+			& DISPC_VID_SIZE_VIDSIZEX)
+			| (((winheight - 1) <<
DISPC_VID_SIZE_VIDSIZEY_SHIFT)
+			& DISPC_VID_SIZE_VIDSIZEY);
+	}
+
+	/* configure the source window in the framebuffer */
+	if (omap2_disp_get_output_dev(ltype) =3D=3D OMAP2_OUTPUT_TV) {
+		vid_picture_size =3D
+			(((cropwidth -
+			1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+			& DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+			(((cropheight / 2 -
+			1) << DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+			& DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+	}
+
+	else {
+		vid_picture_size =3D
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
+		if (rotation_deg =3D=3D 90 || rotation_deg =3D=3D 270) {
+			row_inc_value =3D
+				1 + (MAX_PIXELS_PER_LINE - pixwidth +
+				(pixwidth - cropwidth - cleft) + cleft)
* ps;
+
+		}
+		else if (rotation_deg =3D=3D 180 || rotation_deg =3D=3D 0) {
+			if (V4L2_PIX_FMT_YUYV =3D=3D pix->pixelformat
+				|| V4L2_PIX_FMT_UYVY =3D=3D
pix->pixelformat)
+				row_inc_value =3D
+					1 + (MAX_PIXELS_PER_LINE -
+					(pixwidth/ vr_ps) + ((pixwidth -
cropwidth - cleft)/vr_ps)
+					+ (cleft / vr_ps) ) * ps;
+
+			else
+				row_inc_value =3D
+					1 + (MAX_PIXELS_PER_LINE -
pixwidth +
+					(pixwidth -
+					cropwidth - cleft) + cleft) *
ps;
+		}
+		else {
+			row_inc_value =3D 1 + (pix->width * ps) -
cropwidth * ps;
+		}
+		pixel_inc_value =3D 1;
+		break;
+
+	case 1:		/* Mirroring */
+		if (rotation_deg =3D=3D 90 || rotation_deg =3D=3D 270) {
+			row_inc_value =3D (-(MAX_PIXELS_PER_LINE +
cropwidth) * ps) + 1;
+			pixel_inc_value =3D 1;
+		} else if (rotation_deg =3D=3D 180 || rotation_deg =3D=3D 0) {
+			row_inc_value =3D (-(MAX_PIXELS_PER_LINE +
(cropwidth / vr_ps))
+					 * ps) + 1;
+			pixel_inc_value =3D 1;
+		} else {
+			row_inc_value =3D
+				2 * ((cropwidth / vr_ps) -
+				1) * ps + 1 +
+				((pix->width * ps) / vr_ps) -
+				(cropwidth / vr_ps) * ps;
+			pixel_inc_value =3D (-2 * ps) + 1;
+		}
+		break;
+	}			/* Mirroring Switch */
+
+	/*
+	 * For LCD row inc and pixel inc
+	 */
+
+	layer[ltype].dma[0].row_inc =3D row_inc_value;
+	layer[ltype].dma[0].pix_inc =3D pixel_inc_value;
+
+	if (omap2_disp_get_output_dev(ltype) =3D=3D OMAP2_OUTPUT_LCD) {
+		dispc_reg_out(DISPC_VID_ROW_INC(v), row_inc_value);
+		dispc_reg_out(DISPC_VID_PIXEL_INC(v), pixel_inc_value);
+	}
+
+	/*
+	  * For TV the row increment should be done twice as the
+	  * TV operates in interlaced mode
+	  */
+
+	else {
+		if (rotation_deg >=3D 0) {
+			if (mirroring =3D=3D1) row_inc_value =3D row_inc_value
-
+				MAX_PIXELS_PER_LINE * ps;
+			else	row_inc_value =3D row_inc_value +
MAX_PIXELS_PER_LINE * ps;
+		}
+		else{
+			if (mirroring =3D=3D1) row_inc_value =3D row_inc_value
+
+				pix->width * ps / vr_ps;
+			else	row_inc_value =3D row_inc_value +
pix->width * ps;
+		}
+		dispc_reg_out(DISPC_VID_ROW_INC(v), row_inc_value);
+		dispc_reg_out(DISPC_VID_PIXEL_INC(v), pixel_inc_value);
+	}
+
+	/*
+	 * Store BA0 BA1 for TV, BA1 points to the alternate row
+	 */
+	if (rotation_deg >=3D 0) {
+		if (mirroring =3D=3D1)
+			layer[ltype].dma[1].row_inc =3D row_inc_value -
+				MAX_PIXELS_PER_LINE * ps;
+		else
+			layer[ltype].dma[1].row_inc =3D row_inc_value +
+				MAX_PIXELS_PER_LINE * ps;
+	}
+	else{
+		if (mirroring =3D=3D1) layer[ltype].dma[1].row_inc =3D
+			row_inc_value + pix->width * ps/vr_ps;
+		else	row_inc_value =3D row_inc_value + pix->width * ps;
+
+	}
+	layer[ltype].dma[1].pix_inc =3D pixel_inc_value;
+	layer[ltype].size_x =3D cropwidth;
+	layer[ltype].size_y =3D cropheight;
+
+	vid_position =3D ((vid_position_x <<
DISPC_VID_POSITION_VIDPOSX_SHIFT)
+			& DISPC_VID_POSITION_VIDPOSX)
+			| ((vid_position_y <<
DISPC_VID_POSITION_VIDPOSY_SHIFT)
+			& DISPC_VID_POSITION_VIDPOSY);
+	dispc_reg_out(DISPC_VID_POSITION(v), vid_position);
+	dispc_reg_out(DISPC_VID_SIZE(v), vid_size);
+	dispc_reg_out(DISPC_VID_PICTURE_SIZE(v), vid_picture_size);
+}
+/*---------------------------------------------------------------------
------*/
+
+/* Many display controller registers are shadowed. Setting the GO bit
causes
+ * changes to these registers to take effect in hardware.
+ */
+void
+omap2_disp_reg_sync(int output_dev)
+{
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD)
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GOLCD,
+				DISPC_CONTROL_GOLCD);
+	else
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
+				DISPC_CONTROL_GODIGITAL);
+}
+
+/* This function provides the status of the GO bit. After the GO bit is
set
+ * through software, register changes take affect at the next VFP
(vertical
+ * front porch) or EVSYNC. Per the specs, no further register changes
+ * must be done until the GO bit is reset by hardware. This function
allows
+ * drivers to poll the status of the GO bit, and wait until it is reset
if they
+ * wish to.
+ */
+int
+omap2_disp_reg_sync_done(int output_dev)
+{
+	u32 control =3D dispc_reg_in(DISPC_CONTROL);
+
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD)
+		return ~(control & DISPC_CONTROL_GOLCD);
+	else
+		return ~(control & DISPC_CONTROL_GODIGITAL);
+}
+
+
+/*
+ * Disable the display controller. May be called in interrupt or
process
+ * context. However, this function should not be called with interrupts
+ * disabled as jiffies will not increment.
+ */
+void
+omap2_disp_disable(unsigned long timeout_ticks)
+{
+	unsigned long timeout;
+
+	if (dispc_reg_in(DISPC_CONTROL)
+		& (DISPC_CONTROL_DIGITALENABLE |
DISPC_CONTROL_LCDENABLE))
+	{
+		/* disable the display controller */
+		dispc_reg_merge(DISPC_CONTROL, 0,
+			DISPC_CONTROL_DIGITALENABLE |
DISPC_CONTROL_LCDENABLE);
+
+		/* wait for any frame in progress to complete */
+		dispc_reg_out(DISPC_IRQSTATUS,
+				DISPC_IRQSTATUS_FRAMEDONE);
+		timeout =3D jiffies + timeout_ticks;
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
+			  & DISPC_IRQSTATUS_FRAMEDONE)) {
+			printk(KERN_WARNING "timeout waiting for "
+					"frame-done interrupt\n");
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
+	u32 config =3D 0;
+	u32 gfx_attributes =3D 0, gfx_fifo_threshold =3D 0, gfx_format =3D 0;
+	u32 gfx_position =3D 0, gfx_window_skip =3D 0;
+
+
+	config =3D dispc_reg_in(DISPC_CONFIG);
+
+	config |=3D (DISPC_CONFIG_LOADMODE_PGTABUSETB |
+			DISPC_CONFIG_LOADMODE_FRDATLEFR);
+
+	/* This driver doesn't currently support the video windows, so
+	 * we force the palette/gamma table to be a palette table and
+	 * force both video windows to be disabled.
+	 */
+	config &=3D ~DISPC_CONFIG_PALETTEGAMMATABLE;
+
+	gfx_attributes =3D DISPC_GFX_ATTRIBUTES_GFXBURSTSIZE_BURST16X32;
+
+	/* enable the graphics window only if its size is not zero */
+	if (size_x > 0 && size_y > 0)
+		gfx_attributes |=3D DISPC_GFX_ATTRIBUTES_ENABLE;
+
+	gfx_fifo_threshold =3D (255 <<
DISPC_GFX_FIFO_THRESHOLD_HIGH_SHIFT)
+				  | (192 <<
DISPC_GFX_FIFO_THRESHOLD_LOW_SHIFT);
+	gfx_position =3D 0;
+	gfx_window_skip =3D 0;
+
+	switch(color_depth) {
+		case 1:
+			gfx_format =3D
DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP1;
+			break;
+		case 2:
+			gfx_format =3D
DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP2;
+			break;
+		case 4:
+			gfx_format =3D
DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP4;
+			break;
+		case 8:
+			gfx_format =3D
DISPC_GFX_ATTRIBUTES_GFXFORMAT_BITMAP8;
+			break;
+		case 12:
+			gfx_format =3D
DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB12;
+			break;
+		case 16:
+			gfx_format =3D
DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB16;
+			break;
+		case 24:
+			gfx_format =3D
DISPC_GFX_ATTRIBUTES_GFXFORMAT_RGB24;
+			break;
+		default:
+			gfx_format =3D dispc_reg_in(DISPC_GFX_ATTRIBUTES)
+					&
DISPC_GFX_ATTRIBUTES_GFXFORMAT;
+			break;
+	}
+
+	gfx_attributes |=3D gfx_format;
+
+	dispc_reg_out(DISPC_GFX_FIFO_THRESHOLD, gfx_fifo_threshold);
+	dispc_reg_out(DISPC_GFX_POSITION, gfx_position);
+	dispc_reg_out(DISPC_GFX_WINDOW_SKIP, gfx_window_skip);
+
+	dispc_reg_out(DISPC_CONFIG, config);
+	dispc_reg_out(DISPC_GFX_ATTRIBUTES, gfx_attributes);
+
+	layer[OMAP2_GRAPHICS].size_x =3D size_x;
+	layer[OMAP2_GRAPHICS].size_y =3D size_y;
+}
+
+/* Calculate the number of pixels sent to the display per pixel clock
as
+ * (nom/den) pixels per clock.
+ */
+void
+omap2_disp_pixels_per_clock(unsigned int *nom, unsigned int *den)
+{
+	u32 dispc_control;
+
+	dispc_control =3D dispc_reg_in(DISPC_CONTROL);
+
+	if (dispc_control & DISPC_CONTROL_STNTFT) {
+		/* active display (TFT) */
+		if (dispc_control & DISPC_CONTROL_TDMENABLE) {
+			/* TFT with TDM */
+			switch (dispc_control &
DISPC_CONTROL_TDMCYCLEFORMAT) {
+				case
DISPC_CONTROL_TDMCYCLEFORMAT_1CYCPERPIX:
+					*nom =3D 1;
+					*den =3D 1;
+					break;
+				case
DISPC_CONTROL_TDMCYCLEFORMAT_2CYCPERPIX:
+					*nom =3D 1;
+					*den =3D 2;
+					break;
+				case
DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPERPIX:
+					*nom =3D 1;
+					*den =3D 3;
+					break;
+				case
DISPC_CONTROL_TDMCYCLEFORMAT_3CYCPER2PIX:
+					*nom =3D 2;
+					*den =3D 3;
+					break;
+			}
+		}
+		else {
+			/* TFT without TDM */
+			*nom =3D 1;
+			*den =3D 1;
+		}
+	}
+	else {
+		/* passive display (STN) */
+		if (dispc_control & DISPC_CONTROL_MONOCOLOR) {
+			/* STN mono */
+			if (dispc_control & DISPC_CONTROL_M8B) {
+				/* 8 pixels per pixclock */
+				*nom =3D 8;
+				*den =3D 1;
+			}
+			else {
+				/* 4 pixels per pixclock */
+				*nom =3D 4;
+				*den =3D 1;
+			}
+		}
+		else {
+			/* STN color--8 pixels per 3 pixclocks */
+			*nom =3D 8;
+			*den =3D 3;
+		}
+	}
+}
+
+/* Configure LCD parameters */
+void
+omap2_disp_config_lcd(u32 clkdiv,
+			  u32 hbp, u32 hfp, u32 hsw,
+			  u32 vbp, u32 vfp, u32 vsw,
+			  u32 hsync_high, u32 vsync_high)
+{
+	u32 control, divisor, timing_h, timing_v, pol_freq =3D 0;
+
+	divisor =3D (1 << DISPC_DIVISOR_LCD_SHIFT)
+				| (clkdiv << DISPC_DIVISOR_PCD_SHIFT);
+
+	if (hbp > 255)
+		hbp =3D 255;
+	if (hfp > 255)
+		hfp =3D 255;
+	if (hsw > 63)
+		hsw =3D 63;
+
+	if (vbp > 255)
+		vbp =3D 255;
+	if (vfp > 255)
+		vfp =3D 255;
+	if (vsw > 63)
+		vsw =3D 63;
+
+	timing_h =3D (hbp << DISPC_TIMING_H_HBP_SHIFT)
+			| (hfp << DISPC_TIMING_H_HFP_SHIFT)
+			| (hsw << DISPC_TIMING_H_HSW_SHIFT);
+
+	timing_v =3D (vbp << DISPC_TIMING_V_VBP_SHIFT)
+			| (vfp << DISPC_TIMING_V_VFP_SHIFT)
+			| (vsw << DISPC_TIMING_V_VSW_SHIFT);
+
+	/* set the sync polarity */
+	if (!hsync_high)
+		pol_freq &=3D  ~DISPC_POL_FREQ_IHS;
+	else
+		pol_freq |=3D  DISPC_POL_FREQ_IHS;
+
+	if (!vsync_high)
+		pol_freq &=3D ~DISPC_POL_FREQ_IVS;
+	else
+		pol_freq |=3D  DISPC_POL_FREQ_IVS;
+
+	dispc_reg_out(DISPC_TIMING_H, timing_h);
+	dispc_reg_out(DISPC_TIMING_V, timing_v);
+	dispc_reg_out(DISPC_POL_FREQ, pol_freq);
+	dispc_reg_out(DISPC_DIVISOR, divisor);
+
+	control =3D dispc_reg_in(DISPC_CONTROL);
+
+	control |=3D DISPC_CONTROL_GPOUT1
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
+			 (pcd << DISPC_DIVISOR_PCD_SHIFT));
+}
+
+/*
+ * Set the DSS Functional clock
+ * The DSS clock should be 4 times the Panel's Pixel clock
+ * For TV the Pixel clock required is 13.5Mhz
+ * For LCD the Pixel clock is 6Mhz
+ */
+void
+omap2_disp_set_dssfclk(void)
+{
+	static int LCD_pixel_clk =3D 10000000; /* to get more bandwidth*/
+#ifdef CONFIG_VIDEO_OMAP24XX_TVOUT
+	static int TV_pixel_clk  =3D 14000000; /* rounded 13.5 to 14*/
+#endif
+	u32 ask_clkrate=3D0,sup_clkrate=3D0,tgt_clkrate=3D0,i;
+
+	ask_clkrate =3D LCD_pixel_clk * 4;
+
+#ifdef CONFIG_VIDEO_OMAP24XX_TVOUT
+	if (ask_clkrate < (TV_pixel_clk * 4))
+		ask_clkrate =3D TV_pixel_clk * 4;
+#endif
+
+	tgt_clkrate =3D ask_clkrate;
+
+	for(i=3D1;i<=3D20;i++) {
+		sup_clkrate =3D clk_round_rate(dss1f_scale, ask_clkrate);
+		if (sup_clkrate >=3D tgt_clkrate) break;
+		ask_clkrate =3D ask_clkrate + 1000000;
+	}
+	if (clk_set_rate(dss1f_scale,sup_clkrate)=3D=3D-EINVAL)
+		printk(KERN_ERR "Unable to set the DSS functional clock
to %d\n"
+
,sup_clkrate);
+}
+
+static void
+omap24xx_ll_config_disp_clocks(int sleep_state)
+{
+	static int start =3D 1;
+	int (*clk_onoff)(struct clk *clk) =3D NULL;
+
+	if (start) {
+		omap2_disp_set_dssfclk();
+		start =3D 0;
+	}
+
+	if (sleep_state =3D=3D 1)
+		clk_onoff =3D (int (*)(struct clk *))clk_unuse;
+	else {
+		clk_onoff =3D clk_use;
+	}
+
+	clk_onoff(dss1i);
+	clk_onoff(dss1f);
+	if (sleep_state !=3D 1)
+		clk_safe(dss1f);
+}
+
+/* This function must be called by any driver that needs to use the
display
+ * controller before calling any routine that accesses the display
controller
+ * registers. It increments the count of the number of users of the
display
+ * controller, and turns the clocks ON only when required.
+ */
+void
+omap2_disp_get_dss(void)
+{
+	spin_lock(&dss_lock);
+	if (disp_usage =3D=3D 0) {
+	 	/* turn on DSS clock */
+		omap24xx_ll_config_disp_clocks(0);
+
+		/* remove smart idle */
+		prcm_autoidle_ctrl(PRCM_DSS, DISABLE);
+		prcm_set_idlemode_handshake(PRCM_DSS, CLEAR_SMARTIDLE);
+		prcm_autoidle_ctrl(PRCM_DSS, ENABLE);
+		prcm_set_idlemode_handshake(PRCM_DSS, SMART_IDLE_M);
+	}
+	disp_usage++;
+	spin_unlock(&dss_lock);
+}
+
+/* This function must be called by a driver when it not going to use
the
+ * display controller anymore. E.g., when a driver suspends, it must
call
+ * omap2_disp_put_dss. When it wakes up, it must call
omap2_disp_get_dss again.
+ * It decrements the count of the number of users of the display
+ * controller, and turns the clocks OFF when not required.
+ */
+void
+omap2_disp_put_dss(void)
+{
+	spin_lock(&dss_lock);
+	if (disp_usage =3D=3D 0) {
+		printk(KERN_ERR "trying to put DSS when usage count is
zero\n");
+		spin_unlock(&dss_lock);
+		return;
+	}
+
+	disp_usage--;
+
+	if (disp_usage =3D=3D 0) {
+		/* smart idle on */
+		prcm_autoidle_ctrl(PRCM_DSS, DISABLE);
+		prcm_set_idlemode_handshake(PRCM_DSS, CLEAR_SMARTIDLE);
+		prcm_autoidle_ctrl(PRCM_DSS, ENABLE);
+		prcm_set_idlemode_handshake(PRCM_DSS, SMART_IDLE_M);
+
+		/* turn off DSS clock */
+		omap24xx_ll_config_disp_clocks(1);
+	}
+	spin_unlock(&dss_lock);
+}
+
+void
+omap2_disp_lpm_enter(void)
+{
+	/*Disable LCD*/
+	dispc_reg_merge(DISPC_CONTROL, ~DISPC_CONTROL_LCDENABLE,
+			DISPC_CONTROL_LCDENABLE);
+
+	/* Turn ON APLL 48Mhz DSS FCLK2 */
+	clk_use(dss2f);
+	clk_safe(dss2f);
+
+	/* Modify Pixel Clock Divisor */
+	dispc_reg_out(DISPC_DIVISOR, (1 << DISPC_DIVISOR_LCD_SHIFT) |
+					 (8 <<
DISPC_DIVISOR_PCD_SHIFT));
+
+	/* Switch to DSS FCLK2 */
+	dss_reg_out(DSS_CONTROL, (dss_reg_in(DSS_CONTROL) |
+					DSS_CONTROL_APLL_CLK));
+	/* Enable LCD */
+	dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_LCDENABLE,
+			DISPC_CONTROL_LCDENABLE);
+
+	omap2_disp_reg_sync(OMAP2_OUTPUT_LCD);
+
+	/* Wait till clock is set */
+	while (omap_readl(0x4805005C) =3D=3D 0x1) {
+		udelay(1);
+	}
+
+	/* Turn OFF DSS FCLK1 */
+	clk_unuse(dss1f);
+}
+
+void
+omap2_disp_lpm_exit(void)
+{
+	/* Disable LCD */
+	dispc_reg_merge(DISPC_CONTROL, ~DISPC_CONTROL_LCDENABLE,
+			DISPC_CONTROL_LCDENABLE);
+
+	/* Turn ON DPLL DSS FCLK1 */
+	clk_use(dss1f);
+	clk_safe(dss1f);
+
+	/* Modify Pixel Clock Divisor */
+	dispc_reg_out(DISPC_DIVISOR, (1 << DISPC_DIVISOR_LCD_SHIFT) |
+					 (dispc.divisor <<
DISPC_DIVISOR_PCD_SHIFT));
+
+	omap2_disp_reg_sync(OMAP2_OUTPUT_LCD);
+
+	/* Switch to DSS FCLK1 */
+	dss_reg_out(DSS_CONTROL, (dss_reg_in(DSS_CONTROL) &
+					~DSS_CONTROL_APLL_CLK));
+	/* Enable LCD */
+	dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_LCDENABLE,
+			DISPC_CONTROL_LCDENABLE);
+
+	omap2_disp_reg_sync(OMAP2_OUTPUT_LCD);
+
+	/* Wait till clock is set */
+	while (omap_readl(0x4805005C) =3D=3D 0x2) {
+		udelay(1);
+	}
+
+	/* Turn OFF DSS FCLK2 */
+	clk_unuse(dss2f);
+}
+
+/* This function must be called by any driver that wishes to use a
particular
+ * display pipeline (layer).
+ */
+int
+omap2_disp_request_layer(int ltype)
+{
+	int ret =3D 0;
+
+	spin_lock(&dss_lock);
+	if (!layer[ltype].in_use) {
+		layer[ltype].in_use =3D 1;
+		ret =3D 1;
+	}
+	spin_unlock(&dss_lock);
+
+	return ret;
+}
+
+/* This function must be called by a driver when it is done using a
particular
+ * display pipeline (layer).
+ */
+void
+omap2_disp_release_layer(int ltype)
+{
+	spin_lock(&dss_lock);
+	layer[ltype].in_use =3D 0;
+	spin_unlock(&dss_lock);
+}
+
+/* Used to enable LCDENABLE or DIGITALENABLE of the display controller.
+ */
+void
+omap2_disp_enable_output_dev(int output_dev)
+{
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+		dispc_reg_merge(DISPC_CONTROL, DISPC_CONTROL_LCDENABLE,
+				DISPC_CONTROL_LCDENABLE);
+	}
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+		dispc_reg_merge(DISPC_CONTROL,
DISPC_CONTROL_DIGITALENABLE,
+				DISPC_CONTROL_DIGITALENABLE);
+	}
+}
+
+/* Used to disable LCDENABLE or DIGITALENABLE of the display
controller.
+ */
+void
+omap2_disp_disable_output_dev(int output_dev)
+{
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+		dispc_reg_merge(DISPC_CONTROL, ~DISPC_CONTROL_LCDENABLE,
+				DISPC_CONTROL_LCDENABLE);
+	}
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+		dispc_reg_merge(DISPC_CONTROL,
~DISPC_CONTROL_DIGITALENABLE,
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
+/* This is used to dynamically switch the output of a particular layer
to
+ * either the LCD or TV.
+ */
+void
+omap2_disp_set_output_dev(int ltype, int output_dev)
+{
+	struct omap2_disp_dma_params *dma_param =3D 0;
+	int vid_pic_size =3D 0;
+	int val =3D (output_dev =3D=3D OMAP2_OUTPUT_LCD) ? 0 : ~0;
+
+	layer[ltype].output_dev =3D output_dev;
+
+	switch(ltype) {
+	case OMAP2_GRAPHICS:
+		if (layer[ltype].in_use) {
+			if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+				int gfx_size =3D 0;
+				dma_param =3D
&layer[OMAP2_GRAPHICS].dma[0];
+
+				gfx_size =3D
(((layer[OMAP2_GRAPHICS].size_x - 1)
+						<<
DISPC_GFX_SIZE_GFXSIZEX_SHIFT)
+						  &
DISPC_GFX_SIZE_GFXSIZEX)
+						|
(((layer[OMAP2_GRAPHICS].size_y - 1)
+						<<
DISPC_GFX_SIZE_GFXSIZEY_SHIFT)
+						  &
DISPC_GFX_SIZE_GFXSIZEY);
+				dispc_reg_out(DISPC_GFX_SIZE, gfx_size);
+			}
+			else if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+				int gfx_size =3D 0;
+				dma_param =3D
&layer[OMAP2_GRAPHICS].dma[1];
+				/* dividing the size_y by two,
+				 * because TV operates in interleaved
mode
+				 */
+				gfx_size =3D
(((layer[OMAP2_GRAPHICS].size_x - 1)
+						<<
DISPC_GFX_SIZE_GFXSIZEX_SHIFT)
+						  &
DISPC_GFX_SIZE_GFXSIZEX)
+						|
(((layer[OMAP2_GRAPHICS].size_y/2 - 1)
+						<<
DISPC_GFX_SIZE_GFXSIZEY_SHIFT)
+						  &
DISPC_GFX_SIZE_GFXSIZEY);
+				dispc_reg_out(DISPC_GFX_SIZE, gfx_size);
+			}
+
+			dispc_reg_out(DISPC_GFX_BA0, dma_param->ba0);
+			dispc_reg_out(DISPC_GFX_BA1, dma_param->ba1);
+			dispc_reg_out(DISPC_GFX_ROW_INC,
dma_param->row_inc);
+			dispc_reg_out(DISPC_GFX_PIXEL_INC,
dma_param->pix_inc);
+		}
+		dispc_reg_merge(DISPC_GFX_ATTRIBUTES,
+				DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT &
val,
+				DISPC_GFX_ATTRIBUTES_GFXCHANNELOUT);
+
+		break;
+
+	case OMAP2_VIDEO1:
+		if (!layer[ltype].in_use) {
+			if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+				dma_param =3D &layer[OMAP2_VIDEO1].dma[0];
+				vid_pic_size =3D
+					(((layer[OMAP2_VIDEO1].size_x -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO1].size_y -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(0),
vid_pic_size);
+
+			} else if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+				dma_param =3D &layer[OMAP2_VIDEO1].dma[1];
+				vid_pic_size =3D
+					(((layer[OMAP2_VIDEO1].size_x -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO1].size_y /
2 -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(0),
vid_pic_size);
+			}
+
+			dispc_reg_out(DISPC_VID_BA0(0), dma_param->ba0);
+			dispc_reg_out(DISPC_VID_BA1(0), dma_param->ba1);
+			dispc_reg_out(DISPC_VID_ROW_INC(0),
dma_param->row_inc);
+			dispc_reg_out(DISPC_VID_PIXEL_INC(0),
dma_param->pix_inc);
+		}
+
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(0),
+				DISPC_VID_ATTRIBUTES_VIDCHANNELOUT &
val,
+				DISPC_VID_ATTRIBUTES_VIDCHANNELOUT);
+
+		break;
+	case OMAP2_VIDEO2:
+		if (!layer[ltype].in_use) {
+			if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+				dma_param =3D &layer[OMAP2_VIDEO2].dma[0];
+				vid_pic_size =3D
+					(((layer[OMAP2_VIDEO2].size_x -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO2].size_y -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(1),
vid_pic_size);
+
+			} else if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+				dma_param =3D &layer[OMAP2_VIDEO2].dma[1];
+				vid_pic_size =3D
+					(((layer[OMAP2_VIDEO2].size_x -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEX) |
+					(((layer[OMAP2_VIDEO2].size_y /
2 -
+					1) <<
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY_SHIFT)
+					&
DISPC_VID_PICTURE_SIZE_VIDORGSIZEY);
+				dispc_reg_out(DISPC_VID_PICTURE_SIZE(1),
vid_pic_size);
+
+			}
+
+			dispc_reg_out(DISPC_VID_BA0(1), dma_param->ba0);
+			dispc_reg_out(DISPC_VID_BA1(1), dma_param->ba1);
+			dispc_reg_out(DISPC_VID_ROW_INC(1),
dma_param->row_inc);
+			dispc_reg_out(DISPC_VID_PIXEL_INC(1),
dma_param->pix_inc);
+		}
+
+		dispc_reg_merge(DISPC_VID_ATTRIBUTES(1),
+				DISPC_VID_ATTRIBUTES_VIDCHANNELOUT &
val,
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
+ * omap2_disp_set_output_dev() function to dynamically switch the
output of a
+ * layer to any output device.
+ */
+void
+omap2_disp_set_dma_params(int ltype, int output_dev,
+			  u32 ba0, u32 ba1, u32 row_inc, u32 pix_inc)
+{
+	struct omap2_disp_dma_params *dma;
+
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD)
+		dma =3D &layer[ltype].dma[0];
+	else
+		dma =3D &layer[ltype].dma[1];
+
+	dma->ba0 =3D ba0;
+	dma->ba1 =3D ba1;
+	dma->row_inc =3D row_inc;
+	dma->pix_inc =3D pix_inc;
+}
+
+void
+omap2_disp_start_gfxlayer(void)
+{
+	omap2_disp_set_output_dev(OMAP2_GRAPHICS,
+
layer[OMAP2_GRAPHICS].output_dev);
+}
+
+/*---------------------------------------------------------------------
------*/
+
+/* Sets the background color */
+void
+omap2_disp_set_bg_color(int output_dev, int color)
+{
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD)
+		dispc_reg_out(DISPC_DEFAULT_COLOR0, color);
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV)
+		dispc_reg_out(DISPC_DEFAULT_COLOR1, color);
+
+	omap2_disp_reg_sync(output_dev);
+}
+
+/* Returns the current background color */
+void
+omap2_disp_get_bg_color(int output_dev, int *color)
+{
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD)
+		*color =3D dispc_reg_in(DISPC_DEFAULT_COLOR0);
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV)
+		*color =3D dispc_reg_in(DISPC_DEFAULT_COLOR1);
+}
+
+/* Enable/Disable the Dithering block */
+void
+omap2_disp_set_dithering(int dither_state)
+{
+	switch(dither_state) {
+	case DITHERING_ON:
+		dispc_reg_out(DISPC_CONTROL,
+			(dispc_reg_in(DISPC_CONTROL) |
DISPC_CONTROL_TFTDITHERENABLE));
+	break;
+	case DITHERING_OFF:
+		dispc_reg_out(DISPC_CONTROL,
+			(dispc_reg_in(DISPC_CONTROL) &
~DISPC_CONTROL_TFTDITHERENABLE));
+	break;
+	}
+	omap2_disp_reg_sync(OMAP2_OUTPUT_LCD);
+	omap2_disp_reg_sync(OMAP2_OUTPUT_TV);
+}
+
+/* Get the Dithering state */
+int
+omap2_disp_get_dithering(void)
+{
+	if (dispc_reg_in(DISPC_CONTROL) & 0x00000080) {
+		return(DITHERING_ON);
+	}
+	else{
+		return(DITHERING_OFF);
+	}
+}
+
+/* Get the number of data lines connected to LCD panel*/
+int
+omap2_disp_get_lcddatalines(void)
+{
+	u32 tft_data_lines=3D0;
+	tft_data_lines =3D dispc_reg_in(DISPC_CONTROL)
+					& (DISPC_CONTROL_TFTDATALINES);
+
+	switch(tft_data_lines) {
+	case DISPC_CONTROL_TFTDATALINES_OALSB12B:
+		return(LCD_DATA_LINE_12BIT);
+	case DISPC_CONTROL_TFTDATALINES_OALSB16B:
+		return(LCD_DATA_LINE_16BIT);
+	case DISPC_CONTROL_TFTDATALINES_OALSB18B:
+		return(LCD_DATA_LINE_18BIT);
+	case DISPC_CONTROL_TFTDATALINES_OALSB24B:
+		return(LCD_DATA_LINE_24BIT);
+	}
+	return(LCD_DATA_LINE_16BIT);
+}
+
+/* Set number of data lines to be connected to LCD panel*/
+void
+omap2_disp_set_lcddatalines(int no_of_lines)
+{
+	dispc_reg_out(DISPC_CONTROL,
+		(dispc_reg_in(DISPC_CONTROL) &
~DISPC_CONTROL_TFTDATALINES));
+
+	switch(no_of_lines) {
+	case LCD_DATA_LINE_12BIT:
+		dispc_reg_out(DISPC_CONTROL,
+			(dispc_reg_in(DISPC_CONTROL)
+				| DISPC_CONTROL_TFTDATALINES_OALSB12B));
+	break;
+	case LCD_DATA_LINE_16BIT:
+		dispc_reg_out(DISPC_CONTROL,
+			(dispc_reg_in(DISPC_CONTROL)
+				| DISPC_CONTROL_TFTDATALINES_OALSB16B));
+	break;
+	case LCD_DATA_LINE_18BIT:
+		dispc_reg_out(DISPC_CONTROL,
+			(dispc_reg_in(DISPC_CONTROL)
+					|
DISPC_CONTROL_TFTDATALINES_OALSB18B));
+	break;
+	case LCD_DATA_LINE_24BIT:
+		dispc_reg_out(DISPC_CONTROL,
+			(dispc_reg_in(DISPC_CONTROL)
+					|
DISPC_CONTROL_TFTDATALINES_OALSB24B));
+	break;
+	}
+	omap2_disp_reg_sync(OMAP2_OUTPUT_LCD);
+}
+
+#ifdef CONFIG_ARCH_OMAP243X
+/* Turn on/off the TV reference voltage from OMAP */
+void
+omap2_disp_set_tvref(int tvref_state)
+{
+	switch(tvref_state) {
+	case TVREF_ON:
+		dss_reg_out(DSS_CONTROL,(dss_reg_in(DSS_CONTROL)
+						| DSS_CONTROL_TV_REF));
+		break;
+	case TVREF_OFF:
+		dss_reg_out(DSS_CONTROL, (dss_reg_in(DSS_CONTROL) &
+
~DSS_CONTROL_TV_REF));
+		break;
+	}
+}
+#endif
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
+	page_width_exp =3D PAGE_WIDTH_EXP;
+	page_height_exp =3D PAGE_HEIGHT_EXP;
+	pixel_size_exp =3D bytes_per_pixel >> 1;
+
+	width =3D ((1<<page_width_exp) *
+		 (pages_per_side(width * bytes_per_pixel,
page_width_exp))
+		) >> pixel_size_exp;	// in pixels
+
+	height =3D (1<<page_height_exp) *
+		 (pages_per_side(height, page_height_exp));
+
+	SMS_ROT0_PHYSICAL_BA(context) =3D phy_addr;
+	SMS_ROT0_SIZE(context) =3D 0;
+	SMS_ROT0_SIZE(context)	|=3D (width << SMS_IMAGEWIDTH_OFFSET)
+				| (height << SMS_IMAGEHEIGHT_OFFSET);
+	SMS_ROT_CONTROL(context) =3D 0;
+
+	SMS_ROT_CONTROL(context) |=3D pixel_size_exp << SMS_PS_OFFSET
+			| (page_width_exp - pixel_size_exp) <<
SMS_PW_OFFSET
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
+	venc_reg_out(VENC_CC_CARR_WSS_CARR,
tvstd->venc_cc_carr_wss_carr);
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
+	venc_reg_out(VENC_HTRIGGER_VTRIGGER,
tvstd->venc_htrigger_vtrigger);
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
+	venc_reg_out(VENC_AVID_START_STOP_X,
tvstd->venc_avid_start_stop_x);
+	venc_reg_out(VENC_AVID_START_STOP_Y,
tvstd->venc_avid_start_stop_y);
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
+	omap2_current_tvstandard =3D tvstandard;
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
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+		if (key_type =3D=3D OMAP2_VIDEO_SOURCE)
+			dispc_reg_merge(DISPC_CONFIG,
DISPC_CONFIG_TCKLCDSELECTION,
+				DISPC_CONFIG_TCKLCDSELECTION);
+		else
+			dispc_reg_merge(DISPC_CONFIG, 0,
+				DISPC_CONFIG_TCKLCDSELECTION);
+		dispc_reg_out(DISPC_TRANS_COLOR0, key_val);
+	}
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+		if (key_type =3D=3D OMAP2_VIDEO_SOURCE)
+			dispc_reg_merge(DISPC_CONFIG,
DISPC_CONFIG_TCKDIGSELECTION,
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
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD) {
+		if (dispc_reg_in(DISPC_CONFIG) &
DISPC_CONFIG_TCKLCDSELECTION)
+			*key_type =3D OMAP2_VIDEO_SOURCE;
+		else
+			*key_type =3D OMAP2_GFX_DESTINATION;
+		*key_val =3D dispc_reg_in(DISPC_TRANS_COLOR0);
+	}
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV) {
+		if (dispc_reg_in(DISPC_CONFIG) &
DISPC_CONFIG_TCKDIGSELECTION)
+			*key_type =3D OMAP2_VIDEO_SOURCE;
+		else
+			*key_type =3D OMAP2_GFX_DESTINATION;
+		*key_val =3D dispc_reg_in(DISPC_TRANS_COLOR1);
+	}
+}
+
+void
+omap2_disp_enable_colorkey(int output_dev)
+{
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD)
+		dispc_reg_merge(DISPC_CONFIG, DISPC_CONFIG_TCKLCDENABLE,
+				DISPC_CONFIG_TCKLCDENABLE);
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV)
+		dispc_reg_merge(DISPC_CONFIG, DISPC_CONFIG_TCKDIGENABLE,
+				DISPC_CONFIG_TCKDIGENABLE);
+
+	omap2_disp_reg_sync(output_dev);
+}
+
+void
+omap2_disp_disable_colorkey(int output_dev)
+{
+	if (output_dev =3D=3D OMAP2_OUTPUT_LCD)
+		dispc_reg_merge(DISPC_CONFIG,
~DISPC_CONFIG_TCKLCDENABLE,
+				DISPC_CONFIG_TCKLCDENABLE);
+	else if (output_dev =3D=3D OMAP2_OUTPUT_TV)
+		dispc_reg_merge(DISPC_CONFIG,
~DISPC_CONFIG_TCKDIGENABLE,
+				DISPC_CONFIG_TCKDIGENABLE);
+
+	omap2_disp_reg_sync(output_dev);
+}
+
+/*
+ * This function is required for 2420 errata 1.97
+ */
+
+static void
+omap2_reset_venc(void)
+{
+	u32 i=3D0;
+	struct clk *dss54f;
+	dss54f =3D clk_get(NULL,"dss_54m_fck");
+
+	if (dss54f =3D=3D NULL) return;
+
+	/* Enable VENC clock  */
+	clk_use(dss54f);
+	clk_safe(dss54f);
+
+	/*
+	 * Write 1 to the 8th bit of the F_Control register to reset the
VENC
+	 */
+	venc_reg_merge(VENC_F_CONTROL, VENC_FCONTROL_RESET,
VENC_FCONTROL_RESET);
+
+	/* wait for reset to complete */
+	while ((venc_reg_in(VENC_F_CONTROL)  & VENC_FCONTROL_RESET) =3D=3D
0x00000100)
+	{
+		udelay(10);
+		if (i++ >10) break;
+	}
+
+	if (venc_reg_in(VENC_F_CONTROL) & VENC_FCONTROL_RESET)
+	{
+		printk(KERN_WARNING
+				"omap2_disp: timeout waiting for venc
reset\n");
+
+		/* remove the reset */
+
venc_reg_merge(VENC_F_CONTROL,(0<<8),VENC_FCONTROL_RESET);
+	}
+
+	/* disable the VENC clock */
+	clk_unuse(dss54f);
+}
+
+/*
+ * Enables an IRQ in DSPC_IRQENABLE.
+ */
+int
+omap2_disp_irqenable(omap2_disp_isr_t isr,unsigned int mask)
+{
+	int i;
+	unsigned long flags;
+
+	if (omap2_disp_irq =3D=3D 0 || mask =3D=3D 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dss_lock, flags);
+	for (i =3D 0; i < MAX_ISR_NR; i++) {
+		if (registered_isr[i].isr =3D=3D isr) {
+			registered_isr[i].mask |=3D mask;
+
dispc_reg_out(DISPC_IRQENABLE,dispc_reg_in(DISPC_IRQENABLE) | mask);
+			spin_unlock_irqrestore(&dss_lock, flags);
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&dss_lock, flags);
+	return -EBUSY;
+}
+
+/*
+ * Disables an IRQ in DISPC_IRQENABLE,
+ * The IRQ will be active if any other ISR is still using the same.
+ * mask : should contain '0' for irq to be disable and rest should be
'1'.
+ */
+int
+omap2_disp_irqdisable(omap2_disp_isr_t isr,unsigned int mask)
+{
+	int i;
+	unsigned long flags;
+	unsigned int new_mask =3D 0;
+
+	if (omap2_disp_irq =3D=3D 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dss_lock, flags);
+	for (i =3D 0; i < MAX_ISR_NR; i++)
+		if (registered_isr[i].isr =3D=3D isr) break;
+
+	if (i =3D=3D MAX_ISR_NR) {
+		spin_unlock_irqrestore(&dss_lock, flags);
+		return -EINVAL;
+	}
+
+	registered_isr[i].mask &=3D mask;
+
+	/* disable an IRQ if every one wishes to do so */
+	for (i =3D 0; i < MAX_ISR_NR; i++) {
+		new_mask |=3D registered_isr[i].mask;
+	}
+
+	dispc_reg_out(DISPC_IRQENABLE, new_mask);
+	spin_unlock_irqrestore(&dss_lock, flags);
+	return -EBUSY;
+}
+
+/* Display controller interrupts are handled first by this display
library.
+ * Drivers that need to use certain interrupts should register their
ISRs and
+ * interrupt enable mask with the display library.
+ */
+int
+omap2_disp_register_isr(omap2_disp_isr_t isr, void *arg, unsigned int
mask)
+{
+	int i;
+	unsigned long flags;
+
+	if (omap2_disp_irq =3D=3D 0 || isr =3D=3D 0 || arg =3D=3D 0)
+		return -EINVAL;
+
+	/* Clear all the interrupt, so that you dont get an immediate
interrupt*/
+	dispc_reg_out(DISPC_IRQSTATUS, 0xFFFFFFFF);
+	spin_lock_irqsave(&dss_lock, flags);
+	for (i =3D 0; i < MAX_ISR_NR; i++) {
+		if (registered_isr[i].isr =3D=3D NULL) {
+			registered_isr[i].isr =3D isr;
+			registered_isr[i].arg =3D arg;
+			registered_isr[i].mask =3D mask;
+
+			/* Clear previous interrupts if any */
+			dispc_reg_out(DISPC_IRQSTATUS, mask);
+
dispc_reg_out(DISPC_IRQENABLE,dispc_reg_in(DISPC_IRQENABLE) | mask);
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
+	int i,j;
+	unsigned long flags;
+	unsigned int new_mask =3D0;
+
+	if (omap2_disp_irq =3D=3D 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dss_lock, flags);
+	for (i =3D 0; i < MAX_ISR_NR; i++) {
+		if (registered_isr[i].isr =3D=3D isr) {
+			registered_isr[i].isr =3D NULL;
+			registered_isr[i].arg =3D NULL;
+			registered_isr[i].mask =3D 0;
+
+			/* The interrupt may no longer be valid, re-set
the IRQENABLE */
+			for (j =3D 0; j < MAX_ISR_NR; j++) {
+				new_mask |=3D registered_isr[j].mask;
+			}
+			dispc_reg_out(DISPC_IRQENABLE, new_mask);
+			spin_unlock_irqrestore(&dss_lock, flags);
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&dss_lock, flags);
+	return -EINVAL;
+}
+
+/* DSS Interrupt master service routine. */
+static irqreturn_t
+omap2_disp_master_isr(int irq, void *arg, struct pt_regs *regs)
+{
+	unsigned long dispc_irqstatus =3D dispc_reg_in(DISPC_IRQSTATUS);
+	int i;
+
+	for (i =3D 0; i < MAX_ISR_NR; i++) {
+		if (registered_isr[i].isr =3D=3D NULL)
+			continue;
+		if (registered_isr[i].mask & dispc_irqstatus)
+			registered_isr[i].isr(registered_isr[i].arg,
regs);
+	}
+
+	/* ack the interrupt */
+	dispc_reg_out(DISPC_IRQSTATUS, dispc_irqstatus);
+
+	return IRQ_HANDLED;
+}
+
+int __init
+omap2_disp_init(void)
+{
+	struct device *dev =3D NULL;
+	int rev,i;
+	unsigned long timeout;
+	u32 dss_control;
+
+	spin_lock_init(&dss_lock);
+
+	/*Get handler to all DSS clocks*/
+	dss1i =3D clk_get(dev,"dss_ick");
+	dss1f =3D clk_get(dev,"dss1_fck");
+	dss2f =3D clk_get(dev,"dss2_fck");
+	aclkf =3D clk_get(dev, "func_48m_ck");
+	clk_set_parent(dss2f, aclkf);
+
+
+	/* Required for scale call */
+	dss1f_scale =3D clk_get(dev,"dss1_fck");
+
+	omap2_disp_get_dss();
+
+	/* disable the display controller */
+	omap2_disp_disable(HZ/5);
+
+	/* reset the display controller */
+	dispc_reg_out(DISPC_SYSCONFIG, DISPC_SYSCONFIG_SOFTRESET);
+	/* wait for reset to complete */
+	timeout =3D jiffies + HZ/5;
+	while (!(dispc_reg_in(DISPC_SYSSTATUS)
+			& DISPC_SYSSTATUS_RESETDONE)
+		&& time_before(jiffies, timeout))
+	{
+		udelay(100);
+	}
+
+	if (!(dispc_reg_in(DISPC_SYSSTATUS) &
DISPC_SYSSTATUS_RESETDONE))
+	{
+		printk(KERN_WARNING
+				"omap2_disp: timeout waiting for display
controller reset\n");
+
+		/* remove the reset */
+		dispc_reg_merge(DISPC_SYSCONFIG, 0,
DISPC_SYSCONFIG_SOFTRESET);
+	}
+	rev =3D dss_reg_in(DSS_REVISION);
+	printk(KERN_INFO "OMAP Display hardware version %d.%d\n",
+			(rev & DISPC_REVISION_MAJOR) >>
DISPC_REVISION_MAJOR_SHIFT,
+			(rev & DISPC_REVISION_MINOR) >>
DISPC_REVISION_MINOR_SHIFT);
+
+	/* Disable RFBI mode, which is not currently supported. */
+	dispc_reg_merge(DISPC_CONTROL, 0, DISPC_CONTROL_RFBIMODE);
+
+	/* For 2420 VENC errata 1.97 */
+	/* For 2430 VENC errata 1.20 */
+	omap2_reset_venc();
+
+	/* enable DAC_DEMEN and VENC_4X_CLOCK in DSS for TV operation */
+	dss_control =3D dss_reg_in(DSS_CONTROL);
+
+	/* Should be replaced by FPGA register read  ADD A 2420 ifdef
here*/
+
+#ifdef CONFIG_ARCH_OMAP242X
+	dss_control |=3D (DSS_CONTROL_DAC_DEMEN |
+			DSS_CONTROL_VENC_CLOCK_4X_ENABLE);
+#endif
+
+#ifdef CONFIG_MACH_OMAP_2430SDP
+	#ifdef CONFIG_TWL4030_CORE_T2
+		dss_control |=3D (DSS_CONTROL_TV_REF |
DSS_CONTROL_DAC_DEMEN |
+			DSS_CONTROL_VENC_CLOCK_4X_ENABLE);
+	#endif
+
+	#ifdef CONFIG_TWL4030_CORE_M1
+		dss_control |=3D (DSS_CONTROL_DAC_DEMEN |
+			DSS_CONTROL_VENC_CLOCK_4X_ENABLE);
+	#endif
+#endif
+
+	dss_control &=3D ~DSS_CONTROL_VENC_CLOCK_MODE;
+	dss_reg_out(DSS_CONTROL, dss_control);
+
+	/* By default, all layers go to LCD */
+	layer[OMAP2_GRAPHICS].output_dev =3D OMAP2_OUTPUT_LCD;
+	layer[OMAP2_VIDEO1].output_dev =3D OMAP2_OUTPUT_LCD;
+	layer[OMAP2_VIDEO2].output_dev =3D OMAP2_OUTPUT_LCD;
+
+	/*
+	 * Set the default color conversion parameters for Video
pipelines
+	 * by default the color space is set to JPEG
+	 */
+
+	update_colorconv_mtx(0,cc_bt601_full);
+	set_colorconv(0,V4L2_COLORSPACE_JPEG);
+
+	update_colorconv_mtx(1,cc_bt601_full);
+	set_colorconv(1,V4L2_COLORSPACE_JPEG);
+
+	/* Set the default background color to be black*/
+	omap2_disp_set_bg_color(OMAP2_OUTPUT_LCD, 0x000000);
+	omap2_disp_set_bg_color(OMAP2_OUTPUT_TV, 0x000000);
+
+	if (request_irq(INT_DSS_IRQ, omap2_disp_master_isr, SA_SHIRQ,
+			"OMAP2 Display", registered_isr))
+	{
+		printk(KERN_WARNING "omap2_disp: request_irq failed\n");
+		omap2_disp_irq =3D 0;
+	}
+	else {
+		omap2_disp_irq =3D 1;
+		for(i=3D0;i<MAX_ISR_NR;i++) {
+			registered_isr[i].isr  =3D NULL;
+			registered_isr[i].mask =3D 0;
+		}
+		/* Clear all the pending interrupts, if any */
+		dispc_reg_out(DISPC_IRQSTATUS, 0xFFFFFFFF);
+		omap2_disp_register_isr(omap2_synclost_isr, layer,
+
DISPC_IRQSTATUS_SYNCLOST);
+	}
+
+	omap2_disp_register_isr(omap2_synclost_isr, layer,
+
DISPC_IRQSTATUS_SYNCLOST);
+
+	omap2_disp_put_dss();
+	return 0;
+
+}
+
+/* Start before devices */
+subsys_initcall(omap2_disp_init);
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
+EXPORT_SYMBOL(omap2_disp_set_dithering);
+EXPORT_SYMBOL(omap2_disp_get_dithering);
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
+EXPORT_SYMBOL(omap24xx_ll_config_disp_clocks);
+EXPORT_SYMBOL(omap2_disp_set_dssfclk);
+EXPORT_SYMBOL(omap2_disp_get_dss);
+EXPORT_SYMBOL(omap2_disp_put_dss);
+EXPORT_SYMBOL(omap2_disp_set_default_colorconv);
+EXPORT_SYMBOL(omap2_disp_set_colorconv);
+EXPORT_SYMBOL(omap2_disp_set_colorkey);
+EXPORT_SYMBOL(omap2_disp_get_colorkey);
+EXPORT_SYMBOL(omap2_disp_enable_colorkey);
+EXPORT_SYMBOL(omap2_disp_disable_colorkey);
+
+EXPORT_SYMBOL(omap2_disp_set_gfx_palette);
+EXPORT_SYMBOL(omap2_disp_pixels_per_clock);
+
+EXPORT_SYMBOL(omap2_disp_set_vrfb);
+EXPORT_SYMBOL(omap2_disp_save_initstate);
+EXPORT_SYMBOL(omap2_disp_restore_initstate);
+EXPORT_SYMBOL(omap2_disp_reg_sync);
+EXPORT_SYMBOL(omap2_disp_reg_sync_done);
+EXPORT_SYMBOL(omap2_disp_disable);
+
+EXPORT_SYMBOL(omap2_disp_register_isr);
+EXPORT_SYMBOL(omap2_disp_unregister_isr);
+EXPORT_SYMBOL(omap2_disp_irqenable);
+EXPORT_SYMBOL(omap2_disp_irqdisable);
+EXPORT_SYMBOL(omap2_disp_lpm_enter);
+EXPORT_SYMBOL(omap2_disp_lpm_exit);
+
+EXPORT_SYMBOL(current_colorconv_values);
+
