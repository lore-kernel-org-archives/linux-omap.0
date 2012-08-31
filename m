From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 15/23] OMAPDSS: RFBI: Add dssdev pointers as
 arguments to all exported functions
Date: Fri, 31 Aug 2012 17:20:20 +0300
Message-ID: <1346422820.16067.21.camel@deskari>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1346326845-16583-1-git-send-email-archit@ti.com>
	 <1346326845-16583-16-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-PkWgE6WcZO/g4tgY5X3G"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:40492 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753372Ab2HaOUZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:20:25 -0400
Received: by lagy9 with SMTP id y9so2308537lag.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 07:20:23 -0700 (PDT)
In-Reply-To: <1346326845-16583-16-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-PkWgE6WcZO/g4tgY5X3G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
> All functions of an interface driver used by a panel driver should have a=
n
> omap_dss_device pointer as an argument. This may not be needed by some of=
 the
> interfaces now as driver data is globally visible in them. The correct wa=
y
> to retrieve driver data is to extract the platform device from the output=
,
> and then extract the driver data from the platform device.
>=20
> Add dssdev arguments from functions used by panel drivers which currently=
 miss
> it. This will come to use when the RFBI functions retrieve the driver dat=
a
> in the correct manner.

This and the similar patch for HDMI could probably also be left out for
now. Again I agree that this is correct direction, but this is not
really needed (right?) for output work or writeback. And we'll
eventually just change these parameters again.

The motivation for this patch was probably to have common format for the
output driver's functions, so that you can use func pointers in an ops
struct?

Let's delay that work until the common panel framework gets a bit more
solid.

Sorry if I'm saying "leave this patch out" for most of the patches =3D). I
just want to avoid extra churn, going back and forth with the code. The
most important things now are to get the output work in a state that WB
can be used, and on the other hand to remove the dssdev dependencies so
that at some point we can remove dssdev totally.

 Tomi


--=-PkWgE6WcZO/g4tgY5X3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQMgkAAoJEPo9qoy8lh711x8P/0lyS0PCPpSPw/Kfdg9zDXlH
5UreBdfjME1H/pEWPnOLockjHp4F7mFTqoDB4aZa+bx16GXIsIJI4tGI7unRl5oA
XlNtujo6IN0xXaRYrTU56sBEqOUaYgIOF2Lue3N9nGMDttF38jkTfQbSBGzs7DYn
rltQYpcJdRteey++i36gf8G/M6hgakMwn77Bl8um5dPE5ryoRR4yFZyPJFEz3d2c
wpH6lS3bvvNqjoZ5mhxQ9wkgjgSYWAAceiJWnQwewt7gig2SMLA9/f0iqWCAOHsj
psHFSeqNpb8Mrzj5p7T/aiz4FKlraQu2qZYTNJreEM6frEKupd8jclrq5yRQiL9V
223+2baXsGEtw3D0j1lBokwU7wTp0dsMY7pQIrwR9eTzz2s/7MLjnxGYsAmwKtzK
CeotKUH2caeVuWu4evXFCOgI0+MU+FVFhWYnMWOB1noO21Pw/nzhQA4FjMPwlwMF
odPnsbHoNlN09ckYv3ZRzzXa53MiUH/8FKstfC6Nlx338ZfjtApA9FoWdCKlmAaV
4KCRZjtStn1GM6IRLy2wGzga09dbO0iqErT9z7+5ruIffB9AAcRq4YN5wsr+3rYE
hsS/TRBGZabTKN0OcDCdVvGSmuFNIpU7IuFJkkFICY8HUWL932WCWT62n5XHiswX
Y3VHzkjNsD17ohK/nZK7
=3ul+
-----END PGP SIGNATURE-----

--=-PkWgE6WcZO/g4tgY5X3G--

