From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 16/23] ARM: OMAP4: omapdss: remove legacy pad muxing support
Date: Thu, 27 Nov 2014 18:09:49 +0200
Message-ID: <54774CCD.5060600@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-17-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vLk8wX4giKTxRrPu6UKu6H9HNVnJobKOL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39313 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbaK0QKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 11:10:23 -0500
In-Reply-To: <1417103514-17027-17-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

--vLk8wX4giKTxRrPu6UKu6H9HNVnJobKOL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/11/14 17:51, Tero Kristo wrote:
> OMAP4 is DT only now, so the legacy mux support is not needed anymore.
> Padconf is used instead from the driver / DT. This removes the need
> for having the mux APIs exported from the control module driver.

We still use those mux functions for DT. The mux registers for DSI are
so funny that we can't use the normal padconf for them.

I did do some work to use syscon, but I never had time to finish it.

 Tomi



--vLk8wX4giKTxRrPu6UKu6H9HNVnJobKOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUd0zNAAoJEPo9qoy8lh71TbcP/0MnAtLTZl39JW6aIGptGFQw
W8tZ/pvnu3ZzV7z2192mvxFOtRU+mtzgGku47b2qz2+uEroyYHyztqO0fLa3h3wz
sHAG0bckxc/6vFXxy/NZZoJzXrCv5qZ7dCdJ49uY1C7Nw3RH7zDdlK1B75CdgEFL
C083U2EpNthTNYgok6AHgi23SDMe7poHdq0vSzBzotwnX/oRM/zsF2uy+Q6JWzN3
+8NCzNQdCIcw7pJPne3ZgSpktBndpsxzWxUvOcY+IY9+t0gmo6VhJPjCqWNX+esP
V2/LIRr+Sj4/XUXbJFEShqZ1pGmdnD0FbM7gA83d/VcdTOurVf/22IpclyMYxZLf
rUFeqJX2z967PJhFHl8jWD+dh4vY6VubsSq1Hw/dA+VJVuMD+6VByBM1JDosXR86
/ZmRjrcr7UFJ1PMKJnHjSe7X2sNE9jy5kG4JkpZdu1gyXlg+jlr44IaqViCgcmF2
NbcUksRPwF5b0vH6GnD2fRRFL8Dl8qBP7rxm72OlB2KT4/I9GPf4uQVFsQIPlOh2
neqp6//NtljDHZfc7TP0qhsDs79ZeDD4Ul1B/v03e1avbIVpXIi+4nd0llg0VqIH
5mqSz5yNPmuVwp630sY+/SExsF3N1tV1b7ktvsFerh8AiMF0ngV8Pw7NMhAJ80HV
v1W0c4wtqg58vA6gI4K3
=zBvH
-----END PGP SIGNATURE-----

--vLk8wX4giKTxRrPu6UKu6H9HNVnJobKOL--
