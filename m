From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Tue, 17 Dec 2013 18:14:14 +0100
Message-ID: <20131217171412.GA10442@earth.universe>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
 <52AFFF3F.7020807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:49727 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab3LQROl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 12:14:41 -0500
Content-Disposition: inline
In-Reply-To: <52AFFF3F.7020807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 09:37:35AM +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> On 2013-12-13 20:17, Sebastian Reichel wrote:
> > Hi,
> >=20
> > This patchset adds DT support for the N900 panel. The patchset is based=
 on
> > Tomi's work/dss-dt-2 branch [0]. I suggest to send the DT changes throu=
gh
> > Benoits queue, since I have more N900 DT changes for 3.14. Also the pat=
ch
> > editing the rx51 boardcode can be dropped, since the file is removed in=
 3.14.
> > I included those two with this patchset, since they are needed to test =
the
> > other two patches.
> >=20
> > I did not include a documentation for the DT API, since the omapdss
> > documentation is still missing.
> >=20
> > I have successfully tested this on the N900.
> >=20
> > [0] https://git.kernel.org/cgit/linux/kernel/git/tomba/linux.git/log/?h=
=3Dwork/dss-dt-2
>=20
> I added N900 display DT support on top of my v2 series, including
> pinmuxing. Can you check if it looks right and works?
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt

I just tried it and it does not work. On a first look the pinmuxing
looks fishy: 0x0d4 is muxed two times.

I will have a more detailed look into this later.

-- Sebastian

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSsIZkAAoJENju1/PIO/qa/LYP/iyrGFxaTaZwmkcavWq+J9U/
TMBJwwXy1z5GYqE1egJ5/3f21tzfjlLuCKiEtZteNdv7U45urBGLdX+434iox0br
LcNgiXo8GSfnmbYio/GDSgceOyoGefCHo2/HubNp/jfwM6MeUkFj6yVq60m+8Wwr
GgYvX6zZIcxSiCI3/0oBMozHfHQhf+rmqgpQT0966pXpx/K/Q2kVgadpQm5S65h4
UcYLG4R/s6hLDBRqGVbHRCiotuCxGlQ04hodgjpzf9zLeX05RKOdRLy7Mjzz5KA1
cpRwBt7t0zLvtzrjY06PwZGVPbu66SpECmNw6C5s69S8taOOuW4Bdl5luqdMpL92
itjJGuHRvtBMLa7fdgyY/ptL7oRey5ulzmwyxOZh00mYxEREKZWwnI3Kh3qnwm11
FDLJBGq3/XBXTCYhBC5ikAJrtR/Ms6c/Z1/t6vqL5lJgo5rOTazX9KP6mCgFciGU
tEXlghXJqg0TFdHXE4vf4IcNPtDVWsqgh8ly2Pw1UPfaXFk9oMX28tvfSwNjaSth
SJvrHP4b3kyRb1r2e4ChJGHOVAuSJ+QgNdP0OrHaEoJ9ABreNsBAW3K8L5q0ikIj
zVnGOA8NFSEc22IIIaNkMLDUlZEmsCLc4UHDKjYifMn8/cL0M9QilKMDPdsEwpFt
fSuyYgCj0efJpT/v3MW2
=jmf4
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
