From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v5 06/17] OMAP2,3: DSS2: Create new file display.c for
 central dss driver registration.
Date: Sun, 9 Jan 2011 12:29:51 +0530
Message-ID: <AANLkTincQXte_WbaSjzn=mSoKLUr+3OSQjmN6vN=9ZG9@mail.gmail.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
 <1294399551-10457-7-git-send-email-sumit.semwal@ti.com> <1294409014.3968.94.camel@nubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56075 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1AIHAO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 9 Jan 2011 02:00:14 -0500
Received: by bwg12 with SMTP id 12so17676898bwg.9
        for <linux-omap@vger.kernel.org>; Sat, 08 Jan 2011 23:00:12 -0800 (PST)
In-Reply-To: <1294409014.3968.94.camel@nubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Tomi,

On Fri, Jan 7, 2011 at 7:33 PM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Hi,
>
> On Fri, 2011-01-07 at 16:55 +0530, ext Sumit Semwal wrote:
>> A new file display.c is introduced for display driver init, which ad=
ds a function
>> omap_display_init to do the DSS driver registration. This is the fir=
st step in moving
>> away registration of DSS from board files into a common place.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 57 ++=
+++++++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/display.h | =A0 =A04 ++
>> =A03 files changed, 63 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/display.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 4ab82f6..57b89e6 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -237,3 +237,5 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D $(smc91x-m) $(smc91x-y)
>>
>> =A0smsc911x-$(CONFIG_SMSC911X) =A0 =A0 =A0 =A0 =A0:=3D gpmc-smsc911x=
=2Eo
>> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0+=3D $(smsc911x-m) $(smsc911x-y)
>> +
>> +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0+=3D display.o
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/dis=
play.c
>> new file mode 100644
>> index 0000000..26d3feb
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -0,0 +1,57 @@
>> +/*
>> + * OMAP2plus display device setup / initialization.
>> + *
>> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.t=
i.com/
>> + * =A0 Senthilvadivu Guruswamy
>> + * =A0 =A0 =A0Sumit Semwal
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warra=
nty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +
>> +#include <plat/display.h>
>> +#include <plat/omap_hwmod.h>
>> +#include <plat/omap_device.h>
>> +
>> +#ifdef CONFIG_OMAP2_DSS
>
> This also needs to be built in when DSS is configured as module. The
> define above is only valid when DSS is configured as built-in.
>
> So you can either check for both CONFIG_OMAP2_DSS and
> CONFIG_OMAP2_DSS_MODULE here, or, I think a bit more cleanly:
>
> - Compile display.c only if CONFIG_OMAP2_DSS[_MODULE] is defined (see
> the Makefile, look for example how i2c-omap is handled).
> - Check for CONFIG_OMAP2_DSS[_MODULE] in the header file, and define =
an
> empty static inline function for omap_display_init() if DSS is disabl=
ed.

Yes, thanks. I did it the cleaner way :) - coming up in the next patch =
series.
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
