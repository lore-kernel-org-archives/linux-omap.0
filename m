From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v2] OMAP: DMA: move LCD related code from plat-omap to
	mach-omap1
Date: Fri, 27 Nov 2009 20:39:18 +0100
Message-ID: <e7c6a05e0911271139n1f59b605n4d4e16880af6c8f5@mail.gmail.com>
References: <200911271325.57355.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:64714 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbZK0TjN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 14:39:13 -0500
Received: by iwn1 with SMTP id 1so1103585iwn.33
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 11:39:18 -0800 (PST)
In-Reply-To: <200911271325.57355.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Nov 27, 2009 at 1:25 PM, Janusz Krzysztofik
<jkrzyszt@tis.icnet.pl> wrote:
> All of the LCD DMA code in plat-omap/dma.c appears to be OMAP1-only (=
and
> apparently only is available on a subset of OMAP1 chips).
>
> Move this code to mach-omap1/lcd_dma.c.
>
> Created against linux-omap for-next,
> commit 4421752e331cfb1d942b47ffdb26e451a8da58a0
>
> Tested on OMAP1510 Amstrad Delta.
> Compile-tested with omap_generic_2420_defconfig.
Teste on HTC Wizard ( omap850 ) htcherald_defconfig.
Display seems to work ;) good job.
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> ---
> Issues addressed since v1:
>
> Thursday 26 November 2009 03:08:30 Paul Walmsley wrote:
>> On Wed, 25 Nov 2009, Janusz Krzysztofik wrote:
>> > Wednesday 25 November 2009 10:02:52 Paul Walmsley wrote:
>> > > On Sat, 21 Nov 2009, Janusz Krzysztofik wrote:
> [snip]
>> > > > -obj-y :=3D io.o id.o sram.o clock.o irq.o mux.o serial.o devi=
ces.o
>> > > > +obj-y :=3D io.o id.o sram.o clock.o irq.o lcd_dma.o mux.o ser=
ial.o devices.o
>> > >
>> > > ... It might be good to add a Kconfig option so OMAP730/850
>> > > users can skip compiling it and save some memory.
>> >
>> > ... arch/arm/mach-omap1/lcd_dma.c
>> > exports several functions that are called unconditionaly from
>> > drivers/video/omap/lcdc.c AND the latter is linked into the omapfb
>> > driver based on CONFIG_ARCH_OMAP1=3Dy...
>> > ... I can see two options:
>> > 1. Keep arch/arm/mach-omap1/lcd_dma.c linked in for any OMAP1 suba=
rch
>> > unless CONFIG_FB_OMAP is not set...
>>
>> Let's take option 1 for right now.
>>
> [snip]
>> > > > +#ifndef __MACH_LCD_DMA_H__
>> > >
>> > > Consider adding _OMAP1_ in this macro name...
>> >
>> > OK, will do that too.
>
> diff -uprN git.orig/arch/arm/mach-omap1/Makefile git/arch/arm/mach-om=
ap1/Makefile
> --- git.orig/arch/arm/mach-omap1/Makefile =C2=A0 =C2=A0 =C2=A0 2009-1=
1-27 11:53:32.000000000 +0100
> +++ git/arch/arm/mach-omap1/Makefile =C2=A0 =C2=A02009-11-27 12:26:50=
=2E000000000 +0100
> @@ -48,3 +48,7 @@ led-$(CONFIG_MACH_OMAP_INNOVATOR) =C2=A0 =C2=A0 +=3D=
 led
> =C2=A0led-$(CONFIG_MACH_OMAP_PERSEUS2) =C2=A0 =C2=A0 =C2=A0 +=3D leds=
-h2p2-debug.o
> =C2=A0led-$(CONFIG_MACH_OMAP_OSK) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D leds-osk.o
> =C2=A0obj-$(CONFIG_LEDS) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 +=3D $(led-y)
> +
> +ifneq ($(CONFIG_FB_OMAP),)
> +obj-y +=3D lcd_dma.o
> +endif
> diff -uprN git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h git/ar=
ch/arm/mach-omap1/include/mach/lcd_dma.h
> --- git.orig/arch/arm/mach-omap1/include/mach/lcd_dma.h 1970-01-01 01=
:00:00.000000000 +0100
> +++ git/arch/arm/mach-omap1/include/mach/lcd_dma.h =C2=A0 =C2=A0 =C2=A0=
2009-11-27 12:29:34.000000000 +0100
> @@ -0,0 +1,78 @@
> +/*
> + * =C2=A0arch/arm/mach-omap1/include/mach/lcd_dma.h
> + *
> + * Extracted from arch/arm/plat-omap/include/plat/dma.h
> + * =C2=A0Copyright (C) 2003 Nokia Corporation
> + * =C2=A0Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + */
> +#ifndef __MACH_OMAP1_LCD_DMA_H__
> +#define __MACH_OMAP1_LCD_DMA_H__
> +
> +/* Hardware registers for LCD DMA */
> +#define OMAP1510_DMA_LCD_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xf=
ffedb00)
> +#define OMAP1510_DMA_LCD_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(OMA=
P1510_DMA_LCD_BASE + 0x00)
> +#define OMAP1510_DMA_LCD_TOP_F1_L =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x02)
> +#define OMAP1510_DMA_LCD_TOP_F1_U =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x04)
> +#define OMAP1510_DMA_LCD_BOT_F1_L =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x06)
> +#define OMAP1510_DMA_LCD_BOT_F1_U =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x08)
> +
> +#define OMAP1610_DMA_LCD_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xf=
ffee300)
> +#define OMAP1610_DMA_LCD_CSDP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(OMA=
P1610_DMA_LCD_BASE + 0xc0)
> +#define OMAP1610_DMA_LCD_CCR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (OMA=
P1610_DMA_LCD_BASE + 0xc2)
> +#define OMAP1610_DMA_LCD_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(OMA=
P1610_DMA_LCD_BASE + 0xc4)
> +#define OMAP1610_DMA_LCD_TOP_B1_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xc8)
> +#define OMAP1610_DMA_LCD_TOP_B1_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xca)
> +#define OMAP1610_DMA_LCD_BOT_B1_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xcc)
> +#define OMAP1610_DMA_LCD_BOT_B1_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xce)
> +#define OMAP1610_DMA_LCD_TOP_B2_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd0)
> +#define OMAP1610_DMA_LCD_TOP_B2_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd2)
> +#define OMAP1610_DMA_LCD_BOT_B2_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd4)
> +#define OMAP1610_DMA_LCD_BOT_B2_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd6)
> +#define OMAP1610_DMA_LCD_SRC_EI_B1 =C2=A0 =C2=A0 (OMAP1610_DMA_LCD_B=
ASE + 0xd8)
> +#define OMAP1610_DMA_LCD_SRC_FI_B1_L =C2=A0 (OMAP1610_DMA_LCD_BASE +=
 0xda)
> +#define OMAP1610_DMA_LCD_SRC_EN_B1 =C2=A0 =C2=A0 (OMAP1610_DMA_LCD_B=
ASE + 0xe0)
> +#define OMAP1610_DMA_LCD_SRC_FN_B1 =C2=A0 =C2=A0 (OMAP1610_DMA_LCD_B=
ASE + 0xe4)
> +#define OMAP1610_DMA_LCD_LCH_CTRL =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xea)
> +#define OMAP1610_DMA_LCD_SRC_FI_B1_U =C2=A0 (OMAP1610_DMA_LCD_BASE +=
 0xf4)
> +
> +/* LCD DMA block numbers */
> +enum {
> + =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B1_TOP,
> + =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B1_BOTTOM,
> + =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B2_TOP,
> + =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B2_BOTTOM
> +};
> +
> +/* LCD DMA functions */
> +extern int omap_request_lcd_dma(void (*callback)(u16 status, void *d=
ata),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data);
> +extern void omap_free_lcd_dma(void);
> +extern void omap_setup_lcd_dma(void);
> +extern void omap_enable_lcd_dma(void);
> +extern void omap_stop_lcd_dma(void);
> +extern void omap_set_lcd_dma_ext_controller(int external);
> +extern void omap_set_lcd_dma_single_transfer(int single);
> +extern void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16=
 fb_yres,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int data_type);
> +extern void omap_set_lcd_dma_b1_rotation(int rotate);
> +extern void omap_set_lcd_dma_b1_vxres(unsigned long vxres);
> +extern void omap_set_lcd_dma_b1_mirror(int mirror);
> +extern void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned =
int yscale);
> +
> +extern int omap_lcd_dma_running(void);
> +
> +#endif /* __MACH_OMAP1_LCD_DMA_H__ */
> diff -uprN git.orig/arch/arm/mach-omap1/lcd_dma.c git/arch/arm/mach-o=
map1/lcd_dma.c
> --- git.orig/arch/arm/mach-omap1/lcd_dma.c =C2=A0 =C2=A0 =C2=A01970-0=
1-01 01:00:00.000000000 +0100
> +++ git/arch/arm/mach-omap1/lcd_dma.c =C2=A0 2009-11-27 12:21:49.0000=
00000 +0100
> @@ -0,0 +1,447 @@
> +/*
> + * linux/arch/arm/mach-omap1/lcd_dma.c
> + *
> + * Extracted from arch/arm/plat-omap/dma.c
> + * Copyright (C) 2003 - 2008 Nokia Corporation
> + * Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
> + * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.=
com>
> + * Graphics DMA and LCD DMA graphics tranformations
> + * by Imre Deak <imre.deak@nokia.com>
> + * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
> + * Merged to support both OMAP1 and OMAP2 by Tony Lindgren <tony@ato=
mide.com>
> + * Some functions based on earlier dma-omap.c Copyright (C) 2001 Rid=
geRun, Inc.
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
> + * Support functions for the OMAP internal DMA channels.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
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
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* On OMAP1510, internal LCD controller w=
ill start the transfer
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* when it gets enabled, so assume DMA ru=
nning if LCD enabled.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omap_readw(0xf=
ffec000 + 0x00) & (1 << 0))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Check if LCD DMA is running */
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap16xx())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omap_readw(OMA=
P1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct lcd_dma_info {
> + =C2=A0 =C2=A0 =C2=A0 spinlock_t lock;
> + =C2=A0 =C2=A0 =C2=A0 int reserved;
> + =C2=A0 =C2=A0 =C2=A0 void (*callback)(u16 status, void *data);
> + =C2=A0 =C2=A0 =C2=A0 void *cb_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 int active;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long addr, size;
> + =C2=A0 =C2=A0 =C2=A0 int rotate, data_type, xres, yres;
> + =C2=A0 =C2=A0 =C2=A0 int vxres;
> + =C2=A0 =C2=A0 =C2=A0 int mirror;
> + =C2=A0 =C2=A0 =C2=A0 int xscale, yscale;
> + =C2=A0 =C2=A0 =C2=A0 int ext_ctrl;
> + =C2=A0 =C2=A0 =C2=A0 int src_port;
> + =C2=A0 =C2=A0 =C2=A0 int single_transfer;
> +} lcd_dma;
> +
> +void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yre=
s,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int data_type)
> +{
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.addr =3D addr;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.data_type =3D data_type;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.xres =3D fb_xres;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.yres =3D fb_yres;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1);
> +
> +void omap_set_lcd_dma_src_port(int port)
> +{
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.src_port =3D port;
> +}
> +
> +void omap_set_lcd_dma_ext_controller(int external)
> +{
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.ext_ctrl =3D external;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
> +
> +void omap_set_lcd_dma_single_transfer(int single)
> +{
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.single_transfer =3D single;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
> +
> +void omap_set_lcd_dma_b1_rotation(int rotate)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA rotation is not supported in 1510 mode\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.rotate =3D rotate;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
> +
> +void omap_set_lcd_dma_b1_mirror(int mirror)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA mirror is not supported in 1510 mode\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.mirror =3D mirror;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
> +
> +void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA virtual resulotion is not supported "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "in 1510 mode\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.vxres =3D vxres;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
> +
> +void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int ysc=
ale)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA scale is not supported in 1510 mode\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.xscale =3D xscale;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.yscale =3D yscale;
> +}
> +EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
> +
> +static void set_b1_regs(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long top, bottom;
> + =C2=A0 =C2=A0 =C2=A0 int es;
> + =C2=A0 =C2=A0 =C2=A0 u16 w;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long en, fn;
> + =C2=A0 =C2=A0 =C2=A0 long ei, fi;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long vxres;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int xscale, yscale;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (lcd_dma.data_type) {
> + =C2=A0 =C2=A0 =C2=A0 case OMAP_DMA_DATA_TYPE_S8:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 es =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case OMAP_DMA_DATA_TYPE_S16:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 es =3D 2;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case OMAP_DMA_DATA_TYPE_S32:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 es =3D 4;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 vxres =3D lcd_dma.vxres ? lcd_dma.vxres : lcd_=
dma.xres;
> + =C2=A0 =C2=A0 =C2=A0 xscale =3D lcd_dma.xscale ? lcd_dma.xscale : 1=
;
> + =C2=A0 =C2=A0 =C2=A0 yscale =3D lcd_dma.yscale ? lcd_dma.yscale : 1=
;
> + =C2=A0 =C2=A0 =C2=A0 BUG_ON(vxres < lcd_dma.xres);
> +
> +#define PIXADDR(x, y) (lcd_dma.addr + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((y) * vxres * ysc=
ale + (x) * xscale) * es)
> +#define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) -=
 es + 1)
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (lcd_dma.rotate) {
> + =C2=A0 =C2=A0 =C2=A0 case 0:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* 1510 DMA requires the bottom address to be 2 more
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* than the actual last memory access location. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (cpu_is_omap1510() &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcd_dma.data_type =3D=3D OMAP_DMA_D=
ATA_TYPE_S32)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bottom =
+=3D 2;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(1, 0, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, 0, lcd_dma.xres - 1, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.xre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.yre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 90:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 1, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, 0, 1, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 1, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(1, 0, 0, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.yre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.xre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 180:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(1, 0, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, 1, lcd_dma.xres - 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(lcd_dma.xres - 1, 1, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.xre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.yre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case 270:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 0, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(1, lcd_dma.yres - 1, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 0, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, lcd_dma.yres - 1, 1, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.yre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.xre=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* Suppres=
s warning about uninitialized vars */
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(top >>=
 16, OMAP1510_DMA_LCD_TOP_F1_U);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(top, O=
MAP1510_DMA_LCD_TOP_F1_L);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom=
 >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom=
, OMAP1510_DMA_LCD_BOT_F1_L);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* 1610 regs */
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1=
_U);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT=
_B1_U);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L)=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CSDP);
> + =C2=A0 =C2=A0 =C2=A0 w &=3D ~0x03;
> + =C2=A0 =C2=A0 =C2=A0 w |=3D lcd_dma.data_type;
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CSDP);
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 /* Always set the source port as SDRAM for now=
*/
> + =C2=A0 =C2=A0 =C2=A0 w &=3D ~(0x03 << 6);
> + =C2=A0 =C2=A0 =C2=A0 if (lcd_dma.callback !=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 1; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Block interrupt enable */
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w &=3D ~(1 << 1);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!(lcd_dma.rotate || lcd_dma.mirror ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcd_dma.vxres || lcd_dma.=
xscale || lcd_dma.yscale))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> + =C2=A0 =C2=A0 =C2=A0 /* Set the double-indexed addressing mode */
> + =C2=A0 =C2=A0 =C2=A0 w |=3D (0x03 << 12);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CCR);
> +
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_=
B1_U);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
> +}
> +
> +static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 w;
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(!(w & (1 << 3)))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_WARNIN=
G "Spurious LCD DMA IRQ\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 /* Ack the IRQ */
> + =C2=A0 =C2=A0 =C2=A0 w |=3D (1 << 3);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 if (lcd_dma.callback !=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcd_dma.callback(w=
, lcd_dma.cb_data);
> +
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irq(&lcd_dma.lock);
> + =C2=A0 =C2=A0 =C2=A0 if (lcd_dma.reserved) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&l=
cd_dma.lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "L=
CD DMA channel already reserved\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.reserved =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&lcd_dma.lock);
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.callback =3D callback;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.cb_data =3D data;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.single_transfer =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.rotate =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.vxres =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.mirror =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.xscale =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.yscale =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.ext_ctrl =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.src_port =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +EXPORT_SYMBOL(omap_request_lcd_dma);
> +
> +void omap_free_lcd_dma(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 spin_lock(&lcd_dma.lock);
> + =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.reserved) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&lcd_d=
ma.lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "L=
CD DMA is not reserved\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_is_omap1510())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(omap_r=
eadw(OMAP1610_DMA_LCD_CCR) & ~1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 OMAP1610_DMA_LCD_CCR);
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.reserved =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock(&lcd_dma.lock);
> +}
> +EXPORT_SYMBOL(omap_free_lcd_dma);
> +
> +void omap_enable_lcd_dma(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 w;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set the Enable bit only if an external=
 controller is
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* connected. Otherwise the OMAP internal=
 controller will
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* start the transfer when it gets enable=
d.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 8;
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> + =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 7;
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CCR);
> +}
> +EXPORT_SYMBOL(omap_enable_lcd_dma);
> +
> +void omap_setup_lcd_dma(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 BUG_ON(lcd_dma.active);
> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_is_omap1510()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set some reason=
able defaults */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(0x5440=
, OMAP1610_DMA_LCD_CCR);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(0x9102=
, OMAP1610_DMA_LCD_CSDP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(0x0004=
, OMAP1610_DMA_LCD_LCH_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 set_b1_regs();
> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_is_omap1510()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 w;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(O=
MAP1610_DMA_LCD_CCR);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If DMA was=
 already active set the end_prog bit to have
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the progra=
mmed register set loaded into the active
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* register s=
et.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 11; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* End_prog */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.singl=
e_transfer)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w |=3D (3 << 8); =C2=A0/* Auto_init, repeat */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMA=
P1610_DMA_LCD_CCR);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +EXPORT_SYMBOL(omap_setup_lcd_dma);
> +
> +void omap_stop_lcd_dma(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 w;
> +
> + =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> + =C2=A0 =C2=A0 =C2=A0 w &=3D ~(1 << 7);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CCR);
> +
> + =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 w &=3D ~(1 << 8);
> + =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> +}
> +EXPORT_SYMBOL(omap_stop_lcd_dma);
> +
> +static int __init omap_init_lcd_dma(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int r;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap16xx()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 w;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* this would prev=
ent OMAP sleep */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(O=
MAP1610_DMA_LCD_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w &=3D ~(1 << 8);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMA=
P1610_DMA_LCD_CTRL);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&lcd_dma.lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 r =3D request_irq(INT_DMA_LCD, lcd_dma_irq_han=
dler, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "LCD DMA", NULL);
> + =C2=A0 =C2=A0 =C2=A0 if (r !=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "u=
nable to request IRQ for LCD DMA "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"(error %d)\n", r);
> +
> + =C2=A0 =C2=A0 =C2=A0 return r;
> +}
> +
> +arch_initcall(omap_init_lcd_dma);
> +
> diff -uprN git.orig/arch/arm/plat-omap/dma.c git/arch/arm/plat-omap/d=
ma.c
> --- git.orig/arch/arm/plat-omap/dma.c =C2=A0 2009-11-27 11:53:45.0000=
00000 +0100
> +++ git/arch/arm/plat-omap/dma.c =C2=A0 =C2=A0 =C2=A0 =C2=A02009-11-2=
7 12:21:49.000000000 +0100
> @@ -47,7 +47,6 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTS
> =C2=A0#endif
>
> =C2=A0#define OMAP_DMA_ACTIVE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01
> -#define OMAP_DMA_CCR_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 7)
> =C2=A0#define OMAP2_DMA_CSR_CLEAR_MASK =C2=A0 =C2=A0 =C2=A0 0xffe
>
> =C2=A0#define OMAP_FUNC_MUX_ARM_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0xf=
ffe1000 + 0xec)
> @@ -1120,17 +1119,8 @@ int omap_dma_running(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int lch;
>
> - =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* On OMAP1510, internal LCD controller w=
ill start the transfer
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* when it gets enabled, so assume DMA ru=
nning if LCD enabled.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap1510())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omap_readw(0xf=
ffec000 + 0x00) & (1 << 0))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 1;
> -
> - =C2=A0 =C2=A0 =C2=A0 /* Check if LCD DMA is running */
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap16xx())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omap_readw(OMA=
P1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
> + =C2=A0 =C2=A0 =C2=A0 if (cpu_class_is_omap1())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omap_lcd_dma_r=
unning())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (lch =3D 0; lch < dma_chan_count; lch+=
+)
> @@ -1990,377 +1980,6 @@ static struct irqaction omap24xx_dma_irq
>
> =C2=A0/*-------------------------------------------------------------=
---------------*/
>
> -static struct lcd_dma_info {
> - =C2=A0 =C2=A0 =C2=A0 spinlock_t lock;
> - =C2=A0 =C2=A0 =C2=A0 int reserved;
> - =C2=A0 =C2=A0 =C2=A0 void (*callback)(u16 status, void *data);
> - =C2=A0 =C2=A0 =C2=A0 void *cb_data;
> -
> - =C2=A0 =C2=A0 =C2=A0 int active;
> - =C2=A0 =C2=A0 =C2=A0 unsigned long addr, size;
> - =C2=A0 =C2=A0 =C2=A0 int rotate, data_type, xres, yres;
> - =C2=A0 =C2=A0 =C2=A0 int vxres;
> - =C2=A0 =C2=A0 =C2=A0 int mirror;
> - =C2=A0 =C2=A0 =C2=A0 int xscale, yscale;
> - =C2=A0 =C2=A0 =C2=A0 int ext_ctrl;
> - =C2=A0 =C2=A0 =C2=A0 int src_port;
> - =C2=A0 =C2=A0 =C2=A0 int single_transfer;
> -} lcd_dma;
> -
> -void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yre=
s,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int data_type)
> -{
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.addr =3D addr;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.data_type =3D data_type;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.xres =3D fb_xres;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.yres =3D fb_yres;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1);
> -
> -void omap_set_lcd_dma_src_port(int port)
> -{
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.src_port =3D port;
> -}
> -
> -void omap_set_lcd_dma_ext_controller(int external)
> -{
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.ext_ctrl =3D external;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
> -
> -void omap_set_lcd_dma_single_transfer(int single)
> -{
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.single_transfer =3D single;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
> -
> -void omap_set_lcd_dma_b1_rotation(int rotate)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (omap_dma_in_1510_mode()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA rotation is not supported in 1510 mode\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.rotate =3D rotate;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
> -
> -void omap_set_lcd_dma_b1_mirror(int mirror)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (omap_dma_in_1510_mode()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA mirror is not supported in 1510 mode\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.mirror =3D mirror;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
> -
> -void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (omap_dma_in_1510_mode()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA virtual resulotion is not supported "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "in 1510 mode\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.vxres =3D vxres;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
> -
> -void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int ysc=
ale)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (omap_dma_in_1510_mode()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "D=
MA scale is not supported in 1510 mode\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.xscale =3D xscale;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.yscale =3D yscale;
> -}
> -EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
> -
> -static void set_b1_regs(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 unsigned long top, bottom;
> - =C2=A0 =C2=A0 =C2=A0 int es;
> - =C2=A0 =C2=A0 =C2=A0 u16 w;
> - =C2=A0 =C2=A0 =C2=A0 unsigned long en, fn;
> - =C2=A0 =C2=A0 =C2=A0 long ei, fi;
> - =C2=A0 =C2=A0 =C2=A0 unsigned long vxres;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int xscale, yscale;
> -
> - =C2=A0 =C2=A0 =C2=A0 switch (lcd_dma.data_type) {
> - =C2=A0 =C2=A0 =C2=A0 case OMAP_DMA_DATA_TYPE_S8:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 es =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case OMAP_DMA_DATA_TYPE_S16:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 es =3D 2;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case OMAP_DMA_DATA_TYPE_S32:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 es =3D 4;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 default:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 vxres =3D lcd_dma.vxres ? lcd_dma.vxres : lcd_=
dma.xres;
> - =C2=A0 =C2=A0 =C2=A0 xscale =3D lcd_dma.xscale ? lcd_dma.xscale : 1=
;
> - =C2=A0 =C2=A0 =C2=A0 yscale =3D lcd_dma.yscale ? lcd_dma.yscale : 1=
;
> - =C2=A0 =C2=A0 =C2=A0 BUG_ON(vxres < lcd_dma.xres);
> -
> -#define PIXADDR(x, y) (lcd_dma.addr + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((y) * vxres * ysc=
ale + (x) * xscale) * es)
> -#define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) -=
 es + 1)
> -
> - =C2=A0 =C2=A0 =C2=A0 switch (lcd_dma.rotate) {
> - =C2=A0 =C2=A0 =C2=A0 case 0:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* 1510 DMA requires the bottom address to be 2 more
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* than the actual last memory access location. */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (omap_dma_in_1510_mode() &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcd_dma.data_type =3D=3D OMAP_DMA_D=
ATA_TYPE_S32)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bottom =
+=3D 2;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(1, 0, 0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, 0, lcd_dma.xres - 1, 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.xre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.yre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 90:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 1, 0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, 0, 1, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 1, 0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(1, 0, 0, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.yre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.xre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 180:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(1, 0, 0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, 1, lcd_dma.xres - 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(lcd_dma.xres - 1, 1, 0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.xre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.yre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 case 270:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.mirro=
r) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(lcd_dma.xres - 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(0, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 0, 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(1, lcd_dma.yres - 1, 0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 top =3D PIXADDR(0, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bottom =3D PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ei =3D PIXSTEP(0, 0, 0, 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fi =3D PIXSTEP(0, lcd_dma.yres - 1, 1, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en =3D lcd_dma.yre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D lcd_dma.xre=
s;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 default:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* Suppres=
s warning about uninitialized vars */
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 if (omap_dma_in_1510_mode()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(top >>=
 16, OMAP1510_DMA_LCD_TOP_F1_U);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(top, O=
MAP1510_DMA_LCD_TOP_F1_L);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom=
 >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom=
, OMAP1510_DMA_LCD_BOT_F1_L);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 /* 1610 regs */
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1=
_U);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT=
_B1_U);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L)=
;
> -
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CSDP);
> - =C2=A0 =C2=A0 =C2=A0 w &=3D ~0x03;
> - =C2=A0 =C2=A0 =C2=A0 w |=3D lcd_dma.data_type;
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CSDP);
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 /* Always set the source port as SDRAM for now=
*/
> - =C2=A0 =C2=A0 =C2=A0 w &=3D ~(0x03 << 6);
> - =C2=A0 =C2=A0 =C2=A0 if (lcd_dma.callback !=3D NULL)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 1; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Block interrupt enable */
> - =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w &=3D ~(1 << 1);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -
> - =C2=A0 =C2=A0 =C2=A0 if (!(lcd_dma.rotate || lcd_dma.mirror ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcd_dma.vxres || lcd_dma.=
xscale || lcd_dma.yscale))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> - =C2=A0 =C2=A0 =C2=A0 /* Set the double-indexed addressing mode */
> - =C2=A0 =C2=A0 =C2=A0 w |=3D (0x03 << 12);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CCR);
> -
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_=
B1_U);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
> -}
> -
> -static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 w;
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 if (unlikely(!(w & (1 << 3)))) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_WARNIN=
G "Spurious LCD DMA IRQ\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 /* Ack the IRQ */
> - =C2=A0 =C2=A0 =C2=A0 w |=3D (1 << 3);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 if (lcd_dma.callback !=3D NULL)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lcd_dma.callback(w=
, lcd_dma.cb_data);
> -
> - =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> -}
> -
> -int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0void *data)
> -{
> - =C2=A0 =C2=A0 =C2=A0 spin_lock_irq(&lcd_dma.lock);
> - =C2=A0 =C2=A0 =C2=A0 if (lcd_dma.reserved) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&l=
cd_dma.lock);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "L=
CD DMA channel already reserved\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.reserved =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&lcd_dma.lock);
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.callback =3D callback;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.cb_data =3D data;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.single_transfer =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.rotate =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.vxres =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.mirror =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.xscale =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.yscale =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.ext_ctrl =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.src_port =3D 0;
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> -}
> -EXPORT_SYMBOL(omap_request_lcd_dma);
> -
> -void omap_free_lcd_dma(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 spin_lock(&lcd_dma.lock);
> - =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.reserved) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&lcd_d=
ma.lock);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "L=
CD DMA is not reserved\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 if (!enable_1510_mode)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(omap_r=
eadw(OMAP1610_DMA_LCD_CCR) & ~1,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 OMAP1610_DMA_LCD_CCR);
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.reserved =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 spin_unlock(&lcd_dma.lock);
> -}
> -EXPORT_SYMBOL(omap_free_lcd_dma);
> -
> -void omap_enable_lcd_dma(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 w;
> -
> - =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set the Enable bit only if an external=
 controller is
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* connected. Otherwise the OMAP internal=
 controller will
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* start the transfer when it gets enable=
d.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 if (enable_1510_mode || !lcd_dma.ext_ctrl)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 8;
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 1;
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> - =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 7;
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CCR);
> -}
> -EXPORT_SYMBOL(omap_enable_lcd_dma);
> -
> -void omap_setup_lcd_dma(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 BUG_ON(lcd_dma.active);
> - =C2=A0 =C2=A0 =C2=A0 if (!enable_1510_mode) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set some reason=
able defaults */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(0x5440=
, OMAP1610_DMA_LCD_CCR);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(0x9102=
, OMAP1610_DMA_LCD_CSDP);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(0x0004=
, OMAP1610_DMA_LCD_LCH_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 set_b1_regs();
> - =C2=A0 =C2=A0 =C2=A0 if (!enable_1510_mode) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 w;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(O=
MAP1610_DMA_LCD_CCR);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If DMA was=
 already active set the end_prog bit to have
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the progra=
mmed register set loaded into the active
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* register s=
et.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w |=3D 1 << 11; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* End_prog */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lcd_dma.singl=
e_transfer)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w |=3D (3 << 8); =C2=A0/* Auto_init, repeat */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMA=
P1610_DMA_LCD_CCR);
> - =C2=A0 =C2=A0 =C2=A0 }
> -}
> -EXPORT_SYMBOL(omap_setup_lcd_dma);
> -
> -void omap_stop_lcd_dma(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u16 w;
> -
> - =C2=A0 =C2=A0 =C2=A0 lcd_dma.active =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 if (enable_1510_mode || !lcd_dma.ext_ctrl)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
> - =C2=A0 =C2=A0 =C2=A0 w &=3D ~(1 << 7);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CCR);
> -
> - =C2=A0 =C2=A0 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 w &=3D ~(1 << 8);
> - =C2=A0 =C2=A0 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> -}
> -EXPORT_SYMBOL(omap_stop_lcd_dma);
> -
> =C2=A0void omap_dma_global_context_save(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_dma_global_context.dma_irqenable_l0 =3D
> @@ -2465,14 +2084,6 @@ static int __init omap_init_dma(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dma_chan_count =3D 16;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dma_chan_count =3D 9;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap16x=
x()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u16 w;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* this would prevent OMAP sleep */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w =3D omap_readw(OMAP1610_DMA_LCD_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w &=3D ~(1 << 8);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 omap_writew(w, OMAP1610_DMA_LCD_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (cpu_class_is_omap2()) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 revision =3D=
 dma_read(REVISION) & 0xff;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_IN=
=46O "OMAP DMA hardware revision %d.%d\n",
> @@ -2483,7 +2094,6 @@ static int __init omap_init_dma(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&lcd_dma.lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&dma_chan_lock);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (ch =3D 0; ch < dma_chan_count; ch++) =
{
> @@ -2548,22 +2158,6 @@ static int __init omap_init_dma(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> -
> - =C2=A0 =C2=A0 =C2=A0 /* FIXME: Update LCD DMA to work on 24xx */
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_class_is_omap1()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D request_irq(=
INT_DMA_LCD, lcd_dma_irq_handler, 0,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "LCD DMA", NULL);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r !=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int i;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_ERR "unable to request IRQ for LCD DMA "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"(error %d)\n", r);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 for (i =3D 0; i < dma_chan_count; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_irq(omap1_dma_irq[i], (void *)=
 (i + 1));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto out_free;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> =C2=A0out_free:
> diff -uprN git.orig/arch/arm/plat-omap/include/plat/dma.h git/arch/ar=
m/plat-omap/include/plat/dma.h
> --- git.orig/arch/arm/plat-omap/include/plat/dma.h =C2=A0 =C2=A0 =C2=A0=
2009-11-27 11:53:45.000000000 +0100
> +++ git/arch/arm/plat-omap/include/plat/dma.h =C2=A0 2009-11-27 12:28=
:22.000000000 +0100
> @@ -401,33 +401,6 @@
>
> =C2=A0/*-------------------------------------------------------------=
---------------*/
>
> -/* Hardware registers for LCD DMA */
> -#define OMAP1510_DMA_LCD_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xf=
ffedb00)
> -#define OMAP1510_DMA_LCD_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(OMA=
P1510_DMA_LCD_BASE + 0x00)
> -#define OMAP1510_DMA_LCD_TOP_F1_L =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x02)
> -#define OMAP1510_DMA_LCD_TOP_F1_U =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x04)
> -#define OMAP1510_DMA_LCD_BOT_F1_L =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x06)
> -#define OMAP1510_DMA_LCD_BOT_F1_U =C2=A0 =C2=A0 =C2=A0(OMAP1510_DMA_=
LCD_BASE + 0x08)
> -
> -#define OMAP1610_DMA_LCD_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xf=
ffee300)
> -#define OMAP1610_DMA_LCD_CSDP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(OMA=
P1610_DMA_LCD_BASE + 0xc0)
> -#define OMAP1610_DMA_LCD_CCR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (OMA=
P1610_DMA_LCD_BASE + 0xc2)
> -#define OMAP1610_DMA_LCD_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(OMA=
P1610_DMA_LCD_BASE + 0xc4)
> -#define OMAP1610_DMA_LCD_TOP_B1_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xc8)
> -#define OMAP1610_DMA_LCD_TOP_B1_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xca)
> -#define OMAP1610_DMA_LCD_BOT_B1_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xcc)
> -#define OMAP1610_DMA_LCD_BOT_B1_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xce)
> -#define OMAP1610_DMA_LCD_TOP_B2_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd0)
> -#define OMAP1610_DMA_LCD_TOP_B2_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd2)
> -#define OMAP1610_DMA_LCD_BOT_B2_L =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd4)
> -#define OMAP1610_DMA_LCD_BOT_B2_U =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xd6)
> -#define OMAP1610_DMA_LCD_SRC_EI_B1 =C2=A0 =C2=A0 (OMAP1610_DMA_LCD_B=
ASE + 0xd8)
> -#define OMAP1610_DMA_LCD_SRC_FI_B1_L =C2=A0 (OMAP1610_DMA_LCD_BASE +=
 0xda)
> -#define OMAP1610_DMA_LCD_SRC_EN_B1 =C2=A0 =C2=A0 (OMAP1610_DMA_LCD_B=
ASE + 0xe0)
> -#define OMAP1610_DMA_LCD_SRC_FN_B1 =C2=A0 =C2=A0 (OMAP1610_DMA_LCD_B=
ASE + 0xe4)
> -#define OMAP1610_DMA_LCD_LCH_CTRL =C2=A0 =C2=A0 =C2=A0(OMAP1610_DMA_=
LCD_BASE + 0xea)
> -#define OMAP1610_DMA_LCD_SRC_FI_B1_U =C2=A0 (OMAP1610_DMA_LCD_BASE +=
 0xf4)
> -
> =C2=A0#define OMAP1_DMA_TOUT_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 << 0)
> =C2=A0#define OMAP_DMA_DROP_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 << 1)
> =C2=A0#define OMAP_DMA_HALF_IRQ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 << 2)
> @@ -441,6 +414,8 @@
> =C2=A0#define OMAP2_DMA_SUPERVISOR_ERR_IRQ =C2=A0 (1 << 10)
> =C2=A0#define OMAP2_DMA_MISALIGNED_ERR_IRQ =C2=A0 (1 << 11)
>
> +#define OMAP_DMA_CCR_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 7)
> +
> =C2=A0#define OMAP_DMA_DATA_TYPE_S8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x00
> =C2=A0#define OMAP_DMA_DATA_TYPE_S16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01
> =C2=A0#define OMAP_DMA_DATA_TYPE_S32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02
> @@ -503,14 +478,6 @@
> =C2=A0#define DMA_CH_PRIO_HIGH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x1
> =C2=A0#define DMA_CH_PRIO_LOW =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0 /* Def */
>
> -/* LCD DMA block numbers */
> -enum {
> - =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B1_TOP,
> - =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B1_BOTTOM,
> - =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B2_TOP,
> - =C2=A0 =C2=A0 =C2=A0 OMAP_LCD_DMA_B2_BOTTOM
> -};
> -
> =C2=A0enum omap_dma_burst_mode {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_DMA_DATA_BURST_DIS =3D 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_DMA_DATA_BURST_4,
> @@ -661,20 +628,13 @@ extern int omap_modify_dma_chain_params(
> =C2=A0extern int omap_dma_chain_status(int chain_id);
> =C2=A0#endif
>
> -/* LCD DMA functions */
> -extern int omap_request_lcd_dma(void (*callback)(u16 status, void *d=
ata),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data);
> -extern void omap_free_lcd_dma(void);
> -extern void omap_setup_lcd_dma(void);
> -extern void omap_enable_lcd_dma(void);
> -extern void omap_stop_lcd_dma(void);
> -extern void omap_set_lcd_dma_ext_controller(int external);
> -extern void omap_set_lcd_dma_single_transfer(int single);
> -extern void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16=
 fb_yres,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int data_type);
> -extern void omap_set_lcd_dma_b1_rotation(int rotate);
> -extern void omap_set_lcd_dma_b1_vxres(unsigned long vxres);
> -extern void omap_set_lcd_dma_b1_mirror(int mirror);
> -extern void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned =
int yscale);
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_FB_OMAP)
> +#include <mach/lcd_dma.h>
> +#else
> +static inline int omap_lcd_dma_running(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +#endif
>
> =C2=A0#endif /* __ASM_ARCH_DMA_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Marek
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
