From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH 0/6] ARM: OMAP4+: hwmod: fixing omap4+ DSS hwmods
Date: Fri, 14 Nov 2014 10:51:48 +0200
Message-ID: <5465C2A4.3060901@ti.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="MtrwpBP7gUt1J5PdGSPRpwMxKOeOWI9v0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbaKNIwC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2014 03:52:02 -0500
In-Reply-To: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>

--MtrwpBP7gUt1J5PdGSPRpwMxKOeOWI9v0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 09/10/14 17:03, Tomi Valkeinen wrote:
> This is an RFC to fix the issues with boot time DSS hwmod setup.
>=20
> There was an earlier series sent by Archit here:
>=20
> http://www.spinics.net/lists/linux-omap/msg107700.html
>=20
> This series takes different approach, and just tries to fix the issue a=
t setup
> time by making sure the DSS core hwmod is enabled when a DSS submodule =
hwmod is
> being setup.
>=20
> Quickly tested on OMAP4 Panda and OMAP5 uEVM.
>=20
>  Tomi
>=20
> Tomi Valkeinen (6):
>   ARM: OMAP2+: hwmod: add parent_hwmod support
>   ARM: OMAP5: hwmod: set DSS submodule parent hwmods
>   ARM: OMAP4: hwmod: set DSS submodule parent hwmods
>   ARM: OMAP4: hwmod: use MODULEMODE properly
>   ARM: OMAP4: fix RFBI iclk
>   ARM: dts: omap4.dtsi: remove dss_fck
>=20
>  arch/arm/boot/dts/omap4.dtsi               |  2 +-
>  arch/arm/boot/dts/omap44xx-clocks.dtsi     |  8 --------
>  arch/arm/mach-omap2/omap_hwmod.c           | 22 ++++++++++++++++++++++=

>  arch/arm/mach-omap2/omap_hwmod.h           |  1 +
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 25 ++++++++++++++++------=
---
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  5 +++++
>  6 files changed, 45 insertions(+), 18 deletions(-)
>=20

Ping. Would this series be acceptable?

 Tomi



--MtrwpBP7gUt1J5PdGSPRpwMxKOeOWI9v0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZcKsAAoJEPo9qoy8lh71CVIP/08ZWTap2uELhG+PKGIM984A
VcFCWhjOOJGhSSwpf3gNvsbqy8oze/BvM/ZxBfUYvvduJK5xLv6TXjr2ACPgr322
JZH+1XpJs6PzCyE7unCaui54YtyKyD+vc0TppEPsF0Plnh8tnwxZyjwJ2MGzWikb
ReGRUvveiavdXSWv49I1XdGCmdq7rOHTFJJqtbQWRDC61KtGOZL5wGAniGBPKEmM
B6Sy96E7J/enw3m0FEjNLZzrtw7r439z3lLRGqNYQajHKSN2VlM0daJIEXAFsrDK
2jKqGankN2UaLM2qOoL7eqNBdWgTqV7MZyiFvqJGZ8TzP8uu2a3iG3XKPbalTlMH
/p4zMEa2zlkfO7Rm3hxbMJAVAsjVvOlutrLiLy6iD/axsAijXdTZHRzKkKYuDvDt
5LBo2a4TkOTF4uxWyEWq+d5wuSAjj1h7RrwLsdXuKy//IqvwomN1qmUI8r/qQllw
pb6iuCsGWOYcoAkPkQvEX5T1pHl4D7ImJ2wRS+LngboZVNmnYbRMUlAP7a4Dx59g
zsiSxhVzVo8mdUT1vBrpmLKLKpN/jV6ogKH5H05AykG0swMfeOwYrl2es6i74Xvp
U9QYW75G0LlHst+08VgfjsiPuZ7KkvWCFbs2rz8jdZrqvN08tTGEgfHFVq/Kp4jK
Acf7P7+sKTDPhMMfIP8E
=v7iu
-----END PGP SIGNATURE-----

--MtrwpBP7gUt1J5PdGSPRpwMxKOeOWI9v0--
