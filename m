From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/3] memory: gpmc: Move omap gpmc code to live under
 drivers
Date: Fri, 21 Nov 2014 12:39:11 -0600
Message-ID: <20141121183911.GA7508@saruman>
References: <1416594856-15201-1-git-send-email-tony@atomide.com>
 <1416594856-15201-4-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LG5jgFgJbJFFiAfj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57630 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaKUSjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 13:39:21 -0500
Content-Disposition: inline
In-Reply-To: <1416594856-15201-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>

--LG5jgFgJbJFFiAfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 10:34:16AM -0800, Tony Lindgren wrote:
> Just move to drivers as further clean-up can now happen there
> finally.
>=20
> Let's also add Roger and me to the MAINTAINERS so we get
> notified for any patches related to GPMC.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  MAINTAINERS                                              | 8 ++++++++
>  arch/arm/mach-omap2/Kconfig                              | 2 ++
>  arch/arm/mach-omap2/Makefile                             | 2 +-
>  drivers/memory/Kconfig                                   | 8 ++++++++
>  drivers/memory/Makefile                                  | 1 +
>  arch/arm/mach-omap2/gpmc.c =3D> drivers/memory/omap-gpmc.c | 0
>  6 files changed, 20 insertions(+), 1 deletion(-)
>  rename arch/arm/mach-omap2/gpmc.c =3D> drivers/memory/omap-gpmc.c (100%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dab92a7..78cc059 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6629,6 +6629,14 @@ L:	linux-omap@vger.kernel.org
>  S:	Maintained
>  F:	sound/soc/omap/
> =20
> +OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT
> +M:	Roger Quadros <rogerq@ti.com>
> +M:	Tony Lindgren <tony@atomide.com>
> +L:	linux-omap@vger.kernel.org
> +S:	Maintained
> +F:	drivers/memory/omap-gpmc.c
> +F:	arch/arm/mach-omap2/*gpmc*
> +
>  OMAP FRAMEBUFFER SUPPORT
>  M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
>  L:	linux-fbdev@vger.kernel.org
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f4d06ae..0ea218e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -79,7 +79,9 @@ config ARCH_OMAP2PLUS
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
>  	select MACH_OMAP_GENERIC
> +	select MEMORY
>  	select OMAP_DM_TIMER
> +	select OMAP_GPMC
>  	select PINCTRL
>  	select SOC_BUS
>  	select TI_PRIV_EDMA
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 3e824f8..bd85741 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) :=3D -I$(srctree)/$(=
src)/include \
>  	-I$(srctree)/arch/arm/plat-omap/include
> =20
>  # Common support
> -obj-y :=3D id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o time=
r.o pm.o \
> +obj-y :=3D id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.=
o \
>  	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
>  	 omap_device.o sram.o drm.o
> =20
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 6d91c27..6759de7 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -41,6 +41,14 @@ config TI_EMIF
>  	  parameters and other settings during frequency, voltage and
>  	  temperature changes
> =20
> +config OMAP_GPMC
> +	bool

shouldn't you make this selectable ? I might want to build a kernel
without GPMC support because my board just doesn't use GPMC :-)

--=20
balbi

--LG5jgFgJbJFFiAfj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb4bPAAoJEIaOsuA1yqREjEsQAKFUYahkWmnNouTgI/DWiDaM
FeNADs8mqzhHIO1jo4gCQALY1WpYAyofJc3B4wF5xHAZ0gEuB8vUORxdOm+ZTyBC
1gOVrZISpgkrG93JL2+O2uVhrvUiKLaDiyqFzsOKdIO5NX3rvQcC/83zb77dzCh8
orfshB1CWFvc0CU5Vb36L6nW3CynC2K+qkJXUCgeMHFFQXRas74pXYKUsNxJs5NQ
KLoxGCQaBxEKbkn/EzpXOK0ft7CX3/l0zTbshEGtST1HiCOD4aTO+DVqo3PZ2tHM
YOI90pHFdDVZhlZqWvw4IWgXm790nwYlnD4UfKFgXsMHYWysoFABMPevv384M8NI
1g3/WLgl2KDRJYadb2R3zQ7nWkD4QUkL0gNvBAnYtHEMAXEDOWj8lzM07Y0yjwfK
xC/xwDlNBCosbCDU2ef2CmoeiwnQiZ9mdL4qLBBSBkPUoJ8HF/c/SlZ7MH+U6Fij
mczuZUVHNSeYHmrmoPy3gZnVn7bk/Yzx8XKLsVx+OzX57p1muwVrZzqaJmVuyFop
h4vQNwZC4HBf4Jr6d7uEEpHx72kpOCxUpOTKLYRphAs/E5Fp90CADXZ025hLVoJd
JAq1AARo7S8iasY+VDHY2qCw4JUtxosFYwWPsrkJlVC1/oKpgirPR+FZxEpTMl9A
PBuM0OPnI9XIzE8e3e9p
=fNv7
-----END PGP SIGNATURE-----

--LG5jgFgJbJFFiAfj--
