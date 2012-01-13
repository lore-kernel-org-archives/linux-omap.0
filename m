From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Fri, 13 Jan 2012 21:49:05 +0200
Message-ID: <CAMP44s2MdrzjOa7mS7a0z_-18GNm5nW_35JcX0iso+dRQvJPkw@mail.gmail.com>
References: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
	<CAF6AEGuQt=MK=W3JShpHH-Vh-5WtjUW6+vyODXbpaVTeQQ8L4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57189 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758915Ab2AMTtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 14:49:07 -0500
Received: by lago2 with SMTP id o2so476278lag.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 11:49:05 -0800 (PST)
In-Reply-To: <CAF6AEGuQt=MK=W3JShpHH-Vh-5WtjUW6+vyODXbpaVTeQQ8L4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>

On Fri, Jan 13, 2012 at 9:46 PM, Rob Clark <rob@ti.com> wrote:
> On Fri, Jan 13, 2012 at 1:41 PM, Rob Clark <rob.clark@linaro.org> wrote:
>> +/* files from staging that contain platform data structure definitions */
>> +#include "../../../drivers/staging/omapdrm/omap_priv.h"
>> +#include "../../../drivers/staging/omapdrm/omap_dmm_tiler.h"
>
> btw, I'm not a huge fan of doing #includes this way, so if someone has
> a better suggestion (given that staging drivers should not have
> headers outside of drivers/staging) please let me know

Move those structs to /arch/arm/plat-omap/drm.h?

-- 
Felipe Contreras
