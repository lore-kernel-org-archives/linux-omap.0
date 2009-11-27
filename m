From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v2] OMAP: DMA: move LCD related code from plat-omap to mach-omap1
Date: Fri, 27 Nov 2009 13:25:43 +0100
Message-ID: <200911271325.57355.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:39567 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbZK0M1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 07:27:43 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All of the LCD DMA code in plat-omap/dma.c appears to be OMAP1-only (an=
d
apparently only is available on a subset of OMAP1 chips).

Move this code to mach-omap1/lcd_dma.c.

Created against linux-omap for-next,
commit 4421752e331cfb1d942b47ffdb26e451a8da58a0

Tested on OMAP1510 Amstrad Delta.
Compile-tested with omap_generic_2420_defconfig.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Issues addressed since v1:

Thursday 26 November 2009 03:08:30 Paul Walmsley wrote:
> On Wed, 25 Nov 2009, Janusz Krzysztofik wrote:
> > Wednesday 25 November 2009 10:02:52 Paul Walmsley wrote:
> > > On Sat, 21 Nov 2009, Janusz Krzysztofik wrote:
[snip]
> > > > -obj-y :=3D io.o id.o sram.o clock.o irq.o mux.o serial.o devic=
es.o
> > > > +obj-y :=3D io.o id.o sram.o clock.o irq.o lcd_dma.o mux.o seri=
al.o devices.o
> > >
> > > ... It might be good to add a Kconfig option so OMAP730/850
> > > users can skip compiling it and save some memory.
> >
> > ... arch/arm/mach-omap1/lcd_dma.c
> > exports several functions that are called unconditionaly from
> > drivers/video/omap/lcdc.c AND the latter is linked into the omapfb
> > driver based on CONFIG_ARCH_OMAP1=3Dy...
> > ... I can see two options:
> > 1. Keep arch/arm/mach-omap1/lcd_dma.c linked in for any OMAP1 subar=
ch
> > unless CONFIG_FB_OMAP is not set...
>
> Let's take option 1 for right now.
>
[snip]
> > > > +#ifndef __MACH_LCD_DMA_H__
> > >
> > > Consider adding _OMAP1_ in this macro name...
> >
> > OK, will do that too.

diff -uprN git.orig/arch/arm/mach-omap1/Makefile git/arch/arm/mach-omap=
1/Makefile
--- git.orig/arch/arm/mach-omap1/Makefile	2009-11-27 11:53:32.000000000=
 +0100
+++ git/arch/arm/mach-omap1/Makefile	2009-11-27 12:26:50.000000000 +010=
0
@@ -48,3 +48,7 @@ led-$(CONFIG_MACH_OMAP_INNOVATOR)	+=3D led
 led-$(CONFIG_MACH_OMAP_PERSEUS2)	+=3D leds-h2p2-debug.o
 led-$(CONFIG_MACH_OMAP_OSK)		+=3D leds-osk.o
 obj-$(CONFIG_LEDS)			+=3D $(led-y)
+
+ifneq ($(CONFIG_FB_OMAP),)
+obj-y +=3D lcd_dma.o
+endif
diff -uprN git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h git/arch=
/arm/mach-omap1/include/mach/lcd_dma.h
--- git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h	1970-01-01 01:0=
0:00.000000000 +0100
+++ git/arch/arm/mach-omap1/include/mach/lcd_dma.h	2009-11-27 12:29:34.=
000000000 +0100
@@ -0,0 +1,78 @@
+/*
+ *  arch/arm/mach-omap1/include/mach/lcd_dma.h
+ *
+ * Extracted from arch/arm/plat-omap/include/plat/dma.h
+ *  Copyright (C) 2003 Nokia Corporation
+ *  Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ */
+#ifndef __MACH_OMAP1_LCD_DMA_H__
+#define __MACH_OMAP1_LCD_DMA_H__
+
+/* Hardware registers for LCD DMA */
+#define OMAP1510_DMA_LCD_BASE		(0xfffedb00)
+#define OMAP1510_DMA_LCD_CTRL		(OMAP1510_DMA_LCD_BASE + 0x00)
+#define OMAP1510_DMA_LCD_TOP_F1_L	(OMAP1510_DMA_LCD_BASE + 0x02)
+#define OMAP1510_DMA_LCD_TOP_F1_U	(OMAP1510_DMA_LCD_BASE + 0x04)
+#define OMAP1510_DMA_LCD_BOT_F1_L	(OMAP1510_DMA_LCD_BASE + 0x06)
+#define OMAP1510_DMA_LCD_BOT_F1_U	(OMAP1510_DMA_LCD_BASE + 0x08)
+
+#define OMAP1610_DMA_LCD_BASE		(0xfffee300)
+#define OMAP1610_DMA_LCD_CSDP		(OMAP1610_DMA_LCD_BASE + 0xc0)
+#define OMAP1610_DMA_LCD_CCR		(OMAP1610_DMA_LCD_BASE + 0xc2)
+#define OMAP1610_DMA_LCD_CTRL		(OMAP1610_DMA_LCD_BASE + 0xc4)
+#define OMAP1610_DMA_LCD_TOP_B1_L	(OMAP1610_DMA_LCD_BASE + 0xc8)
+#define OMAP1610_DMA_LCD_TOP_B1_U	(OMAP1610_DMA_LCD_BASE + 0xca)
+#define OMAP1610_DMA_LCD_BOT_B1_L	(OMAP1610_DMA_LCD_BASE + 0xcc)
+#define OMAP1610_DMA_LCD_BOT_B1_U	(OMAP1610_DMA_LCD_BASE + 0xce)
+#define OMAP1610_DMA_LCD_TOP_B2_L	(OMAP1610_DMA_LCD_BASE + 0xd0)
+#define OMAP1610_DMA_LCD_TOP_B2_U	(OMAP1610_DMA_LCD_BASE + 0xd2)
+#define OMAP1610_DMA_LCD_BOT_B2_L	(OMAP1610_DMA_LCD_BASE + 0xd4)
+#define OMAP1610_DMA_LCD_BOT_B2_U	(OMAP1610_DMA_LCD_BASE + 0xd6)
+#define OMAP1610_DMA_LCD_SRC_EI_B1	(OMAP1610_DMA_LCD_BASE + 0xd8)
+#define OMAP1610_DMA_LCD_SRC_FI_B1_L	(OMAP1610_DMA_LCD_BASE + 0xda)
+#define OMAP1610_DMA_LCD_SRC_EN_B1	(OMAP1610_DMA_LCD_BASE + 0xe0)
+#define OMAP1610_DMA_LCD_SRC_FN_B1	(OMAP1610_DMA_LCD_BASE + 0xe4)
+#define OMAP1610_DMA_LCD_LCH_CTRL	(OMAP1610_DMA_LCD_BASE + 0xea)
+#define OMAP1610_DMA_LCD_SRC_FI_B1_U	(OMAP1610_DMA_LCD_BASE + 0xf4)
+
+/* LCD DMA block numbers */
+enum {
+	OMAP_LCD_DMA_B1_TOP,
+	OMAP_LCD_DMA_B1_BOTTOM,
+	OMAP_LCD_DMA_B2_TOP,
+	OMAP_LCD_DMA_B2_BOTTOM
+};
+
+/* LCD DMA functions */
+extern int omap_request_lcd_dma(void (*callback)(u16 status, void *dat=
a),
+				void *data);
+extern void omap_free_lcd_dma(void);
+extern void omap_setup_lcd_dma(void);
+extern void omap_enable_lcd_dma(void);
+extern void omap_stop_lcd_dma(void);
+extern void omap_set_lcd_dma_ext_controller(int external);
+extern void omap_set_lcd_dma_single_transfer(int single);
+extern void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 f=
b_yres,
+				int data_type);
+extern void omap_set_lcd_dma_b1_rotation(int rotate);
+extern void omap_set_lcd_dma_b1_vxres(unsigned long vxres);
+extern void omap_set_lcd_dma_b1_mirror(int mirror);
+extern void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned in=
t yscale);
+
+extern int omap_lcd_dma_running(void);
+
+#endif /* __MACH_OMAP1_LCD_DMA_H__ */
diff -uprN git.orig/arch/arm/mach-omap1/lcd_dma.c git/arch/arm/mach-oma=
p1/lcd_dma.c
--- git.orig/arch/arm/mach-omap1/lcd_dma.c	1970-01-01 01:00:00.00000000=
0 +0100
+++ git/arch/arm/mach-omap1/lcd_dma.c	2009-11-27 12:21:49.000000000 +01=
00
@@ -0,0 +1,447 @@
+/*
+ * linux/arch/arm/mach-omap1/lcd_dma.c
+ *
+ * Extracted from arch/arm/plat-omap/dma.c
+ * Copyright (C) 2003 - 2008 Nokia Corporation
+ * Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.co=
m>
+ * Graphics DMA and LCD DMA graphics tranformations
+ * by Imre Deak <imre.deak@nokia.com>
+ * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
+ * Merged to support both OMAP1 and OMAP2 by Tony Lindgren <tony@atomi=
de.com>
+ * Some functions based on earlier dma-omap.c Copyright (C) 2001 Ridge=
Run, Inc.
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Support functions for the OMAP internal DMA channels.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <plat/dma.h>
+
+int omap_lcd_dma_running(void)
+{
+	/*
+	 * On OMAP1510, internal LCD controller will start the transfer
+	 * when it gets enabled, so assume DMA running if LCD enabled.
+	 */
+	if (cpu_is_omap1510())
+		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
+			return 1;
+
+	/* Check if LCD DMA is running */
+	if (cpu_is_omap16xx())
+		if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
+			return 1;
+
+	return 0;
+}
+
+static struct lcd_dma_info {
+	spinlock_t lock;
+	int reserved;
+	void (*callback)(u16 status, void *data);
+	void *cb_data;
+
+	int active;
+	unsigned long addr, size;
+	int rotate, data_type, xres, yres;
+	int vxres;
+	int mirror;
+	int xscale, yscale;
+	int ext_ctrl;
+	int src_port;
+	int single_transfer;
+} lcd_dma;
+
+void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yres,
+			 int data_type)
+{
+	lcd_dma.addr =3D addr;
+	lcd_dma.data_type =3D data_type;
+	lcd_dma.xres =3D fb_xres;
+	lcd_dma.yres =3D fb_yres;
+}
+EXPORT_SYMBOL(omap_set_lcd_dma_b1);
+
+void omap_set_lcd_dma_src_port(int port)
+{
+	lcd_dma.src_port =3D port;
+}
+
+void omap_set_lcd_dma_ext_controller(int external)
+{
+	lcd_dma.ext_ctrl =3D external;
+}
+EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
+
+void omap_set_lcd_dma_single_transfer(int single)
+{
+	lcd_dma.single_transfer =3D single;
+}
+EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
+
+void omap_set_lcd_dma_b1_rotation(int rotate)
+{
+	if (cpu_is_omap1510()) {
+		printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
+		BUG();
+		return;
+	}
+	lcd_dma.rotate =3D rotate;
+}
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
+
+void omap_set_lcd_dma_b1_mirror(int mirror)
+{
+	if (cpu_is_omap1510()) {
+		printk(KERN_ERR "DMA mirror is not supported in 1510 mode\n");
+		BUG();
+	}
+	lcd_dma.mirror =3D mirror;
+}
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
+
+void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
+{
+	if (cpu_is_omap1510()) {
+		printk(KERN_ERR "DMA virtual resulotion is not supported "
+				"in 1510 mode\n");
+		BUG();
+	}
+	lcd_dma.vxres =3D vxres;
+}
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
+
+void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscal=
e)
+{
+	if (cpu_is_omap1510()) {
+		printk(KERN_ERR "DMA scale is not supported in 1510 mode\n");
+		BUG();
+	}
+	lcd_dma.xscale =3D xscale;
+	lcd_dma.yscale =3D yscale;
+}
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
+
+static void set_b1_regs(void)
+{
+	unsigned long top, bottom;
+	int es;
+	u16 w;
+	unsigned long en, fn;
+	long ei, fi;
+	unsigned long vxres;
+	unsigned int xscale, yscale;
+
+	switch (lcd_dma.data_type) {
+	case OMAP_DMA_DATA_TYPE_S8:
+		es =3D 1;
+		break;
+	case OMAP_DMA_DATA_TYPE_S16:
+		es =3D 2;
+		break;
+	case OMAP_DMA_DATA_TYPE_S32:
+		es =3D 4;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	vxres =3D lcd_dma.vxres ? lcd_dma.vxres : lcd_dma.xres;
+	xscale =3D lcd_dma.xscale ? lcd_dma.xscale : 1;
+	yscale =3D lcd_dma.yscale ? lcd_dma.yscale : 1;
+	BUG_ON(vxres < lcd_dma.xres);
+
+#define PIXADDR(x, y) (lcd_dma.addr +					\
+		((y) * vxres * yscale + (x) * xscale) * es)
+#define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) - e=
s + 1)
+
+	switch (lcd_dma.rotate) {
+	case 0:
+		if (!lcd_dma.mirror) {
+			top =3D PIXADDR(0, 0);
+			bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
+			/* 1510 DMA requires the bottom address to be 2 more
+			 * than the actual last memory access location. */
+			if (cpu_is_omap1510() &&
+				lcd_dma.data_type =3D=3D OMAP_DMA_DATA_TYPE_S32)
+					bottom +=3D 2;
+			ei =3D PIXSTEP(0, 0, 1, 0);
+			fi =3D PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
+		} else {
+			top =3D PIXADDR(lcd_dma.xres - 1, 0);
+			bottom =3D PIXADDR(0, lcd_dma.yres - 1);
+			ei =3D PIXSTEP(1, 0, 0, 0);
+			fi =3D PIXSTEP(0, 0, lcd_dma.xres - 1, 1);
+		}
+		en =3D lcd_dma.xres;
+		fn =3D lcd_dma.yres;
+		break;
+	case 90:
+		if (!lcd_dma.mirror) {
+			top =3D PIXADDR(0, lcd_dma.yres - 1);
+			bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
+			ei =3D PIXSTEP(0, 1, 0, 0);
+			fi =3D PIXSTEP(0, 0, 1, lcd_dma.yres - 1);
+		} else {
+			top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
+			bottom =3D PIXADDR(0, 0);
+			ei =3D PIXSTEP(0, 1, 0, 0);
+			fi =3D PIXSTEP(1, 0, 0, lcd_dma.yres - 1);
+		}
+		en =3D lcd_dma.yres;
+		fn =3D lcd_dma.xres;
+		break;
+	case 180:
+		if (!lcd_dma.mirror) {
+			top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
+			bottom =3D PIXADDR(0, 0);
+			ei =3D PIXSTEP(1, 0, 0, 0);
+			fi =3D PIXSTEP(0, 1, lcd_dma.xres - 1, 0);
+		} else {
+			top =3D PIXADDR(0, lcd_dma.yres - 1);
+			bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
+			ei =3D PIXSTEP(0, 0, 1, 0);
+			fi =3D PIXSTEP(lcd_dma.xres - 1, 1, 0, 0);
+		}
+		en =3D lcd_dma.xres;
+		fn =3D lcd_dma.yres;
+		break;
+	case 270:
+		if (!lcd_dma.mirror) {
+			top =3D PIXADDR(lcd_dma.xres - 1, 0);
+			bottom =3D PIXADDR(0, lcd_dma.yres - 1);
+			ei =3D PIXSTEP(0, 0, 0, 1);
+			fi =3D PIXSTEP(1, lcd_dma.yres - 1, 0, 0);
+		} else {
+			top =3D PIXADDR(0, 0);
+			bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
+			ei =3D PIXSTEP(0, 0, 0, 1);
+			fi =3D PIXSTEP(0, lcd_dma.yres - 1, 1, 0);
+		}
+		en =3D lcd_dma.yres;
+		fn =3D lcd_dma.xres;
+		break;
+	default:
+		BUG();
+		return;	/* Suppress warning about uninitialized vars */
+	}
+
+	if (cpu_is_omap1510()) {
+		omap_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
+		omap_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
+		omap_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
+		omap_writew(bottom, OMAP1510_DMA_LCD_BOT_F1_L);
+
+		return;
+	}
+
+	/* 1610 regs */
+	omap_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1_U);
+	omap_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
+	omap_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT_B1_U);
+	omap_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L);
+
+	omap_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
+	omap_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CSDP);
+	w &=3D ~0x03;
+	w |=3D lcd_dma.data_type;
+	omap_writew(w, OMAP1610_DMA_LCD_CSDP);
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
+	/* Always set the source port as SDRAM for now*/
+	w &=3D ~(0x03 << 6);
+	if (lcd_dma.callback !=3D NULL)
+		w |=3D 1 << 1;		/* Block interrupt enable */
+	else
+		w &=3D ~(1 << 1);
+	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+
+	if (!(lcd_dma.rotate || lcd_dma.mirror ||
+	      lcd_dma.vxres || lcd_dma.xscale || lcd_dma.yscale))
+		return;
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
+	/* Set the double-indexed addressing mode */
+	w |=3D (0x03 << 12);
+	omap_writew(w, OMAP1610_DMA_LCD_CCR);
+
+	omap_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
+	omap_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_B1_U);
+	omap_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
+}
+
+static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
+{
+	u16 w;
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
+	if (unlikely(!(w & (1 << 3)))) {
+		printk(KERN_WARNING "Spurious LCD DMA IRQ\n");
+		return IRQ_NONE;
+	}
+	/* Ack the IRQ */
+	w |=3D (1 << 3);
+	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+	lcd_dma.active =3D 0;
+	if (lcd_dma.callback !=3D NULL)
+		lcd_dma.callback(w, lcd_dma.cb_data);
+
+	return IRQ_HANDLED;
+}
+
+int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
+			 void *data)
+{
+	spin_lock_irq(&lcd_dma.lock);
+	if (lcd_dma.reserved) {
+		spin_unlock_irq(&lcd_dma.lock);
+		printk(KERN_ERR "LCD DMA channel already reserved\n");
+		BUG();
+		return -EBUSY;
+	}
+	lcd_dma.reserved =3D 1;
+	spin_unlock_irq(&lcd_dma.lock);
+	lcd_dma.callback =3D callback;
+	lcd_dma.cb_data =3D data;
+	lcd_dma.active =3D 0;
+	lcd_dma.single_transfer =3D 0;
+	lcd_dma.rotate =3D 0;
+	lcd_dma.vxres =3D 0;
+	lcd_dma.mirror =3D 0;
+	lcd_dma.xscale =3D 0;
+	lcd_dma.yscale =3D 0;
+	lcd_dma.ext_ctrl =3D 0;
+	lcd_dma.src_port =3D 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_request_lcd_dma);
+
+void omap_free_lcd_dma(void)
+{
+	spin_lock(&lcd_dma.lock);
+	if (!lcd_dma.reserved) {
+		spin_unlock(&lcd_dma.lock);
+		printk(KERN_ERR "LCD DMA is not reserved\n");
+		BUG();
+		return;
+	}
+	if (!cpu_is_omap1510())
+		omap_writew(omap_readw(OMAP1610_DMA_LCD_CCR) & ~1,
+			    OMAP1610_DMA_LCD_CCR);
+	lcd_dma.reserved =3D 0;
+	spin_unlock(&lcd_dma.lock);
+}
+EXPORT_SYMBOL(omap_free_lcd_dma);
+
+void omap_enable_lcd_dma(void)
+{
+	u16 w;
+
+	/*
+	 * Set the Enable bit only if an external controller is
+	 * connected. Otherwise the OMAP internal controller will
+	 * start the transfer when it gets enabled.
+	 */
+	if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
+		return;
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
+	w |=3D 1 << 8;
+	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+
+	lcd_dma.active =3D 1;
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
+	w |=3D 1 << 7;
+	omap_writew(w, OMAP1610_DMA_LCD_CCR);
+}
+EXPORT_SYMBOL(omap_enable_lcd_dma);
+
+void omap_setup_lcd_dma(void)
+{
+	BUG_ON(lcd_dma.active);
+	if (!cpu_is_omap1510()) {
+		/* Set some reasonable defaults */
+		omap_writew(0x5440, OMAP1610_DMA_LCD_CCR);
+		omap_writew(0x9102, OMAP1610_DMA_LCD_CSDP);
+		omap_writew(0x0004, OMAP1610_DMA_LCD_LCH_CTRL);
+	}
+	set_b1_regs();
+	if (!cpu_is_omap1510()) {
+		u16 w;
+
+		w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
+		/*
+		 * If DMA was already active set the end_prog bit to have
+		 * the programmed register set loaded into the active
+		 * register set.
+		 */
+		w |=3D 1 << 11;		/* End_prog */
+		if (!lcd_dma.single_transfer)
+			w |=3D (3 << 8);	/* Auto_init, repeat */
+		omap_writew(w, OMAP1610_DMA_LCD_CCR);
+	}
+}
+EXPORT_SYMBOL(omap_setup_lcd_dma);
+
+void omap_stop_lcd_dma(void)
+{
+	u16 w;
+
+	lcd_dma.active =3D 0;
+	if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
+		return;
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
+	w &=3D ~(1 << 7);
+	omap_writew(w, OMAP1610_DMA_LCD_CCR);
+
+	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
+	w &=3D ~(1 << 8);
+	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+}
+EXPORT_SYMBOL(omap_stop_lcd_dma);
+
+static int __init omap_init_lcd_dma(void)
+{
+	int r;
+
+	if (cpu_is_omap16xx()) {
+		u16 w;
+
+		/* this would prevent OMAP sleep */
+		w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
+		w &=3D ~(1 << 8);
+		omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+	}
+
+	spin_lock_init(&lcd_dma.lock);
+
+	r =3D request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
+			"LCD DMA", NULL);
+	if (r !=3D 0)
+		printk(KERN_ERR "unable to request IRQ for LCD DMA "
+			       "(error %d)\n", r);
+
+	return r;
+}
+
+arch_initcall(omap_init_lcd_dma);
+
diff -uprN git.orig/arch/arm/plat-omap/dma.c git/arch/arm/plat-omap/dma=
=2Ec
--- git.orig/arch/arm/plat-omap/dma.c	2009-11-27 11:53:45.000000000 +01=
00
+++ git/arch/arm/plat-omap/dma.c	2009-11-27 12:21:49.000000000 +0100
@@ -47,7 +47,6 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTS
 #endif
=20
 #define OMAP_DMA_ACTIVE			0x01
-#define OMAP_DMA_CCR_EN			(1 << 7)
 #define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
=20
 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
@@ -1120,17 +1119,8 @@ int omap_dma_running(void)
 {
 	int lch;
=20
-	/*
-	 * On OMAP1510, internal LCD controller will start the transfer
-	 * when it gets enabled, so assume DMA running if LCD enabled.
-	 */
-	if (cpu_is_omap1510())
-		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
-			return 1;
-
-	/* Check if LCD DMA is running */
-	if (cpu_is_omap16xx())
-		if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
+	if (cpu_class_is_omap1())
+		if (omap_lcd_dma_running())
 			return 1;
=20
 	for (lch =3D 0; lch < dma_chan_count; lch++)
@@ -1990,377 +1980,6 @@ static struct irqaction omap24xx_dma_irq
=20
 /*--------------------------------------------------------------------=
--------*/
=20
-static struct lcd_dma_info {
-	spinlock_t lock;
-	int reserved;
-	void (*callback)(u16 status, void *data);
-	void *cb_data;
-
-	int active;
-	unsigned long addr, size;
-	int rotate, data_type, xres, yres;
-	int vxres;
-	int mirror;
-	int xscale, yscale;
-	int ext_ctrl;
-	int src_port;
-	int single_transfer;
-} lcd_dma;
-
-void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yres,
-			 int data_type)
-{
-	lcd_dma.addr =3D addr;
-	lcd_dma.data_type =3D data_type;
-	lcd_dma.xres =3D fb_xres;
-	lcd_dma.yres =3D fb_yres;
-}
-EXPORT_SYMBOL(omap_set_lcd_dma_b1);
-
-void omap_set_lcd_dma_src_port(int port)
-{
-	lcd_dma.src_port =3D port;
-}
-
-void omap_set_lcd_dma_ext_controller(int external)
-{
-	lcd_dma.ext_ctrl =3D external;
-}
-EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
-
-void omap_set_lcd_dma_single_transfer(int single)
-{
-	lcd_dma.single_transfer =3D single;
-}
-EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
-
-void omap_set_lcd_dma_b1_rotation(int rotate)
-{
-	if (omap_dma_in_1510_mode()) {
-		printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
-		BUG();
-		return;
-	}
-	lcd_dma.rotate =3D rotate;
-}
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
-
-void omap_set_lcd_dma_b1_mirror(int mirror)
-{
-	if (omap_dma_in_1510_mode()) {
-		printk(KERN_ERR "DMA mirror is not supported in 1510 mode\n");
-		BUG();
-	}
-	lcd_dma.mirror =3D mirror;
-}
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
-
-void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
-{
-	if (omap_dma_in_1510_mode()) {
-		printk(KERN_ERR "DMA virtual resulotion is not supported "
-				"in 1510 mode\n");
-		BUG();
-	}
-	lcd_dma.vxres =3D vxres;
-}
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
-
-void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscal=
e)
-{
-	if (omap_dma_in_1510_mode()) {
-		printk(KERN_ERR "DMA scale is not supported in 1510 mode\n");
-		BUG();
-	}
-	lcd_dma.xscale =3D xscale;
-	lcd_dma.yscale =3D yscale;
-}
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
-
-static void set_b1_regs(void)
-{
-	unsigned long top, bottom;
-	int es;
-	u16 w;
-	unsigned long en, fn;
-	long ei, fi;
-	unsigned long vxres;
-	unsigned int xscale, yscale;
-
-	switch (lcd_dma.data_type) {
-	case OMAP_DMA_DATA_TYPE_S8:
-		es =3D 1;
-		break;
-	case OMAP_DMA_DATA_TYPE_S16:
-		es =3D 2;
-		break;
-	case OMAP_DMA_DATA_TYPE_S32:
-		es =3D 4;
-		break;
-	default:
-		BUG();
-		return;
-	}
-
-	vxres =3D lcd_dma.vxres ? lcd_dma.vxres : lcd_dma.xres;
-	xscale =3D lcd_dma.xscale ? lcd_dma.xscale : 1;
-	yscale =3D lcd_dma.yscale ? lcd_dma.yscale : 1;
-	BUG_ON(vxres < lcd_dma.xres);
-
-#define PIXADDR(x, y) (lcd_dma.addr +					\
-		((y) * vxres * yscale + (x) * xscale) * es)
-#define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) - e=
s + 1)
-
-	switch (lcd_dma.rotate) {
-	case 0:
-		if (!lcd_dma.mirror) {
-			top =3D PIXADDR(0, 0);
-			bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
-			/* 1510 DMA requires the bottom address to be 2 more
-			 * than the actual last memory access location. */
-			if (omap_dma_in_1510_mode() &&
-				lcd_dma.data_type =3D=3D OMAP_DMA_DATA_TYPE_S32)
-					bottom +=3D 2;
-			ei =3D PIXSTEP(0, 0, 1, 0);
-			fi =3D PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
-		} else {
-			top =3D PIXADDR(lcd_dma.xres - 1, 0);
-			bottom =3D PIXADDR(0, lcd_dma.yres - 1);
-			ei =3D PIXSTEP(1, 0, 0, 0);
-			fi =3D PIXSTEP(0, 0, lcd_dma.xres - 1, 1);
-		}
-		en =3D lcd_dma.xres;
-		fn =3D lcd_dma.yres;
-		break;
-	case 90:
-		if (!lcd_dma.mirror) {
-			top =3D PIXADDR(0, lcd_dma.yres - 1);
-			bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
-			ei =3D PIXSTEP(0, 1, 0, 0);
-			fi =3D PIXSTEP(0, 0, 1, lcd_dma.yres - 1);
-		} else {
-			top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
-			bottom =3D PIXADDR(0, 0);
-			ei =3D PIXSTEP(0, 1, 0, 0);
-			fi =3D PIXSTEP(1, 0, 0, lcd_dma.yres - 1);
-		}
-		en =3D lcd_dma.yres;
-		fn =3D lcd_dma.xres;
-		break;
-	case 180:
-		if (!lcd_dma.mirror) {
-			top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
-			bottom =3D PIXADDR(0, 0);
-			ei =3D PIXSTEP(1, 0, 0, 0);
-			fi =3D PIXSTEP(0, 1, lcd_dma.xres - 1, 0);
-		} else {
-			top =3D PIXADDR(0, lcd_dma.yres - 1);
-			bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
-			ei =3D PIXSTEP(0, 0, 1, 0);
-			fi =3D PIXSTEP(lcd_dma.xres - 1, 1, 0, 0);
-		}
-		en =3D lcd_dma.xres;
-		fn =3D lcd_dma.yres;
-		break;
-	case 270:
-		if (!lcd_dma.mirror) {
-			top =3D PIXADDR(lcd_dma.xres - 1, 0);
-			bottom =3D PIXADDR(0, lcd_dma.yres - 1);
-			ei =3D PIXSTEP(0, 0, 0, 1);
-			fi =3D PIXSTEP(1, lcd_dma.yres - 1, 0, 0);
-		} else {
-			top =3D PIXADDR(0, 0);
-			bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
-			ei =3D PIXSTEP(0, 0, 0, 1);
-			fi =3D PIXSTEP(0, lcd_dma.yres - 1, 1, 0);
-		}
-		en =3D lcd_dma.yres;
-		fn =3D lcd_dma.xres;
-		break;
-	default:
-		BUG();
-		return;	/* Suppress warning about uninitialized vars */
-	}
-
-	if (omap_dma_in_1510_mode()) {
-		omap_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
-		omap_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
-		omap_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
-		omap_writew(bottom, OMAP1510_DMA_LCD_BOT_F1_L);
-
-		return;
-	}
-
-	/* 1610 regs */
-	omap_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1_U);
-	omap_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
-	omap_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT_B1_U);
-	omap_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L);
-
-	omap_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
-	omap_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CSDP);
-	w &=3D ~0x03;
-	w |=3D lcd_dma.data_type;
-	omap_writew(w, OMAP1610_DMA_LCD_CSDP);
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
-	/* Always set the source port as SDRAM for now*/
-	w &=3D ~(0x03 << 6);
-	if (lcd_dma.callback !=3D NULL)
-		w |=3D 1 << 1;		/* Block interrupt enable */
-	else
-		w &=3D ~(1 << 1);
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
-
-	if (!(lcd_dma.rotate || lcd_dma.mirror ||
-	      lcd_dma.vxres || lcd_dma.xscale || lcd_dma.yscale))
-		return;
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
-	/* Set the double-indexed addressing mode */
-	w |=3D (0x03 << 12);
-	omap_writew(w, OMAP1610_DMA_LCD_CCR);
-
-	omap_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
-	omap_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_B1_U);
-	omap_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
-}
-
-static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
-{
-	u16 w;
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
-	if (unlikely(!(w & (1 << 3)))) {
-		printk(KERN_WARNING "Spurious LCD DMA IRQ\n");
-		return IRQ_NONE;
-	}
-	/* Ack the IRQ */
-	w |=3D (1 << 3);
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
-	lcd_dma.active =3D 0;
-	if (lcd_dma.callback !=3D NULL)
-		lcd_dma.callback(w, lcd_dma.cb_data);
-
-	return IRQ_HANDLED;
-}
-
-int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
-			 void *data)
-{
-	spin_lock_irq(&lcd_dma.lock);
-	if (lcd_dma.reserved) {
-		spin_unlock_irq(&lcd_dma.lock);
-		printk(KERN_ERR "LCD DMA channel already reserved\n");
-		BUG();
-		return -EBUSY;
-	}
-	lcd_dma.reserved =3D 1;
-	spin_unlock_irq(&lcd_dma.lock);
-	lcd_dma.callback =3D callback;
-	lcd_dma.cb_data =3D data;
-	lcd_dma.active =3D 0;
-	lcd_dma.single_transfer =3D 0;
-	lcd_dma.rotate =3D 0;
-	lcd_dma.vxres =3D 0;
-	lcd_dma.mirror =3D 0;
-	lcd_dma.xscale =3D 0;
-	lcd_dma.yscale =3D 0;
-	lcd_dma.ext_ctrl =3D 0;
-	lcd_dma.src_port =3D 0;
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_request_lcd_dma);
-
-void omap_free_lcd_dma(void)
-{
-	spin_lock(&lcd_dma.lock);
-	if (!lcd_dma.reserved) {
-		spin_unlock(&lcd_dma.lock);
-		printk(KERN_ERR "LCD DMA is not reserved\n");
-		BUG();
-		return;
-	}
-	if (!enable_1510_mode)
-		omap_writew(omap_readw(OMAP1610_DMA_LCD_CCR) & ~1,
-			    OMAP1610_DMA_LCD_CCR);
-	lcd_dma.reserved =3D 0;
-	spin_unlock(&lcd_dma.lock);
-}
-EXPORT_SYMBOL(omap_free_lcd_dma);
-
-void omap_enable_lcd_dma(void)
-{
-	u16 w;
-
-	/*
-	 * Set the Enable bit only if an external controller is
-	 * connected. Otherwise the OMAP internal controller will
-	 * start the transfer when it gets enabled.
-	 */
-	if (enable_1510_mode || !lcd_dma.ext_ctrl)
-		return;
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
-	w |=3D 1 << 8;
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
-
-	lcd_dma.active =3D 1;
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
-	w |=3D 1 << 7;
-	omap_writew(w, OMAP1610_DMA_LCD_CCR);
-}
-EXPORT_SYMBOL(omap_enable_lcd_dma);
-
-void omap_setup_lcd_dma(void)
-{
-	BUG_ON(lcd_dma.active);
-	if (!enable_1510_mode) {
-		/* Set some reasonable defaults */
-		omap_writew(0x5440, OMAP1610_DMA_LCD_CCR);
-		omap_writew(0x9102, OMAP1610_DMA_LCD_CSDP);
-		omap_writew(0x0004, OMAP1610_DMA_LCD_LCH_CTRL);
-	}
-	set_b1_regs();
-	if (!enable_1510_mode) {
-		u16 w;
-
-		w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
-		/*
-		 * If DMA was already active set the end_prog bit to have
-		 * the programmed register set loaded into the active
-		 * register set.
-		 */
-		w |=3D 1 << 11;		/* End_prog */
-		if (!lcd_dma.single_transfer)
-			w |=3D (3 << 8);	/* Auto_init, repeat */
-		omap_writew(w, OMAP1610_DMA_LCD_CCR);
-	}
-}
-EXPORT_SYMBOL(omap_setup_lcd_dma);
-
-void omap_stop_lcd_dma(void)
-{
-	u16 w;
-
-	lcd_dma.active =3D 0;
-	if (enable_1510_mode || !lcd_dma.ext_ctrl)
-		return;
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
-	w &=3D ~(1 << 7);
-	omap_writew(w, OMAP1610_DMA_LCD_CCR);
-
-	w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
-	w &=3D ~(1 << 8);
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
-}
-EXPORT_SYMBOL(omap_stop_lcd_dma);
-
 void omap_dma_global_context_save(void)
 {
 	omap_dma_global_context.dma_irqenable_l0 =3D
@@ -2465,14 +2084,6 @@ static int __init omap_init_dma(void)
 			dma_chan_count =3D 16;
 		} else
 			dma_chan_count =3D 9;
-		if (cpu_is_omap16xx()) {
-			u16 w;
-
-			/* this would prevent OMAP sleep */
-			w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
-			w &=3D ~(1 << 8);
-			omap_writew(w, OMAP1610_DMA_LCD_CTRL);
-		}
 	} else if (cpu_class_is_omap2()) {
 		u8 revision =3D dma_read(REVISION) & 0xff;
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
@@ -2483,7 +2094,6 @@ static int __init omap_init_dma(void)
 		return 0;
 	}
=20
-	spin_lock_init(&lcd_dma.lock);
 	spin_lock_init(&dma_chan_lock);
=20
 	for (ch =3D 0; ch < dma_chan_count; ch++) {
@@ -2548,22 +2158,6 @@ static int __init omap_init_dma(void)
 		}
 	}
=20
-
-	/* FIXME: Update LCD DMA to work on 24xx */
-	if (cpu_class_is_omap1()) {
-		r =3D request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
-				"LCD DMA", NULL);
-		if (r !=3D 0) {
-			int i;
-
-			printk(KERN_ERR "unable to request IRQ for LCD DMA "
-			       "(error %d)\n", r);
-			for (i =3D 0; i < dma_chan_count; i++)
-				free_irq(omap1_dma_irq[i], (void *) (i + 1));
-			goto out_free;
-		}
-	}
-
 	return 0;
=20
 out_free:
diff -uprN git.orig/arch/arm/plat-omap/include/plat/dma.h git/arch/arm/=
plat-omap/include/plat/dma.h
--- git.orig/arch/arm/plat-omap/include/plat/dma.h	2009-11-27 11:53:45.=
000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/dma.h	2009-11-27 12:28:22.00000=
0000 +0100
@@ -401,33 +401,6 @@
=20
 /*--------------------------------------------------------------------=
--------*/
=20
-/* Hardware registers for LCD DMA */
-#define OMAP1510_DMA_LCD_BASE		(0xfffedb00)
-#define OMAP1510_DMA_LCD_CTRL		(OMAP1510_DMA_LCD_BASE + 0x00)
-#define OMAP1510_DMA_LCD_TOP_F1_L	(OMAP1510_DMA_LCD_BASE + 0x02)
-#define OMAP1510_DMA_LCD_TOP_F1_U	(OMAP1510_DMA_LCD_BASE + 0x04)
-#define OMAP1510_DMA_LCD_BOT_F1_L	(OMAP1510_DMA_LCD_BASE + 0x06)
-#define OMAP1510_DMA_LCD_BOT_F1_U	(OMAP1510_DMA_LCD_BASE + 0x08)
-
-#define OMAP1610_DMA_LCD_BASE		(0xfffee300)
-#define OMAP1610_DMA_LCD_CSDP		(OMAP1610_DMA_LCD_BASE + 0xc0)
-#define OMAP1610_DMA_LCD_CCR		(OMAP1610_DMA_LCD_BASE + 0xc2)
-#define OMAP1610_DMA_LCD_CTRL		(OMAP1610_DMA_LCD_BASE + 0xc4)
-#define OMAP1610_DMA_LCD_TOP_B1_L	(OMAP1610_DMA_LCD_BASE + 0xc8)
-#define OMAP1610_DMA_LCD_TOP_B1_U	(OMAP1610_DMA_LCD_BASE + 0xca)
-#define OMAP1610_DMA_LCD_BOT_B1_L	(OMAP1610_DMA_LCD_BASE + 0xcc)
-#define OMAP1610_DMA_LCD_BOT_B1_U	(OMAP1610_DMA_LCD_BASE + 0xce)
-#define OMAP1610_DMA_LCD_TOP_B2_L	(OMAP1610_DMA_LCD_BASE + 0xd0)
-#define OMAP1610_DMA_LCD_TOP_B2_U	(OMAP1610_DMA_LCD_BASE + 0xd2)
-#define OMAP1610_DMA_LCD_BOT_B2_L	(OMAP1610_DMA_LCD_BASE + 0xd4)
-#define OMAP1610_DMA_LCD_BOT_B2_U	(OMAP1610_DMA_LCD_BASE + 0xd6)
-#define OMAP1610_DMA_LCD_SRC_EI_B1	(OMAP1610_DMA_LCD_BASE + 0xd8)
-#define OMAP1610_DMA_LCD_SRC_FI_B1_L	(OMAP1610_DMA_LCD_BASE + 0xda)
-#define OMAP1610_DMA_LCD_SRC_EN_B1	(OMAP1610_DMA_LCD_BASE + 0xe0)
-#define OMAP1610_DMA_LCD_SRC_FN_B1	(OMAP1610_DMA_LCD_BASE + 0xe4)
-#define OMAP1610_DMA_LCD_LCH_CTRL	(OMAP1610_DMA_LCD_BASE + 0xea)
-#define OMAP1610_DMA_LCD_SRC_FI_B1_U	(OMAP1610_DMA_LCD_BASE + 0xf4)
-
 #define OMAP1_DMA_TOUT_IRQ		(1 << 0)
 #define OMAP_DMA_DROP_IRQ		(1 << 1)
 #define OMAP_DMA_HALF_IRQ		(1 << 2)
@@ -441,6 +414,8 @@
 #define OMAP2_DMA_SUPERVISOR_ERR_IRQ	(1 << 10)
 #define OMAP2_DMA_MISALIGNED_ERR_IRQ	(1 << 11)
=20
+#define OMAP_DMA_CCR_EN			(1 << 7)
+
 #define OMAP_DMA_DATA_TYPE_S8		0x00
 #define OMAP_DMA_DATA_TYPE_S16		0x01
 #define OMAP_DMA_DATA_TYPE_S32		0x02
@@ -503,14 +478,6 @@
 #define DMA_CH_PRIO_HIGH		0x1
 #define DMA_CH_PRIO_LOW			0x0 /* Def */
=20
-/* LCD DMA block numbers */
-enum {
-	OMAP_LCD_DMA_B1_TOP,
-	OMAP_LCD_DMA_B1_BOTTOM,
-	OMAP_LCD_DMA_B2_TOP,
-	OMAP_LCD_DMA_B2_BOTTOM
-};
-
 enum omap_dma_burst_mode {
 	OMAP_DMA_DATA_BURST_DIS =3D 0,
 	OMAP_DMA_DATA_BURST_4,
@@ -661,20 +628,13 @@ extern int omap_modify_dma_chain_params(
 extern int omap_dma_chain_status(int chain_id);
 #endif
=20
-/* LCD DMA functions */
-extern int omap_request_lcd_dma(void (*callback)(u16 status, void *dat=
a),
-				void *data);
-extern void omap_free_lcd_dma(void);
-extern void omap_setup_lcd_dma(void);
-extern void omap_enable_lcd_dma(void);
-extern void omap_stop_lcd_dma(void);
-extern void omap_set_lcd_dma_ext_controller(int external);
-extern void omap_set_lcd_dma_single_transfer(int single);
-extern void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 f=
b_yres,
-				int data_type);
-extern void omap_set_lcd_dma_b1_rotation(int rotate);
-extern void omap_set_lcd_dma_b1_vxres(unsigned long vxres);
-extern void omap_set_lcd_dma_b1_mirror(int mirror);
-extern void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned in=
t yscale);
+#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_FB_OMAP)
+#include <mach/lcd_dma.h>
+#else
+static inline int omap_lcd_dma_running(void)
+{
+	return 0;
+}
+#endif
=20
 #endif /* __ASM_ARCH_DMA_H */
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
