From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Fri, 13 Jan 2012 22:59:07 +0200
Message-ID: <CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56338 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932912Ab2AMU7J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 15:59:09 -0500
Received: by lago2 with SMTP id o2so507658lag.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 12:59:07 -0800 (PST)
In-Reply-To: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

On Fri, Jan 13, 2012 at 10:41 PM, Rob Clark <rob.clark@linaro.org> wrot=
e:
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefil=
e
> index 9a58461..b86e6cb 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -4,7 +4,7 @@
>
> =C2=A0# Common support
> =C2=A0obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0usb.o fb.o counter_32k.o
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0usb.o fb.o counter_32k.o drm.o

Should be something like this:
obj-$(CONFIG_DRM_OMAP) +=3D drm.o

No?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
