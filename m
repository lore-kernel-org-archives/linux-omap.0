From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC 0/6] Use DRM component API in tilcdc to connect to
 tda998x
Date: Mon, 2 Mar 2015 13:34:14 +0200
Message-ID: <54F44AB6.1080607@ti.com>
References: <cover.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="QoNAV6trRMMMvJe0mBfj00PhsVTAW9wOp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58409 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbbCBLec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2015 06:34:32 -0500
In-Reply-To: <cover.1424961754.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk

--QoNAV6trRMMMvJe0mBfj00PhsVTAW9wOp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Rob,

You weren't cc'd to this series. I don't know if you're still interested
in tilcdc, but if you are, any comments appreciated =3D).

 Tomi

On 26/02/15 16:55, Jyri Sarha wrote:
> Remove tilcdc slave support and connect to tda998x trough its
> component DRM API. For dtb backward compatibility the code creates at
> boot time a DT overlay based on the earlier binding. The overlay
> conforms to the new graph based binding.
>=20
> The first patch is just a bugfix and can be applied or dropped
> independenty.
>=20
> Jyri Sarha (6):
>   drm/tilcdc: Fix module unloading
>   drm/tilcdc: Remove tilcdc slave support for tda998x driver
>   drm/tilcdc: Add support for external compontised DRM encoder
>   drm/tilcdc: Add DRM_TILCDC_INIT for "ti,tilcdc,slave" binding support=

>   drm/tilcdc: Force building of DRM_TILCDC_INIT
>   ARM: dts: am335x-boneblack: Use new binding for HDMI
>=20
>  .../devicetree/bindings/drm/tilcdc/slave.txt       |  18 -
>  .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  27 ++
>  arch/arm/boot/dts/am335x-boneblack.dts             |  20 +-
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/tilcdc/Kconfig                     |   6 +
>  drivers/gpu/drm/tilcdc/Makefile                    |   4 +-
>  drivers/gpu/drm/tilcdc/tilcdc_boot_init.c          | 270 +++++++++++++=
+
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  36 +-
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  69 ++--
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h                |   3 +-
>  drivers/gpu/drm/tilcdc/tilcdc_external.c           | 105 ++++++
>  drivers/gpu/drm/tilcdc/tilcdc_external.h           |  24 ++
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 411 -------------=
--------
>  drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 --
>  drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts    |  70 ++++
>  15 files changed, 601 insertions(+), 489 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.=
txt
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_boot_init.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.h
>  delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
>  delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts
>=20



--QoNAV6trRMMMvJe0mBfj00PhsVTAW9wOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9Eq2AAoJEPo9qoy8lh71EsAP/3yFfFLvrDgzVHrhJ6EM2w6e
IMqvwwxfUxEtxSUC/vv6sswdlJcoj+ioE3KZphHBoaXICsula9Y3vmzKtdvVZsdu
+/JxoO8vV8Spnas9aliX7IATtJnj4tLexZOlGByUlFHGlHz11CTbFd+FAybBXlYf
x68XsD3gLMuwW4xUSJ0idihu84AcWiCn12G+I7jjvY8/hYoysnBC5EoQI2FnWZ7n
U+1lojpWzACwPJdxWOL5xtvJseajxYeR1rE7dspTeyTdsSuEEY+E2o6geFEGyxOn
ChyS+VmkIMCjlxdvAUIyuGsTF/d8Lm9DSUNhSus59EAhQ5/4SDQhYrbcELqY66ZA
tiSKTgiGXNndiMWp1C3ezp4JvPdJ5CMAUEWjR30e7RIzSODcaufiuZMlnGOqCeTr
MoRtZqvACGcCMK54SBAlAIXBz1jxUGMV1TM+J6wp4FDeg3J8H7BnalIfwQk8G0d9
vrpRuSWaFAvvvtjPRPahIiIoosUFh/YjIo3JI3Z4nLX0R4f79FTdhnCIKZ90Ifpv
Ji5ifWcK/NlZ1AdSpXWCeXXXywbzqYXVF29ZR46KvDvcv+jjdj1IYJO5fxxTdmj+
/+0kEhE/2OeSheCSoeHCQa4eTmi2q37JKLLrO9fqBg4wWpX7VF1GVKMxj9Blijgs
5Jpf8M2z27OjsNwbl0dV
=PqWs
-----END PGP SIGNATURE-----

--QoNAV6trRMMMvJe0mBfj00PhsVTAW9wOp--
