From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 01/11] usb: musb: add musb->id to identify core
 instance
Date: Wed, 25 Jul 2012 15:11:29 +0300
Message-ID: <20120725121128.GO16794@arwen.pp.htv.fi>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-2-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lLR1BQqf7txDtYcF"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343218049-29917-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--lLR1BQqf7txDtYcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Wed, Jul 25, 2012 at 05:37:19PM +0530, Ajay Kumar Gupta wrote:
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 89d1871..f5eb8a7 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c

<snip>

> @@ -1889,6 +1921,7 @@ musb_init_controller(struct device *dev, int nIrq, =
void __iomem *ctrl)
>  	pm_runtime_enable(musb->controller);
> =20
>  	spin_lock_init(&musb->lock);
> +	musb->id =3D pdev->id;

I fail to see where this musb->id would be used. Care to clarify ?

--=20
balbi

--lLR1BQqf7txDtYcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD+JwAAoJEIaOsuA1yqREvusP/A4McnAxdTMPHHe9NKSsm9BJ
EI4o2TTQ62iEJ4WRTnuVQvuXz6YmCWly6n04+Q+yizh6ohW0BnJkYUM4KoDTD0gJ
LUw1iODyi2kTfNvha8ktvUeJvskPzvrW4PNyVQiI02v8HVLthuNpDejYCsji4KUd
DKfgT+7eIVtOfZjKzEiGcAO/nGr57A1DtVrZRWHhUyqtwjLx2585drr9irmEvlk3
tBCRJa8xcCOSlfHjg+WJg7vfb31g2HthS9fvny6yOom2Fg75MedTKALknAFe+qVW
66knu1ChZan7Q3XgCgca30a73jlbKed7GkQQCgGgqGcv4Jg+qt7gsi/hK5Swi5xi
IR4sxPKFk6nbJ6osdFCZ/00oab4e4uw82Lj7g9WbJbhk0MNnGVd7jpTOWdQCSge2
MAS30UsJ/F7NzPHPM3DqHD+MsiPVSlfgO+/tKBqTOzGQRlttA8wyzMfQqXnDxaC3
JpeW2Kpb5rexsjV5tkHixqLj8qqICyTWsT8j63Gk1GLqwtPFel4YPq7E1kjrBZxn
wK0B7GVihTS8F0eSMadNzJodgMC+kg3c8hiBiFfu3Xo770yM+1XJ20mw1AZATRv7
lu2i4pCL6gshbJpDwdblOa2Uqqh3UpwtN0z9CVqaftXYFj3iAgK3vU0ZDypSsjR/
RuM/tg1SMHjsAd4kUeTL
=Hnv6
-----END PGP SIGNATURE-----

--lLR1BQqf7txDtYcF--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
