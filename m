From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] arm: fix compilation warning during compilation
Date: Mon, 8 Nov 2010 10:13:02 +0100
Message-ID: <20101108091302.GO16938@pengutronix.de>
References: <4CD51A9B.7010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CD51A9B.7010806@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sanjeev Premi <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Sat, Nov 06, 2010 at 10:06:35AM +0100, Marco Stornelli wrote:
> From: Marco Stornelli <marco.stornelli@gmail.com>
>=20
> During compilation of 2.6.36 for Beagle board, there a are a couple o=
f warnings. This patch fix them.
Please break lines for commit logs at around 76 chars and mention the
exact compiler warning being fixed.

>=20
> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
> ---
>=20
> --- linux-2.6.36-orig/arch/arm/plat-omap/include/plat/usb.h	2010-10-2=
0 22:30:22.000000000 +0200
> +++ linux-2.6.36/arch/arm/plat-omap/include/plat/usb.h	2010-11-01 09:=
44:13.000000000 +0100
> @@ -105,7 +105,7 @@ static inline void omap1_usb_init(struct
>  #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP_OTG_MO=
DULE)
>  void omap2_usbfs_init(struct omap_usb_config *pdata);
>  #else
> -static inline omap2_usbfs_init(struct omap_usb_config *pdata)
> +static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
>  {
>  }
>  #endif
> --- linux-2.6.36-orig/arch/arm/mach-omap2/mux.c	2010-10-20 22:30:22.0=
00000000 +0200
> +++ linux-2.6.36/arch/arm/mach-omap2/mux.c	2010-11-01 10:21:29.000000=
000 +0100
> @@ -87,7 +87,7 @@ static char *omap_mux_options;
>  int __init omap_mux_init_gpio(int gpio, int val)
>  {
>  	struct omap_mux_entry *e;
> -	struct omap_mux *gpio_mux;
> +	struct omap_mux *gpio_mux =3D NULL;
this warning is already fixed by ca82876 (omap2: fix assorted compiler
warnings).

As this warning is a false positive (i.e. gpio_mux is never used
uninitialized), making the line read

	struct omap_mux *uninitialized_var(gpio_mux);

(IMHO) would have been a bit better for both, readabily and (probably)
generated code.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
