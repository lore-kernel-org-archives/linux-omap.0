From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] usb: host: ohci-omap3: Print warning to get people
 to use ohci-platform
Date: Thu, 18 May 2017 11:15:02 +0200
Message-ID: <20170518091502.f3q6opnoey7aw2aw@earth>
References: <20170517225922.17723-1-tony@atomide.com>
 <20170517225922.17723-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dqud2kyt4u7gvkbu"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170517225922.17723-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--dqud2kyt4u7gvkbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 17, 2017 at 03:59:21PM -0700, Tony Lindgren wrote:
> We can't just remove ohci-omap3 as that could make some people's
> systems unusable for keyboard and mouse. Let's print a warning for
> now, and then remove the driver in a year or so.
>=20
> Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

I guess you could drop the driver and modify the Kconfig entry,
so that it selects USB_OHCI_HCD_PLATFORM? I just checked and
there are already a few examples of this in the USB host Kconfig :)

-- Sebastian

> ---
>  drivers/usb/host/ohci-omap3.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
> --- a/drivers/usb/host/ohci-omap3.c
> +++ b/drivers/usb/host/ohci-omap3.c
> @@ -130,6 +130,9 @@ static int ohci_hcd_omap3_probe(struct platform_devic=
e *pdev)
>  		dev_dbg(dev, "failed to add hcd with err %d\n", ret);
>  		goto err_add_hcd;
>  	}
> +
> +	WARN(1, "ohci-omap3 is deprecated, please use ohci-platform instead\n");
> +
>  	device_wakeup_enable(hcd->self.controller);
> =20
>  	return 0;
> --=20
> 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--dqud2kyt4u7gvkbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkdZhQACgkQ2O7X88g7
+pqvXQ/9F0zIkaZbPzO5cQpjJyKXHbbkkwDF3NrcevEVCjVeYEtPwl6qMHuPDk5M
6jECpLjp7qA6n0TkPhxeT55soqVA+rAuM8ZjT18su54Hpi6N39HawO5G+V2Darg5
S6LaxN6bIEsN8vlPxTTPwK419NjkWKB9X9f9QPQYkAjSnmHCVH/00UWkwNK9C5Uh
28DJz5TbkYIjDGJcq4wQFbIltDEthHa29tRuXabqSkSTXvPTBTPhhdzv6fgy7hw8
iwG6hQqmVjCOwy9299lPiYsRvxPq9myewhwxwDx5NUScjfG1vw6Ds24Cfw+K6IVK
5ADTXoe49ZBYlc2DbkvGCyyEEbFKq0JRkjYNCjzmNHAP4585oa8dG4/C6qIkd3+q
f7xXYVWtEIAKYLejq1h1DeODroasnSVBVQBW7v2BfP23ZRPmoXlAGvU69Vb8G5A9
hymy1x+/AbTT8Byh5WKom6tuOitS+9CqLHqteUgRnafwFTz6oqCHphHXQZslDTgn
NS1vGXepVlx3vler2jYcCzot9kFqU78mbsdxLVQwEnyMQmB1GexYjgJhO66+Ku/K
FJxdCiBl8KZ5bMBmwkGhYlkJt/U9Tgzu07p78qVneccX/st0mwvOdfA9pP74QxHa
FogKeTrmqsJsVjEoNmywmLxfn5SAGcvNwP52MZ5xLuW1tGJp7qA=
=wd4O
-----END PGP SIGNATURE-----

--dqud2kyt4u7gvkbu--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
