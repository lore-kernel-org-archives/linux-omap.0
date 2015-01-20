From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] arm: omap: hwmod: add debugfs interface
Date: Tue, 20 Jan 2015 08:36:03 -0600
Message-ID: <20150120143603.GB6556@saruman>
References: <1417818672-11586-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501200515370.5450@utopia.booyaka.com>
 <alpine.DEB.2.02.1501200810270.5450@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37033 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbbATOhT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2015 09:37:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501200810270.5450@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 20, 2015 at 08:13:57AM +0000, Paul Walmsley wrote:
> On Tue, 20 Jan 2015, Paul Walmsley wrote:
>=20
> > On Fri, 5 Dec 2014, Felipe Balbi wrote:
> >=20
> > > By exposing the details of hwmod structures
> > > to debugfs we can much more easily verify
> > > that changes to hwmod data is correct and won't
> > > cause regressions.
> > >=20
> > > The idea is that this can be used to check the
> > > state of one hwmod, verify hwmod sysc fields, etc.
> > >=20
> > > For example, this will be used to move some of
> > > the sysc fields to DT and later verify that they
> > > are correct pre- and post-patch.
> > >=20
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
> > This one had a bunch of unnecessary includes and checkpatch issues=20
> > (below).  I cleaned those up here and have queued the result (also belo=
w)=20
> > for v3.20.
>=20
> ... and, the patch doesn't even boot.  Dropped.
>=20
> If you really want something like this to be merged, resend a version tha=
t=20
> boots, and has checkpatch warnings fixed and unnecessary includes dropped=
=2E =20
> Otherwise you're just wasting my time.

you're using a really old version, though. There have been other
versions which are still under discussion.

--=20
balbi

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvmfTAAoJEIaOsuA1yqRE1osP/2vGGGQnNyQyNjwWe0CSmVlJ
9OLSnjUeVLgpaDa8m2/mgXam7uLVXG5Y60lchGg5vcOPRV/vJQzYtwtKmaG4zCQi
zNuS0C3FBeG//5C9lajc0Lwq2ipj0z3sFM0K9M8nLVhSzoExf/A+Fbrq0KUyPgZq
U+7jaRoy23XkjJ5w9bZxFflr2bk/9sb9OLDmcrIMGCWnuz6KqtOOpILzNn3HLHKK
6jgEF1JQ3GZrojCiq+r5A2Evg3dpkoPR1G9IaFsGWBiL32QPWCYf7+NHM673Pbm4
u0acwCq1Ayy2rcfa7BHfKXttFGq30PpZ00Ud19u0tB+4GZmdiDo7ZW6QjQBRXT44
v+MURohfY5q1yHNfMZSqBwfQ3B/Bkqcd34F8kwD575OSB2NKefW8VXudVi7zw7wN
oplULSjR4xv7lZ76eeT6EiI+IEj3cL7f0eMcptKjloq+PrY+bJUykU6ovLdrvfD8
dAMzlacVDVm0gnHYCuS0Ews2E+Buviu5/KozUYfzXaI2yRpHi3G0liTdyBCVnsPd
3OSG0T4XyYwaDWcewPJ/KZln/8NLMF/MOGk4/s5/qhyKjuqG4CNnbyeyho+qiHpB
lnGB3J3YCgCVzjtylo1nyvaHzr25IzXiZjXC87TzWrFGgAek1CKgIKrAn48eXsua
uzqt4sDFRxuvuJ/l2K05
=+H8H
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
