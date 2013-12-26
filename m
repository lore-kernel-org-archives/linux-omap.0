From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: configs: Select USB PHY for AM335x SoC
Date: Thu, 26 Dec 2013 09:55:55 -0600
Message-ID: <20131226155555.GA3937@saruman.home>
References: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131226120833.GA24645@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35874 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab3LZP5G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Dec 2013 10:57:06 -0500
Content-Disposition: inline
In-Reply-To: <20131226120833.GA24645@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2013 at 09:08:34AM -0300, Ezequiel Garcia wrote:
> Felipe,
>=20
> On Thu, Dec 12, 2013 at 12:14:29PM -0300, Ezequiel Garcia wrote:
> > Enable this option as it's required to use USB on AM335x SoC.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/configs/omap2plus_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/om=
ap2plus_defconfig
> > index 12c848e..e427b95 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -223,6 +223,7 @@ CONFIG_USB_TEST=3Dy
> >  CONFIG_NOP_USB_XCEIV=3Dy
> >  CONFIG_OMAP_USB2=3Dy
> >  CONFIG_OMAP_USB3=3Dy
> > +CONFIG_AM335X_PHY_USB=3Dy
> >  CONFIG_USB_GADGET=3Dy
> >  CONFIG_USB_GADGET_DEBUG=3Dy
> >  CONFIG_USB_GADGET_DEBUG_FILES=3Dy
> > --=20
> > 1.8.1.5
> >=20
>=20
> Maybe you can take this through your tree?

sorry, no. This should go through Tony to avoid conflicting.

--=20
balbi

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSvFGLAAoJEIaOsuA1yqREfNQP+wVqDOAAbbZkEKM9AFeO3nhN
pmvx/llWC67o4IiITLDXJgTGBRSndh/h8DoHpvb/4G8FT1a+a9PO/A5T8ABW6ZBe
tsT0UMVGOrHi6gfYwG84YOPbc5XaGcAZeNz5/dgvyDSj7UoHlPo/RLvPQtEpDUSf
MoVL0nVXrkm4nT8GlbiM7KJJr90kqL6tvdlPuhpFO4rE+Zd7A+Z056/50i/qYl6N
TmXhytWTnjjQO1Rr2d+JWNbxPxc/Qe/fjL0nZM5jR9inscLGIll0OhSOY5R8Bauh
qmE6pvWWdDKSlKiWXkFPx41kJZCuVHxR8lM5Bb5U+gsGAPu0yHs/qcZL+ZpMeMfD
rin+yTEs0OZa3qAvm76zOYQkwUFpr3VQIGN0uINhdw44ZwMPONeuNz06ihqEKCPd
vTteH942ry+bO3UfEU2sOCt7CEfRxtGe5Xp8fVB2nelMt1b0e41SrgsZ/b1lhLgs
NC260nTR3b1SmtgSvJFaUtTk6gwx+CV3RsbG8dSB8bnBU11JW8uKKRAZGfo1hbyn
rBS285xtpOHVh2mfvnzHAtJTXGB42ZgqQdt0AqamMiJgqpAIVnQmKUDnrcyaB62m
zryviwOhaw0nMOINnuccQrD/KgRpvDy3GqT5JmTLRsr+7s7kZUdfyCgoh0FFJrrl
hzaattqrklieCcXCKu1Y
=BABk
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
