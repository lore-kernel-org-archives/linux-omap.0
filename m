From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] arm: omap: hwmod: add debugfs interface
Date: Tue, 20 Jan 2015 09:11:44 -0600
Message-ID: <20150120151144.GD6556@saruman>
References: <1417818672-11586-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501200515370.5450@utopia.booyaka.com>
 <alpine.DEB.2.02.1501200810270.5450@utopia.booyaka.com>
 <20150120143603.GB6556@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38471 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbbATPM7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2015 10:12:59 -0500
Content-Disposition: inline
In-Reply-To: <20150120143603.GB6556@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2015 at 08:36:03AM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Jan 20, 2015 at 08:13:57AM +0000, Paul Walmsley wrote:
> > On Tue, 20 Jan 2015, Paul Walmsley wrote:
> >=20
> > > On Fri, 5 Dec 2014, Felipe Balbi wrote:
> > >=20
> > > > By exposing the details of hwmod structures
> > > > to debugfs we can much more easily verify
> > > > that changes to hwmod data is correct and won't
> > > > cause regressions.
> > > >=20
> > > > The idea is that this can be used to check the
> > > > state of one hwmod, verify hwmod sysc fields, etc.
> > > >=20
> > > > For example, this will be used to move some of
> > > > the sysc fields to DT and later verify that they
> > > > are correct pre- and post-patch.
> > > >=20
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > >=20
> > > This one had a bunch of unnecessary includes and checkpatch issues=20
> > > (below).  I cleaned those up here and have queued the result (also be=
low)=20
> > > for v3.20.
> >=20
> > ... and, the patch doesn't even boot.  Dropped.
> >=20
> > If you really want something like this to be merged, resend a version t=
hat=20
> > boots, and has checkpatch warnings fixed and unnecessary includes dropp=
ed. =20
> > Otherwise you're just wasting my time.
>=20
> you're using a really old version, though. There have been other
> versions which are still under discussion.

not to mention that this was an RFC, not meant for merging at the time
it was sent.

--=20
balbi

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvnAwAAoJEIaOsuA1yqREeYIP/iXDCIyJ/Z5UCEgGEcSsG4RI
0Qz45AUT7jkNuJ5MXszeOM9LK8lMHKEvVY4F5lI+FbwPR4bWAvTLfFKTGtuwNAxI
meunVly6Va1dm/XSFg3gjsaGaLVKok2ckh9uGxriXkf3gnuCKO/QV/5h8SDDCD9C
NaLkVF0AVEZabyMtg//TWWeiwnZB4ztRfGzbNS/g0px28qh1ic0iZYaVIqtFyVAg
hsHG85XSqjcqWtiQ6YHg2/ewchuF7Wx+IFI3UBrocaY/u9dLbALkhopUP55cdOdt
wRQ93H6fVIqXuMEFnvdT44vq6DGu/BuFIK3nJ/8nb6cDW+G11T59eBfedOMbSQRV
LADCqhFXj6f2hV9A1VSmYyuJ2i+tW87q54XiMo8eJPz8lyam2ScrqlKdxYhBKHlT
a+V7G62e/DzzabkFBDV3OPpK/UMN8GRxKBHSl6Gb+q03dORbpwAsVAAt3MXFDUso
h8RVKM8cNxJR9ql5770CxEKCFxLqmkBT5INQjAGN1drsdTzDpsmFxV5NL9Jqfwgl
lZ3j/I4NFhZox+KHAKYkLyZeJwKHGbbZ0z2nppJTHOe7AVaiFGILXtwxCTYzzsR2
4e+bq4zjQbL9t8wnVDdvGCqauqm9/8nmlUn3N/kGCcNLxqMNej+j9V1Fp9M98mKW
IXQodz7Py0ocnokJUHQq
=YCsa
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
