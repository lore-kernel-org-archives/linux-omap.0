From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap
 to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken
 when PM set)
Date: Wed, 25 Nov 2009 02:02:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911230154230.26334@utopia.booyaka.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200910301542.27206.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911100347320.20233@utopia.booyaka.com> <200911211658.31404.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-763488501-1258967044=:26334"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55681 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934582AbZKYJCr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 04:02:47 -0500
In-Reply-To: <200911211658.31404.jkrzyszt@tis.icnet.pl>
Content-ID: <alpine.DEB.2.00.0911230204350.26334@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-763488501-1258967044=:26334
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.0911230204351.26334@utopia.booyaka.com>

Hello Janusz,

On Sat, 21 Nov 2009, Janusz Krzysztofik wrote:

> (probably less interested persons and lists dropped)
>=20
> Tuesday 10 November 2009 11:50:52 Paul Walmsley wrote:
> > ...  All of the LCD DMA code in plat-omap/dma.c appears to be
> > OMAP1-only (and apparently only is available on a subset of OMAP1 chips=
).
> > It would be great if this code could be moved to mach-omap1/lcd_dma.c o=
r
> > a similar place.
>=20
> The patch just tries to implement this idea.
>=20
> Created against linux-omap for-next,
> commit 2963c21fab52bfa8227da7f22864db393ebbc858
>=20
> Tested on OMAP1510 Amstrad Delta.
> Compile tested using omap_generic_2420_defconfig.
>=20
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>=20
> ---
> Hi Paul,
>=20
> I hope the patch meets your suggestion closely enough.

Thanks, just scanned it quickly and it looks carefully done.  Two=20
suggestions below, both minor:

> Thanks,
> Janusz
>=20
> diff -uprN git.orig/arch/arm/mach-omap1/Makefile git/arch/arm/mach-omap1/=
Makefile
> --- git.orig/arch/arm/mach-omap1/Makefile=092009-11-21 00:38:45.000000000=
 +0100
> +++ git/arch/arm/mach-omap1/Makefile=092009-11-21 01:27:12.000000000 +010=
0
> @@ -3,7 +3,7 @@
>  #
> =20
>  # Common support
> -obj-y :=3D io.o id.o sram.o clock.o irq.o mux.o serial.o devices.o
> +obj-y :=3D io.o id.o sram.o clock.o irq.o lcd_dma.o mux.o serial.o devic=
es.o

It seems that this LCD DMA controller is not present on OMAPs prior to the=
=20
1510, given all the references in the LCD DMA code to 1510 and 1610, etc. =
=20
It might be good to add a Kconfig option so OMAP730/850 users can skip=20
compiling it and save some memory.  The drivers that use these routines=20
can then include Kconfig dependencies on that option so it is=20
automatically included when those drivers are built.

>  obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
> =20
> diff -uprN git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h git/arch/a=
rm/mach-omap1/include/mach/lcd_dma.h
> --- git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h=091970-01-01 01:0=
0:00.000000000 +0100
> +++ git/arch/arm/mach-omap1/include/mach/lcd_dma.h=092009-11-21 03:22:25.=
000000000 +0100
> @@ -0,0 +1,78 @@
> +/*
> + *  arch/arm/mach-omap1/include/mach/lcd_dma.h
> + *
> + * Extracted from arch/arm/plat-omap/include/plat/dma.h
> + *  Copyright (C) 2003 Nokia Corporation
> + *  Author: Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA
> + */
> +#ifndef __MACH_LCD_DMA_H__

Consider adding _OMAP1_ in this macro name.  I doubt that name collisions=
=20
here will be a serious issue, but adding a few extra bytes here might=20
avoid some bug-hunting frustration in the long run...

> +#define __MACH_LCD_DMA_H__
> +
> +/* Hardware registers for LCD DMA */
> +#define OMAP1510_DMA_LCD_BASE=09=09(0xfffedb00)
> +#define OMAP1510_DMA_LCD_CTRL=09=09(OMAP1510_DMA_LCD_BASE + 0x00)
> +#define OMAP1510_DMA_LCD_TOP_F1_L=09(OMAP1510_DMA_LCD_BASE + 0x02)
> +#define OMAP1510_DMA_LCD_TOP_F1_U=09(OMAP1510_DMA_LCD_BASE + 0x04)
> +#define OMAP1510_DMA_LCD_BOT_F1_L=09(OMAP1510_DMA_LCD_BASE + 0x06)
> +#define OMAP1510_DMA_LCD_BOT_F1_U=09(OMAP1510_DMA_LCD_BASE + 0x08)
> +
> +#define OMAP1610_DMA_LCD_BASE=09=09(0xfffee300)
> +#define OMAP1610_DMA_LCD_CSDP=09=09(OMAP1610_DMA_LCD_BASE + 0xc0)
> +#define OMAP1610_DMA_LCD_CCR=09=09(OMAP1610_DMA_LCD_BASE + 0xc2)
> +#define OMAP1610_DMA_LCD_CTRL=09=09(OMAP1610_DMA_LCD_BASE + 0xc4)
> +#define OMAP1610_DMA_LCD_TOP_B1_L=09(OMAP1610_DMA_LCD_BASE + 0xc8)
> +#define OMAP1610_DMA_LCD_TOP_B1_U=09(OMAP1610_DMA_LCD_BASE + 0xca)
> +#define OMAP1610_DMA_LCD_BOT_B1_L=09(OMAP1610_DMA_LCD_BASE + 0xcc)
> +#define OMAP1610_DMA_LCD_BOT_B1_U=09(OMAP1610_DMA_LCD_BASE + 0xce)
> +#define OMAP1610_DMA_LCD_TOP_B2_L=09(OMAP1610_DMA_LCD_BASE + 0xd0)
> +#define OMAP1610_DMA_LCD_TOP_B2_U=09(OMAP1610_DMA_LCD_BASE + 0xd2)
> +#define OMAP1610_DMA_LCD_BOT_B2_L=09(OMAP1610_DMA_LCD_BASE + 0xd4)
> +#define OMAP1610_DMA_LCD_BOT_B2_U=09(OMAP1610_DMA_LCD_BASE + 0xd6)
> +#define OMAP1610_DMA_LCD_SRC_EI_B1=09(OMAP1610_DMA_LCD_BASE + 0xd8)
> +#define OMAP1610_DMA_LCD_SRC_FI_B1_L=09(OMAP1610_DMA_LCD_BASE + 0xda)
> +#define OMAP1610_DMA_LCD_SRC_EN_B1=09(OMAP1610_DMA_LCD_BASE + 0xe0)
> +#define OMAP1610_DMA_LCD_SRC_FN_B1=09(OMAP1610_DMA_LCD_BASE + 0xe4)
> +#define OMAP1610_DMA_LCD_LCH_CTRL=09(OMAP1610_DMA_LCD_BASE + 0xea)
> +#define OMAP1610_DMA_LCD_SRC_FI_B1_U=09(OMAP1610_DMA_LCD_BASE + 0xf4)
> +
> +/* LCD DMA block numbers */
> +enum {
> +=09OMAP_LCD_DMA_B1_TOP,
> +=09OMAP_LCD_DMA_B1_BOTTOM,
> +=09OMAP_LCD_DMA_B2_TOP,
> +=09OMAP_LCD_DMA_B2_BOTTOM
> +};
> +
> +/* LCD DMA functions */
> +extern int omap_request_lcd_dma(void (*callback)(u16 status, void *data)=
,
> +=09=09=09=09void *data);
> +extern void omap_free_lcd_dma(void);
> +extern void omap_setup_lcd_dma(void);
> +extern void omap_enable_lcd_dma(void);
> +extern void omap_stop_lcd_dma(void);
> +extern void omap_set_lcd_dma_ext_controller(int external);
> +extern void omap_set_lcd_dma_single_transfer(int single);
> +extern void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_=
yres,
> +=09=09=09=09int data_type);
> +extern void omap_set_lcd_dma_b1_rotation(int rotate);
> +extern void omap_set_lcd_dma_b1_vxres(unsigned long vxres);
> +extern void omap_set_lcd_dma_b1_mirror(int mirror);
> +extern void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int =
yscale);
> +
> +extern int omap_lcd_dma_running(void);
> +
> +#endif /* __MACH_LCD_DMA_H__ */
> diff -uprN git.orig/arch/arm/mach-omap1/lcd_dma.c git/arch/arm/mach-omap1=
/lcd_dma.c
> --- git.orig/arch/arm/mach-omap1/lcd_dma.c=091970-01-01 01:00:00.00000000=
0 +0100
> +++ git/arch/arm/mach-omap1/lcd_dma.c=092009-11-21 14:36:59.000000000 +01=
00
> @@ -0,0 +1,447 @@
> +/*
> + * linux/arch/arm/mach-omap1/lcd_dma.c
> + *
> + * Extracted from arch/arm/plat-omap/dma.c
> + * Copyright (C) 2003 - 2008 Nokia Corporation
> + * Author: Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
> + * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.com>
> + * Graphics DMA and LCD DMA graphics tranformations
> + * by Imre Deak <imre.deak@nokia.com>
> + * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
> + * Merged to support both OMAP1 and OMAP2 by Tony Lindgren <tony@atomide=
=2Ecom>
> + * Some functions based on earlier dma-omap.c Copyright (C) 2001 RidgeRu=
n, Inc.
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * Support functions for the OMAP internal DMA channels.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <plat/dma.h>
> +
> +int omap_lcd_dma_running(void)
> +{
> +=09/*
> +=09 * On OMAP1510, internal LCD controller will start the transfer
> +=09 * when it gets enabled, so assume DMA running if LCD enabled.
> +=09 */
> +=09if (cpu_is_omap1510())
> +=09=09if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> +=09=09=09return 1;
> +
> +=09/* Check if LCD DMA is running */
> +=09if (cpu_is_omap16xx())
> +=09=09if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
> +=09=09=09return 1;
> +
> +=09return 0;
> +}
> +
> +static struct lcd_dma_info {
> +=09spinlock_t lock;
> +=09int reserved;
> +=09void (*callback)(u16 status, void *data);
> +=09void *cb_data;
> +
> +=09int active;
> +=09unsigned long addr, size;
> +=09int rotate, data_type, xres, yres;
> +=09int vxres;
> +=09int mirror;
> +=09int xscale, yscale;
> +=09int ext_ctrl;
> +=09int src_port;
> +=09int single_transfer;
> +} lcd_dma;
> +
> +void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yres,
> +=09=09=09 int data_type)
> +{
> +=09lcd_dma.addr =3D addr;
> +=09lcd_dma.data_type =3D data_type;
> +=09lcd_dma.xres =3D fb_xres;
> +=09lcd_dma.yres =3D fb_yres;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1);
> +
> +void omap_set_lcd_dma_src_port(int port)
> +{
> +=09lcd_dma.src_port =3D port;
> +}
> +
> +void omap_set_lcd_dma_ext_controller(int external)
> +{
> +=09lcd_dma.ext_ctrl =3D external;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
> +
> +void omap_set_lcd_dma_single_transfer(int single)
> +{
> +=09lcd_dma.single_transfer =3D single;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
> +
> +void omap_set_lcd_dma_b1_rotation(int rotate)
> +{
> +=09if (cpu_is_omap1510()) {
> +=09=09printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
> +=09=09BUG();
> +=09=09return;
> +=09}
> +=09lcd_dma.rotate =3D rotate;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
> +
> +void omap_set_lcd_dma_b1_mirror(int mirror)
> +{
> +=09if (cpu_is_omap1510()) {
> +=09=09printk(KERN_ERR "DMA mirror is not supported in 1510 mode\n");
> +=09=09BUG();
> +=09}
> +=09lcd_dma.mirror =3D mirror;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
> +
> +void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
> +{
> +=09if (cpu_is_omap1510()) {
> +=09=09printk(KERN_ERR "DMA virtual resulotion is not supported "
> +=09=09=09=09"in 1510 mode\n");
> +=09=09BUG();
> +=09}
> +=09lcd_dma.vxres =3D vxres;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
> +
> +void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscale)
> +{
> +=09if (cpu_is_omap1510()) {
> +=09=09printk(KERN_ERR "DMA scale is not supported in 1510 mode\n");
> +=09=09BUG();
> +=09}
> +=09lcd_dma.xscale =3D xscale;
> +=09lcd_dma.yscale =3D yscale;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
> +
> +static void set_b1_regs(void)
> +{
> +=09unsigned long top, bottom;
> +=09int es;
> +=09u16 w;
> +=09unsigned long en, fn;
> +=09long ei, fi;
> +=09unsigned long vxres;
> +=09unsigned int xscale, yscale;
> +
> +=09switch (lcd_dma.data_type) {
> +=09case OMAP_DMA_DATA_TYPE_S8:
> +=09=09es =3D 1;
> +=09=09break;
> +=09case OMAP_DMA_DATA_TYPE_S16:
> +=09=09es =3D 2;
> +=09=09break;
> +=09case OMAP_DMA_DATA_TYPE_S32:
> +=09=09es =3D 4;
> +=09=09break;
> +=09default:
> +=09=09BUG();
> +=09=09return;
> +=09}
> +
> +=09vxres =3D lcd_dma.vxres ? lcd_dma.vxres : lcd_dma.xres;
> +=09xscale =3D lcd_dma.xscale ? lcd_dma.xscale : 1;
> +=09yscale =3D lcd_dma.yscale ? lcd_dma.yscale : 1;
> +=09BUG_ON(vxres < lcd_dma.xres);
> +
> +#define PIXADDR(x, y) (lcd_dma.addr +=09=09=09=09=09\
> +=09=09((y) * vxres * yscale + (x) * xscale) * es)
> +#define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) - es =
+ 1)
> +
> +=09switch (lcd_dma.rotate) {
> +=09case 0:
> +=09=09if (!lcd_dma.mirror) {
> +=09=09=09top =3D PIXADDR(0, 0);
> +=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> +=09=09=09/* 1510 DMA requires the bottom address to be 2 more
> +=09=09=09 * than the actual last memory access location. */
> +=09=09=09if (cpu_is_omap1510() &&
> +=09=09=09=09lcd_dma.data_type =3D=3D OMAP_DMA_DATA_TYPE_S32)
> +=09=09=09=09=09bottom +=3D 2;
> +=09=09=09ei =3D PIXSTEP(0, 0, 1, 0);
> +=09=09=09fi =3D PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
> +=09=09} else {
> +=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, 0);
> +=09=09=09bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> +=09=09=09ei =3D PIXSTEP(1, 0, 0, 0);
> +=09=09=09fi =3D PIXSTEP(0, 0, lcd_dma.xres - 1, 1);
> +=09=09}
> +=09=09en =3D lcd_dma.xres;
> +=09=09fn =3D lcd_dma.yres;
> +=09=09break;
> +=09case 90:
> +=09=09if (!lcd_dma.mirror) {
> +=09=09=09top =3D PIXADDR(0, lcd_dma.yres - 1);
> +=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> +=09=09=09ei =3D PIXSTEP(0, 1, 0, 0);
> +=09=09=09fi =3D PIXSTEP(0, 0, 1, lcd_dma.yres - 1);
> +=09=09} else {
> +=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> +=09=09=09bottom =3D PIXADDR(0, 0);
> +=09=09=09ei =3D PIXSTEP(0, 1, 0, 0);
> +=09=09=09fi =3D PIXSTEP(1, 0, 0, lcd_dma.yres - 1);
> +=09=09}
> +=09=09en =3D lcd_dma.yres;
> +=09=09fn =3D lcd_dma.xres;
> +=09=09break;
> +=09case 180:
> +=09=09if (!lcd_dma.mirror) {
> +=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> +=09=09=09bottom =3D PIXADDR(0, 0);
> +=09=09=09ei =3D PIXSTEP(1, 0, 0, 0);
> +=09=09=09fi =3D PIXSTEP(0, 1, lcd_dma.xres - 1, 0);
> +=09=09} else {
> +=09=09=09top =3D PIXADDR(0, lcd_dma.yres - 1);
> +=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> +=09=09=09ei =3D PIXSTEP(0, 0, 1, 0);
> +=09=09=09fi =3D PIXSTEP(lcd_dma.xres - 1, 1, 0, 0);
> +=09=09}
> +=09=09en =3D lcd_dma.xres;
> +=09=09fn =3D lcd_dma.yres;
> +=09=09break;
> +=09case 270:
> +=09=09if (!lcd_dma.mirror) {
> +=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, 0);
> +=09=09=09bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> +=09=09=09ei =3D PIXSTEP(0, 0, 0, 1);
> +=09=09=09fi =3D PIXSTEP(1, lcd_dma.yres - 1, 0, 0);
> +=09=09} else {
> +=09=09=09top =3D PIXADDR(0, 0);
> +=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> +=09=09=09ei =3D PIXSTEP(0, 0, 0, 1);
> +=09=09=09fi =3D PIXSTEP(0, lcd_dma.yres - 1, 1, 0);
> +=09=09}
> +=09=09en =3D lcd_dma.yres;
> +=09=09fn =3D lcd_dma.xres;
> +=09=09break;
> +=09default:
> +=09=09BUG();
> +=09=09return;=09/* Suppress warning about uninitialized vars */
> +=09}
> +
> +=09if (cpu_is_omap1510()) {
> +=09=09omap_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
> +=09=09omap_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
> +=09=09omap_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
> +=09=09omap_writew(bottom, OMAP1510_DMA_LCD_BOT_F1_L);
> +
> +=09=09return;
> +=09}
> +
> +=09/* 1610 regs */
> +=09omap_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1_U);
> +=09omap_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
> +=09omap_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT_B1_U);
> +=09omap_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L);
> +
> +=09omap_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
> +=09omap_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CSDP);
> +=09w &=3D ~0x03;
> +=09w |=3D lcd_dma.data_type;
> +=09omap_writew(w, OMAP1610_DMA_LCD_CSDP);
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> +=09/* Always set the source port as SDRAM for now*/
> +=09w &=3D ~(0x03 << 6);
> +=09if (lcd_dma.callback !=3D NULL)
> +=09=09w |=3D 1 << 1;=09=09/* Block interrupt enable */
> +=09else
> +=09=09w &=3D ~(1 << 1);
> +=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +
> +=09if (!(lcd_dma.rotate || lcd_dma.mirror ||
> +=09      lcd_dma.vxres || lcd_dma.xscale || lcd_dma.yscale))
> +=09=09return;
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> +=09/* Set the double-indexed addressing mode */
> +=09w |=3D (0x03 << 12);
> +=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> +
> +=09omap_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
> +=09omap_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_B1_U);
> +=09omap_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
> +}
> +
> +static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
> +{
> +=09u16 w;
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> +=09if (unlikely(!(w & (1 << 3)))) {
> +=09=09printk(KERN_WARNING "Spurious LCD DMA IRQ\n");
> +=09=09return IRQ_NONE;
> +=09}
> +=09/* Ack the IRQ */
> +=09w |=3D (1 << 3);
> +=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +=09lcd_dma.active =3D 0;
> +=09if (lcd_dma.callback !=3D NULL)
> +=09=09lcd_dma.callback(w, lcd_dma.cb_data);
> +
> +=09return IRQ_HANDLED;
> +}
> +
> +int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
> +=09=09=09 void *data)
> +{
> +=09spin_lock_irq(&lcd_dma.lock);
> +=09if (lcd_dma.reserved) {
> +=09=09spin_unlock_irq(&lcd_dma.lock);
> +=09=09printk(KERN_ERR "LCD DMA channel already reserved\n");
> +=09=09BUG();
> +=09=09return -EBUSY;
> +=09}
> +=09lcd_dma.reserved =3D 1;
> +=09spin_unlock_irq(&lcd_dma.lock);
> +=09lcd_dma.callback =3D callback;
> +=09lcd_dma.cb_data =3D data;
> +=09lcd_dma.active =3D 0;
> +=09lcd_dma.single_transfer =3D 0;
> +=09lcd_dma.rotate =3D 0;
> +=09lcd_dma.vxres =3D 0;
> +=09lcd_dma.mirror =3D 0;
> +=09lcd_dma.xscale =3D 0;
> +=09lcd_dma.yscale =3D 0;
> +=09lcd_dma.ext_ctrl =3D 0;
> +=09lcd_dma.src_port =3D 0;
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL(omap_request_lcd_dma);
> +
> +void omap_free_lcd_dma(void)
> +{
> +=09spin_lock(&lcd_dma.lock);
> +=09if (!lcd_dma.reserved) {
> +=09=09spin_unlock(&lcd_dma.lock);
> +=09=09printk(KERN_ERR "LCD DMA is not reserved\n");
> +=09=09BUG();
> +=09=09return;
> +=09}
> +=09if (!cpu_is_omap1510())
> +=09=09omap_writew(omap_readw(OMAP1610_DMA_LCD_CCR) & ~1,
> +=09=09=09    OMAP1610_DMA_LCD_CCR);
> +=09lcd_dma.reserved =3D 0;
> +=09spin_unlock(&lcd_dma.lock);
> +}
> +EXPORT_SYMBOL(omap_free_lcd_dma);
> +
> +void omap_enable_lcd_dma(void)
> +{
> +=09u16 w;
> +
> +=09/*
> +=09 * Set the Enable bit only if an external controller is
> +=09 * connected. Otherwise the OMAP internal controller will
> +=09 * start the transfer when it gets enabled.
> +=09 */
> +=09if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
> +=09=09return;
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> +=09w |=3D 1 << 8;
> +=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +
> +=09lcd_dma.active =3D 1;
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> +=09w |=3D 1 << 7;
> +=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> +}
> +EXPORT_SYMBOL(omap_enable_lcd_dma);
> +
> +void omap_setup_lcd_dma(void)
> +{
> +=09BUG_ON(lcd_dma.active);
> +=09if (!cpu_is_omap1510()) {
> +=09=09/* Set some reasonable defaults */
> +=09=09omap_writew(0x5440, OMAP1610_DMA_LCD_CCR);
> +=09=09omap_writew(0x9102, OMAP1610_DMA_LCD_CSDP);
> +=09=09omap_writew(0x0004, OMAP1610_DMA_LCD_LCH_CTRL);
> +=09}
> +=09set_b1_regs();
> +=09if (!cpu_is_omap1510()) {
> +=09=09u16 w;
> +
> +=09=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> +=09=09/*
> +=09=09 * If DMA was already active set the end_prog bit to have
> +=09=09 * the programmed register set loaded into the active
> +=09=09 * register set.
> +=09=09 */
> +=09=09w |=3D 1 << 11;=09=09/* End_prog */
> +=09=09if (!lcd_dma.single_transfer)
> +=09=09=09w |=3D (3 << 8);=09/* Auto_init, repeat */
> +=09=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> +=09}
> +}
> +EXPORT_SYMBOL(omap_setup_lcd_dma);
> +
> +void omap_stop_lcd_dma(void)
> +{
> +=09u16 w;
> +
> +=09lcd_dma.active =3D 0;
> +=09if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
> +=09=09return;
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> +=09w &=3D ~(1 << 7);
> +=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> +
> +=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> +=09w &=3D ~(1 << 8);
> +=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +}
> +EXPORT_SYMBOL(omap_stop_lcd_dma);
> +
> +static int __init omap_init_lcd_dma(void)
> +{
> +=09int r;
> +
> +=09if (cpu_is_omap16xx()) {
> +=09=09u16 w;
> +
> +=09=09/* this would prevent OMAP sleep */
> +=09=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> +=09=09w &=3D ~(1 << 8);
> +=09=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +=09}
> +
> +=09spin_lock_init(&lcd_dma.lock);
> +
> +=09r =3D request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
> +=09=09=09"LCD DMA", NULL);
> +=09if (r !=3D 0)
> +=09=09printk(KERN_ERR "unable to request IRQ for LCD DMA "
> +=09=09=09       "(error %d)\n", r);
> +
> +=09return r;
> +}
> +
> +arch_initcall(omap_init_lcd_dma);
> +
> diff -uprN git.orig/arch/arm/plat-omap/dma.c git/arch/arm/plat-omap/dma.c
> --- git.orig/arch/arm/plat-omap/dma.c=092009-11-21 00:38:46.000000000 +01=
00
> +++ git/arch/arm/plat-omap/dma.c=092009-11-21 03:34:23.000000000 +0100
> @@ -47,7 +47,6 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTS
>  #endif
> =20
>  #define OMAP_DMA_ACTIVE=09=09=090x01
> -#define OMAP_DMA_CCR_EN=09=09=09(1 << 7)
>  #define OMAP2_DMA_CSR_CLEAR_MASK=090xffe
> =20
>  #define OMAP_FUNC_MUX_ARM_BASE=09=09(0xfffe1000 + 0xec)
> @@ -1120,17 +1119,8 @@ int omap_dma_running(void)
>  {
>  =09int lch;
> =20
> -=09/*
> -=09 * On OMAP1510, internal LCD controller will start the transfer
> -=09 * when it gets enabled, so assume DMA running if LCD enabled.
> -=09 */
> -=09if (cpu_is_omap1510())
> -=09=09if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> -=09=09=09return 1;
> -
> -=09/* Check if LCD DMA is running */
> -=09if (cpu_is_omap16xx())
> -=09=09if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
> +=09if (cpu_class_is_omap1())
> +=09=09if (omap_lcd_dma_running())
>  =09=09=09return 1;
> =20
>  =09for (lch =3D 0; lch < dma_chan_count; lch++)
> @@ -1990,377 +1980,6 @@ static struct irqaction omap24xx_dma_irq
> =20
>  /*----------------------------------------------------------------------=
------*/
> =20
> -static struct lcd_dma_info {
> -=09spinlock_t lock;
> -=09int reserved;
> -=09void (*callback)(u16 status, void *data);
> -=09void *cb_data;
> -
> -=09int active;
> -=09unsigned long addr, size;
> -=09int rotate, data_type, xres, yres;
> -=09int vxres;
> -=09int mirror;
> -=09int xscale, yscale;
> -=09int ext_ctrl;
> -=09int src_port;
> -=09int single_transfer;
> -} lcd_dma;
> -
> -void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yres,
> -=09=09=09 int data_type)
> -{
> -=09lcd_dma.addr =3D addr;
> -=09lcd_dma.data_type =3D data_type;
> -=09lcd_dma.xres =3D fb_xres;
> -=09lcd_dma.yres =3D fb_yres;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1);
> -
> -void omap_set_lcd_dma_src_port(int port)
> -{
> -=09lcd_dma.src_port =3D port;
> -}
> -
> -void omap_set_lcd_dma_ext_controller(int external)
> -{
> -=09lcd_dma.ext_ctrl =3D external;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
> -
> -void omap_set_lcd_dma_single_transfer(int single)
> -{
> -=09lcd_dma.single_transfer =3D single;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
> -
> -void omap_set_lcd_dma_b1_rotation(int rotate)
> -{
> -=09if (omap_dma_in_1510_mode()) {
> -=09=09printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
> -=09=09BUG();
> -=09=09return;
> -=09}
> -=09lcd_dma.rotate =3D rotate;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
> -
> -void omap_set_lcd_dma_b1_mirror(int mirror)
> -{
> -=09if (omap_dma_in_1510_mode()) {
> -=09=09printk(KERN_ERR "DMA mirror is not supported in 1510 mode\n");
> -=09=09BUG();
> -=09}
> -=09lcd_dma.mirror =3D mirror;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
> -
> -void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
> -{
> -=09if (omap_dma_in_1510_mode()) {
> -=09=09printk(KERN_ERR "DMA virtual resulotion is not supported "
> -=09=09=09=09"in 1510 mode\n");
> -=09=09BUG();
> -=09}
> -=09lcd_dma.vxres =3D vxres;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
> -
> -void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscale)
> -{
> -=09if (omap_dma_in_1510_mode()) {
> -=09=09printk(KERN_ERR "DMA scale is not supported in 1510 mode\n");
> -=09=09BUG();
> -=09}
> -=09lcd_dma.xscale =3D xscale;
> -=09lcd_dma.yscale =3D yscale;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
> -
> -static void set_b1_regs(void)
> -{
> -=09unsigned long top, bottom;
> -=09int es;
> -=09u16 w;
> -=09unsigned long en, fn;
> -=09long ei, fi;
> -=09unsigned long vxres;
> -=09unsigned int xscale, yscale;
> -
> -=09switch (lcd_dma.data_type) {
> -=09case OMAP_DMA_DATA_TYPE_S8:
> -=09=09es =3D 1;
> -=09=09break;
> -=09case OMAP_DMA_DATA_TYPE_S16:
> -=09=09es =3D 2;
> -=09=09break;
> -=09case OMAP_DMA_DATA_TYPE_S32:
> -=09=09es =3D 4;
> -=09=09break;
> -=09default:
> -=09=09BUG();
> -=09=09return;
> -=09}
> -
> -=09vxres =3D lcd_dma.vxres ? lcd_dma.vxres : lcd_dma.xres;
> -=09xscale =3D lcd_dma.xscale ? lcd_dma.xscale : 1;
> -=09yscale =3D lcd_dma.yscale ? lcd_dma.yscale : 1;
> -=09BUG_ON(vxres < lcd_dma.xres);
> -
> -#define PIXADDR(x, y) (lcd_dma.addr +=09=09=09=09=09\
> -=09=09((y) * vxres * yscale + (x) * xscale) * es)
> -#define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) - es =
+ 1)
> -
> -=09switch (lcd_dma.rotate) {
> -=09case 0:
> -=09=09if (!lcd_dma.mirror) {
> -=09=09=09top =3D PIXADDR(0, 0);
> -=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> -=09=09=09/* 1510 DMA requires the bottom address to be 2 more
> -=09=09=09 * than the actual last memory access location. */
> -=09=09=09if (omap_dma_in_1510_mode() &&
> -=09=09=09=09lcd_dma.data_type =3D=3D OMAP_DMA_DATA_TYPE_S32)
> -=09=09=09=09=09bottom +=3D 2;
> -=09=09=09ei =3D PIXSTEP(0, 0, 1, 0);
> -=09=09=09fi =3D PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
> -=09=09} else {
> -=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, 0);
> -=09=09=09bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> -=09=09=09ei =3D PIXSTEP(1, 0, 0, 0);
> -=09=09=09fi =3D PIXSTEP(0, 0, lcd_dma.xres - 1, 1);
> -=09=09}
> -=09=09en =3D lcd_dma.xres;
> -=09=09fn =3D lcd_dma.yres;
> -=09=09break;
> -=09case 90:
> -=09=09if (!lcd_dma.mirror) {
> -=09=09=09top =3D PIXADDR(0, lcd_dma.yres - 1);
> -=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> -=09=09=09ei =3D PIXSTEP(0, 1, 0, 0);
> -=09=09=09fi =3D PIXSTEP(0, 0, 1, lcd_dma.yres - 1);
> -=09=09} else {
> -=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> -=09=09=09bottom =3D PIXADDR(0, 0);
> -=09=09=09ei =3D PIXSTEP(0, 1, 0, 0);
> -=09=09=09fi =3D PIXSTEP(1, 0, 0, lcd_dma.yres - 1);
> -=09=09}
> -=09=09en =3D lcd_dma.yres;
> -=09=09fn =3D lcd_dma.xres;
> -=09=09break;
> -=09case 180:
> -=09=09if (!lcd_dma.mirror) {
> -=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> -=09=09=09bottom =3D PIXADDR(0, 0);
> -=09=09=09ei =3D PIXSTEP(1, 0, 0, 0);
> -=09=09=09fi =3D PIXSTEP(0, 1, lcd_dma.xres - 1, 0);
> -=09=09} else {
> -=09=09=09top =3D PIXADDR(0, lcd_dma.yres - 1);
> -=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> -=09=09=09ei =3D PIXSTEP(0, 0, 1, 0);
> -=09=09=09fi =3D PIXSTEP(lcd_dma.xres - 1, 1, 0, 0);
> -=09=09}
> -=09=09en =3D lcd_dma.xres;
> -=09=09fn =3D lcd_dma.yres;
> -=09=09break;
> -=09case 270:
> -=09=09if (!lcd_dma.mirror) {
> -=09=09=09top =3D PIXADDR(lcd_dma.xres - 1, 0);
> -=09=09=09bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> -=09=09=09ei =3D PIXSTEP(0, 0, 0, 1);
> -=09=09=09fi =3D PIXSTEP(1, lcd_dma.yres - 1, 0, 0);
> -=09=09} else {
> -=09=09=09top =3D PIXADDR(0, 0);
> -=09=09=09bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> -=09=09=09ei =3D PIXSTEP(0, 0, 0, 1);
> -=09=09=09fi =3D PIXSTEP(0, lcd_dma.yres - 1, 1, 0);
> -=09=09}
> -=09=09en =3D lcd_dma.yres;
> -=09=09fn =3D lcd_dma.xres;
> -=09=09break;
> -=09default:
> -=09=09BUG();
> -=09=09return;=09/* Suppress warning about uninitialized vars */
> -=09}
> -
> -=09if (omap_dma_in_1510_mode()) {
> -=09=09omap_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
> -=09=09omap_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
> -=09=09omap_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
> -=09=09omap_writew(bottom, OMAP1510_DMA_LCD_BOT_F1_L);
> -
> -=09=09return;
> -=09}
> -
> -=09/* 1610 regs */
> -=09omap_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1_U);
> -=09omap_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
> -=09omap_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT_B1_U);
> -=09omap_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L);
> -
> -=09omap_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
> -=09omap_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CSDP);
> -=09w &=3D ~0x03;
> -=09w |=3D lcd_dma.data_type;
> -=09omap_writew(w, OMAP1610_DMA_LCD_CSDP);
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> -=09/* Always set the source port as SDRAM for now*/
> -=09w &=3D ~(0x03 << 6);
> -=09if (lcd_dma.callback !=3D NULL)
> -=09=09w |=3D 1 << 1;=09=09/* Block interrupt enable */
> -=09else
> -=09=09w &=3D ~(1 << 1);
> -=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -
> -=09if (!(lcd_dma.rotate || lcd_dma.mirror ||
> -=09      lcd_dma.vxres || lcd_dma.xscale || lcd_dma.yscale))
> -=09=09return;
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> -=09/* Set the double-indexed addressing mode */
> -=09w |=3D (0x03 << 12);
> -=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> -
> -=09omap_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
> -=09omap_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_B1_U);
> -=09omap_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
> -}
> -
> -static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
> -{
> -=09u16 w;
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> -=09if (unlikely(!(w & (1 << 3)))) {
> -=09=09printk(KERN_WARNING "Spurious LCD DMA IRQ\n");
> -=09=09return IRQ_NONE;
> -=09}
> -=09/* Ack the IRQ */
> -=09w |=3D (1 << 3);
> -=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -=09lcd_dma.active =3D 0;
> -=09if (lcd_dma.callback !=3D NULL)
> -=09=09lcd_dma.callback(w, lcd_dma.cb_data);
> -
> -=09return IRQ_HANDLED;
> -}
> -
> -int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
> -=09=09=09 void *data)
> -{
> -=09spin_lock_irq(&lcd_dma.lock);
> -=09if (lcd_dma.reserved) {
> -=09=09spin_unlock_irq(&lcd_dma.lock);
> -=09=09printk(KERN_ERR "LCD DMA channel already reserved\n");
> -=09=09BUG();
> -=09=09return -EBUSY;
> -=09}
> -=09lcd_dma.reserved =3D 1;
> -=09spin_unlock_irq(&lcd_dma.lock);
> -=09lcd_dma.callback =3D callback;
> -=09lcd_dma.cb_data =3D data;
> -=09lcd_dma.active =3D 0;
> -=09lcd_dma.single_transfer =3D 0;
> -=09lcd_dma.rotate =3D 0;
> -=09lcd_dma.vxres =3D 0;
> -=09lcd_dma.mirror =3D 0;
> -=09lcd_dma.xscale =3D 0;
> -=09lcd_dma.yscale =3D 0;
> -=09lcd_dma.ext_ctrl =3D 0;
> -=09lcd_dma.src_port =3D 0;
> -
> -=09return 0;
> -}
> -EXPORT_SYMBOL(omap_request_lcd_dma);
> -
> -void omap_free_lcd_dma(void)
> -{
> -=09spin_lock(&lcd_dma.lock);
> -=09if (!lcd_dma.reserved) {
> -=09=09spin_unlock(&lcd_dma.lock);
> -=09=09printk(KERN_ERR "LCD DMA is not reserved\n");
> -=09=09BUG();
> -=09=09return;
> -=09}
> -=09if (!enable_1510_mode)
> -=09=09omap_writew(omap_readw(OMAP1610_DMA_LCD_CCR) & ~1,
> -=09=09=09    OMAP1610_DMA_LCD_CCR);
> -=09lcd_dma.reserved =3D 0;
> -=09spin_unlock(&lcd_dma.lock);
> -}
> -EXPORT_SYMBOL(omap_free_lcd_dma);
> -
> -void omap_enable_lcd_dma(void)
> -{
> -=09u16 w;
> -
> -=09/*
> -=09 * Set the Enable bit only if an external controller is
> -=09 * connected. Otherwise the OMAP internal controller will
> -=09 * start the transfer when it gets enabled.
> -=09 */
> -=09if (enable_1510_mode || !lcd_dma.ext_ctrl)
> -=09=09return;
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> -=09w |=3D 1 << 8;
> -=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -
> -=09lcd_dma.active =3D 1;
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> -=09w |=3D 1 << 7;
> -=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> -}
> -EXPORT_SYMBOL(omap_enable_lcd_dma);
> -
> -void omap_setup_lcd_dma(void)
> -{
> -=09BUG_ON(lcd_dma.active);
> -=09if (!enable_1510_mode) {
> -=09=09/* Set some reasonable defaults */
> -=09=09omap_writew(0x5440, OMAP1610_DMA_LCD_CCR);
> -=09=09omap_writew(0x9102, OMAP1610_DMA_LCD_CSDP);
> -=09=09omap_writew(0x0004, OMAP1610_DMA_LCD_LCH_CTRL);
> -=09}
> -=09set_b1_regs();
> -=09if (!enable_1510_mode) {
> -=09=09u16 w;
> -
> -=09=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> -=09=09/*
> -=09=09 * If DMA was already active set the end_prog bit to have
> -=09=09 * the programmed register set loaded into the active
> -=09=09 * register set.
> -=09=09 */
> -=09=09w |=3D 1 << 11;=09=09/* End_prog */
> -=09=09if (!lcd_dma.single_transfer)
> -=09=09=09w |=3D (3 << 8);=09/* Auto_init, repeat */
> -=09=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> -=09}
> -}
> -EXPORT_SYMBOL(omap_setup_lcd_dma);
> -
> -void omap_stop_lcd_dma(void)
> -{
> -=09u16 w;
> -
> -=09lcd_dma.active =3D 0;
> -=09if (enable_1510_mode || !lcd_dma.ext_ctrl)
> -=09=09return;
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> -=09w &=3D ~(1 << 7);
> -=09omap_writew(w, OMAP1610_DMA_LCD_CCR);
> -
> -=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> -=09w &=3D ~(1 << 8);
> -=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -}
> -EXPORT_SYMBOL(omap_stop_lcd_dma);
> -
>  void omap_dma_global_context_save(void)
>  {
>  =09omap_dma_global_context.dma_irqenable_l0 =3D
> @@ -2465,14 +2084,6 @@ static int __init omap_init_dma(void)
>  =09=09=09dma_chan_count =3D 16;
>  =09=09} else
>  =09=09=09dma_chan_count =3D 9;
> -=09=09if (cpu_is_omap16xx()) {
> -=09=09=09u16 w;
> -
> -=09=09=09/* this would prevent OMAP sleep */
> -=09=09=09w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> -=09=09=09w &=3D ~(1 << 8);
> -=09=09=09omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -=09=09}
>  =09} else if (cpu_class_is_omap2()) {
>  =09=09u8 revision =3D dma_read(REVISION) & 0xff;
>  =09=09printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
> @@ -2483,7 +2094,6 @@ static int __init omap_init_dma(void)
>  =09=09return 0;
>  =09}
> =20
> -=09spin_lock_init(&lcd_dma.lock);
>  =09spin_lock_init(&dma_chan_lock);
> =20
>  =09for (ch =3D 0; ch < dma_chan_count; ch++) {
> @@ -2548,22 +2158,6 @@ static int __init omap_init_dma(void)
>  =09=09}
>  =09}
> =20
> -
> -=09/* FIXME: Update LCD DMA to work on 24xx */
> -=09if (cpu_class_is_omap1()) {
> -=09=09r =3D request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
> -=09=09=09=09"LCD DMA", NULL);
> -=09=09if (r !=3D 0) {
> -=09=09=09int i;
> -
> -=09=09=09printk(KERN_ERR "unable to request IRQ for LCD DMA "
> -=09=09=09       "(error %d)\n", r);
> -=09=09=09for (i =3D 0; i < dma_chan_count; i++)
> -=09=09=09=09free_irq(omap1_dma_irq[i], (void *) (i + 1));
> -=09=09=09goto out_free;
> -=09=09}
> -=09}
> -
>  =09return 0;
> =20
>  out_free:
> diff -uprN git.orig/arch/arm/plat-omap/include/plat/dma.h git/arch/arm/pl=
at-omap/include/plat/dma.h
> --- git.orig/arch/arm/plat-omap/include/plat/dma.h=092009-11-21 00:38:46.=
000000000 +0100
> +++ git/arch/arm/plat-omap/include/plat/dma.h=092009-11-21 03:40:19.00000=
0000 +0100
> @@ -401,33 +401,6 @@
> =20
>  /*----------------------------------------------------------------------=
------*/
> =20
> -/* Hardware registers for LCD DMA */
> -#define OMAP1510_DMA_LCD_BASE=09=09(0xfffedb00)
> -#define OMAP1510_DMA_LCD_CTRL=09=09(OMAP1510_DMA_LCD_BASE + 0x00)
> -#define OMAP1510_DMA_LCD_TOP_F1_L=09(OMAP1510_DMA_LCD_BASE + 0x02)
> -#define OMAP1510_DMA_LCD_TOP_F1_U=09(OMAP1510_DMA_LCD_BASE + 0x04)
> -#define OMAP1510_DMA_LCD_BOT_F1_L=09(OMAP1510_DMA_LCD_BASE + 0x06)
> -#define OMAP1510_DMA_LCD_BOT_F1_U=09(OMAP1510_DMA_LCD_BASE + 0x08)
> -
> -#define OMAP1610_DMA_LCD_BASE=09=09(0xfffee300)
> -#define OMAP1610_DMA_LCD_CSDP=09=09(OMAP1610_DMA_LCD_BASE + 0xc0)
> -#define OMAP1610_DMA_LCD_CCR=09=09(OMAP1610_DMA_LCD_BASE + 0xc2)
> -#define OMAP1610_DMA_LCD_CTRL=09=09(OMAP1610_DMA_LCD_BASE + 0xc4)
> -#define OMAP1610_DMA_LCD_TOP_B1_L=09(OMAP1610_DMA_LCD_BASE + 0xc8)
> -#define OMAP1610_DMA_LCD_TOP_B1_U=09(OMAP1610_DMA_LCD_BASE + 0xca)
> -#define OMAP1610_DMA_LCD_BOT_B1_L=09(OMAP1610_DMA_LCD_BASE + 0xcc)
> -#define OMAP1610_DMA_LCD_BOT_B1_U=09(OMAP1610_DMA_LCD_BASE + 0xce)
> -#define OMAP1610_DMA_LCD_TOP_B2_L=09(OMAP1610_DMA_LCD_BASE + 0xd0)
> -#define OMAP1610_DMA_LCD_TOP_B2_U=09(OMAP1610_DMA_LCD_BASE + 0xd2)
> -#define OMAP1610_DMA_LCD_BOT_B2_L=09(OMAP1610_DMA_LCD_BASE + 0xd4)
> -#define OMAP1610_DMA_LCD_BOT_B2_U=09(OMAP1610_DMA_LCD_BASE + 0xd6)
> -#define OMAP1610_DMA_LCD_SRC_EI_B1=09(OMAP1610_DMA_LCD_BASE + 0xd8)
> -#define OMAP1610_DMA_LCD_SRC_FI_B1_L=09(OMAP1610_DMA_LCD_BASE + 0xda)
> -#define OMAP1610_DMA_LCD_SRC_EN_B1=09(OMAP1610_DMA_LCD_BASE + 0xe0)
> -#define OMAP1610_DMA_LCD_SRC_FN_B1=09(OMAP1610_DMA_LCD_BASE + 0xe4)
> -#define OMAP1610_DMA_LCD_LCH_CTRL=09(OMAP1610_DMA_LCD_BASE + 0xea)
> -#define OMAP1610_DMA_LCD_SRC_FI_B1_U=09(OMAP1610_DMA_LCD_BASE + 0xf4)
> -
>  #define OMAP1_DMA_TOUT_IRQ=09=09(1 << 0)
>  #define OMAP_DMA_DROP_IRQ=09=09(1 << 1)
>  #define OMAP_DMA_HALF_IRQ=09=09(1 << 2)
> @@ -441,6 +414,8 @@
>  #define OMAP2_DMA_SUPERVISOR_ERR_IRQ=09(1 << 10)
>  #define OMAP2_DMA_MISALIGNED_ERR_IRQ=09(1 << 11)
> =20
> +#define OMAP_DMA_CCR_EN=09=09=09(1 << 7)
> +
>  #define OMAP_DMA_DATA_TYPE_S8=09=090x00
>  #define OMAP_DMA_DATA_TYPE_S16=09=090x01
>  #define OMAP_DMA_DATA_TYPE_S32=09=090x02
> @@ -503,14 +478,6 @@
>  #define DMA_CH_PRIO_HIGH=09=090x1
>  #define DMA_CH_PRIO_LOW=09=09=090x0 /* Def */
> =20
> -/* LCD DMA block numbers */
> -enum {
> -=09OMAP_LCD_DMA_B1_TOP,
> -=09OMAP_LCD_DMA_B1_BOTTOM,
> -=09OMAP_LCD_DMA_B2_TOP,
> -=09OMAP_LCD_DMA_B2_BOTTOM
> -};
> -
>  enum omap_dma_burst_mode {
>  =09OMAP_DMA_DATA_BURST_DIS =3D 0,
>  =09OMAP_DMA_DATA_BURST_4,
> @@ -661,20 +628,13 @@ extern int omap_modify_dma_chain_params(
>  extern int omap_dma_chain_status(int chain_id);
>  #endif
> =20
> -/* LCD DMA functions */
> -extern int omap_request_lcd_dma(void (*callback)(u16 status, void *data)=
,
> -=09=09=09=09void *data);
> -extern void omap_free_lcd_dma(void);
> -extern void omap_setup_lcd_dma(void);
> -extern void omap_enable_lcd_dma(void);
> -extern void omap_stop_lcd_dma(void);
> -extern void omap_set_lcd_dma_ext_controller(int external);
> -extern void omap_set_lcd_dma_single_transfer(int single);
> -extern void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_=
yres,
> -=09=09=09=09int data_type);
> -extern void omap_set_lcd_dma_b1_rotation(int rotate);
> -extern void omap_set_lcd_dma_b1_vxres(unsigned long vxres);
> -extern void omap_set_lcd_dma_b1_mirror(int mirror);
> -extern void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int =
yscale);
> +#ifdef CONFIG_ARCH_OMAP1
> +#include <mach/lcd_dma.h>
> +#else
> +static inline int omap_lcd_dma_running(void)
> +{
> +=09return 0;
> +}
> +#endif
> =20
>  #endif /* __ASM_ARCH_DMA_H */
>=20


- Paul
--155748971-763488501-1258967044=:26334--
