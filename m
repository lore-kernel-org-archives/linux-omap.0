From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC] drm/lcdc: add TI LCD Controller DRM driver
Date: Mon, 17 Dec 2012 15:56:27 +0200
Message-ID: <50CF248B.4010401@ti.com>
References: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72597C62CF18CA745C8258BF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36108 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab2LQN4g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 08:56:36 -0500
In-Reply-To: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, patches@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--------------enig72597C62CF18CA745C8258BF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-14 02:04, Rob Clark wrote:
> A simple DRM/KMS driver for the TI LCD Controller found in various
> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the
> CMA helpers.  Currently only the TFP410 DVI encoder is supported
> (tested with beaglebone + DVI cape).  There are also various LCD
> displays, for which support can be added (as I get hw to test on),
> and an external i2c HDMI encoder found on some boards.
>=20
> The display controller supports a single CRTC.  And the encoder+
> connector are split out into sub-devices.  Depending on which LCD
> or external encoder is actually present, the appropriate output
> module(s) will be loaded.
>=20
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig            |   2 +
>  drivers/gpu/drm/Makefile           |   1 +
>  drivers/gpu/drm/lcdc/Kconfig       |  11 +
>  drivers/gpu/drm/lcdc/Makefile      |   8 +
>  drivers/gpu/drm/lcdc/lcdc_crtc.c   | 544 +++++++++++++++++++++++++++++=
++++
>  drivers/gpu/drm/lcdc/lcdc_drv.c    | 604 +++++++++++++++++++++++++++++=
++++++++
>  drivers/gpu/drm/lcdc/lcdc_drv.h    | 162 ++++++++++
>  drivers/gpu/drm/lcdc/lcdc_regs.h   | 154 ++++++++++
>  drivers/gpu/drm/lcdc/lcdc_tfp410.c | 424 ++++++++++++++++++++++++++
>  drivers/gpu/drm/lcdc/lcdc_tfp410.h |  26 ++
>  10 files changed, 1936 insertions(+)
>  create mode 100644 drivers/gpu/drm/lcdc/Kconfig
>  create mode 100644 drivers/gpu/drm/lcdc/Makefile
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_crtc.c
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.c
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.h
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_regs.h
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.c
>  create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.h

"lcdc" is quite a common term. The directory should perhaps be something
like ti-lcdc?

Probably not relevant, but I wonder if the same LCDC was used in
omap1... It'd be nice to get rid of the omap1 fb driver.

I'm not very enthusiastic about adding ti-lcdc specific panel/chip
drivers. It's not really a big deal if it's only kernel code, but you
add device-tree bindings also, which is an external API that you need to
support after adding it.

I'd rather see the energy put to common display framework, and get this
whole panel/chip driver issue solved in a generic manner.

 Tomi



--------------enig72597C62CF18CA745C8258BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQzySMAAoJEPo9qoy8lh71+2QP/jSZxtTPm5YI4NnOaGSSsVm5
F6K+No8IqBBLwn7D13p6C9ETr29tOf8xT24xvATRgIIkP9wzFPIPrbszrFSLhM5/
CSgb5gaAbEZ3Sf2ZvWQnnA94Um+Il3vvtag4wdnz64dHupkjm54A+nMKfvmicyn6
jzjtwumhGU4G493WzoZSHSZuztjoamnB2lJBdR8W2mc9jEHiUpfem7nJDuwEHuc4
i+fCCoR7claFYo2tUjkFSj+pp6KXYBYVF/QVKLsbhPLjgMYHSOlnXYKonEGEeeHs
5h1o6o18HJIW2c3YyMn1nRBjCJap5+jF88B8kDPzO8IXB1yeyuxqdxhtuz8nLQei
bl1vxFoTWtD5UDUFtxQaGkx3a1yGaizvaaOvt/gaMRUOrnZduSU+uBRfyl0yytaf
wB2qde1upSoeTNULwhd7nGnMIzrSoNjHrTrFGRD4FO4sILjDZOKXnzLgUDbxVbjF
x93AFxjHebCDyjzMdrhQOCA3yrxDbOUPS7v4/+W7abcsZKGX8kj7Vjf5B9psRScu
SGwOXfNOJ22FYzymhKnYaSIcZgDwGuOfdfNRwMsKrJSiY8aBCIoHb+C0J4f964ne
bC6gC8yTOTJYSuj+ObIJzAlhQnvq4YjYWblu7/VbfwIXGLmh/df4lTXeBhwOK0bI
cXlpj+8KeN1KEAi7KqWn
=wjOe
-----END PGP SIGNATURE-----

--------------enig72597C62CF18CA745C8258BF--
