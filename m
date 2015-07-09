From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: musb-hdrc: "Vbus off, timeout 1100 msec" message does not belong in sysfs
Date: Thu, 9 Jul 2015 23:54:36 +0200
Message-ID: <201507092354.36649@pali>
References: <20150709213922.GA32698@amd> <20150709214610.GA20890@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart31235275.TegAg5q0Su";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150709214610.GA20890@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, balbi@ti.com, bigeasy@linutronix.de, george.cherian@ti.com, tony@atomide.com, varkabhadram@gmail.com, linux-kernel@vger.kernel.org, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

--nextPart31235275.TegAg5q0Su
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 09 July 2015 23:46:10 Pavel Machek wrote:
> On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
> > Hi!
> >=20
> > sysfs should contain one value per file. This one has at least two,
> > with nice english sentence as a bonus.
> >=20
> > root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/mu
> > sb-hdrc.0.auto# cat vbus
> > Vbus off, timeout 1100 msec
> >=20
> > :-(.
>=20
> Plus, documentation for this is nowhere to be seen:
>=20
> pavel@amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
> pavel@amd:/data/l/linux-n900$
>=20
> ..which is a shame, because it is not really clear how to use this
> one:
>=20
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# cat mode
> b_idle
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a_suspend > mode
> -bash: echo: write error: Invalid argument
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a > mode
> -bash: echo: write error: Invalid argument
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a_host > mode
> -bash: echo: write error: Invalid argument
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo b_host > mode
> -bash: echo: write error: Invalid argument
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo a_idle > mode
> -bash: echo: write error: Invalid argument
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto# echo b_wait_acon > mode
> -bash: echo: write error: Invalid argument
> root@n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb
> -hdrc.0.auto#
>=20
>=20
> 									Pavel

Hi!

I remember that this file is used for switching between usb peripheral=20
and host mode. But because n900 HW somehow broken, for usb host mode are=20
needed couple of "hack" patches which workaround HW bugs... This is=20
still not enough and "support" from userspace is needed for it too.

Kernel patches are part of Maemo kernel-power 2.6.28 version and with=20
package usbmode http://maemo.org/packages/view/usbmode/ is it possible=20
to enter usb host mode on n900 (and then connect e.g. usb stick).

And IIRC correct command is:

# echo host > mode
# echo peripheral > mode

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart31235275.TegAg5q0Su
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWe7ZwACgkQi/DJPQPkQ1K74wCeJUmg2JgXPaA2dE4TyVLIlV8n
qj4AoMQm3fdkgjK5bM7TubMm/YWm553T
=sWOg
-----END PGP SIGNATURE-----

--nextPart31235275.TegAg5q0Su--
