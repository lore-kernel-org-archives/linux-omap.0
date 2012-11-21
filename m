From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 15/16] ARM: OMAP4: omap4panda: Don't enable USB PHY clock
 from board
Date: Wed, 21 Nov 2012 15:59:21 +0200
Message-ID: <20121121135921.GP10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-16-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CfiwpigK2vfmwpN3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60912 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496Ab2KUOFw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 09:05:52 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-16-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--CfiwpigK2vfmwpN3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:13PM +0200, Roger Quadros wrote:
> Instead of enabling the USB PHY clock in the board file we
> provide the PHY clock details to the driver via board platform
> data so that driver code can manage the clock.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

this patch is ok-ish. But clock should be managed by PHY driver instead.

> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   14 +++-----------
>  1 files changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2=
/board-omap4panda.c
> index bfcd397..b942abe 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -151,7 +151,9 @@ static const struct usbhs_omap_board_data usbhs_bdata=
 __initconst =3D {
>  	.phy_reset  =3D false,
>  	.reset_gpio_port[0]  =3D -EINVAL,
>  	.reset_gpio_port[1]  =3D -EINVAL,
> -	.reset_gpio_port[2]  =3D -EINVAL
> +	.reset_gpio_port[2]  =3D -EINVAL,
> +	.clk[0] =3D "auxclk3_ck", /* FREF_CLK3 provides 19.2 MHz clock to PHY */
> +	.clkrate[0] =3D 19200000,
>  };
> =20
>  static struct gpio panda_ehci_gpios[] __initdata =3D {
> @@ -162,16 +164,6 @@ static struct gpio panda_ehci_gpios[] __initdata =3D=
 {
>  static void __init omap4_ehci_init(void)
>  {
>  	int ret;
> -	struct clk *phy_ref_clk;
> -
> -	/* FREF_CLK3 provides the 19.2 MHz reference clock to the PHY */
> -	phy_ref_clk =3D clk_get(NULL, "auxclk3_ck");
> -	if (IS_ERR(phy_ref_clk)) {
> -		pr_err("Cannot request auxclk3\n");
> -		return;
> -	}
> -	clk_set_rate(phy_ref_clk, 19200000);
> -	clk_prepare_enable(phy_ref_clk);
> =20
>  	/* disable the power to the usb hub prior to init and reset phy+hub */
>  	ret =3D gpio_request_array(panda_ehci_gpios,
> --=20
> 1.7.4.1
>=20

--=20
balbi

--CfiwpigK2vfmwpN3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrN45AAoJEIaOsuA1yqREsCcP/1fAKOaVV+XhNw8WrF8uJFuI
Rm/a1Q60IYFO7hMMdSpI3W1Ox/+BLFtQ8ak1a1hoiCNEzQPfKD8JGVmRLJzE7ewC
aLCl7KPChUwbHr+5XxwZgeKcNcFnQH9nEdQ4jxtrVk0L/o8nGC3Ani+bSbh5SKVe
IIZ0kUC6vWWPq8j7OiHT6SWdZnKNes2g9hi4pwHqNYNANvWODHUsvVQwVe9Lz0jq
FdNzNtaC3mEjtPStyFRRCdQTTpWald6VgGxwgrA24E2q6I4bECogsdE6gpkVbLPL
2hZQ2cXkfjvodgaHp1dQKTmnOI4U8LvxqOuD/Ziatyp4ZW1zKuFUsRNvpznMhQI3
KCk7F3krzbIrxVqWGjeFpcHSXmr2lx8rOVwpQzRstC8xZydlG9kSr6fbtmoTVxyu
vBDJimP1Oh8omUrSEoscxSEHTWWcI3baq0puspDlkfDoKLuKzkUo04GXXH8fXJb0
CX+SF8IQikdj+guKsZ0dgEjWGqoT60UF9bzYmulbvs5WdsUdoPW6HsmhNJWT02rF
cKUJ39sfjLLZxXz6sHYjeN23JGTMAbSjt4m9kygUtDoyNt47elJbrdCGdPFbTRUJ
d2ojic5t5ODMMcHHh7EEBuvtRLY6QfBkt0F8VDYTKWEZp1zjoNlf0qQjjoMPpYOW
PsjbptQ8LCizIN0D/RJj
=s66G
-----END PGP SIGNATURE-----

--CfiwpigK2vfmwpN3--
