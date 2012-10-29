From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/20] OMAPDSS: add dispc_ovl_enabled()
Date: Mon, 29 Oct 2012 12:28:12 +0200
Message-ID: <508E5A3C.2000200@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-10-git-send-email-tomi.valkeinen@ti.com> <508E55BC.5060607@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC0940C6F384AA4CD40F77C01"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56525 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab2J2K2P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 06:28:15 -0400
In-Reply-To: <508E55BC.5060607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigC0940C6F384AA4CD40F77C01
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-29 12:09, Archit Taneja wrote:
> On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
>> Add new dispc function, dispc_ovl_enabled(). This returns if the overl=
ay
>> enable bit is set in the registers.
>=20
> Is this function used by omapdrm? I can't see it being used in the late=
r
> patches.

Yes, it will be used by omapdrm (or, at least, it can be used). I guess
some of these patches don't quite make sense without the final
compat-layer work, and modifications to omapdrm. But mostly the "doesn't
make sense" parts are probably just exposing functions that aren't used y=
et.

 Tomi



--------------enigC0940C6F384AA4CD40F77C01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQjlo8AAoJEPo9qoy8lh71xkoP/iRJ5phab32ZcU6dRovTo9qR
L5kZJcXpiEQzG9/71O3PcO0rziXilxsFuyEpIIzEMFNctuo6zHLuKK0MbxpusxYg
VWxHOkWy+s0MLY8rSBY8eH2yZWAiXj26Af6CmR7T+xn08xIfKNCp+NOr2PMfIFHe
GHactQtTyIvPSgUoWEoMnFiKsd15ILTl1id1ECHKRLxqFyYtoREsQZqH7faa5mik
nyPO2THtmf2Wg/yXPTyZ/wO0cW5P12oEVh76GZEpwemyueqS2RrThcNG+/pCI8+c
dnf5H5KLhglKBL6xygjkNX0eb9UKt8UvqN4aJXxvy2qEYfsktoF8HxVC2NRbls5V
jMVMVtGssavBrFbPTwzvsDv9ANyAsWOb8abAOQWwOlJhvaPDPpsy2NCyYRs5Kae5
AlzcnMBZjNPVE6SKVpDe15NBpvVUF8Pjfm3/JDPIbx2rLuAiT/RvQzAco5bgNglm
ikTjlFMzPq3C8LMiCqFYc7/CBjp1DB/xAoW62aDLeX7ArYOuqIaZqdxFUulY8aa7
3dEhRG+jzwOuWu5qosRd+VjdDQ/3m8RSkYvE5p85F5LbM0BhR2wtXB0ZOLeEv9aV
ElvtZNWZhsDV3+xalMR0CMbKUcIgmgLq5vi+9Cs2n9J+LRNG4lXYI5kPurJ6qJoy
AQM9ZZWWgAlXKxpniqby
=zDw7
-----END PGP SIGNATURE-----

--------------enigC0940C6F384AA4CD40F77C01--
