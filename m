From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Mon, 5 Mar 2012 19:42:39 -0600
Message-ID: <CAF6AEGuy8ycnJGiA_md4p6rRRMMxRFz5BRHi4hA=5=Cq3J=b2Q@mail.gmail.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<20120306001014.GR12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48480 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107Ab2CFBmk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 20:42:40 -0500
Received: by vcqp1 with SMTP id p1so3988800vcq.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 17:42:39 -0800 (PST)
In-Reply-To: <20120306001014.GR12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>

On Mon, Mar 5, 2012 at 6:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Rob Clark <rob.clark@linaro.org> [120305 08:24]:
>> From: Andy Gross <andy.gross@ti.com>
>>
>> Register OMAP DRM/KMS platform device, and reserve a CMA region for
>> the device to use for buffer allocation. =A0DMM is split into a
>> separate device using hwmod.
>> --- a/arch/arm/plat-omap/common.c
>> +++ b/arch/arm/plat-omap/common.c
>> @@ -21,10 +21,10 @@
>> =A0#include <plat/board.h>
>> =A0#include <plat/vram.h>
>> =A0#include <plat/dsp.h>
>> +#include <plat/drm.h>
>>
>> =A0#include <plat/omap-secure.h>
>>
>> -
>> =A0#define NO_LENGTH_CHECK 0xffffffff
>>
>> =A0struct omap_board_config_kernel *omap_board_config __initdata;
>> @@ -65,6 +65,7 @@ const void *__init omap_get_var_config(u16 tag, si=
ze_t *len)
>>
>> =A0void __init omap_reserve(void)
>> =A0{
>> + =A0 =A0 omapdrm_reserve_vram();
>> =A0 =A0 =A0 omapfb_reserve_sdram_memblock();
>> =A0 =A0 =A0 omap_vram_reserve_sdram_memblock();
>> =A0 =A0 =A0 omap_dsp_reserve_sdram_memblock();
>
> Tomi needs to look at the vram changes here.

it is just setting up a CMA region (if CMA is enabled.. basically for
once CMA is merged)

after CMA is merged, other drivers should be migrated to use CMA, and
omap_vram removed.. but that is a topic for another patch

>> --- /dev/null
>> +++ b/arch/arm/plat-omap/drm.c
>
> This file would be better in mach-omap2/drm.c. I doubt that this will
> ever be usable for omap1. But other than that, up to Tomi.

I was attempting to copy what omapfb was doing (plat-omap/fb.c)
because I wasn't really sure about plat-omap vs mach-omap2, although
on closer inspection I think the file I was looking at is actually for
the legacy omapdss1..  So I'll move this stuff under mach-omap2 and
resubmit this patch.

BR,
-R

> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
