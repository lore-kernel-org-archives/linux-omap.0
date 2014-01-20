From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 0/6] N900 DTS additions for 3.14
Date: Mon, 20 Jan 2014 16:59:51 +0100
Message-ID: <20140120155950.GB17118@earth.universe>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:38427 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbaATP74 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jan 2014 10:59:56 -0500
Content-Disposition: inline
In-Reply-To: <1389475023-11616-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2014 at 10:16:57PM +0100, Sebastian Reichel wrote:
> Here are a couple of additions for the Nokia N900 Device Tree
> Source file. All related drivers changes are queued for 3.14
> (except for the tpa6130a2, which got merged into 3.13).
>=20
> I may have some more additions if the driver changes for the
> accelerometer, the touchscreen or the wireless lan chip will be
> queued up.

ping?

Also it seems, that for_3.14/dts branch on bcousson/linux-omap-dt.git
merged some branches, which Tony no longer intends to be merged for
3.14.

-- Sebastian

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJS3Uf2AAoJENju1/PIO/qaDcgP/iphWFKVVTOlnJ994CJ9rdvz
pr/HbW0ERTSMeZ3OP/LNK9TFrwS9i+aExn2CXHGKkYPYEG/iaFj1BvjirT7QO5hN
XqBM/evwqQNGO4cSVCGbBh2Eekwq9YQmOQiESC4fte3XlA7dGCy3hwOSDcFHJMoD
vOb7K4gdI0+0YN9sEx6jyYiL74z6PSJyTBrAhzHE0gyYNCh5strGcu9H/2y6LOhn
WUvbgmSJ2MRH67uX6SDT7YwTgrB32CZU+kEv4qFX/z/t3u550mi4kk0NazO7TLrc
4IQHvJUIWFy68Dwebm9JdfvYkwQaQYSIIKcsb2mbRnu5/NAZfECxALX/c30D6q0m
ZtUsd8iT9pdwZRvj/tbTNQFcTcVhJZC+DejFVBK9qlsrqBUFp8OUqjQ27KAp6lk8
E+s+bbfzIJkob8315Pqqq/4E/n4f60o3kvZXW7wSAdY1FkrgjEgigeEkev2AO59j
nWrVoXcwuEHqRjAs1oYw9Et36dwn7ALDfAY9aqpdU32rx62+4+H4si4zgcrv/SPy
SjRjttpJszfrNLZ6XB2YfYzSXhI3Iwq8wASbkvfeAlSniVLL3b9Y4Rls4IyXf5e2
kcZvHg1QjDFCcD25vMANwl2jR94lSlppacIjHULigXwDpmcct/RtRUJVraZDXRAv
Br9VQHlS5tMb2bgdHswU
=m6cS
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
