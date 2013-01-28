From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc5
Date: Mon, 28 Jan 2013 12:47:52 +0200
Message-ID: <20130128104752.GB28698@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51822 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab3A1KsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 05:48:15 -0500
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 28, 2013 at 11:34:15AM +0100, Mohammed, Afzal wrote:
> Hi,
>=20
> On Sat, Jan 26, 2013 at 14:16:04, Balbi, Felipe wrote:
> > On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
>=20
> > > * am335xbone: hangs after "Starting kernel"
> > >   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=3Dy?
> > >   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.h=
tml
> > >   - http://marc.info/?l=3Dlinux-omap&m=3D135903184512238&w=3D2
> >=20
> > FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
> > without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
> > to help my bone, no matter if I had appended DTB or not.
>=20
> Following patch with low level debug may help to find where the issue is,
> (my observation is that it boots with mainline u-boot)

will try your patch, but are you using Beagle Bone white or black ? I
should've made it clear I'm using beagle bone black.

--=20
balbi

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBldYAAoJEIaOsuA1yqREooIP/1TEiz/fK7mETelBTwFZU5aE
KuHLDc1d0eFPYrwx5xDdcY3cACqAQirypv7ojqsXinEZCIxeVAX/KFccjqGRo5bl
qx1TU1FWHItBFpsP2x6hR8NYHbMsSnbVR1htMXw2ZeSXmaw6lYfvPmA1TTzBuxw9
2dmOTb/yRsz/RZmGogrLLR3qkaLn8P+8EcbRpwnoJXkTlyNAmCXnKoJgghP5XVdE
tMYhvvz8Anh8kmipseJjAGNnoh3/oTTDiTdbCDOnsUyS5CrMCa4cRFWhTSeUHzvJ
TDH/4nDlwPxzxz+RzbVySVPpAMPPSAi5xwTPCObhYLeI0Z9KBEvTEB8XIt5RPni1
SeTOIlafvzX3MWGqMpIpQrk65GwXclRoPWJnStp3M9CDDNMm/55G8bGOSjO06oiU
CFsCqor3NAsTWVhpKm/4AWsvq67xzQMn5acGS4QsIqdAXK/j0UGvNn50QE8OEzPg
svnj4axFrNOws9aqNP+4JHwbBE1YptCg9DP/FSmgt/qecsbRbNNS2uNCe6FjoNAX
hCHd8g0if7eXgcGgLm+0aqwf45TzPiMVTLLDhswXfNByRwVVrmv8W1IfwYbbVOS+
foOguY1M60buX50udTtg7SuwhmbCRLbAEDd9BCIhgfL59heUa3AdiJkrIF3IZCun
Wfiey7Gf+7Lgbwtwhemm
=X0K+
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
