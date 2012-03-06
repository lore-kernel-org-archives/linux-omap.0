From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Tue, 06 Mar 2012 15:26:11 +0200
Message-ID: <1331040371.2059.113.camel@deskari>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2VNmull/3geziZvlJmOC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:59488 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965144Ab2CFN0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 08:26:17 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id y4so7537422lag.8
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 05:26:15 -0800 (PST)
In-Reply-To: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>


--=-2VNmull/3geziZvlJmOC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-05 at 10:54 -0600, Rob Clark wrote:
> From: Andy Gross <andy.gross@ti.com>
>=20
> Register OMAP DRM/KMS platform device, and reserve a CMA region for
> the device to use for buffer allocation.  DMM is split into a
> separate device using hwmod.
>=20
> Signed-off-by: Andy Gross <andy.gross@ti.com>
> Signed-off-by: Rob Clark <rob@ti.com>
> ---
>  arch/arm/plat-omap/Makefile           |    2 +-
>  arch/arm/plat-omap/common.c           |    3 +-
>  arch/arm/plat-omap/drm.c              |   83 +++++++++++++++++++++++++++=
++++++
>  arch/arm/plat-omap/include/plat/drm.h |   64 +++++++++++++++++++++++++
>  4 files changed, 150 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/plat-omap/drm.c
>  create mode 100644 arch/arm/plat-omap/include/plat/drm.h
>=20
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 9a58461..b86e6cb 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -4,7 +4,7 @@
> =20
>  # Common support
>  obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
> -	 usb.o fb.o counter_32k.o
> +	 usb.o fb.o counter_32k.o drm.o
>  obj-m :=3D
>  obj-n :=3D
>  obj-  :=3D
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 06383b5..0d87dab 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -21,10 +21,10 @@
>  #include <plat/board.h>
>  #include <plat/vram.h>
>  #include <plat/dsp.h>
> +#include <plat/drm.h>
> =20
>  #include <plat/omap-secure.h>
> =20
> -
>  #define NO_LENGTH_CHECK 0xffffffff
> =20
>  struct omap_board_config_kernel *omap_board_config __initdata;
> @@ -65,6 +65,7 @@ const void *__init omap_get_var_config(u16 tag, size_t =
*len)
> =20
>  void __init omap_reserve(void)
>  {
> +	omapdrm_reserve_vram();
>  	omapfb_reserve_sdram_memblock();
>  	omap_vram_reserve_sdram_memblock();
>  	omap_dsp_reserve_sdram_memblock();
> diff --git a/arch/arm/plat-omap/drm.c b/arch/arm/plat-omap/drm.c

As Tony said, mach-omap2 is probably a better place. fb.c is in
plat-omap because it supports both OMAP1 and OMAP2+.

> new file mode 100644
> index 0000000..28279df
> --- /dev/null
> +++ b/arch/arm/plat-omap/drm.c
> @@ -0,0 +1,83 @@
> +/*
> + * DRM/KMS device registration for TI OMAP platforms
> + *
> + * Copyright (C) 2012 Texas Instruments
> + * Author: Rob Clark <rob.clark@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#ifdef CONFIG_CMA
> +#  include <linux/dma-contiguous.h>
> +#endif
> +
> +#include <plat/omap_device.h>
> +#include <plat/omap_hwmod.h>
> +
> +#include <plat/drm.h>
> +
> +#if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
> +
> +static struct omap_drm_platform_data omapdrm_platdata;
> +
> +static struct platform_device omap_drm_device =3D {
> +		.dev =3D {
> +			.coherent_dma_mask =3D DMA_BIT_MASK(32),
> +			.platform_data =3D &omapdrm_platdata,
> +		},
> +		.name =3D "omapdrm",
> +		.id =3D 0,

Can there be more than one omapdrm device? I guess not. If so, the id
should be -1.

> +};
> +
> +static int __init omap_init_gpu(void)
> +{
> +	struct omap_hwmod *oh =3D NULL;
> +	struct platform_device *pdev;
> +
> +	/* lookup and populate the DMM information, if present - OMAP4+ */
> +	oh =3D omap_hwmod_lookup("dmm");
> +
> +	if (oh) {
> +		pdev =3D omap_device_build(oh->name, -1, oh, NULL, 0, NULL, 0,
> +					false);
> +		WARN(IS_ERR(pdev), "Could not build omap_device for %s\n",
> +			oh->name);
> +	}
> +
> +	return platform_device_register(&omap_drm_device);
> +
> +}

The function is called omap_init_gpu(), but it doesn't do anything
related to the gpu... And aren't DMM and DRM totally separate things,
why are they bunched together like that?

> +arch_initcall(omap_init_gpu);
> +
> +void omapdrm_reserve_vram(void)
> +{
> +#ifdef CONFIG_CMA
> +	/*
> +	 * Create private 32MiB contiguous memory area for omapdrm.0 device
> +	 * TODO revisit size.. if uc/wc buffers are allocated from CMA pages
> +	 * then the amount of memory we need goes up..
> +	 */
> +	dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1M, 0, 0);

What does this actually do? Does it reserve the memory, i.e. it's not
usable for others? If so, shouldn't there be a way for the user to
configure it?

> +#else
> +#  warning "CMA is not enabled, there may be limitations about scanout b=
uffer allocations on OMAP3 and earlier"
> +#endif
> +}
> +
> +#endif
> diff --git a/arch/arm/plat-omap/include/plat/drm.h b/arch/arm/plat-omap/i=
nclude/plat/drm.h
> new file mode 100644
> index 0000000..df9bc41
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/drm.h
> @@ -0,0 +1,64 @@
> +/*
> + * DRM/KMS device registration for TI OMAP platforms
> + *
> + * Copyright (C) 2012 Texas Instruments
> + * Author: Rob Clark <rob.clark@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __PLAT_OMAP_DRM_H__
> +#define __PLAT_OMAP_DRM_H__
> +
> +/*
> + * Optional platform data to configure the default configuration of whic=
h
> + * pipes/overlays/CRTCs are used.. if this is not provided, then instead=
 the
> + * first CONFIG_DRM_OMAP_NUM_CRTCS are used, and they are each connected=
 to
> + * one manager, with priority given to managers that are connected to
> + * detected devices.  Remaining overlays are used as video planes.  This
> + * should be a good default behavior for most cases, but yet there still
> + * might be times when you wish to do something different.
> + */
> +struct omap_kms_platform_data {
> +	/* overlays to use as CRTCs: */
> +	int ovl_cnt;
> +	const int *ovl_ids;
> +
> +	/* overlays to use as video planes: */
> +	int pln_cnt;
> +	const int *pln_ids;
> +
> +	int mgr_cnt;
> +	const int *mgr_ids;
> +
> +	int dev_cnt;
> +	const char **dev_names;
> +};
> +
> +struct omap_drm_platform_data {
> +	struct omap_kms_platform_data *kms_pdata;
> +};

I don't know if there's need to add these... With device tree the
plaform data will not be usable anyway.

 Tomi


--=-2VNmull/3geziZvlJmOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPVhBzAAoJEPo9qoy8lh71i3YP/jP1AorF1HNyMlD6HIjfW3aL
VnHlPJFQKmw+jIjJn3kpXLZrQuz72ZpOn7qK+h8eeFyESiHVdWIFW0EefMCvPLUz
jdaJsnw2LtLhxyhtwWU1CCvJQXSpufd+PO1lyB/xzm2KHV3haj+4z9msGIwOKtfL
EKvc6CjLWeWvah4P5O0vdKANDB6dgaDbYD7A7pOOFmJe1EfvY6Op94KUfsrl5VOP
f9A9/dt+2x8vsjXJ9IdVH9EANZ5KO+XK5dAt5LuGpIWed4rbBCZYQGpeH20v0OW3
RPmHHQKvQbJPw5axw8sc2XUNICj8QsZE3PogDAnlYkyLTLApGcQLKlCIYGXgVF09
lV6y/MGICS2GgHO9No/Oc6FVC6DQQ2aYIR8vUkaOXQLwGjZoQGmFm5KD7W0NOkLL
xAvsseG1dZi0IcuICgPGX60xQeGPxwhcyojNT67rVV7X/Jn4I35roAQuVlfsK7aH
s1Fmvz5WmJCMZ1zhGBIw0uP97ZvGjO/rIUKWz5hLtB4B6kXD4xpdgw2e+B2NcBLa
e+s9n26TlnPUpLFrfoeiZccHlWlmJMdiuMTgv8VGt2pa+O8l1x01YflhtQHGYsM+
E639ovSeikDnfTGomYOgXJpCiaZZZTOyofLJUJkUixVbcJzYTF4sd5v5Cc0Ecy+8
Xqo6E2ghHCAKT7f4Juxm
=jbb2
-----END PGP SIGNATURE-----

--=-2VNmull/3geziZvlJmOC--

