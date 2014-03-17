From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Mon, 17 Mar 2014 08:13:59 +0200
Message-ID: <532692A7.7000509@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fSGM1UABo14S9qd8Inn0GSUc5hoJtMUp0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbaCQGOa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Mar 2014 02:14:30 -0400
In-Reply-To: <53258DDA.50005@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--fSGM1UABo14S9qd8Inn0GSUc5hoJtMUp0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16/03/14 13:41, Dmitry Lifshitz wrote:
> Hi Tomi,
>=20
> (resending in the text format)
>=20
> Where can I get those unpublished omap5 and omap5-uevm display patches
> to test the video out with this patch?
> I'll appreciate your assistance in additional setup (like required uEvm=

> .dts changes and DSI panel connection short guide).

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
work/dss-dt-pyra

I've since added omap5 hdmi support, so omap5-uevm's hdmi output works
on that branch.

 Tomi



--fSGM1UABo14S9qd8Inn0GSUc5hoJtMUp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJpKnAAoJEPo9qoy8lh71UeEP/2lHsKAVwkAYBlXqaidsurNc
b2z0ZS+x4IE1MoPRwDUVBjjedOZC5mKkZ1zzj2FujXqbgqyWXDXrFyJjf/B5f3ga
1DBtSQcOZJWFacOpVbpL2p0Txsd+OjlqsC97OYNYoCxRmVS6N1A4rsCYYMrLy+rA
tYShrRC5s3fkL0tZKvORGY/66Rfrd6MAAHL8cJbvAO9A01e+589/46oYOA6r6Nry
4V59fbcBB510MOmkCz9e/Ko1tNvGF5kwFxNYJcAcQgFanbkplElMnECs5yVNKKOl
mYnlzvEVO07OKebDs+XWS1iZPI0iWgi7i418Zx7+AbrIGgDooLOPZ+0Fr+RilJw6
TmnbJGqx/2dTz3NrJnXcwTzNg+KQrjlXu2XPGjXxvQZVIyiUidF/SZ7Mwkx8fKQp
PlIdOKeMm/pHLk7m+NseHIPidHGggv2rEP5z32lPT38rzXHyyAl7YcHNZQhr+kJX
LWATtZdR8CnRlakmHGZVygRd/e96sx0A5JLDDi15881K5w3M9yHHOpAB9Is1isnG
pTk5jS9V9zF21W25CjRI5DwOSsVfuP+QLbWZOlVuRZHlzTJsNn47SHgB8v0/4mCp
braaTSoBktUqnDGEqCHTH0sNozKX95YdDGv0lGNstmC9hG+I9udOcRKc03r9eRhu
S6nwyKPylp0hsNC9ZptJ
=ZkC3
-----END PGP SIGNATURE-----

--fSGM1UABo14S9qd8Inn0GSUc5hoJtMUp0--
