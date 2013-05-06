From: NeilBrown <neilb@suse.de>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Mon, 6 May 2013 12:40:11 +1000
Message-ID: <20130506124011.7e4c2806@notabene.brown>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
	<20130502082218.GA21614@n2100.arm.linux.org.uk>
	<20130502153834.GR28721@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/DH9uujlTyLvZqlq4N==Ua.w"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33629 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab3EFCkd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 May 2013 22:40:33 -0400
In-Reply-To: <20130502153834.GR28721@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Eduardo Valentin <eduardo.valentin@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/DH9uujlTyLvZqlq4N==Ua.w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 May 2013 08:38:34 -0700 Tony Lindgren <tony@atomide.com> wrote:

> > drivers/power/twl4030_charger.c: In function 'twl4030_charger_enable_us=
b':
> > drivers/power/twl4030_charger.c:192:20: warning: ignoring return value =
of 'regulator_enable', declared with attribute warn_unused_result
>=20
> Neil, care to provide a fix for this? It's from your commit ab37813
> (twl4030_charger: Allow charger to control the regulator that feeds it).
>=20
>
This the sort of thing that might be appropriate?

NeilBrown


From: NeilBrown <neilb@suse.de>
Date: Mon, 6 May 2013 12:35:59 +1000
Subject: [PATCH] twl4030_charger: don't ignore regulator_enable()

regulator_enable() doesn't like being ignored.  If it does fail there
is nothing we can do except not set usb_enabled (which is necessary
else a subsequent regulator_disable() will be unbalanced).

We cannot usefully return an error here as errors from
twl4030_charger_enable_usb() are ignored.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charge=
r.c
index bed4581..8b0ec70 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -189,8 +189,8 @@ static int twl4030_charger_enable_usb(struct twl4030_bc=
i *bci, bool enable)
=20
 		/* Need to keep regulator on */
 		if (!bci->usb_enabled) {
-			regulator_enable(bci->usb_reg);
-			bci->usb_enabled =3D 1;
+			if (regulator_enable(bci->usb_reg) =3D=3D 0)
+				bci->usb_enabled =3D 1;
 		}
=20
 		/* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */

--Sig_/DH9uujlTyLvZqlq4N==Ua.w
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUYcYCznsnt1WYoG5AQLoWg/+JBjm6yNBIB6WyBfBRPaKwJHI1B6+yCet
iIy7eLK4Ely4VWOJdjqf5vzFcHKTeOEczo6r/Lng98rDWtJZYLJOvCM0rXPhc2d+
0OhIlKg4ZLB2vKGPslzNJlgjFoA5zC/lteCUjn7CAbYi8eJr/0UcL1ZjXwdzSkQr
YRjMDhjxYD4PAmBohGqjSsD9bAVUgQ292xN7B3eKleU8kjhdWx/I+cp/7nf4hkLF
d82pnIJ02/zeBKxGC8VxDcLOb77Tj5p783zuFezO67dXsa2r2EDFQ5QclYd3kYyo
si824aH/HX7Z7LuetrDZbLMYudqR+kQbvzXmRk/mv7FcgJ+o3FaN2YTjECvqk4fC
U4x9vTayW5R/MdUWMvZUSmea/gJN69ZHiKShLymZQE1C1t2g4ipRfacoS72MxUKh
L6qfN+OOY7xKm6LqUMBoVRf4PcZvQ8Cl+Ft2ZkeCINTmEK9HZ+sVz9QbeQnSQ9sS
iFGQ/9l0p9INHQKUMUaugHth2HFG89R61pqKS8Jv+lyO2IZccIovNuisSZu5eEup
hODOZJcEB9JKa/81+xkO8ZgUdDWWtn9v0lt8IAJ/cbIBQBtuVPdbxbOPRbWieyZN
KVN7F7uNEeD0JuMI5VPXSNLjZKSvqh/4GxeY6KAyY+rC6lZoVgbc3w+ak4Ej0s2W
/Ciyrxq0SqE=
=P0hp
-----END PGP SIGNATURE-----

--Sig_/DH9uujlTyLvZqlq4N==Ua.w--
