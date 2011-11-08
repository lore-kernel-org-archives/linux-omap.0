From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
Date: Tue, 08 Nov 2011 12:08:31 +0200
Message-ID: <1320746911.1907.47.camel@deskari>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
	 <20111105003550.GM31337@atomide.com>
	 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-16ZB4BRbmHU9toUatRV3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33338 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878Ab1KHKIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 05:08:38 -0500
Received: by mail-bw0-f49.google.com with SMTP id t2so292259bka.36
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 02:08:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-16ZB4BRbmHU9toUatRV3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-11-08 at 00:50 -0700, Paul Walmsley wrote:
> On Fri, 4 Nov 2011, Tony Lindgren wrote:
>=20
> > * Paul Walmsley <paul@pwsan.com> [111006 16:33]:
> > > Hi Tony,
> > >=20
> > > The following changes since commit be73246058737beec52ae232bcab777633=
2a9e06:
> > >=20
> > >   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-2=
6 17:50:37 -0700)
> > >=20
> > > are available in the git repository at:
> > >   git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2
> >=20
> > Looks like you should take a look at the merge conflicts with
> > this one, maybe rebase it on 994c0e992522c123298b4a91b72f5e67ba2d1123.
>=20
> Do you want this series for 3.2-rc or 3.3 at this point?

Seems that at least HDMI output is broken due to this series missing.

 Tomi


--=-16ZB4BRbmHU9toUatRV3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOuP+fAAoJEPo9qoy8lh71Z4QP/1SbU5WsF61GaD6U9cgzoVN6
Woncp0o2wSDE/b0OZPvunBBo5a1rbFBPmnshFtrLbfVw6WUE0EYNWg8Z+NRC4nD6
P71bDp9h3fnkgqHLBTxN+u2/3r0PpaHeEtCZWlbZQ+AhP4zmOrkTc8A13W96tGjj
iEMHviz/3PoP3kwSg3Aab4z4BUkGJ5n5p/KC8bDQqJ5qz0j8rPkLLXDiD6eYenjj
8RsQZr/KjImq8QXTBigrHZXBY07gZm+mgLqXera3cT+QHyd6fi4dUZkwyeRMt7m9
kWZQB849ffv2FlHogfgPjDc/No2ztJgL5p7ADcO94MCUawaIx1lkumPfTMLIDEnt
kWF5TyrPGpKkOq+JYCTwhJ4KaRax0FftSGZDXQxXmbUhgM6eZKIDFmGOuITIXeDT
A0wFjNJaToerAjo+tEYEoJX3p8pjz66qCs6YPyFXVZK/G1yt38Tu8Ml+hBuDKdyw
Zgs7+21er/Qc2EspP86yQ6DtWqS9VnZ24L7VNlrf42QuAX4nwNbsDZGqZA3hhXmw
myYeXLpe1OPei/5Z7pBphPe3CJVsrszJU+Au+q1ackZ0rWfpf+d4n1VtpuPQFjmY
ejemSjdHsfDwZWks3b46cUvCEmJxwhefF1unLfUVjybFPCoBpnZShraJlEmzbl+9
XJNhTT6mLcEEhgjh3Oya
=CIIq
-----END PGP SIGNATURE-----

--=-16ZB4BRbmHU9toUatRV3--

