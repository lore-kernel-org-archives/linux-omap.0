From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Wed, 06 Apr 2016 09:09:08 +0300
Message-ID: <87zit72rqz.fsf@intel.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com> <1459865117-7032-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 2ca2cef..6b1930d 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2706,6 +2706,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	int retval;
>  	struct usb_device *rhdev;
>=20=20
> +	hcd->flags =3D 0;

seems like this would make more sense in usb_del_hcd() instead.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBKgFAAoJEIaOsuA1yqRE2QYP/1tkydBAY8xD7TaTcY7o8MsX
MSpvLnHl8AnDWqR5l53do25XGzoAXBXlwT0eKumOSEJXR7915f3AWDN7M892nt30
BxFY0iycNMe3ZUn5u7avYJcMInh1LEjVzHlFcnV/DDIJRxEZcPa6cxTqWJoM/s8y
UUVWi5c6V6AfnMlEueAMtWi52EOK5arsvpTwC9QE7lifU6IHfXC2iI+1pTKL0kgG
KZcuKhk9AUKs8MRGL8EMAblp4oXUd6uiHor4rA9UrNYQSOfWzuP29M6Ma2kU1/1Y
A5hV7XNzwkcQ1BL5jepwmadapzU9Oki739b7OFcSMJ7UgA2Xma7bw4wut1qRSlY5
JOHUKca2WoBrnY1MMecmTngW99bhgYLN9uzcKz7QJn4KMsw1R01P41lUo+MCCB3k
iWcXfk5ELr4Xt7HAO+a0Ripk4rlD+O/R/FzmIFPaw80+iMsqq9/IS/7Li8fwXbWA
SmehiCY20DyV6s1dOtmZr/GrZvDPmlIlMYuA3vS9jYkX9CZ0Kncu72/bw4/nK61z
TwVqivVd+WdDDWaZqKwKj6NbRzVvK2/HppKGsINiEKMGkeoz/O50imNnaMrZ1fg8
IZbe5ncTvZ8d7TGzLsKk8GNIwoXG0E1LZX3+QxHmxt7saczteFT09+4uQQHO7wat
YB1PK37/bhKTrzNu3Cut
=bcRo
-----END PGP SIGNATURE-----
--=-=-=--
