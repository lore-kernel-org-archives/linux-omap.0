From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: DISPC: Fix 34xx overlay scaling calculation
Date: Tue, 14 Jan 2014 10:11:41 +0200
Message-ID: <52D4F13D.6080905@ti.com>
References: <52D3C3EB.6000104@ti.com> <1389630782-1764-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="O6uWwefHnelruFMtc7dAKkitVAUjAWiXd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54374 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbaANIL5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jan 2014 03:11:57 -0500
In-Reply-To: <1389630782-1764-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: archit@ti.com, plagnioj@jcrosoft.com, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>

--O6uWwefHnelruFMtc7dAKkitVAUjAWiXd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-13 18:33, Ivaylo Dimitrov wrote:
> From: Ivaylo Dimitrov <freemangordon@abv.bg>
>=20
> commit 7faa92339bbb1e6b9a80983b206642517327eb75 OMAPDSS: DISPC: Handle
> synclost errors in OMAP3 introduces limits check to prevent SYNCLOST er=
rors
> on OMAP3. However, it misses the logic found in Nokia kernels that is
> needed to correctly calculate whether 3 tap or 5 tap rescaler to be use=
d as
> well as the logic to fallback to 3 taps if 5 taps clock results in too
> tight horizontal timings. Without that patch "horizontal timing too tig=
ht"
> errors are seen when a video with resolution above 640x350 is tried to =
be
> played. The patch is a forward-ported logic found in Nokia N900 and N9/=
50
> kernels.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Queued for 3.14.

 Tomi



--O6uWwefHnelruFMtc7dAKkitVAUjAWiXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS1PE9AAoJEPo9qoy8lh71e/sQAI5vRwNpZcOoKZA1zhFXRbT7
NRruVYIiHrUQ9vOGq3UBidic/R5JXrmXXgFbcHoU/MHPVCGhXDWVonEGV8I5UARZ
EHSFtoFgdUlaCDZVxNEi1I2VDR3X+t/4AEQpsQNuXZyFvfawDGCQIW5ApVdcGHpK
qXvAJIZyIV+cYa4jqPZKA/JPezUVsTTzTaA4C1epu+z5VdNCRsj2Tldwb9h55Iwf
Q0DET4oVYn9LqogC2Q/lCAMkkIyQd8au6VCdCzc8J60NJ49b0kHyN+JoFatxymbk
xaHA5/U3T0MikHgnRXsPs41pdVQ3vT/tSHuYBKNWkS3ikG7ZQqmjg+U2wIJ8ZRXP
C9czaIpGT+9pKBoZhyOQJ0K3NJI7N4ktBr4VbdsrI9l+ViFF1LSa6MdI5jhJU9Mb
3CBgNmWmDavAuD/Q2IGLuqXn4l6qzbLrzqxt2x26wqcnsehaFF0koYIFh8JRNnuy
J0K6QxrZJ57fbPUNMbOW4FqOthKw2yr4AaWhYS7gyjSLRbaEAWuXNULqvUNkA3tg
PcFwaPgmuG0D2AhyQHOhMbQQusTwm0kOnJ8DS8xCvCg3gwC9ALYTMx7raE24WHFB
2EOHLGYR24X5qnQP6INC+l4MZsPlXbdChCIprNL3kJ7BVXpBktkgPnWWEyq5pW97
kv+eUiueUYuCbNjUy5tF
=40g7
-----END PGP SIGNATURE-----

--O6uWwefHnelruFMtc7dAKkitVAUjAWiXd--
