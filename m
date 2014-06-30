From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] phy: omap-usb2: Manage PHY 3.3V supply regulator
Date: Mon, 30 Jun 2014 12:09:39 -0500
Message-ID: <20140630170939.GE31442@saruman.home>
References: <1404126038-19974-1-git-send-email-rogerq@ti.com>
 <1404126038-19974-2-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404126038-19974-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: kishon-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 30, 2014 at 02:00:36PM +0300, Roger Quadros wrote:
> On some SoCs e.g. J6 the 3.3V supply to the USB2 PHY can be
> powered down when the PHY is not in use. Add regulator
> management code to control this power line.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/phy/phy-omap-usb2.c  | 25 +++++++++++++++++++++++++
>  include/linux/phy/omap_usb.h |  1 +
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> index 7007c11..2afc79c 100644
> --- a/drivers/phy/phy-omap-usb2.c
> +++ b/drivers/phy/phy-omap-usb2.c
> @@ -30,6 +30,7 @@
>  #include <linux/phy/omap_control_phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
> =20
>  #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
>  #define USB2PHY_ANA_CONFIG1 0x4c
> @@ -107,6 +108,14 @@ static int omap_usb_power_off(struct phy *x)
> =20
>  	omap_control_phy_power(phy->control_dev, 0);
> =20
> +	if (phy->pwr) {
> +		int ret;
> +
> +		ret =3D regulator_disable(phy->pwr);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -114,6 +123,14 @@ static int omap_usb_power_on(struct phy *x)
>  {
>  	struct omap_usb *phy =3D phy_get_drvdata(x);
> =20
> +	if (phy->pwr) {
> +		int ret;
> +
> +		ret =3D regulator_enable(phy->pwr);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	omap_control_phy_power(phy->control_dev, 1);
> =20
>  	return 0;
> @@ -253,6 +270,14 @@ static int omap_usb2_probe(struct platform_device *p=
dev)
>  	phy->control_dev =3D &control_pdev->dev;
>  	omap_control_phy_power(phy->control_dev, 0);
> =20
> +	/* phy-supply */
> +	phy->pwr =3D devm_regulator_get_optional(phy->dev, "phy");
> +	if (IS_ERR(phy->pwr)) {
> +		if (PTR_ERR(phy->pwr) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		phy->pwr =3D NULL;
> +	}
> +
>  	otg->set_host		=3D omap_usb_set_host;
>  	otg->set_peripheral	=3D omap_usb_set_peripheral;
>  	if (phy_data->flags & OMAP_USB2_HAS_SET_VBUS)
> diff --git a/include/linux/phy/omap_usb.h b/include/linux/phy/omap_usb.h
> index dc2c541..e2c46df 100644
> --- a/include/linux/phy/omap_usb.h
> +++ b/include/linux/phy/omap_usb.h
> @@ -40,6 +40,7 @@ struct omap_usb {
>  	struct clk		*wkupclk;
>  	struct clk		*optclk;
>  	u8			flags;
> +	struct regulator	*pwr;
>  };
> =20
>  struct usb_phy_data {
> --=20
> 1.8.3.2
>=20

--=20
balbi

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTsZnTAAoJEIaOsuA1yqREfxAQAJn7C/Sy3RHFp37Kz3rFbu66
iWu486I3DkYSbhks7ZdbT16J8kA1stgakYCyq+5cFKT083tVcF6gDW4pW9/VYRuL
Toez0HzRcwNTwRTIL1VEN5PPcXAnWpedJatBGPiJLTu/W4farvWt4DdUql0VcoIi
2rHdeVr3dkw5yiqSpMcivsdX7LxBssVeDdBy2d4zR4G5C9/0aZrXfsPCi2HBiiK3
c96196j6FheJpojGLeUUjCnQu/o+YbsIyNRa3IlawGSDqwOekPKRnBx6iO5+EEKM
JD+qrmMQ/6K74MHw/81JMmiL7naL4/QAeEbTkgQcgSBibFlQgUDVcAXqk0dGDXfJ
SUrSKehboWnv8+4abJ5d//aA3+SUjIWGR4VNcZNXpswDCm9IpnUqEyuqMevNe9rb
bRvcz4fLbS1uNkwJPUVqxsIiwIMsoebfEZNZiinorMSqFtWEcOki6oZUAz2uVsau
uLzJeQ+m7tiYAQhH6vU1b8DkwQ1EKDrbru8Ljz1Nwxu8McYN9IOfg8x120gNGbC5
0PtVazp8MBYH6ojFK1fy6nZqb02ENKOnElTgnHFForDklUTSD33vNeKwRPCF8i8x
vYTfZgMEZB6S8G33lXhb4Ibx1EMFjPDqnOLWECX/a5N0Ylpscz6f+o1h7mXAMpw6
DiSD1FhyuIVaCDcgnQk8
=tMgZ
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
