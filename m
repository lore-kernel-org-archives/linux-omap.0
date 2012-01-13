From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Fri, 13 Jan 2012 22:23:36 +0200
Message-ID: <CAMP44s16EvinPo3oxgiwY7D9uSyrSZFWFNhk5+8rndbMJDnP6g@mail.gmail.com>
References: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
	<CAF6AEGuQt=MK=W3JShpHH-Vh-5WtjUW6+vyODXbpaVTeQQ8L4w@mail.gmail.com>
	<CAMP44s2MdrzjOa7mS7a0z_-18GNm5nW_35JcX0iso+dRQvJPkw@mail.gmail.com>
	<CAF6AEGsX3USGbqrMLgfWK=aO5JbsyELcvFMCMuH5XQGHr0y+XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61657 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932694Ab2AMUXi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 15:23:38 -0500
Received: by lago2 with SMTP id o2so491958lag.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 12:23:36 -0800 (PST)
In-Reply-To: <CAF6AEGsX3USGbqrMLgfWK=aO5JbsyELcvFMCMuH5XQGHr0y+XQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Greg KH <greg@kroah.com>

On Fri, Jan 13, 2012 at 9:53 PM, Rob Clark <rob@ti.com> wrote:
> On Fri, Jan 13, 2012 at 1:49 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Jan 13, 2012 at 9:46 PM, Rob Clark <rob@ti.com> wrote:
>>> On Fri, Jan 13, 2012 at 1:41 PM, Rob Clark <rob.clark@linaro.org> w=
rote:
>>>> +/* files from staging that contain platform data structure defini=
tions */
>>>> +#include "../../../drivers/staging/omapdrm/omap_priv.h"
>>>> +#include "../../../drivers/staging/omapdrm/omap_dmm_tiler.h"
>>>
>>> btw, I'm not a huge fan of doing #includes this way, so if someone =
has
>>> a better suggestion (given that staging drivers should not have
>>> headers outside of drivers/staging) please let me know
>>
>> Move those structs to /arch/arm/plat-omap/drm.h?
>
> Can I do that? =C2=A0Maybe it depends of if you consider those struct=
s as
> part of the driver, or part of the platform?

Why not? The platform is using them in arch/arm/plat-omap/drm.c.

> I guess that looks like how it was handled for dspbridge, so maybe
> that means it is a suitable precedent..

Indeed, the way I see it is this: imagine there's another driver in
staging (or maybe even out of tree), that requires this data. It would
simply include plat-omap/drm.h to fill this. OK, this is pretty
far-fetched, but demonstrates the point: platform data should be
completely independent of the drivers.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
