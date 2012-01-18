From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP3 DSS2 - VENC timings
Date: Wed, 18 Jan 2012 09:38:23 +0200
Message-ID: <1326872303.1954.28.camel@deskari>
References: <4F1467B5.80600@mlbassoc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-DZVxjZUfd8tO0VnxU4NC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56036 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753005Ab2ARHi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 02:38:29 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id i14so2669530lam.6
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 23:38:28 -0800 (PST)
In-Reply-To: <4F1467B5.80600@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org


--=-DZVxjZUfd8tO0VnxU4NC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-16 at 11:08 -0700, Gary Thomas wrote:
> I'm running a frame buffer console on a TV device via the VENC.
> The video timings don't see to be quite right as Tux is about
> 1/2 off the screen - both directions, i.e. his head and right
> side have been cut off as they are outside the viewable area.
> Also, when I send data to the device (via /dev/tty1) which has
> 90x35 characters, I lose 4 characters on each end of every line.
>=20
> Is there something I can do about this?  I've looked at the
> timings in drivers/video/omap2/dss/venc.c

I don't know much about analog TV, but my understanding is that there's
always overscanning going on. You just have to size and position the
overlay so that it is visible on your TV.

> Also, how can I select NTSC vs PAL setups via the command line?
> I have only the one video device VENC.

Documentation/arm/OMAP/DSS says you can echo "pal" or "ntsc" to
sys/devices/platform/omapdss/display?/timings file.

 Tomi


--=-DZVxjZUfd8tO0VnxU4NC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPFnbvAAoJEPo9qoy8lh710AIP/1SCiLcE9tppJbIyXgNMz3LI
ugF4glc/k1J8+LFdL/o+yQvc1dAf1BHvMH6wj6f5BuGsUfDdIDlgz4GoDhN3oxpB
0mJSGemZO9Jrd4WBNawveK2BQTuU6MYggo3YoNA/AyqEUFRiG+7Hr53Qp0XZuTeR
LsptRQOgqpgcvkSXzr4cRjRcULQn0DYOjiCPkroCS40PY4yzpmeTOhA2i9S/tVx1
rlAN9VdafZOs8XzLbXb2rnTHbMGXqKtMRdvPfPaXjwKYuiF1X+bWPxKpZMeflZWS
3GMAS64NJ7gKLjXu0+kXf6T20psJv2T/NwaTKAaq52cYD04ugMKALAkkoRaH+QmP
4FM4rMNTtc0NQs/m5cW5489VQLf/fDswnOh1L0jOBwETVRONN+B7uL/aFyJrOU3Z
IgOMwqB4CSZtzJirxZwfRWvsc43/l4Y09uZ4IBBVvumpZrQBPV1USeqhpbswt5SF
raqkoj5+7hg24RPfPjbVsGAkGQMxNpL7Af+duJ7yv2Sx7WTRRXyzx4OybV/2raWj
fZ3NtiU4fdF00Hh1aMTyCo6Kjg4phe8Gzm3+YJ3uo5g+jmSzMjc6E72Lm3bI98ft
v+ZzDkJQc+t3A4HIiwuW2VRyhbvF4vtet1ZzOjNhmD/zCYYnNJt0xjzO0C4mQsrp
8NYYDSanhuwSF6Wr73F/
=FGuW
-----END PGP SIGNATURE-----

--=-DZVxjZUfd8tO0VnxU4NC--

