From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
 implementations
Date: Thu, 11 Aug 2011 17:15:31 +0300
Message-ID: <20110811141528.GL28500@legolas.emea.dhcp.ti.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2011 at 09:08:01AM +0100, Russell King - ARM Linux wrote:
> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/gpio.h                 |   10 ++++++++++
>  arch/arm/mach-at91/include/mach/gpio.h      |    5 +----
>  arch/arm/mach-ep93xx/include/mach/gpio.h    |    7 +------
>  arch/arm/mach-exynos4/include/mach/gpio.h   |    5 +----
>  arch/arm/mach-gemini/include/mach/gpio.h    |    5 +----
>  arch/arm/mach-ks8695/include/mach/gpio.h    |   11 ++---------
>  arch/arm/mach-lpc32xx/include/mach/gpio.h   |   17 +----------------
>  arch/arm/mach-msm/include/mach/gpio.h       |    5 +----
>  arch/arm/mach-mxs/include/mach/gpio.h       |    6 +-----
>  arch/arm/mach-realview/include/mach/gpio.h  |    6 +-----
>  arch/arm/mach-s3c2410/include/mach/gpio.h   |    5 +----
>  arch/arm/mach-s3c64xx/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5p64x0/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pc100/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pv210/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-shmobile/include/mach/gpio.h  |   15 +--------------
>  arch/arm/mach-tegra/include/mach/gpio.h     |    6 +-----
>  arch/arm/mach-versatile/include/mach/gpio.h |    6 +-----
>  arch/arm/mach-vt8500/include/mach/gpio.h    |    6 +-----
>  arch/arm/mach-w90x900/include/mach/gpio.h   |    5 +----
>  arch/arm/plat-mxc/include/mach/gpio.h       |    5 +----
>  arch/arm/plat-nomadik/include/plat/gpio.h   |   11 +----------
>  arch/arm/plat-omap/include/plat/gpio.h      |   15 +--------------
>  arch/arm/plat-orion/include/plat/gpio.h     |    6 ++----
>  arch/arm/plat-spear/include/plat/gpio.h     |    6 +-----
>  25 files changed, 36 insertions(+), 151 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 166a7a3..15e8970 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -4,4 +4,14 @@
>  /* not all ARM platforms necessarily support this API ... */
>  #include <mach/gpio.h>
> =20
> +#ifdef __ARM_GPIOLIB_TRIVIAL
> +/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.=
h */
> +#include <asm-generic/gpio.h>
> +
> +/* The trivial gpiolib dispatchers */
> +#define gpio_get_value  __gpio_get_value
> +#define gpio_set_value  __gpio_set_value
> +#define gpio_cansleep   __gpio_cansleep
> +#endif

could that be a selectable symbol ? Something like:

CONFIG_HAS_ARM_TRIVIAL_GPIO

then on Kconfig you just:

select HAS_ARM_TIVIAL_GPIO or something ?

--=20
balbi

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQ+QAAAoJEAv8Txj19kN1pnsH/jjIZ/l51eOlKP75j5KHaq/S
GRTw4CVEa/c1kTf7oCmfV7gVqGb/NBM2/kI/zeVD/GfZobV29mq452AXuoLeDipd
3g1suFowb0YSILWAdTXdzPoQbSvWDVdnsIcoJH4dJNcHE1w7MYLnp1brWV3G9g5/
sAR3kah4pkPw9PO/XU4q2MPrgOW30i+bLST4RzTpL2Luai5dtJs+H+Bf5ORGLXFt
g/yFIMLxXBDwtaQdxPFoeiheg+fX6d6YH32vjiKYOhnrq4vm7MeJpU0dDz+GinNJ
gFlOU2imPOuA2tV1J+iVwNkc9G85yHSEe2pHl7CDqcwSRp9mB+HhNu3HqmIqJ9k=
=GTxs
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--
