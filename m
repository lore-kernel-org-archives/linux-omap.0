From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Date: Sat, 18 Feb 2017 08:45:33 +0100
Message-ID: <20170218084533.27ad3e3b@aktux>
References: <cover.1482936802.git.hns@goldelico.com>
        <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
        <20170128193342.GB38136@dtor-ws>
        <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
        <20170217204041.GE13050@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3rG=c/8M1G6uC7ZLT1cLQw8"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170217204041.GE13050@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrey Gelman <andrey.gelman-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Michel Verlaan <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>Hans
List-Id: linux-omap@vger.kernel.org

--Sig_/3rG=c/8M1G6uC7ZLT1cLQw8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, 17 Feb 2017 12:40:41 -0800
Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

[...]=20
> > Let me cite myself:
> >=20
> > >> This makes it possible to pre-calibrate the touch so that is
> > >> (almost)
>=20
> Yes, it allows you to pre-calibrate, I get it. But you still do
> properly calibrate later, right? So you are doing double work here,
> once in kernel, and second time in userspace.
>=20
I as a daily user of that tsc2007 patch series say that I had never the
wish to calibrate it later in a better way. I am doing console work
with a virtual keyboard on it. So it is rarely double work here.

Regards,
Andreas

--Sig_/3rG=c/8M1G6uC7ZLT1cLQw8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYp/vNAAoJEInxNTv1CwY0lvcP/iQIdUpev8N0q7YbW5iaYmzn
Yq4v07bkJplCEMjl8yliy7+OOm+syPCf9zoP/hph80/CJw3z5u9iOyPOwnBtrmMa
wCz+hS30lXnC0qDk3gar5SXrNGavWlkOFRuQEW3y+yLWt4C+n6r3X2SoZhUnRuQn
75m0lym+bTxo80As6HwaeTXNlA3uIfT2KYqvxY7zVJlD9mDjv1YC1kLhYNfyQ4FO
X7pN3QG89KJDuOw/d5JmiOpUCrqA9Qt9Tn6hIdne5nDKe6dybnHJZr31MBmfmrn5
iZUoQAXtfQRJMve6g0RrEnwdP8D5rVDttx+FCtOQWCDA5wjcW/1GlUEGvxCY4TIt
/0eJ5r02JkVyBjHolOkHdIXI2ryGoQPBnkC2KKys4qj9vwDTF+GR4gYy2GWxx3oR
55iUbmorAg5GbRznqcrAvxCxb49y5wey0eOzNVoPO7i1SSJRBnks2cOdsJUdtUY6
r6u5zzW58BZyXiIUmvJVC5C9YdD+fyNOpAPZNzkNg+6tN8RCy6vKDZivYfAYxgbP
rAJzQWzz3GTxQ7uuIKw+RxaA1kDY6aIlwecN7PvwSSfOD6ueuPvUiH2DT0Ek2n4B
a3N6ZxNw0DQDmwTyfx79M853C/AKEV5e5MBKNeOdV6ZbHltlJtVPBDsX4LHe/PE9
fVw9Eh3Yu9zRPvT9r+0A
=iQv0
-----END PGP SIGNATURE-----

--Sig_/3rG=c/8M1G6uC7ZLT1cLQw8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
