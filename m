From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk
 function
Date: Mon, 2 Jul 2012 11:13:59 +0300
Message-ID: <20120702081358.GF16670@arwen.pp.htv.fi>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:37389 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753161Ab2GBIQc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 04:16:32 -0400
Received: by lbbgj3 with SMTP id gj3so6361145lbb.25
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 01:16:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 12, 2012 at 08:36:21PM +0300, Ruslan Bilovol wrote:
> If the clocks are enabled and we want to enable them again
> omap4430_phy_set_clk disables them.
>=20
> Fix this - so now if we try to enable already enabled clocks
> it works correctly.
>=20
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap=
2/omap_phy_internal.c
> index 4c90477..0196683 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int on)
>  		clk_enable(clk48m);
>  		clk_enable(clk32k);
>  		state =3D 1;
> -	} else if (state) {
> +	} else if (!on && state) {

why don't you let clocks be enabled twice then ? That would cut down the
churn.

--=20
balbi

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8VhGAAoJEIaOsuA1yqREM9gP/j7hvmBt9WUrYk8UM4+rFzRa
xWpfvpDnFnKq51XIvVdG1KLNmdmQNAWZYrhCejIeAk96WKvjzBugGNCzv0Du3qwy
7k4SsRSIl6p/q8JFD050kE4jjeKH2xot3eJwsD+kcE1+bNPq1DQ+ccJYk3R7fEX/
tC27NAcWBN9GRrqclDztBfZR0BgIHEveaieQnqf2Y3ySU0bsZ/5w+lGJco+Q3mjo
HRoxHMYzy+2UuvO5DuaSNF8LVB8IZS7BdWWFlsM1wepCW6QBPrSNIc4ONiHxZvCI
wezDzgouUfY54NqmXO07Nqzr8IST9WAJR7VHyOn021jMmaKzolDZ1l5WhSMT5FeL
Z75H2G45kwA28fnZgV9gg0X+A+3MDsKjT7ZMaLteNfcvQBtybu7uyE12AkgmMS5U
XeSrTTAxB/I3CAN7pRRL51e+4CCTv/16rt3sK3sMcDaIIuZ/zVQKGSVzzL+c5r99
akwvl+zMsUPWA0ZE0FRROLf7Ibpaayfh9MoFnHfZ9wbClKd5eP1clfX/35xehdi3
9lls7lSIAWUmvNPjIp0bx8Xs/Im5lLTAbSl+7YNf8mwsT/e9fR8Axy7Or35GqMna
GGNY8MdWosS/pPDyNTJyCadYboCZ5ncFkE9gNOgPiZUkOdpN6eluVwN4HvYbY3N7
HrgJFCZp5rnBJ+k30C8R
=dHxr
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
