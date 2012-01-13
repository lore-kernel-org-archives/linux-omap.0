From: Rob Clark <rob@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Fri, 13 Jan 2012 14:25:25 -0600
Message-ID: <CAF6AEGuHC3FCORR5nN6TdCLO5hhjVgzO9MtN3e9DY7dY77HONw@mail.gmail.com>
References: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
	<CAF6AEGuQt=MK=W3JShpHH-Vh-5WtjUW6+vyODXbpaVTeQQ8L4w@mail.gmail.com>
	<CAMP44s2MdrzjOa7mS7a0z_-18GNm5nW_35JcX0iso+dRQvJPkw@mail.gmail.com>
	<CAF6AEGsX3USGbqrMLgfWK=aO5JbsyELcvFMCMuH5XQGHr0y+XQ@mail.gmail.com>
	<CAMP44s16EvinPo3oxgiwY7D9uSyrSZFWFNhk5+8rndbMJDnP6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58635 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab2AMUZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 15:25:26 -0500
Received: by vbmv11 with SMTP id v11so1460152vbm.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 12:25:25 -0800 (PST)
In-Reply-To: <CAMP44s16EvinPo3oxgiwY7D9uSyrSZFWFNhk5+8rndbMJDnP6g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Greg KH <greg@kroah.com>

On Fri, Jan 13, 2012 at 2:23 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Jan 13, 2012 at 9:53 PM, Rob Clark <rob@ti.com> wrote:
>> On Fri, Jan 13, 2012 at 1:49 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Fri, Jan 13, 2012 at 9:46 PM, Rob Clark <rob@ti.com> wrote:
>>>> On Fri, Jan 13, 2012 at 1:41 PM, Rob Clark <rob.clark@linaro.org> =
wrote:
>>>>> +/* files from staging that contain platform data structure defin=
itions */
>>>>> +#include "../../../drivers/staging/omapdrm/omap_priv.h"
>>>>> +#include "../../../drivers/staging/omapdrm/omap_dmm_tiler.h"
>>>>
>>>> btw, I'm not a huge fan of doing #includes this way, so if someone=
 has
>>>> a better suggestion (given that staging drivers should not have
>>>> headers outside of drivers/staging) please let me know
>>>
>>> Move those structs to /arch/arm/plat-omap/drm.h?
>>
>> Can I do that? =A0Maybe it depends of if you consider those structs =
as
>> part of the driver, or part of the platform?
>
> Why not? The platform is using them in arch/arm/plat-omap/drm.c.
>
>> I guess that looks like how it was handled for dspbridge, so maybe
>> that means it is a suitable precedent..
>
> Indeed, the way I see it is this: imagine there's another driver in
> staging (or maybe even out of tree), that requires this data. It woul=
d
> simply include plat-omap/drm.h to fill this. OK, this is pretty
> far-fetched, but demonstrates the point: platform data should be
> completely independent of the drivers.

yeah, makes sense.. I'm about to send v2 of this patch.

BR,
-R

> Cheers.
>
> --
> Felipe Contreras
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
