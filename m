From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/7] phy: omap-usb2: Use generic clock names "wkupclk"
 and "refclk"
Date: Mon, 5 May 2014 13:14:09 -0500
Message-ID: <20140505181409.GI17875@saruman.home>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com>
 <1399283686-6127-2-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399283686-6127-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2014 at 12:54:40PM +0300, Roger Quadros wrote:
> As clocks might be named differently on multiple platforms, use a generic
> name in the driver and allow device tree node to specify the platform
> specific clock name.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/phy/phy-omap-usb2.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> index a2205a8..7007c11 100644
> --- a/drivers/phy/phy-omap-usb2.c
> +++ b/drivers/phy/phy-omap-usb2.c
> @@ -275,18 +275,34 @@ static int omap_usb2_probe(struct platform_device *=
pdev)
>  	if (IS_ERR(phy_provider))
>  		return PTR_ERR(phy_provider);
> =20
> -	phy->wkupclk =3D devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
> +	phy->wkupclk =3D devm_clk_get(phy->dev, "wkupclk");
>  	if (IS_ERR(phy->wkupclk)) {
> -		dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
> -		return PTR_ERR(phy->wkupclk);
> +		dev_warn(&pdev->dev, "unable to get wkupclk, trying old name\n");
> +		phy->wkupclk =3D devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
> +		if (IS_ERR(phy->wkupclk)) {
> +			dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
> +			return PTR_ERR(phy->wkupclk);
> +		} else {
> +			dev_warn(&pdev->dev,
> +				 "found usb_phy_cm_clk32k, please fix DTS\n");
> +		}
>  	}
>  	clk_prepare(phy->wkupclk);
> =20
> -	phy->optclk =3D devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
> -	if (IS_ERR(phy->optclk))
> -		dev_vdbg(&pdev->dev, "unable to get refclk960m\n");
> -	else
> +	phy->optclk =3D devm_clk_get(phy->dev, "refclk");
> +	if (IS_ERR(phy->optclk)) {
> +		dev_dbg(&pdev->dev, "unable to get refclk, trying old name\n");
> +		phy->optclk =3D devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
> +		if (IS_ERR(phy->optclk)) {
> +			dev_dbg(&pdev->dev,
> +				"unable to get usb_otg_ss_refclk960m\n");
> +		} else {
> +			dev_warn(&pdev->dev,
> +				 "found usb_otg_ss_refclk960m, please fix DTS\n");
> +		}
> +	} else {
>  		clk_prepare(phy->optclk);
> +	}
> =20
>  	usb_add_phy_dev(&phy->phy);
> =20
> --=20
> 1.8.3.2
>=20

--=20
balbi

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTZ9TxAAoJEIaOsuA1yqREeg0P+wUhOT+fTXN+OzXkgV6Ky6N8
rn8Y9FL4FRixJKurWZkL99ujQmxmONgtvS0sQc5Nvm99hAwEDefKVFVoi/p5Nn+w
0WzHHQBDRxIPcNFIvGO0Z4/h3tE9tBBoaOkRXPKPL0NlQ8FVvEDC3dJ4GNx9FVx4
Y0x9Mtn0UYOYh43j4xnrasbYFAZy7fJJUMWBlgD7t+LV+0zCRnZUDbxqQW/IVGlP
Qo95DLWOkYwyid1sH7I5KziUcOHuK2Y660HICMX6GEVZHuAEDEdJ/8AVykywt/8u
9/2Muq7qq9b7AjwwAfYxz0E2hSG76rI+zkjU7KfmIyLbrfkHxGmHA/SvnhgjGGCh
uD3GT+Lx4eqM7vlwOD5P1FhT+4nr4cU0OdjIxMg/K9M82rG0KyLwhdIRXCdj2rVQ
GqPAWW+Efc9kcgWwD19oxGO8Ou9c0X5MvjQ6ze4wgewVrb98Lq2LVxPzmO5kNv6+
fc1l7xArE8lqd/TOukfpE9PRCiLMGjNHJRgYlWCiIYO4knVoo3k416HimvyU7QJ1
e3e4nGGmQof32TSIlzhJlKWqJswO9OUsNqOUMuvmw0YoCr2nB9zMW291Zkw17ZH4
M9Pec8LWvWdqNsqqVGgArpqviHF1UZMpYoUzITafhtqfqiyUTm2wIoNTYJP38td9
H7EXZy4M+UOLZAAt++r1
=ccct
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
