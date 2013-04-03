From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Wed, 3 Apr 2013 12:36:58 +0300
Message-ID: <515BF83A.7000108@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE2AFA5B1ECC6BC2E60D0EFB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53917 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758952Ab3DCJhD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Apr 2013 05:37:03 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

--------------enigAE2AFA5B1ECC6BC2E60D0EFB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-03-28 14:48, Tomi Valkeinen wrote:
> So here are the DSS related board file changes for 3.10.
>=20
> First there are a bunch of patches adding the Kconfig options so that o=
nly one
> display device is created for a single video bus. Only Overo had more t=
han two
> displays on the same bus, but unfortunately there were multiple boards =
with a
> setup that puts an LCD and DVI output on the same video bus.
>=20
> So the ifdeffery is not very nice. But, as discussed, this is the best =
way
> forward, and should be seen as a temporary solution until we get full D=
T
> support.
>=20
> Then the rest are converting the old omap_dss_device style displays to =
platform
> devices. Only TFP410, generic-dpi-panel, HDMI and Taal drivers have bee=
n
> converted yet, but those seem to form the bulk of the display options u=
sed.
>=20
> This series can be found from:
> git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/1-arch-dss
>=20
> These patches depend on a few dss header file changes. These header fil=
e
> changes can be found from:
> git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers
>=20
> If this series is applied without the relevant omapdss changes, everyth=
ing
> compiles and the boards boot, but the converted displays do not work. T=
he same
> happens if only the omapdss changes are applied, but not this series.
>=20
> The related omapdss changes can be found from:
> git://gitorious.org/linux-omap-dss2/linux.git 3.10/3-dss-dev-model

I'll drop these patches and the branches mentioned above, as I don't
have a solution to the multiple-displays-per-output problem. I'll
continue looking at this, but it surely won't make into the next merge
window.

 Tomi



--------------enigAE2AFA5B1ECC6BC2E60D0EFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRW/g6AAoJEPo9qoy8lh71XwQP/1skfB+jd9weYG5DaJ0aidMI
nRVyHD8JJKnGnhU5nxslMImer4u6Iu1B7xZ/Bnau8gb6hyKjmaVdNnH3NS5qP1Zm
VR4yX/BODfJg7o6lULFkSvjYsK4zULXXOR93DFIvW+u9Cz7puznNi+Yz79hWBBnw
87ogSoVVlGLMNU5zJCPUxBDYGF23VelgsBFI5QorIlCk1AJHSozfoYyNqXz/fTvZ
PrEa1qSqQ8Yzg+CWtY1THqs64VUGXnMXEC8Xkp+50UL1vANcHq/bAIXWU2EP0P2F
v+qO0MyVmJknhvgP54K06Ue+6wKDceJ/VokeCQ6Ut196CS7NSMep4tb4/PcQtZ9N
kYce/5I91ZtjNXjGpwR0xqOet/HvMgyEIeFKGboRy+icWUdcJqz1EH4GbCxX8A6M
JWBgxczVGNXZonHrvDKAzNDD5rxjcwSaREd6R9Jnh4C8yBVMP2igGbNwmzj82poh
FYvXbyy7vTC5O92eZnbwIrxnik3uOneJyDY0jiT4MwoLOpOQ1x9EuJFLB0J7jCk4
p87SMI7GSqdV9OJ1Oi4WFEWimpPGpA0SoBGgzbzK4Yd0wi41gwYV0HScIXXnNJuC
xsp9LGBbfZKez3wrSK5hURnx9LQSmginvoCFYSTSXHYBx9UAu9Gt+O6cLffHTXjE
mnQJHM3WwUXL0IJpNQuz
=U4Vx
-----END PGP SIGNATURE-----

--------------enigAE2AFA5B1ECC6BC2E60D0EFB--
