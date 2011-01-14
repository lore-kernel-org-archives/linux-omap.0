From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Fri, 14 Jan 2011 16:23:56 +0100
Message-ID: <AANLkTimc+GY1Pr1T=baF8WO8sTnprra66o52K-4_XxYh@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58061 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757836Ab1ANPYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 10:24:06 -0500
Received: by qyk12 with SMTP id 12so3472861qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 07:23:57 -0800 (PST)
In-Reply-To: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean Pihet <j-pihet@ti.com>

On Fri, Jan 14, 2011 at 4:21 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> The new fncpy API is better suited for copying some
> code to SRAM at runtime. This patch changes the ad-hoc
> code to the more generic fncpy API.
>
> Tested OK on OMAP3 in low power modes (RET/OFF)
> with !CONFIG_THUMB2_KERNEL
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

This patch depends on Dave's '[PATCH v3 1/1] ARM: Thumb-2: Symbol
manipulation macros for function' patch, cf.
http://marc.info/?l=3Dlinux-arm-kernel&m=3D129495865831165&w=3D2

Regards,
Jean

> ---
> =A0arch/arm/plat-omap/sram.c | =A0 =A07 +++----
> =A01 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index e26e504..e2982b0 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -23,7 +23,7 @@
>
> =A0#include <asm/tlb.h>
> =A0#include <asm/cacheflush.h>
> -
> +#include <asm/fncpy.h>
> =A0#include <asm/mach/map.h>
>
> =A0#include <plat/sram.h>
> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long=
 size)
>
> =A0 =A0 =A0 =A0omap_sram_ceil -=3D size;
> =A0 =A0 =A0 =A0omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeof(v=
oid *));
> - =A0 =A0 =A0 memcpy((void *)omap_sram_ceil, start, size);
> - =A0 =A0 =A0 flush_icache_range((unsigned long)omap_sram_ceil,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)(omap_sram_ceil + size))=
;
> +
> + =A0 =A0 =A0 fncpy((void *)omap_sram_ceil, start, size);
>
> =A0 =A0 =A0 =A0return (void *)omap_sram_ceil;
> =A0}
> --
> 1.7.2.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
