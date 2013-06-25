From: Felipe Balbi <balbi@ti.com>
Subject: Re: MMC breakage on 3.11/cleanup
Date: Tue, 25 Jun 2013 13:40:11 +0300
Message-ID: <20130625104011.GH15407@arwen.pp.htv.fi>
References: <CAD=GYpZGdLem1igUsLq7DzMu-Z=9d6apS-aT=MJ59_-ytZan7w@mail.gmail.com>
 <20130625064944.GX5523@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57582 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab3FYKkQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 06:40:16 -0400
Content-Disposition: inline
In-Reply-To: <20130625064944.GX5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>

--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2013 at 11:49:44PM -0700, Tony Lindgren wrote:
> * Joel A Fernandes <agnel.joel@gmail.com> [130624 15:33]:
> > Hi Tony,
> >=20
> > Following branch breaks MMC for me on am33xx (beaglebone):
> > http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?=
h=3Domap-for-v3.11/cleanup
> >=20
> > I tried to work around it by specifying interrupt and reg property in D=
T:
> >       mmc1: mmc@48060000 {
> >          compatible =3D "ti,omap3-hsmmc";
> >          ti,hwmods =3D "mmc1";
> >          ti,dual-volt;
> >          ti,needs-special-reset;
> >          dmas =3D <&edma 24
> >             &edma 25>;
> >          dma-names =3D "tx", "rx";
> >          interrupts =3D <64>;
> >          interrupt-parent =3D <&intc>;
> >          reg =3D <0x48060000 0x1000>;
> >          status =3D "disabled";
> >       };
> >=20
> > The probe succeeds but I still get a "Waiting for root device
> > /dev/mmcblk0p2" when booting over MMC.
> >=20
> > If you're planning to push the cleanup branch, can we temporarily add
> > the hwmod data back while we work on this issue so that upstream MMC
> > is kept working.
>=20
> Yes the cleanup branch is queued up. Can you please send a patch
> reverting the MMC parts of the hwmod change for am33xx for now,
> then try to find the real cause for the breakage?

I had mentioned that Joel should *not* depend on hwmod data and if
adding interrupts to DTS caused issues, that issue should be resolved.

http://marc.info/?l=3Dlinux-omap&m=3D137124891908957&w=3D2

--=20
balbi

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyXOKAAoJEIaOsuA1yqREcWQQAJRBwkawbIwPxbhE2E5S2xuF
r7BUSd5Y0nu+AWUuVxzmKcDP8rwfLTCCnjz9UbXRsNfaHy+TWb24S5s/DShIMKP2
wnAha81AtPlH3G+r+umxj8OD0p+OpL2gKALb/lvnIAjnp8EiNLKv0Boe3pMsyAyZ
G97uvSfTNyUYk8uDqjOuB0XYJWBuFHOVYplT/Jjsx3T1lAhmCYxxPTtiS/eTrWmo
aNzXQ0dgjyJcVutaQtNzgyYkyH153KfWW7hY7GOhzxLeAl4k6vJvpoaOZMxHd4um
zFJxucrCKl1/1efWtlnKQYvXr+B3n8i/IeFjSxZmce7WYa5KljpIgOX8kqsTZlT+
FUZgn1jPGNsqIw7Pn5xS1UDmEjNl/Gj7b4EsI+JScTg7lVfA+a50TcbVArZmgeBE
YDZ3KIbOKJoeYLndH2Or9Sehj245RizIeCI6f4D8q4rEPRLHkoX3O1kJtrf+bYiJ
AJCTepSqJNdDDvOr/hgUeksODyt8j5EalBPedBsODpD6+qty57+u+P9BeJ0/NPlP
cZie0IuMx+X2vd4BayfRKtDExKlGDZYDKy2Y4slOtbC3VUFWAKtu6h+Xe9vBOmxL
pXXENMxf0FMcJkt2KulqYCwcUQredHWipByj1CLRUY9hLuJd75TUcbkheXs2gNuh
VB8kkwaoWrSHSPjEcJZz
=zZbQ
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
