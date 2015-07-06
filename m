From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Mon, 6 Jul 2015 18:36:03 +0200
Message-ID: <201507061836.03293@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <CAL_Jsq+ysDqxTgfW1JvG5czHa4UkZQDv1BN63iK4jvV9kDXM8w@mail.gmail.com> <201507061820.35789@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2173250.yWbRqrjftP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507061820.35789@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--nextPart2173250.yWbRqrjftP
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 06 July 2015 18:20:35 Pali Roh=C3=A1r wrote:
> > > "/chosen/linux,atags"
> >=20
> > This one. ATAGs are a Linux data struct.
> >=20
> > Rob
>=20
> Ok, and how read that property "/chosen/linux,atags" in function
> setup_machine_fdt() from file arch/arm/kernel/devtree.c ?
>=20
> of_get_flat_dt_prop() cannot be used unless somebody get me offset to
> node "/chosen"...
>=20
> Any idea?
>=20

fdt_path_offset() from libfdt.h seems to work...

Is solution like this one acceptable?

#include <linux/libfdt.h>
#include "atags.h"

=2E.. setup_machine_fdt(unsigned int dt_phys) {

dt_virt =3D phys_to_virt(dt_phys);
dt_chosen =3D fdt_path_offset(dt_virt, "/chosen");
atags =3D of_get_flat_dt_prop(dt_chosen, "linux,atags", NULL);
save_atags(atags);

}

(this is without checks for errors)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2173250.yWbRqrjftP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWarnMACgkQi/DJPQPkQ1KK8ACeMiZcY5SZoQKbwDDLM9/vyV1L
XlIAoMPPtruD7bAAgb7ADcd0Urx+Cvae
=jwYI
-----END PGP SIGNATURE-----

--nextPart2173250.yWbRqrjftP--
