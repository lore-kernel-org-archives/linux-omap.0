From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: improve duty cycle on SCL
Date: Fri, 19 Jun 2015 10:30:21 -0500
Message-ID: <20150619153021.GD29392@saruman.tx.rr.com>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
 <55815581.80807@gmx.de>
 <20150617153812.GB18421@saruman.tx.rr.com>
 <5582678F.4010505@gmx.de>
 <20150618172428.GB27790@saruman.tx.rr.com>
 <5583AB9D.6090805@gmx.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5583AB9D.6090805-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2015 at 07:41:49AM +0200, Michael Lawnick wrote:
> Am 18.06.2015 um 19:24 schrieb Felipe Balbi:
> >On Thu, Jun 18, 2015 at 08:39:11AM +0200, Michael Lawnick wrote:
> >>Am 17.06.2015 um 17:38 schrieb Felipe Balbi:
> >>>Hi,
> >>>
> >>>On Wed, Jun 17, 2015 at 01:09:53PM +0200, Michael Lawnick wrote:
> >>>>Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
> >>>>>With this patch we try to be as close to 50%
> >>>>>duty cycle as possible. The reason for this
> >>>>>is that some devices present an erratic behavior
> >>>>>with certain duty cycles.
> >>>>>
> >>>>>One such example is TPS65218 PMIC which fails
> >>>>>to change voltages when running @ 400kHz and
> >>>>>duty cycle is lower than 34%.
> >>>>>
> >>>>>The idea of the patch is simple:
> >>>>>
> >>>>>calculate desired scl_period from requested scl
> >>>>>and use 50% for tLow and 50% for tHigh.
> >>>>...
> >>>>Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Table=
 5?
> >>>>
> >>>>>PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE   =
  UNIT
> >>>>>                                          MIN. MAX.     MIN. MAX.
> >>>>>LOW period of the SCL clock     tLOW      4.7   =E2=80=93       1.3 =
  =E2=80=93       =C2=B5s
> >>>>>HIGH period of the SCL clock    tHIGH     4.0   =E2=80=93       0.6 =
  =E2=80=93       =C2=B5s
> >>>>
> >>>>Your signal is in spec (0.85 =C2=B5s high, 1,65 low).
> >>>>Maybe your TPS65218 is just buggy or signals are bad?
> >>>
> >>>yes, tps is buggy, it's written in the commit log itself.
> >>>
> >>
> >>So I think it is unacceptable to change the adapters code violating
> >>specification because some buggy device doesn't work properly.
> >
> >read the other thread and you'll see that it's not violating jack
> >
> >>This change for your device has chance to blow up many correctly
> >>working ones.
> >
> >How ?
> >
> The answer is so obvious that I'm a bit irritated.
> Your patch description tells: 'and use 50% for tLow and 50% for tHigh'

another one who can't do simple algebra.

http://marc.info/?l=3Dlinux-i2c&m=3D143456423512634&w=3D2
http://marc.info/?l=3Dlinux-i2c&m=3D143456444212698&w=3D2
http://marc.info/?l=3Dlinux-omap&m=3D143456762413953&w=3D2

> For 400kHz this means 1.25 us for high and low. This clearly violates the
> specification for minimum low period and will not work with any device th=
at
> relies on it.
> In the other thread it is discussed that your patch does effectively not =
do
> what you describe but this is something completely independent.

Read the comment where the calculation goes, it states that we try to
get as close to 50% duty cycle while making sure we're within spec.

Also, commit log is saying that we're using 50% of SCL period for tLow
and tHigh calculation, not that duty cycle will be 50%, which it isn't.

--=20
balbi

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVhDWNAAoJEIaOsuA1yqRESEUP/jNlWfGVikRlqRv+85M8pf5r
d705ZECWwlNhm+2TVceRyh+wZiQNIoFHb1D9+szPqgStRfegvu/ycJNTZNnsB+dZ
KPPpSXWr6Uy1Y+a/ahDbqmC33NJEtRJmmWsUOAb0EW8JzVWQBH9n1FDB67seOw2c
GvOLngklcYoPGz1bEw1QvztDXxtA6FIjI7SEqKk3gJRlp6D8C80iS0CclMPTr84Q
ke0/kY2bh5zSza61vtZIMDhY8hb26aIG4V0UFVjdiKfD1oXIht+YrbYlaXc3MarS
SxmgHyhu8clyISlZiyLOmn/e3lfztHln4UHIwDpO5qAFmoo/sh3pwiwqJWyuHtyU
RMJ0D14urhc1JrKgK324MofpuZgz1ow6lJYK12h5whGy8t6j7W/LBz8dMtivlznd
kzjfYo/58PamV2uCcqajeYEjUrM/7TaxGxm8Mkg80y3Ao41kAhXHafbHqKdIYbRx
WVZRVKWVgRqabTl1sNBLNLPrYFEzsOChOvfp6LFAJekCckYbMKzS8FyNrF+FJrz7
VYcpy8fALODzcQBtN26ESaB9I/XUf7t4DqSsg+uWI24NstjA01nsJNAynv4DDR8r
cGgcpyPaunsXuY84smrPeNKdgNR1kvrqkl7kWYtWc+05Hl51gknpZgQCd1IFhyAk
Db2tvdx1cPlXRJorgS3v
=5C6B
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
