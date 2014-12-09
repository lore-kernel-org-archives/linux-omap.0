From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 0/7] arm: omap: move more HWMOD data to DT
Date: Tue, 9 Dec 2014 16:30:14 -0600
Message-ID: <20141209223014.GE25857@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45116 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbaLIWam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2014 17:30:42 -0500
Content-Disposition: inline
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2014 at 04:27:45PM -0600, Felipe Balbi wrote:
> Hi,
>=20
> here's a more complete series showing the out of debugfs interface.
>=20
> So far only AM43xx has been converted and only those HWMODs which
> play well with DT and/or are not common with other OMAPs/AM33xx.
>=20
> I plan to work on AM33xx tomorrow, but this RFC shows what we can
> achieve WRT HWMOD static data reduction.
>=20
> As you can see, with AM43xx, data reduction is quite minimal, since
> it reuses so much from AM33xx, but well, had to start somewhere.
>=20
> All patches were boot tested with AM437x SK on top of:
>=20
> commit 1ca7c606de868d172afb4eb65e04e290dbdb51ff
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Thu Dec 4 19:49:10 2014 +1100
>=20
>     Add linux-next specific files for 20141204
>    =20
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> cheers
>=20
> Felipe Balbi (7):
>   arm: omap: hwmod: add debugfs interface
>   arm: omap: devicetree: add new properties for OMAP devices
>   arm: omap: hwmod: drop 'const' qualifier from omap_hwmod_class name
>   arm: omap: device: add support for generating sysconfig data from DT
>   arm: omap: hwmod: allow for registration of class-less hwmods
>   arm: boot: dts: am4372: add sysconfig data to all HWMODs
>   arm: omap: hwmod: 43xx: remove sysc and class data
>=20
>  .../devicetree/bindings/arm/omap/omap.txt          |   7 +
>  arch/arm/boot/dts/am4372.dtsi                      | 251 +++++++++++++++=
++++
>  arch/arm/mach-omap2/Makefile                       |   2 +-
>  arch/arm/mach-omap2/omap_device.c                  | 117 +++++++++
>  arch/arm/mach-omap2/omap_hwmod.c                   |  30 ++-
>  arch/arm/mach-omap2/omap_hwmod.h                   |  11 +-
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  61 -----
>  arch/arm/mach-omap2/omap_hwmod_debugfs.c           | 269 +++++++++++++++=
++++++
>  8 files changed, 673 insertions(+), 75 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_debugfs.c

btw, after removing all class and sysconfig static definitions, we get:

$ git diff --stat
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  44 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  70 --
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  42 --
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 188 ------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 370 +----------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  78 ---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 399 ------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  37 --
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 713 -----------------=
----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         | 469 --------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 488 +-------------
 .../mach-omap2/omap_hwmod_common_ipblock_data.c    |  30 +-
 12 files changed, 5 insertions(+), 2923 deletions(-)

--=20
balbi

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUh3f2AAoJEIaOsuA1yqRE8QwP/0yzwQ29lTahwB9aP33ZPXsg
JG2AgJqRakncKdeS0wYxVOlfSU2OmIMjws0//LViQ6/lSrrKFJ6hY5YfLb023h1P
liECWdCHMbg3b9cjNWXd2dqViu002Aidpo4w4TB/jDZNVGB8XWB2Iz02brdNDGWw
N0DN9GLGT3A7g6P1ySAUq5MO6piid20dMqmpIhJ2tDQwgqtI7eiVQ4p3KvMiSJr/
5zLZMx1t1HwzvFlgpwQ5nisLip0+S0bvMugRKQ0HJXTrE3IoFr6abbfTtqqd1clp
o+BSjyx77qlFQOjkZ+crwDBfbl/b/c4ddvMaz0yjlsuvsaK60SLyIuebAcTmNe/M
HUNM5+9ftgASKVerJ5ZlRGA76fFAqCraN1Xd8LEsQX4rsh+kKnPPabHxlpFhXTPS
q9m1cXTYA1KOQ3UtZMr2i/TMrJVNoNvNxIe0qOHsn4PCAoZ1WpdslnRvdrIBIiml
TvFMIDhqmfOXVPJCrdPTb8Dp8Wrz8X2ONadXzx7IvOrgnUI4pxJqjeHSsc5eDkBA
8lH7Ko1gm2Jc1orIIdBgn15GgyPszW1IhGUZVgUYI05aymvwdKp8/NLlQNlek4fk
Wn6A4StbeKqI4lgHf10Phgp842BEsBg9jlbeK7klwaISTW5CqoGB4faI2KBnsNbw
+dhbs/N9NA6MLLBcuS44
=mb96
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
