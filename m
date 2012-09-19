From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: Do not require a VDDS_DSI regulator on
 am35xx
Date: Wed, 19 Sep 2012 10:49:03 +0300
Message-ID: <1348040943.2565.8.camel@deskari>
References: <20120815191627.GA22993@renkinjitsu.usine.8d.com>
	 <1345545584.4085.49.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-8IN0HiKvDZMF9E7IRTDK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:44834 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751507Ab2ISHtJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 03:49:09 -0400
Received: by lbbgj3 with SMTP id gj3so598585lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 00:49:06 -0700 (PDT)
In-Reply-To: <1345545584.4085.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org


--=-8IN0HiKvDZMF9E7IRTDK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 13:39 +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On Wed, 2012-08-15 at 15:16 -0400, Raphael Assenat wrote:
> > On our AM3505 based board, dpi.c complains that there is no VDSS_DSI re=
gulator
> > and the framebuffer cannot be enabled. However, this check does not see=
m to
> > apply to AM3505/17 chips.
> >=20
> > Taking into account comments received after my first patch[1], I have a=
dded
> > entries to dss_features.c to support the am35xx soc. Then in dpi.c, ins=
tead
> > of using cpu_is_omap34xx() and soc_is_am35xx(), a call to dss_has_featu=
re()
> > is used.
> >=20
> > [1] http://marc.info/?l=3Dlinux-fbdev&m=3D134272967203409&w=3D2
> >=20
> > Signed-off-by: Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com>
>=20
> Chandrabhanu has posted a series that removes a bunch of cpu_is checks
> from omapdss. On of them is the use of VDDS_DSI in dpi.c.
>=20
> Can you wait until I've merged those patches to omapdss master branch
> (probably a few days), and then create a new patch that adds AM35xx to
> dss_features?

If you have time, can you revisit this? The current omapdss master
branch has some cleanups for the cpu check:

git://gitorious.org/linux-omap-dss2/linux.git master

 Tomi


--=-8IN0HiKvDZMF9E7IRTDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQWXjvAAoJEPo9qoy8lh71fdUQAIJaFtjTV5yjtZI9mJAJUZfy
lNXz3HZAZNHaG/wzUf5QnS40AxHtxMEM2zifPdcOLQQ1cz8GOIPzbNwGxf74K2Du
zyTBPV/rTbkxhRi+qYCbtlpCkq1wHlTjQY0M0IlNyQl43QMkX8MqJkewVIz6EENB
BBt2f+VS1OeR71zVfuT0BRJRxBkk2I5wLeHveTEj4wKqA7lAGw1HN/PEXDQhGYbx
5KqRNV5S685KD8zcrG/3OYMNJcUPw4kCUFrtcDdfdeZndvgDi0pOvvEPgqkn58SX
f62G2xd71eMn075D2k1KHKbJVaJV1HVodj7rwzQADhs26+IjQvqVX2VArAAOcHFd
Is80HenmCEugbihm3hghLQ27UNH6hsmAffYL5q0OKjhC93gV2FSiDts+EeW+ejUL
mrn1zrsZfXGHFnJr31yKxIdf3KI+GMTa1aCtGeribFZ6o7epmQwbOiIt6bFGfd6I
ibrzvwDR0v9z2Sb63XlNL6gGgG2N6mZDaUXqF69nHwCiqkoy4sEi16iRjoOXX9WE
LvpRve6TZ/N4Zv3MBKSBfui6YhLGQ6/behQ+gFUp80sFOYXRvTlAwxaEHQgFhbsF
FC8GtBOf4dkgZLd+C3/PK4/68S+wznDl5uCtZYMCktjX8GjoI2vBzZfK7r6nPgi4
teKivPJribUghtqdM7nU
=57P6
-----END PGP SIGNATURE-----

--=-8IN0HiKvDZMF9E7IRTDK--

