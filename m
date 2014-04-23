From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 10/13] tty: serial: omap: remove some dead code
Date: Wed, 23 Apr 2014 18:01:21 -0500
Message-ID: <20140423230121.GC10924@saruman.home>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
 <1398265117-11793-10-git-send-email-balbi@ti.com>
 <5357DDA8.4040206@ti.com>
 <20140424084305.20c7f301@notabene.brown>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140424084305.20c7f301-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 24, 2014 at 08:43:05AM +1000, NeilBrown wrote:
> On Wed, 23 Apr 2014 10:35:04 -0500 Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
>=20
> > On 04/23/2014 09:58 AM, Felipe Balbi wrote:
> > > nobody passes a DTR_gpio to this driver, so
> > > this code is not necessary.
> > >=20
> > > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > > ---
> >=20
> > Niel,
> > this seems to revert the functionality introduced in
> > commit 9574f36fb801035f6ab0fbb1b53ce2c12c17d100
> > (OMAP/serial: Add support for driving a GPIO as DTR.)
> >=20
> > would you like to Ack this change?
>=20
> I have a couple of out-of-tree drivers that use this support.
>=20
> I hope to get back to working on that code one day and even get those dri=
vers
> upstream.  So I would really prefer this code to remain if it isn't causi=
ng
> any actual problems.

it causes problem with DT (not really). That suport is only available on
legacy platform_data-based boot, it's not available on DT. I hear Tony
is pretty close to turning OMAP3 DT-only.

> Of course, I can always re-submit it when I need it again, but that it ju=
st
> extra work all around.

I wonder how you will pass those attributes through DT considering they
are *really* SW configuration. Why can't you use the real DTR pin, btw ?

--=20
balbi

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWEZBAAoJEIaOsuA1yqRE40wQAILR19zMkM/rKTjCVC1C2C0Z
QgxHiiRQVI035WCwtRXqeEqGsUutycofiDI0sIOF37gh0oS1WVKctmJkhh70AipL
tZv3KiXO3aX/xWuSLW16yT2D5WU4TdLndmzZB+7bkOST9aSHQ8LIBPEKgJQofruB
IY4PZdJhi2ucWIsLNClL8VaR/YltpTEqdByIyxHBjd4Oacz6QV5QFF9ybyPomtKa
/EBXi0ZBgUGKV+jTBesNb41hDHVzvZ/rvidTpmt0LgvWg/NdN7A2XPn6vMuIfPDz
sUSpPAnt7zHSY8k/L/FuzK2mjBKQ6QX7spLLgKabQUachp8bgS+Psxud7omsUVj1
W4XsAdbzrbaIp6/JRyMUTeuW0i5zxq4y8dUudqkOhRHhQWylrpHFJV79ELdHuFiY
WUTZ58OyCOneb1FuOBq85S9GDgdefdqvyapG4qR48mxs5UYfExGe5YEM4zBqBNn5
Y0qgDB/9XZwhc4+pN8LJjBiN0dqA87ZSESK9fVspOh26crg9Erh0CKRgBdFg8fyc
sqSss/4yO5hKFY6TnyyxvwyYrEZubXq7z8gyEg7n2HLrf8UshfH4eWWf56gF0LBh
b8FXvNr7spfgChwyQfHXTIy7mtywCGFda04qP8mOgCJZLBGhMuOx9/2OwGNVH/tD
U459l1ufd8I6wDHLAPPh
=xl8F
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
