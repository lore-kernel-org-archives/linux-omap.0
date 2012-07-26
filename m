From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Thu, 26 Jul 2012 10:36:22 +0300
Message-ID: <20120726073621.GG29029@arwen.pp.htv.fi>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-5-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343218049-29917-5-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 25, 2012 at 05:37:22PM +0530, Ajay Kumar Gupta wrote:
> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> index 01203eb..eb6220f 100644
> --- a/drivers/usb/musb/am35x.c
> +++ b/drivers/usb/musb/am35x.c
> @@ -364,7 +364,7 @@ static int am35x_musb_init(struct musb *musb)
>  	if (!rev)
>  		return -ENODEV;
> =20
> -	usb_nop_xceiv_register();
> +	usb_nop_xceiv_register(musb->id);
>  	musb->xceiv =3D usb_get_phy(USB_PHY_TYPE_USB2);
>  	if (IS_ERR_OR_NULL(musb->xceiv))
>  		return -ENODEV;
> @@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
>  		data->set_phy_power(0);
> =20
>  	usb_put_phy(musb->xceiv);
> -	usb_nop_xceiv_unregister();
> +	usb_nop_xceiv_unregister(musb->xceiv);

Dude, this is so wrong... You don't know if there are other users of the
nop xceiv in the system. If there are other users which already have
claimed id 0, you will try to create duplicated directories under sysfs.
MUSB's ID has nothing to do with NOP's ID.

--=20
balbi

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEPN1AAoJEIaOsuA1yqREUgcQAKp7esp5/YgHXtOgiwUIQxx9
ymaIG797I33lR01ycUGfbZy2ZVu+v6J0NjM0o0j6s8Wdy1v4r6OTgbu955+2Uj8C
sAOLFlxkBXIvbPMC7iJ1CThcUNm95pfMqO35rcYUUfgBNfI6hCK8t1bVETgiMhMx
N1bPbW9JgVbtlFlxIOEeZVcazH8RkGaplsihPNbX1s4WUqdGpsG/HfUN4xOxIilG
0BKFgqCQVStEOoGdDcSZl50C07ywF5NqMyWjIVFn2HIGU/lovk4WiYpi0YBcEsC/
cG38hyowRe8LOYHk8easKBjrjeJ5c2xkrxNvcK05O6Ss8Kyr6DABFLyY/ccKMVwc
J3Amw7lf1aYz3qKWJIu308IOYiRLiQ/YFErJdaywcsxf9Br79afTfz/4A3oejGvv
dyuHWjYGj1MHan71hpTRnRrSq8Uul9z2aKTgyTixOdUbv20n9COWAf2lInF4WruK
ZGSbt5hAG4ZWHvKkOCdNQhgD0kqmUlm/Nu2EhZxF360omo8VPoHW80nP0T7rsBfc
w9RW6EUu8GDFx8OalcsYvywAZPGXMzLR75Dj0Wik7Iln+B52SgaweQ8zp38sLz9a
WrZA3cwopiL6KjiC252ET4ZLfx7UYqiRNNb0UprXEz54pdoNldaHSFcBE5gIOz6I
KadWtxJElVM6cyo2uYbX
=AJao
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
