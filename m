From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2: Remove legacy USB FS support
Date: Tue, 22 May 2012 10:07:03 +0300
Message-ID: <20120522070702.GB30559@arwen.pp.htv.fi>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190106.927.57764.stgit@muffinssi.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:49573 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752211Ab2EVHJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 03:09:04 -0400
Received: by lbbgj10 with SMTP id gj10so4986292lbb.23
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 00:09:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120521190106.927.57764.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 12:01:06PM -0700, Tony Lindgren wrote:
> The FS (Full Speed) USB controller is available on 2420 and 2430,
> but not being used.
>=20
> Out of the 2420 based boards only Nokia N8X0 are seeing active
> development and they have external HS (High Speed) TUSB controller.
> On omap 2430sdp there is MUSB HS controller, so there's no need
> to use the legacy USB FS controller.
>=20
> That leaves only H4 and Apollon boards that could use the FS USB
> controller. As both H4 and Apollon boards are old proprietary
> development boards, it's unlikely that we have any active
> developers working on those boards using the USB.
>=20
> So remove the FS USB support for omap2 machines. Patches are
> welcome if somebody wants to instead fix it all up to the
> current standards.
>=20
> Cc: linux-usb@vger.kernel.org
> Cc: Felipe Balbi <balbi@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Kconfig         |    2=20
>  arch/arm/mach-omap2/Makefile        |    3=20
>  arch/arm/mach-omap2/board-2430sdp.c |   11 -
>  arch/arm/mach-omap2/board-apollon.c |   18 --
>  arch/arm/mach-omap2/board-h4.c      |   13 -
>  arch/arm/mach-omap2/usb-fs.c        |  359 -----------------------------=
------
>  6 files changed, 406 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/usb-fs.c
>=20
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0e4dd67..042f157 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -64,13 +64,11 @@ config SOC_OMAP2420
>  	depends on ARCH_OMAP2
>  	default y
>  	select OMAP_DM_TIMER
> -	select ARCH_OMAP_OTG
> =20
>  config SOC_OMAP2430
>  	bool "OMAP2430 support"
>  	depends on ARCH_OMAP2
>  	default y
> -	select ARCH_OMAP_OTG
> =20
>  config SOC_OMAP3430
>  	bool "OMAP3430 support"
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index fa742f3..664224f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -244,9 +244,6 @@ obj-y					+=3D $(omap-flash-y) $(omap-flash-m)
>  omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:=3D hsmmc.o
>  obj-y					+=3D $(omap-hsmmc-m) $(omap-hsmmc-y)
> =20
> -
> -usbfs-$(CONFIG_ARCH_OMAP_OTG)		:=3D usb-fs.o
> -obj-y					+=3D $(usbfs-m) $(usbfs-y)
>  obj-y					+=3D usb-musb.o
>  obj-y					+=3D omap_phy_internal.o
> =20
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/bo=
ard-2430sdp.c
> index 99ca6ba..6523aea 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -254,16 +254,6 @@ static struct omap2_hsmmc_info mmc[] __initdata =3D {
>  	{}	/* Terminator */
>  };
> =20
> -static struct omap_usb_config sdp2430_usb_config __initdata =3D {
> -	.otg		=3D 1,
> -#ifdef  CONFIG_USB_GADGET_OMAP
> -	.hmc_mode	=3D 0x0,
> -#elif   defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODU=
LE)
> -	.hmc_mode	=3D 0x1,
> -#endif
> -	.pins[0]	=3D 3,
> -};
> -
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata =3D {
>  	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> @@ -280,7 +270,6 @@ static void __init omap_2430sdp_init(void)
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  	omap_hsmmc_init(mmc);
> -	omap2_usbfs_init(&sdp2430_usb_config);
> =20
>  	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
>  	usb_musb_init(NULL);
> diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/bo=
ard-apollon.c
> index 502c31e..519bcd3 100644
> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -35,7 +35,6 @@
>  #include <asm/mach/flash.h>
> =20
>  #include <plat/led.h>
> -#include <plat/usb.h>
>  #include <plat/board.h>
>  #include "common.h"
>  #include <plat/gpmc.h>
> @@ -253,13 +252,6 @@ out:
>  	clk_put(gpmc_fck);
>  }
> =20
> -static struct omap_usb_config apollon_usb_config __initdata =3D {
> -	.register_dev	=3D 1,
> -	.hmc_mode	=3D 0x14,	/* 0:dev 1:host1 2:disable */
> -
> -	.pins[0]	=3D 6,
> -};
> -
>  static struct panel_generic_dpi_data apollon_panel_data =3D {
>  	.name			=3D "apollon",
>  };
> @@ -297,15 +289,6 @@ static void __init apollon_led_init(void)
>  	gpio_request_array(apollon_gpio_leds, ARRAY_SIZE(apollon_gpio_leds));
>  }
> =20
> -static void __init apollon_usb_init(void)
> -{
> -	/* USB device */
> -	/* DEVICE_SUSPEND */
> -	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
> -	gpio_request_one(12, GPIOF_OUT_INIT_LOW, "USB suspend");
> -	omap2_usbfs_init(&apollon_usb_config);
> -}
> -
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata =3D {
>  	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> @@ -321,7 +304,6 @@ static void __init omap_apollon_init(void)
>  	apollon_init_smc91x();
>  	apollon_led_init();
>  	apollon_flash_init();
> -	apollon_usb_init();
> =20
>  	/* REVISIT: where's the correct place */
>  	omap_mux_init_signal("sys_nirq", OMAP_PULL_ENA | OMAP_PULL_UP);
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h=
4.c
> index 876becf..ace2048 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -32,7 +32,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> =20
> -#include <plat/usb.h>
>  #include <plat/board.h>
>  #include "common.h"
>  #include <plat/menelaus.h>
> @@ -329,17 +328,6 @@ static void __init h4_init_flash(void)
>  	h4_flash_resource.end	=3D base + SZ_64M - 1;
>  }
> =20
> -static struct omap_usb_config h4_usb_config __initdata =3D {
> -	/* S1.10 OFF -- usb "download port"
> -	 * usb0 switched to Mini-B port and isp1105 transceiver;
> -	 * S2.POS3 =3D ON, S2.POS4 =3D OFF ... to enable battery charging
> -	 */
> -	.register_dev	=3D 1,
> -	.pins[0]	=3D 3,
> -/*	.hmc_mode	=3D 0x14,*/	/* 0:dev 1:host 2:disable */
> -	.hmc_mode	=3D 0x00,		/* 0:dev|otg 1:disable 2:disable */
> -};
> -
>  static struct at24_platform_data m24c01 =3D {
>  	.byte_len	=3D SZ_1K / 8,
>  	.page_size	=3D 16,
> @@ -381,7 +369,6 @@ static void __init omap_h4_init(void)
>  			ARRAY_SIZE(h4_i2c_board_info));
> =20
>  	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
> -	omap2_usbfs_init(&h4_usb_config);
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  	h4_init_flash();
> diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
> deleted file mode 100644
> index 1481078..0000000
> --- a/arch/arm/mach-omap2/usb-fs.c
> +++ /dev/null
> @@ -1,359 +0,0 @@
> -/*
> - * Platform level USB initialization for FS USB OTG controller on omap1 =
and 24xx
> - *
> - * Copyright (C) 2004 Texas Instruments, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/clk.h>
> -#include <linux/err.h>
> -
> -#include <asm/irq.h>
> -
> -#include <plat/usb.h>
> -#include <plat/board.h>
> -
> -#include "control.h"
> -#include "mux.h"
> -
> -#define INT_USB_IRQ_GEN		INT_24XX_USB_IRQ_GEN
> -#define INT_USB_IRQ_NISO	INT_24XX_USB_IRQ_NISO
> -#define INT_USB_IRQ_ISO		INT_24XX_USB_IRQ_ISO
> -#define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
> -#define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
> -
> -#if defined(CONFIG_ARCH_OMAP2)
> -
> -#ifdef	CONFIG_USB_GADGET_OMAP
> -
> -static struct resource udc_resources[] =3D {
> -	/* order is significant! */
> -	{		/* registers */
> -		.start		=3D UDC_BASE,
> -		.end		=3D UDC_BASE + 0xff,
> -		.flags		=3D IORESOURCE_MEM,
> -	}, {		/* general IRQ */
> -		.start		=3D INT_USB_IRQ_GEN,
> -		.flags		=3D IORESOURCE_IRQ,
> -	}, {		/* PIO IRQ */
> -		.start		=3D INT_USB_IRQ_NISO,
> -		.flags		=3D IORESOURCE_IRQ,
> -	}, {		/* SOF IRQ */
> -		.start		=3D INT_USB_IRQ_ISO,
> -		.flags		=3D IORESOURCE_IRQ,
> -	},
> -};
> -
> -static u64 udc_dmamask =3D ~(u32)0;
> -
> -static struct platform_device udc_device =3D {
> -	.name		=3D "omap_udc",
> -	.id		=3D -1,
> -	.dev =3D {
> -		.dma_mask		=3D &udc_dmamask,
> -		.coherent_dma_mask	=3D 0xffffffff,
> -	},
> -	.num_resources	=3D ARRAY_SIZE(udc_resources),
> -	.resource	=3D udc_resources,
> -};
> -
> -static inline void udc_device_init(struct omap_usb_config *pdata)
> -{
> -	pdata->udc_device =3D &udc_device;
> -}
> -
> -#else
> -
> -static inline void udc_device_init(struct omap_usb_config *pdata)
> -{
> -}
> -
> -#endif
> -
> -#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> -
> -/* The dmamask must be set for OHCI to work */
> -static u64 ohci_dmamask =3D ~(u32)0;
> -
> -static struct resource ohci_resources[] =3D {
> -	{
> -		.start	=3D OMAP_OHCI_BASE,
> -		.end	=3D OMAP_OHCI_BASE + 0xff,
> -		.flags	=3D IORESOURCE_MEM,
> -	},
> -	{
> -		.start	=3D INT_USB_IRQ_HGEN,
> -		.flags	=3D IORESOURCE_IRQ,
> -	},
> -};
> -
> -static struct platform_device ohci_device =3D {
> -	.name			=3D "ohci",
> -	.id			=3D -1,
> -	.dev =3D {
> -		.dma_mask		=3D &ohci_dmamask,
> -		.coherent_dma_mask	=3D 0xffffffff,
> -	},
> -	.num_resources	=3D ARRAY_SIZE(ohci_resources),
> -	.resource		=3D ohci_resources,
> -};
> -
> -static inline void ohci_device_init(struct omap_usb_config *pdata)
> -{
> -	pdata->ohci_device =3D &ohci_device;
> -}
> -
> -#else
> -
> -static inline void ohci_device_init(struct omap_usb_config *pdata)
> -{
> -}
> -
> -#endif
> -
> -#if	defined(CONFIG_USB_OTG) && defined(CONFIG_ARCH_OMAP_OTG)
> -
> -static struct resource otg_resources[] =3D {
> -	/* order is significant! */
> -	{
> -		.start		=3D OTG_BASE,
> -		.end		=3D OTG_BASE + 0xff,
> -		.flags		=3D IORESOURCE_MEM,
> -	}, {
> -		.start		=3D INT_USB_IRQ_OTG,
> -		.flags		=3D IORESOURCE_IRQ,
> -	},
> -};
> -
> -static struct platform_device otg_device =3D {
> -	.name		=3D "omap_otg",
> -	.id		=3D -1,
> -	.num_resources	=3D ARRAY_SIZE(otg_resources),
> -	.resource	=3D otg_resources,
> -};
> -
> -static inline void otg_device_init(struct omap_usb_config *pdata)
> -{
> -	pdata->otg_device =3D &otg_device;
> -}
> -
> -#else
> -
> -static inline void otg_device_init(struct omap_usb_config *pdata)
> -{
> -}
> -
> -#endif
> -
> -static void omap2_usb_devconf_clear(u8 port, u32 mask)
> -{
> -	u32 r;
> -
> -	r =3D omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> -	r &=3D ~USBTXWRMODEI(port, mask);
> -	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
> -}
> -
> -static void omap2_usb_devconf_set(u8 port, u32 mask)
> -{
> -	u32 r;
> -
> -	r =3D omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> -	r |=3D USBTXWRMODEI(port, mask);
> -	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
> -}
> -
> -static void omap2_usb2_disable_5pinbitll(void)
> -{
> -	u32 r;
> -
> -	r =3D omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> -	r &=3D ~(USBTXWRMODEI(2, USB_BIDIR_TLL) | USBT2TLL5PI);
> -	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
> -}
> -
> -static void omap2_usb2_enable_5pinunitll(void)
> -{
> -	u32 r;
> -
> -	r =3D omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> -	r |=3D USBTXWRMODEI(2, USB_UNIDIR_TLL) | USBT2TLL5PI;
> -	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
> -}
> -
> -static u32 __init omap2_usb0_init(unsigned nwires, unsigned is_device)
> -{
> -	u32	syscon1 =3D 0;
> -
> -	omap2_usb_devconf_clear(0, USB_BIDIR_TLL);
> -
> -	if (nwires =3D=3D 0)
> -		return 0;
> -
> -	if (is_device)
> -		omap_mux_init_signal("usb0_puen", 0);
> -
> -	omap_mux_init_signal("usb0_dat", 0);
> -	omap_mux_init_signal("usb0_txen", 0);
> -	omap_mux_init_signal("usb0_se0", 0);
> -	if (nwires !=3D 3)
> -		omap_mux_init_signal("usb0_rcv", 0);
> -
> -	switch (nwires) {
> -	case 3:
> -		syscon1 =3D 2;
> -		omap2_usb_devconf_set(0, USB_BIDIR);
> -		break;
> -	case 4:
> -		syscon1 =3D 1;
> -		omap2_usb_devconf_set(0, USB_BIDIR);
> -		break;
> -	case 6:
> -		syscon1 =3D 3;
> -		omap_mux_init_signal("usb0_vp", 0);
> -		omap_mux_init_signal("usb0_vm", 0);
> -		omap2_usb_devconf_set(0, USB_UNIDIR);
> -		break;
> -	default:
> -		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
> -			0, nwires);
> -	}
> -
> -	return syscon1 << 16;
> -}
> -
> -static u32 __init omap2_usb1_init(unsigned nwires)
> -{
> -	u32	syscon1 =3D 0;
> -
> -	omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
> -
> -	if (nwires =3D=3D 0)
> -		return 0;
> -
> -	/* NOTE:  board-specific code must set up pin muxing for usb1,
> -	 * since each signal could come out on either of two balls.
> -	 */
> -
> -	switch (nwires) {
> -	case 2:
> -		/* NOTE: board-specific code must override this setting if
> -		 * this TLL link is not using DP/DM
> -		 */
> -		syscon1 =3D 1;
> -		omap2_usb_devconf_set(1, USB_BIDIR_TLL);
> -		break;
> -	case 3:
> -		syscon1 =3D 2;
> -		omap2_usb_devconf_set(1, USB_BIDIR);
> -		break;
> -	case 4:
> -		syscon1 =3D 1;
> -		omap2_usb_devconf_set(1, USB_BIDIR);
> -		break;
> -	case 6:
> -	default:
> -		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
> -			1, nwires);
> -	}
> -
> -	return syscon1 << 20;
> -}
> -
> -static u32 __init omap2_usb2_init(unsigned nwires, unsigned alt_pingroup)
> -{
> -	u32	syscon1 =3D 0;
> -
> -	omap2_usb2_disable_5pinbitll();
> -	alt_pingroup =3D 0;
> -
> -	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
> -	if (alt_pingroup || nwires =3D=3D 0)
> -		return 0;
> -
> -	omap_mux_init_signal("usb2_dat", 0);
> -	omap_mux_init_signal("usb2_se0", 0);
> -	if (nwires > 2)
> -		omap_mux_init_signal("usb2_txen", 0);
> -	if (nwires > 3)
> -		omap_mux_init_signal("usb2_rcv", 0);
> -
> -	switch (nwires) {
> -	case 2:
> -		/* NOTE: board-specific code must override this setting if
> -		 * this TLL link is not using DP/DM
> -		 */
> -		syscon1 =3D 1;
> -		omap2_usb_devconf_set(2, USB_BIDIR_TLL);
> -		break;
> -	case 3:
> -		syscon1 =3D 2;
> -		omap2_usb_devconf_set(2, USB_BIDIR);
> -		break;
> -	case 4:
> -		syscon1 =3D 1;
> -		omap2_usb_devconf_set(2, USB_BIDIR);
> -		break;
> -	case 5:
> -		/* NOTE: board-specific code must mux this setting depending
> -		 * on TLL link using DP/DM.  Something must also
> -		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
> -		 * 2420: hdq_sio.usb2_tllse0 or vlynq_rx0.usb2_tllse0
> -		 * 2430: hdq_sio.usb2_tllse0 or sdmmc2_dat0.usb2_tllse0
> -		 */
> -
> -		syscon1 =3D 3;
> -		omap2_usb2_enable_5pinunitll();
> -		break;
> -	case 6:
> -	default:
> -		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
> -			2, nwires);
> -	}
> -
> -	return syscon1 << 24;
> -}
> -
> -void __init omap2_usbfs_init(struct omap_usb_config *pdata)
> -{
> -	struct clk *ick;
> -
> -	if (!cpu_is_omap24xx())
> -		return;
> -
> -	ick =3D clk_get(NULL, "usb_l4_ick");
> -	if (IS_ERR(ick))
> -		return;
> -
> -	clk_enable(ick);
> -	pdata->usb0_init =3D omap2_usb0_init;
> -	pdata->usb1_init =3D omap2_usb1_init;
> -	pdata->usb2_init =3D omap2_usb2_init;
> -	udc_device_init(pdata);
> -	ohci_device_init(pdata);
> -	otg_device_init(pdata);
> -	omap_otg_init(pdata);
> -	clk_disable(ick);
> -	clk_put(ick);
> -}
> -
> -#endif
>=20

--=20
balbi

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPuzsVAAoJEIaOsuA1yqRE3mYQAIytgwigB3UaXL+GZPcu8849
vWrJuiUbkvL47s2ZPS3gdHsz+rZg7iZY4VHI6m2jsvU2/wWcYWKNY91SdwKubs0C
Q2mEs+Hc4nt+VVQbf7IoYbMgI7eF7KYEQh7qAUYL+Aa0zk9t52zscR6SF0MJdS0j
XQ0TjGQuUWn0sFjlUJNPU5BmsDjEIOHU8sy+uP9ciagYm2TG4yP0tYflp/HCzk0F
yvCLaolBbVY0E4+SH8RQp6EzmkVmtJzgGuEDeqGOPXj6j8Dg+X/yAdMmPFdrBpPI
h4zO3ibdXcYEWFESeKFkmNIcqYXoICOUsQ8EZ0fokiHQlyy/QX08x7eKk8Zjqmh7
UA1x4X80ULi+RztX4RBuPw16KrI0VFLnoucgI4pzNolI4PBCCMpGoOYFaZ8i1zR0
NKIRF3zMNI/g3E3EGasJ+5gOh43UBYh91JthFKoXo/b13DlP7+zUPUvAP/k2b1hR
n+DLn+rVDs4qzI1b+zLhU36QFduXYm1zS/D6fjXUo83yoWmcSCayP5W743tCoUnH
DWy5Qeh/i2xWKMrDBNMGhNDpGLScZy0K4IVDCWKK7Qcg/cmGV4qfyGzzA/5YOxSB
JsnIPn7N5X0dW1ogEq0ylDkBxVAkfUQsu+6PeDmCzOwCXx6nocx6QbjWpfD2igg6
yVLF4erki7wkxVpbMx3m
=MPIG
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
