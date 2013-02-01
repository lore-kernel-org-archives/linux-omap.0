From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 2/6] usb: otg: utils: add facilities in phy lib to
 support multiple PHYs of same type
Date: Fri, 01 Feb 2013 22:54:49 +0100
Message-ID: <510C39A9.70202@pengutronix.de>
References: <1359081206-5602-1-git-send-email-kishon@ti.com> <1359081206-5602-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2SLKDIUCRXOLHVIHGQKBU"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359081206-5602-3-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2SLKDIUCRXOLHVIHGQKBU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/25/2013 03:33 AM, Kishon Vijay Abraham I wrote:
> In order to add support for multipe PHY's of the same type, new API's
> for adding PHY and getting PHY has been added. Now the binding
> information for the PHY and controller should be done in platform file
> using usb_bind_phy API. And for getting a PHY, the device pointer of th=
e
> USB controller and an index should be passed. Based on the binding
> information that is added in the platform file, usb_get_phy_dev will re=
turn the
> appropriate PHY.
> Already existing API's to add and get phy by type is not removed. These=

> API's are deprecated and will be removed once all the platforms start t=
o
> use the new API.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/otg/otg.c   |  118 +++++++++++++++++++++++++++++++++++++++=
+++++++-
>  include/linux/usb/phy.h |   13 ++++++
>  2 files changed, 130 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
> index 8e756d9..4bb4333 100644
> --- a/drivers/usb/otg/otg.c
> +++ b/drivers/usb/otg/otg.c
> @@ -36,6 +36,24 @@ static struct usb_phy *__usb_find_phy(struct list_he=
ad *list,
>  	return ERR_PTR(-ENODEV);
>  }
> =20
> +static struct usb_phy *__usb_find_phy_dev(struct device *dev,
> +	struct list_head *list, u8 index)
> +{
> +	struct usb_phy_bind *phy_bind =3D NULL;
> +
> +	list_for_each_entry(phy_bind, list, list) {
> +		if (!(strcmp(phy_bind->dev_name, dev_name(dev))) &&
> +				phy_bind->index =3D=3D index) {
> +			if (phy_bind->phy)
> +				return phy_bind->phy;
> +			else
> +				return ERR_PTR(-EPROBE_DEFER);
> +		}
> +	}
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +
>  static void devm_usb_phy_release(struct device *dev, void *res)
>  {
>  	struct usb_phy *phy =3D *(struct usb_phy **)res;
> @@ -112,6 +130,69 @@ err0:
>  EXPORT_SYMBOL(usb_get_phy);
> =20
>  /**
> + * usb_get_phy_dev - find the USB PHY
> + * @dev - device that requests this phy
> + * @index - the index of the phy
> + *
> + * Returns the phy driver, after getting a refcount to it; or
> + * -ENODEV if there is no such phy.  The caller is responsible for
> + * calling usb_put_phy() to release that count.
> + *
> + * For use by USB host and peripheral drivers.
> + */
> +struct usb_phy *usb_get_phy_dev(struct device *dev, u8 index)
> +{
> +	struct usb_phy	*phy =3D NULL;
> +	unsigned long	flags;
> +
> +	spin_lock_irqsave(&phy_lock, flags);
> +
> +	phy =3D __usb_find_phy_dev(dev, &phy_bind_list, index);
> +	if (IS_ERR(phy)) {

You should probably lock the phy module in memory. See my patch "usb:
otg: use try_module_get in all usb_get_phy functions and add missing
module_put".

Marc



--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2SLKDIUCRXOLHVIHGQKBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEMOakACgkQjTAFq1RaXHOKowCfcq9DjJoX+cyD3QMX4TMCqrY8
SjIAn3zdUZrd7noqE+1/t8twNL37IRLG
=pmYn
-----END PGP SIGNATURE-----

------enig2SLKDIUCRXOLHVIHGQKBU--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
