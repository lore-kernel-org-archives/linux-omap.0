From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/7] phy: omap-usb2: use omap_usb_power_off to power off
 the PHY during probe
Date: Tue, 4 Aug 2015 11:07:21 -0500
Message-ID: <20150804160721.GI23659@saruman.tx.rr.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com>
 <1438701646-7876-6-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438701646-7876-6-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 08:50:44PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Previously omap_control_phy_power() was used to pow=
er

same comment as before.

> off the PHY during probe. But once phy-omap-usb2 driver is adapted to
> use syscon, omap_control_phy_power() cannot be used. Hence used
> omap_usb_power_off to power off the PHY.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/phy/phy-omap-usb2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> index c1a4686..b5c266a 100644
> --- a/drivers/phy/phy-omap-usb2.c
> +++ b/drivers/phy/phy-omap-usb2.c
> @@ -241,7 +241,6 @@ static int omap_usb2_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	phy->control_dev =3D &control_pdev->dev;
> -	omap_control_phy_power(phy->control_dev, 0);
> =20
>  	otg->set_host		=3D omap_usb_set_host;
>  	otg->set_peripheral	=3D omap_usb_set_peripheral;
> @@ -261,6 +260,7 @@ static int omap_usb2_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	phy_set_drvdata(generic_phy, phy);
> +	omap_usb_power_off(generic_phy);
> =20
>  	phy_provider =3D devm_of_phy_provider_register(phy->dev,
>  			of_phy_simple_xlate);
> --=20
> 1.7.9.5
>=20

--=20
balbi

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwOM5AAoJEIaOsuA1yqREUvMP/0P4SFD9Vy70w/xu0jxcgSf/
jX7Cdk/yK29A/lrFvzIJhjX65Z6RazB69YNQVQvAhdIHq2ij3j17Hdp9Vx0Df096
o7sh2rip9SWiLwBqP+5bQPg/TnLnKRoZ8iU6dLfmHwrkM7IJ45WK60YOdU8velSX
cQdGq/F7/F9ZPX9LMqtS9coqG4Z7Jr9hgQxuvuQGnSZEwoT9bWr8qJwwn7spTqbz
T43eRm2PiGidjqub4wOgXGjHCuiOpNd+r6rVqZLSV6XWTc245x/wPPwVxbQgGeNC
4oVNiEuD6h2PNqtpg+SvOqUhTtMnPF3J0eIeiPge4jWuBGOnrV0dpiviCOUrA03B
4xN8bYhS0++WHor6OND6a4PabVBBHwt758liWKLVZRuwTD7+SA6PNH9E14iWM5AI
bmZFIjqJ4jxBNgbTpdaYenjTub9vrbpyDDTryeuzA3vDPpoiV8HRVmwV0WyFdzq5
Au9L+ROnpVhlQpHB523OShzGu/mj4Eg9a6i5Zlz9ZGvr83sS8kt/s5MVrI2U6M4l
EDgYFztNtiTXNUmdmXH6bE8cHQFnXuRpI4kscramPCxYH4ZZK1zlmIybAP1ykcbb
TDbRfjsMkBKLh850PDqcYBdcWntBcGNMQGDrsRWymYuXvU0KuXPEmFsplP0V+Bhw
bX+7xRfpKPLlGShcvadV
=+/kn
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
