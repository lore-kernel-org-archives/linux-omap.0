From: Sebastian Reichel <sre@debian.org>
Subject: Re: 3.11-rc1+ multiplatform kernel+dtb pandaboard issues
Date: Thu, 22 Aug 2013 02:25:59 +0200
Message-ID: <20130822002558.GA9933@earth.universe>
References: <20130821154321.GA26531@redacted.bos.redhat.com>
 <20130821194143.GE26531@redacted.bos.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:40500 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab3HVA0G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 20:26:06 -0400
Content-Disposition: inline
In-Reply-To: <20130821194143.GE26531@redacted.bos.redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyle McMartin <kmcmarti@redhat.com>
Cc: linux-omap@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 21, 2013 at 03:41:43PM -0400, Kyle McMartin wrote:
> On Wed, Aug 21, 2013 at 11:43:21AM -0400, Kyle McMartin wrote:
> > I've suspected there might be a config issue, as omap2_defconfig
> > works alright, as does booting a uImage with an appended
> > omap4-panda.dtb, but there's no love with a zImage + initrd + dtb
> > (or even just zImage without initrd + dtb.)
> >=20
>=20
> after some further investigation, something odd is going on... turns
> out things have been working (at least until initrd time, but that's
> another story)

The initrd problem may be the same error I got, when I tried to boot
an OMAP DT kernel with an initrd file (I had no problems with kernel
arguments):

http://www.spinics.net/lists/linux-omap/msg95504.html

-- Sebastian

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSFVqWAAoJENju1/PIO/qamPIP/2f2qBwcWPVyCAzUl8OzH+Gd
oNMGug6uOzyLgGRqZ6ogRm3VrpXtT1y5Hj3/EGL+gSbuxYkZypzYwF2retIkZjOu
OE6tBEME4+cOGGlmRncFaZsGmaKXUAkNKvBJDGvkdAC5ovjShWEe34X25ujr57qs
uGQD9ZQ5ZsEddy6ihnPSp3NhGY6MZ55d3Xg8104ldZcTVFFDA8nmmEbPetFokwSL
6J4CdP3WdiJ3jrjpHsOxvEfMtlf9j/gahDzw2/cK9kFOAnES16P8oUrBFHGWwbkO
9/GoOuOZh33YRESYHTvCujP7fgnK6yzopQEsdHC4WXmht2HWFeRugXxaXkMgOhio
CbNHsVp9DCPpkG/41ZwBImjtdD4ecrHdBOldKwOWOd88Se/ZfWImNc0OI5Vi/GUM
+LRi6DpbNzned5z3JnoMepVZFHG1HbFUwrT0vtY/6yJX9nmhM4JAKls2KC0aBb5S
4iIZ8y5HUdQ2n2Zlx6AJimHwhCxvXL8xbsWnQK7Nth1EdElUKLPjto3f2avROsKS
MrsFSn13PVpUYoIL7r1tefjUCEjib46h2qazbtKoJQCutzYUe+12H4jFQ4w0zh1Z
gdoYnUscLSjGr5Xg3Pz49QYEy6AKif1cxFI33uIHQ8PTJ/JUM14/AJkA/y9a08ch
H92+RJ2c2wlOkGuoR4r1
=hphF
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
