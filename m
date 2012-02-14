From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/16] OMAPDSS: old OMAPFB cleanup
Date: Tue, 14 Feb 2012 13:52:23 +0200
Message-ID: <1329220343.1845.65.camel@deskari>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tQ+yPTMpVogF2sJAh83r"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35393 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619Ab2BNLw2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 06:52:28 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, archit@ti.com, linux-omap@vger.kernel.org


--=-tQ+yPTMpVogF2sJAh83r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, 2012-01-24 at 12:00 +0200, Tomi Valkeinen wrote:
> Now that all omap2+ boards have been changed to use the newer omapdss dri=
ver,
> this patch series removes omap2+ support from the old omapfb driver
> (drivers/video/omap), and thus makes it an omap1 dss/fb driver.
>=20
> The use of SRAM for video ram had earlier been disabled by removing the S=
RAM
> allocation (fee926bb0d399b1eaaf38f9f694bbf2747c4b8a2), and now this serie=
s also
> removes the support from the omap fb drivers.
>=20
> Also various cleanup patches allow us to remove remove OMAP_TAG_LCD and
> OMAP_TAG_FBMEM.
>=20
> All in all, the series removes quite a bit of unneeded code and cleans up=
 the
> links between the board files and the display drivers, and this should he=
lp
> with device tree adaptation.
>=20
> Some of the patches affect the newer omapdss and omapfb drivers, but most=
ly the
> patches deal with omap1. I have compile tested the series for both omap1 =
and
> omap2, but I have only tested this on OMAP3 and OMAP4 boards, as I don't =
have
> OMAP1/2 boards. I think N770's display won't work after these patches, bu=
t
> other OMAP1 boards should be ok. To fix N770's display requires knowledge=
 of
> the hardware setup, which is currently passed from the bootloader.

Tony, do you have any feedback on this? I think the arch/arm changes are
quite clean as such, but are you ok with (possibly) breaking N770's
display? The other OMAP1 boards should, at least in theory, work as well
as before.

For N770, the bootloader passes the reset GPIO number and number of
datalines, and I have no idea what those are.

 Tomi


>  Tomi
>=20
> Tomi Valkeinen (16):
>   OMAPFB: remove old blizzard driver
>   OMAPFB: Remove OMAP2/3 support from old omapfb driver
>   OMAPDSS: Remove video SRAM support
>   OMAPFB: Remove video SRAM support (old omapfb)
>   OMAP2+: remove unneeded #include omapfb.h
>   OMAP: N770: remove HWA742 platform data
>   OAMPFB: remove unused omapfb_set_ctrl_platform_data()
>   OMAPFB: remove early mem alloc from old omapfb
>   OMAPFB: remove mem info from platform_data
>   OMAPFB: remove unused fb_format_to_dss_mode()
>   OMAPFB: Move old omapfb private structs to a private include file
>   OMAPFB: remove omapfb_set_platform_data()
>   OMAP1: pass LCD config with omapfb_set_lcd_config()
>   OMAP: Remove OMAP_TAG_LCD and OMAP_TAG_FBMEM
>   OMAP1: Remove unused LCD devices from board files
>   OMAPFB: remove remaining OMAP arch checks
>=20
>  arch/arm/mach-omap1/board-ams-delta.c      |    9 +-
>  arch/arm/mach-omap1/board-fsample.c        |   15 +-
>  arch/arm/mach-omap1/board-h2.c             |   15 +-
>  arch/arm/mach-omap1/board-h3.c             |    9 +-
>  arch/arm/mach-omap1/board-htcherald.c      |    9 +-
>  arch/arm/mach-omap1/board-innovator.c      |   11 +-
>  arch/arm/mach-omap1/board-nokia770.c       |   19 +-
>  arch/arm/mach-omap1/board-osk.c            |   14 +-
>  arch/arm/mach-omap1/board-palmte.c         |   10 +-
>  arch/arm/mach-omap1/board-palmtt.c         |   10 +-
>  arch/arm/mach-omap1/board-palmz71.c        |   10 +-
>  arch/arm/mach-omap1/board-perseus2.c       |   15 +-
>  arch/arm/mach-omap1/board-sx1.c            |   16 +-
>  arch/arm/mach-omap2/io.c                   |    1 -
>  arch/arm/plat-omap/common.c                |    2 -
>  arch/arm/plat-omap/fb.c                    |  336 +------
>  arch/arm/plat-omap/fb.h                    |   10 -
>  arch/arm/plat-omap/include/plat/blizzard.h |   12 -
>  arch/arm/plat-omap/include/plat/board.h    |    2 -
>  arch/arm/plat-omap/include/plat/hwa742.h   |    8 -
>  arch/arm/plat-omap/include/plat/vram.h     |   21 +-
>  drivers/video/omap/Kconfig                 |   16 +-
>  drivers/video/omap/Makefile                |   12 +-
>  drivers/video/omap/blizzard.c              | 1648 ----------------------=
------
>  drivers/video/omap/dispc.c                 | 1547 ----------------------=
----
>  drivers/video/omap/dispc.h                 |   46 -
>  drivers/video/omap/hwa742.c                |   21 +-
>  drivers/video/omap/omapfb.h                |   25 +-
>  drivers/video/omap/omapfb_main.c           |   30 +-
>  drivers/video/omap/rfbi.c                  |  598 ----------
>  drivers/video/omap2/dss/dispc.c            |    1 -
>  drivers/video/omap2/omapfb/omapfb-ioctl.c  |    2 +-
>  drivers/video/omap2/omapfb/omapfb-main.c   |  101 +--
>  drivers/video/omap2/vram.c                 |   99 +--
>  include/linux/omapfb.h                     |   32 +-
>  35 files changed, 100 insertions(+), 4632 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/fb.h
>  delete mode 100644 arch/arm/plat-omap/include/plat/blizzard.h
>  delete mode 100644 arch/arm/plat-omap/include/plat/hwa742.h
>  delete mode 100644 drivers/video/omap/blizzard.c
>  delete mode 100644 drivers/video/omap/dispc.c
>  delete mode 100644 drivers/video/omap/dispc.h
>  delete mode 100644 drivers/video/omap/rfbi.c
>=20


--=-tQ+yPTMpVogF2sJAh83r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOkr3AAoJEPo9qoy8lh71lxwP/0M74uZfm3nwID8zSYwCohpe
2hr/q8T4IA/LePYdnjnYblBKuFPRse/+QWN8Kk5AHUOVLaG4c/1ZrF1oomgfrOW5
bDyuBYahLoqKxNk2bQ6Yea1517nDL3CeOTrlhL1RnfNLf6MnZRtF+lO9HY5hlxyo
FF+nXrTfJryEnQzdxAFnl8cwE2zkdflx+aZAN5VxP9MM5o/t7sbdSo9ZUALiiT5l
UinpB/L/5w8eM+7JoLM4RbE0gO6MTpiLLJnBeTDrZP5+ODlwicheRFS8uMJC9aUL
5hw92c0FPOsuWoLxyMUhB3EcxRYBoF/RZ8+YX6f5aifcUeIeBL3knqTcwxa4UmmF
l8JJSiZ9glLAt1CnRQkkIVYaqQjYsEHq76bjk8H5r4t8RrE/zAqt1YjpR5LXDNpd
Yklf8zD51fmtYvg0CTHeNg6Rf3hyWDR332AXJSlP901q8B4RZG++y6GTQ1MWrU6Z
41iY3KIv+baecI9PcDsCbRUoXVadhZYrIGdo52s/xuX8yWGXuVlpXjq+N+GaIkPR
zzXC02krUn/ABkJgfWDtgmMl+1odo5oqi3KGHumluaWDtpb+DoqJvJlKmJfZyW3V
wX93Q9E4t2DXPwi63AvTX+r96VAJKOa1z0qGUmP7PFcRz6RjQINKJiiWm1CXasDb
edZJOzS4eabMAMI3SPsl
=TXGq
-----END PGP SIGNATURE-----

--=-tQ+yPTMpVogF2sJAh83r--

