From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
Date: Mon, 11 Jun 2012 09:41:15 +0300
Message-ID: <1339396875.3632.1.camel@lappyti>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Nw9Zi4KpDK3vhDr2C5gu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog026.obsmtp.com ([74.125.150.92]:55643 "EHLO
	na6sys009bog026.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751431Ab2FKGtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 02:49:46 -0400
Received: by lahd3 with SMTP id d3so2867367lah.5
        for <linux-omap@vger.kernel.org>; Sun, 10 Jun 2012 23:49:35 -0700 (PDT)
In-Reply-To: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, archit@ti.com


--=-Nw9Zi4KpDK3vhDr2C5gu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paul,

Ping. These could be queued for the next merge window.

 Tomi

On Thu, 2012-05-10 at 13:21 +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> These patches fix DSS hwmod data related to sysc flags. I haven't seen an=
y
> problem produced by these missing bits, but by looking at the TRM it's cl=
ear
> that they should be defined.
>=20
> However, applying these will cause additional warnings to show during boo=
t:
>=20
> omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
> omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)
>=20
> Most likely the softreset fails even now, but as there's no check to veri=
fy it,
> no warnings are visible.
>=20
> I think the reason for the failing softreset is the same problem as we ha=
ve on
> OMAP4: dss_core hwmod should be enabled before other dss hwmods can be en=
abled
> (and reset).
>=20
>  Tomi
>=20
> Tomi Valkeinen (3):
>   ARM: OMAP2/3: HWMOD: Add missing flags for dispc class
>   ARM: OMAP2/3: HWMOD: Add missing flag for rfbi class
>   ARM: OMAP3: HWMOD: Add omap_hwmod_class_sysconfig for dsi
>=20
>  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   15 ++++++++++++++=
-
>  3 files changed, 17 insertions(+), 3 deletions(-)
>=20


--=-Nw9Zi4KpDK3vhDr2C5gu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP1ZMLAAoJEPo9qoy8lh71UNcP/1R9K0H1MbISwC+SZ84v1oBU
5VmrDiKZMs7hZ4R17MAdmnwX5qu5LnR3BzqsknPHbpriGKpWneCdoCWMpVdBkvc2
VdLKX1mOJA6jfTsFHDAw7gSSh2dmk9S+6BrvQ/u7+CRo94PaD6opJYTdgRLFBHJW
3UxXRTqkC/g1ZH7LArZ8W0KXCzTQidLYhr9e2CEsiqjWMun2oUTviUFhjr7lhj7b
5JQNH+6spxJn2kwA0UwnJ9C31tSC6Pt8nnn8/JP2s5cwqB0kXZyNqDuS6L6wd0KX
/MgMe9p3AKYIoviV6qauOOTNtXQPGwsRQkdBJ1/mTmdf16/5FZ58n0kj2W4+zXKw
C623yD928eSzU1DkQKeUpKSKrrh3oGzPKF+si59frSAtGlcfofgByqKesQQMnAur
anLeb15seZIpPCAsRTOU/b6nTsVbxSm8mZvFimYq7shCcVTe0Xu49IZIgvsFph4B
f4D8l2l+p5TQpbBj5r0S8T4m5C4aJqQXDtK5dTtUZGzoz6LzKWDrJgTK1/DQHXU1
H7LkGq1wX87NAM0W5+MoYVXE1A6wMeb7e8l7T8XSOY5LXicfNfzFk2TXDnDo/a/Q
fyao1wFstiasAxKmCTkf0aAvlxKK8Lnq7E4hGxESKvknHyqSG04LTuyJeQi1gvh3
wnivMlR96/YzWYDPA6dB
=B69c
-----END PGP SIGNATURE-----

--=-Nw9Zi4KpDK3vhDr2C5gu--

