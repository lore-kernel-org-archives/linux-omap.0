From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Adding DT support for TI HECC module
Date: Fri, 17 Feb 2017 09:46:52 +0100
Message-ID: <7c8fb14d-835b-d1d0-ca4f-4d184b711ae0@pengutronix.de>
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fklsjnRseX9vAwDw0GQx1gPe8gw2B0agh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487170125-10815-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fklsjnRseX9vAwDw0GQx1gPe8gw2B0agh
Content-Type: multipart/mixed; boundary="W3mjXSSrBAjEOArEamvAwai7GNQo2tKV7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 hs-ynQEQJNshbs@public.gmane.org, anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Message-ID: <7c8fb14d-835b-d1d0-ca4f-4d184b711ae0-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Adding DT support for TI HECC module
References: <1487170125-10815-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <1487170125-10815-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

--W3mjXSSrBAjEOArEamvAwai7GNQo2tKV7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 03:48 PM, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>=20
> This is an attempt to revive DT support for TI HECC that was started in=
 2015 [1].
>=20
> Changes v2 -> v3:
>   - rename compatible property to "ti,am3517-hecc" (though there is a s=
tipped
>     device named 3505, EMAC driver already uses am3517-emac name, so ke=
ep this
>     property consistent)
>   - use reg-names to specify different HECC I/O mapping (suggested by T=
ony Lindgren)
>   - provide fallback offsets and sizes for board files

Are there any board files using te_hecc intree? I don't see any on the
first glance. What about making the driver DT only?

>   - convert optional property ti,int_line to ti,use-hecc1int and add pr=
oper
>     description

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--W3mjXSSrBAjEOArEamvAwai7GNQo2tKV7--

--fklsjnRseX9vAwDw0GQx1gPe8gw2B0agh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlimuIAACgkQHv7KIOw4
HPbY9Qf/Q9z5k9dRvk3dOK7j8u2PjKMga2t3aR4EEYAMvpMP+ziGgFxiNEw9Q97X
a3IN/KItZ98ezhXaFwABKCbTaWD2oXXjg5lCaBgl1zmzxzQ71MWU6GJNlLGSJQ7q
lOdi0fbi7lyFO6y5WMjp4pl4cw6HliwJHfrLgSOFWpT8DSHDcXpRZTxSWI3T4Vyg
/aVgC4LjyO3BdMOjukgzArbmrnQFW7XHlx4EsMg1rABUfoQMMgJ5ZhA49IXI9TPs
9nMXRl8gr6H6YF8SbKe/JXLCE2mlHZL0ZodKYZX3wqmwvvOBv5FidgnJHvLSWK7k
GI7niIgZ92EQwJq9112sKoVRWRQ7nQ==
=z82X
-----END PGP SIGNATURE-----

--fklsjnRseX9vAwDw0GQx1gPe8gw2B0agh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
