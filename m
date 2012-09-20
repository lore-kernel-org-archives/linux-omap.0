From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: Do not require a VDDS_DSI regulator on
 am35xx
Date: Thu, 20 Sep 2012 11:22:00 +0300
Message-ID: <1348129320.2404.20.camel@deskari>
References: <20120815191627.GA22993@renkinjitsu.usine.8d.com>
	 <1345545584.4085.49.camel@deskari> <505A22AA.9080804@8d.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-gtNO32DRyGkoqWpn161J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43101 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab2ITIWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Sep 2012 04:22:07 -0400
Received: by lbbgj3 with SMTP id gj3so2067852lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 01:22:03 -0700 (PDT)
In-Reply-To: <505A22AA.9080804@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Cc: linux-omap@vger.kernel.org


--=-gtNO32DRyGkoqWpn161J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-19 at 15:53 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:
> Hello Tomi,
>=20
> On 21/08/12 06:39 AM, Tomi Valkeinen wrote:
> > Hi,
> >=20
> > On Wed, 2012-08-15 at 15:16 -0400, Raphael Assenat wrote:
> >> On our AM3505 based board, dpi.c complains that there is no VDSS_DSI r=
egulator
> >> and the framebuffer cannot be enabled. However, this check does not se=
em to
> >> apply to AM3505/17 chips.
> >>
> >> Taking into account comments received after my first patch[1], I have =
added
> >> entries to dss_features.c to support the am35xx soc. Then in dpi.c, in=
stead
> >> of using cpu_is_omap34xx() and soc_is_am35xx(), a call to dss_has_feat=
ure()
> >> is used.
> >>
> >> [1] http://marc.info/?l=3Dlinux-fbdev&m=3D134272967203409&w=3D2
> >>
> >> Signed-off-by: Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com>
> >=20
> > Chandrabhanu has posted a series that removes a bunch of cpu_is checks
> > from omapdss. On of them is the use of VDDS_DSI in dpi.c.
> >=20
> > Can you wait until I've merged those patches to omapdss master branch
> > (probably a few days), and then create a new patch that adds AM35xx to
> > dss_features?
>=20
> Please find a new version of the patch below. Due to the above mentioned =
changes,=20
> the patch now only touches dss_features.c.=20
>=20
> Tested on am3505 only.
>=20
> Diff based on git://gitorious.org/linux-omap-dss2/linux.git master.

Thanks, I'll apply this.

 Tomi


--=-gtNO32DRyGkoqWpn161J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQWtIoAAoJEPo9qoy8lh717JIP/ihTFuQ/5i/hy4/PHgQt91VB
14bfFq7sKn2S40Os7P/rTYPxmVTIEho0rfLyIJ2tB3GXubi/o46qYW1WXaDlu/I7
2atLrnn4C9bIe6MC/61QMe2WljWy1iAMb4qdR15Hgrx74rSlW5C93L8f3oKUBX1n
O27W8dSXXn3M5nv6l0EUXGQesAfDGdqoNoIGjWeSNA6xv9Qrd9+1D5Usvk5hGty6
dFiE+yUpnoe+SzP6NCFuqeGBsQOg4Qij8cc/0dgSC/ukxlHzf1On9IAdPQFIuCdx
m4Op4YLItxRXrln8qNCJdYV67ER1fX+iwnOItzElkRwp3MVHXhAeL6Iht6fJfoC0
FqodL3/OtFOLywl3cIcAomBS7wg5ctwALT1+/v3tJtBfTk6W01cFaU9B2ch9Sqku
v7Wr2XFFAeHm6C8hBXtM+ZkC02mfEnPCYCIRUr8oDBFahaFkCn4tgse+E2vAowhX
7hLExRDcTyoUWkS37+59sOBWL9iIyqyYQeUNLWh843p0Ov/WCUsS7tTR24icYg2K
SPPuj5iZOuxnEU1ReVERDftffUUK//bEVg105gnDbILsHFMAfcewCIvsBY+0ENOx
MWGGyZkbskSHVo46OQoWzcwDklsG/fniPWRzMgQhXQ6qM3j1RH8TryzH4QntGAm+
J39IV6lo9Z0nHLDAagxe
=5Y8d
-----END PGP SIGNATURE-----

--=-gtNO32DRyGkoqWpn161J--

