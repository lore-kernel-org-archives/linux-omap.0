From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] ARM: OMAP: Move plat/omap-serial.h to
 include/linux/platform_data/serial-omap.h
Date: Wed, 21 Nov 2012 19:38:10 +0200
Message-ID: <20121121173740.GA13262@arwen.pp.htv.fi>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121121174230.25576.64507.stgit@muffinssi.local>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121121174230.25576.64507.stgit@muffinssi.local>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2012 at 09:42:30AM -0800, Tony Lindgren wrote:
> We need to move this file to allow ARM multiplatform configurations
> to build for omap2+. This can now be done as this file now only
> contains platform_data.
>=20
> cc: Russell King <linux@arm.linux.org.uk>
> cc: Alan Cox <alan@linux.intel.com>
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: Govindraj.R <govindraj.raja@ti.com>
> cc: Kevin Hilman <khilman@ti.com>
> cc: Felipe Balbi <balbi@ti.com>
> cc: linux-serial@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

nice, thanks :-)

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/serial.c                  |    4 +---
>  drivers/tty/serial/omap-serial.c              |    3 +--
>  include/linux/platform_data/serial-omap.h     |    0=20
>  3 files changed, 2 insertions(+), 5 deletions(-)
>  rename arch/arm/plat-omap/include/plat/omap-serial.h =3D> include/linux/=
platform_data/serial-omap.h (100%)
>=20
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index aa30a3c..25c799b 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -26,9 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/console.h>
> -
> -#include <plat/omap-serial.h>
> -#include <plat-omap/dma-omap.h>
> +#include <linux/platform_data/serial-omap.h>
> =20
>  #include "common.h"
>  #include "omap_hwmod.h"
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-s=
erial.c
> index 17babde..0240aa8 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -41,8 +41,7 @@
>  #include <linux/of.h>
>  #include <linux/gpio.h>
>  #include <linux/pinctrl/consumer.h>
> -
> -#include <plat/omap-serial.h>
> +#include <linux/platform_data/serial-omap.h>
> =20
>  #define OMAP_MAX_HSUART_PORTS	6
> =20
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/include/linu=
x/platform_data/serial-omap.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/omap-serial.h
> rename to include/linux/platform_data/serial-omap.h
>=20

--=20
balbi

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrRGCAAoJEIaOsuA1yqREqisQAIRwtfAfVJ2aSfpJC3xQd9fi
c5eazEag1kELfiVj1wXRnqXSHZrSh60J20hyl0BYZZvRZHdOV1V7KVhXB2UNDLXt
LJ3sQv3T0qNLZ47e0d5OePonXGA9wXKb8NG+wqPxZ5ZT/wVlEncyd1dN+EHjWjOr
VeERhMQ/gWyboj7gG5fjN+g7UsTj9cVB+sPY1jDNOAGNLflaWo2pfdnEganA6ahU
RS4aSFIRs33jifr0cBlSS9DkeGCgMI6BcnNCLrWhI8FMjlN4LdHvqbIgIOgNXCvS
tKI5hbG/EYaITssRen5nTZJHp2+Eufar4hWDi+XE/q1JjvNesTZCoSKlnoPYlyPT
mFoTfsv4uqocvLPGlOshpDqz8j3ACxaHauxyGc1zO2ML9aLsLQIZu8UNfYfMHRt5
fqnxV4Yd2PZAZ5hSnzAmBbe56nxtb1InDxDoJfxhn5FWmWtqb2y0rKJF5QtZ4koV
2VDj7FIYrHbn2ELn0Fr+o3B4kI2J9CeY0V/SSr4Ihomt6uCCxdI5B/XG+uF1hIuT
zPzTCEQwBck+8S6GgRJJ+/YpwReCLURMgEE196ej+EGef19EX2QD4cSjNc+GL5pl
tIWlRbeBHZVtpS+NAecUuPGH1Gv1jRTiDBTmk6OKlie7w5kb8GadjcBlAdUMknqj
QqMtgYXc2hrWXtmsxMZr
=almK
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
