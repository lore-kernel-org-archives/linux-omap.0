From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Fri, 13 Jan 2012 22:29:16 +0200
Message-ID: <CAMP44s0jFJvHU4AMq86gmMdtLg9+hAM0vzS=7UP84UbpZ3tgOA@mail.gmail.com>
References: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40572 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753853Ab2AMU3R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 15:29:17 -0500
Received: by lago2 with SMTP id o2so494713lag.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 12:29:16 -0800 (PST)
In-Reply-To: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

On Fri, Jan 13, 2012 at 9:41 PM, Rob Clark <rob.clark@linaro.org> wrote=
:
> +void omapdrm_reserve_vram(void)
> +{
> +#ifdef CONFIG_CMA
> + =C2=A0 =C2=A0 =C2=A0 /* Create private 32MiB contiguous memory area=
 for omapdrm.0 device
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO revisit size.. if uc/wc buffers a=
re allocated from CMA pages
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* then the amount of memory we need goes=
 up..
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/

/*
 * Foo.
 */

> + =C2=A0 =C2=A0 =C2=A0 dma_declare_contiguous(&omap_drm_device.dev, 3=
2*SZ_1M, 0, 0);

32 * SZ1_M

> +#else
> +# =C2=A0warning "CMA is not enabled, there may be limitations about =
scanout buffer allocations on OMAP3 and earlier"
> +#endif
> +}
> +
> +#endif
> diff --git a/arch/arm/plat-omap/drm.h b/arch/arm/plat-omap/drm.h
> new file mode 100644
> index 0000000..56e0c0e
> --- /dev/null
> +++ b/arch/arm/plat-omap/drm.h

Maybe this should go to include/plat

> +#ifndef __PLAT_OMAP_DRM_H__
> +#define __PLAT_OMAP_DRM_H__

I see a lot of headers using this form:
__ARCH_OMAP_FOO_H

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
