From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] OMAPDSS: HDMI audio compliance fixes
Date: Wed, 3 Jun 2015 14:35:19 +0300
Message-ID: <556EE677.80000@ti.com>
References: <cover.1429705991.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KFfw2xO3QixkIFrBDWPkfq7h3NEWLJlD0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44382 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbbFCLfb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 07:35:31 -0400
In-Reply-To: <cover.1429705991.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, misael.lopez@ti.com

--KFfw2xO3QixkIFrBDWPkfq7h3NEWLJlD0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/04/15 16:22, Jyri Sarha wrote:
> I have rebased these patches from ti-linux-3.14.y on top of Linux
> 4.0.0. I tested them briefly on OMAP4 and OMAP5 in my environment, but
> I could not test any channel count beyond stereo. However, there were
> no conflicts in the rebase and each fix makes sense when looking at
> the chip TRM and the relevant HDMI specs.
>=20
> All the changes are really minor, but most of them apply to OMAPDSS sid=
e,
> so it is probably best to merge them trough there.
>=20
> Best regards,
> Jyri
>=20
> Misael Lopez Cruz (5):
>   OMAPDSS: HDMI4: Set correct CC for 8-channels layout
>   OMAPDSS: HDMI5: Set valid sample order
>   OMAPDSS: HDMI5: Fix AUDICONF3 bitfield offsets
>   ASoC: omap-hdmi-audio: Force channel allocation only for OMAP4
>   ASoC: omap-hdmi-audio: Fix invalid combination of DM_INH and CA
>=20
>  drivers/video/fbdev/omap2/dss/hdmi4_core.c | 12 +++++++++++-
>  drivers/video/fbdev/omap2/dss/hdmi5_core.c |  5 ++++-
>  sound/soc/omap/omap-hdmi-audio.c           | 12 +++++++-----
>  3 files changed, 22 insertions(+), 7 deletions(-)

I've queued these for 4.2.

 Tomi


--KFfw2xO3QixkIFrBDWPkfq7h3NEWLJlD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbuZ3AAoJEPo9qoy8lh71WksQAI6C1RFB5290+ShhQ0WWeSJL
JGnRKK6P6V9nOrMWNxV9RCU51I3vnmqHF9XiL2fSjZdjrnkuEBS6R61N4xx4r0FC
KBBibUi5PVZpul9mnLThEHpY4OC4KY1W02tUwtA0ONQYksr48nJic9tUPNQj2wcP
UZwRXAWNVlGfEpmeUu/7w25jQimxufDcTqq758Q0fxkvqGRp7KbcUH53/5ZknsfN
qNS43DaubK3OcQBl0ENrd/K1PAOIC5rnk8ntsNI6fA/KI2a2cjEpD9JZkkU71nzf
u+0wEI9TXxibQHA5i6oRaaYXflAHB/nnPG5qmWqQUQDcO9mKfsL5seUJ+q4JyVDw
/xqtinTsS4jL9Sf4ijcDEMRyRUsyMfnrMBszYBrj8XUDusTQVgE5GVI6Z/fWZt/q
/h+g3ajWjrFBKPEhuThC+Ozgef7XNgJE+8twxdkrVGpQTaGXycqj6HTzM7vKHxjH
E+YbW5GFX7PDxMqTrUOa3jYRiuOYQLINGL7ciQFn6lcwW0Egp8ZVYdaAuDCb9+en
3Fm+eiiI7LD63OIYCHqX/cKZdkGbubD4vFqklMR8TIULAmb6FudSWYHZzkDpnV5Z
c19+BmNweSZwLS3PVbPphSgKH6lAmx2PE35RBCpVeBqF/fr8soe2zCza5YA0KUp2
4yu5TjcY8+2/TSb4fNey
=V5s4
-----END PGP SIGNATURE-----

--KFfw2xO3QixkIFrBDWPkfq7h3NEWLJlD0--
