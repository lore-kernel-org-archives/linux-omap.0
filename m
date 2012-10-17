From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 0/5] OMAP: VRFB: convert to platform device
Date: Wed, 17 Oct 2012 13:25:59 +0300
Message-ID: <507E87B7.3070707@ti.com>
References: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD22693110BFC897BD1FC249F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56326 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022Ab2JQK0G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 06:26:06 -0400
In-Reply-To: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, archit@ti.com

--------------enigD22693110BFC897BD1FC249F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

I have pushed this vrfb series and the omapdss version series to:

git://gitorious.org/linux-omap-dss2/linux.git 3.8/dss-version
git://gitorious.org/linux-omap-dss2/linux.git 3.8/vrfb-conversion

If they look ok to you and we don't get any other comments, I think
these branches can be considered stable and you can pull them.

After these are merged:

$ git grep -E "(plat/)|(mach/)" drivers/video/omap2/
drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vram.h>
drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vram.h>
drivers/video/omap2/vram.c:#include <plat/vram.h>

So the vram stuff should be the only omap dependency left in omapdss and
omapfb. I'll start working on that soon.

 Tomi

On 2012-10-17 13:18, Tomi Valkeinen wrote:
> This is the third version of the series. Changes to v2 are:
> * rebased on 3.7-rc1 to resolve conflicts
> * add omap_vrfb_supported() so that cpu_is_* check can be removed from =
omapfb
>=20
> As Kevin Hilman pointed out, the context restore is not functional. I d=
idn't
> touch that, as it's not functional with the current kernel either (and =
nobody
> has complained, so it can't be that critical).
>=20
>  Tomi
>=20
> Tomi Valkeinen (5):
>   OMAP: VRFB: convert vrfb to platform device
>   OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
>   OMAP: SDRC: remove VRFB code
>   OMAPDSS: VRFB: add omap_vrfb_supported()
>   OMAPFB: use omap_vrfb_supported()
>=20
>  arch/arm/mach-omap2/sdrc.c                   |   16 ---
>  arch/arm/plat-omap/fb.c                      |   61 +++++++++++
>  arch/arm/plat-omap/include/plat/sdrc.h       |    7 --
>  arch/arm/plat-omap/include/plat/vrfb.h       |   66 ------------
>  drivers/media/platform/omap/omap_vout.c      |    2 +-
>  drivers/media/platform/omap/omap_vout_vrfb.c |    2 +-
>  drivers/media/platform/omap/omap_voutdef.h   |    2 +-
>  drivers/video/omap2/omapfb/omapfb-ioctl.c    |    2 +-
>  drivers/video/omap2/omapfb/omapfb-main.c     |    8 +-
>  drivers/video/omap2/omapfb/omapfb-sysfs.c    |    2 +-
>  drivers/video/omap2/vrfb.c                   |  142 ++++++++++++++++++=
++++----
>  include/video/omapvrfb.h                     |   68 ++++++++++++
>  12 files changed, 257 insertions(+), 121 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/include/plat/vrfb.h
>  create mode 100644 include/video/omapvrfb.h
>=20



--------------enigD22693110BFC897BD1FC249F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQfoe3AAoJEPo9qoy8lh71FXUP/3bCXgBB3bXKyjN1Gg3l0GZd
ycsoAc3YFYbqudBfPn47fh1vBYPM92w612ukINvP3FVjoV3PqYtCtJuFlHykm5Ju
xV03JKvNFpxRjuYmZdAOSva6hp2fNLo1CFLIlYmd7Z0Zxi2TLAQomLo2Wd8/TW/e
UHuWhqD4LvbgVHTQLhGcwl6RgRz9J2aXygqKGB79XdOwFH8Y1RXHoDqj8j4Pn5To
h2BLUGEjrZIPUtFwH5a34HeBya14UfZD4EomIcKdetRyBvWqV95OfHxfp4hKETdK
bKqY37iqUCky6ftSY6Yxuho2HId3SpMWl2jt/9D6JRN9NMimaLVe6dVxk6238cFe
VwzcfuETeECWNCRuZ0ItSLfUysA0HUmoKg0UsCzjsoEl0OtRus2ouMsd+M7r4v0V
uB/wdwN5eOWPHqizcut92i4RZOIanyuyK17FymODR/m/TE/1krRIviPBmrG7ck52
Cd9/UNwkCJ/Z7W671S4UvxEDHzSyWv6HIrEqNRbDXatMwKNEHOPUBYjGn/75ivFW
lb6+oSq2FA70gzGa6nP1Laa8IF6TT/VTF5wYdg1TmYZ/R7r4v74LmAMfc3A7ozqg
R06zMAOiM0oZoAJqVv7VIR6HoD0gkM6K7G9SpNGxkDV2PSWOEHiPh+EN6EK/fIb1
mqVoAf6B9Z4QLcne2PDQ
=ah6m
-----END PGP SIGNATURE-----

--------------enigD22693110BFC897BD1FC249F--
