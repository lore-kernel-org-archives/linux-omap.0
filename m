From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/7] phy: omap-usb2: Use generic clock names "wkupclk"
 and "refclk"
Date: Mon, 28 Apr 2014 11:03:47 -0500
Message-ID: <20140428160347.GG30292@saruman.home>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
 <1398693687-13967-4-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398693687-13967-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 28, 2014 at 05:01:23PM +0300, Roger Quadros wrote:
> As clocks might be named differently on multiple platforms, use a generic
> name in the driver and allow device tree node to specify the platform
> specific clock name.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/phy/phy-omap-usb2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> index a2205a8..fb5e515 100644
> --- a/drivers/phy/phy-omap-usb2.c
> +++ b/drivers/phy/phy-omap-usb2.c
> @@ -275,16 +275,16 @@ static int omap_usb2_probe(struct platform_device *=
pdev)
>  	if (IS_ERR(phy_provider))
>  		return PTR_ERR(phy_provider);
> =20
> -	phy->wkupclk =3D devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
> +	phy->wkupclk =3D devm_clk_get(phy->dev, "wkupclk");

doesn't this patch cause a regression ? I mean, you're changing the
clock name before fixing DTS. Also, that DTS has been in a major version
of the kernel, so we need to maintain compatibility with it. How about:

	phy->wkupclk =3D devm_clk_get(phy->dev, "wkupclk");
	if (IS_ERR(phy->wkupclk)) {
		dev_err(&pdev->dev, "unable to get wkupclk, trying old name\n");
		phy->wkupclk =3D devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
		if (IS_ERR(phy->wkupclk)) {
			dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
			return PTR_ERR(phy->wkupclk);
		} else {
			dev_warn(&pdev->dev, "found usb_phy_cm_clk32k, please fix your DTS\n");
		}
	}

a bit ugly, but at least we don't cause any regressions. Likewise for
other clocks.

--=20
balbi

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXnvjAAoJEIaOsuA1yqREVVUP/jOXH9w40xHCHrKEBH7jF5+h
w/BiiiqX1YSrUHe2H5PtbVTJCOSBfHkct/t7TJTOZerIN7zIdwnw5lI5T30/WHS8
0l6mv/JPJZGzPmLHCrZm4gd5C8nGeePvP+KB+1+1RuCRM6gBoUhLPTDLo+7twzDI
1owzKtYO1vZ8MEGgZVpxVtAnGJkc07BgJR/WqnnRIIxsr9XvjSRqdZmQRxBII6//
SKYPpHxspepfepYAUCmHS2c8kAVzL0TP+TXbbUFeeP/NFFKFTYVR89MM55E820Q3
MzZA+ITOasFvE4DJmdns6mF2CZfUbeihbS2Bqq3m9XqC6uYyNK0bYvQIDtVf/SJA
XPz2n/F+wB7DT6sK0PrI1ZCNDbO1Zc+D5fCkpvye8gs2BqJkxNedZqcZV+t3b6OB
REwKNDh7ljnu99Hp2b0HDLD+OjoHqlIvfQfhdbgT8+rXwuOcDTsLrJP4TlyIU+GQ
3mNdEa7nIlu5nfHMT8AkRgYMmzMJXjeKuXbcSp+aiImh2PUGChwQeRUipbQUEg4l
H2XG6/G4zYB1zIIhkQiCLjQ965k4m6ywjY2JMsm5BrjX1HRDxNAoE7jP/Q7anyih
RFFFQV9ici7D1VYei4sWcPMDOIgp+Mqbq3xDYy4u76vJwRvkBCMr1eDZEqyFCbOM
Om8laT6bPqg69i0vZcPr
=radd
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
