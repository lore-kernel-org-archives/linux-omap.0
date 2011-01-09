From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v5 06/17] OMAP2,3: DSS2: Create new file display.c for
 central dss driver registration.
Date: Sun, 9 Jan 2011 12:30:56 +0530
Message-ID: <AANLkTi=Dn+NSV-bdL9pT1gRfV5g978fSBitUoA+rO43F@mail.gmail.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
 <1294399551-10457-7-git-send-email-sumit.semwal@ti.com> <87d3o8mmly.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41651 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1AIHBT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 9 Jan 2011 02:01:19 -0500
Received: by bwz12 with SMTP id 12so12034689bwz.41
        for <linux-omap@vger.kernel.org>; Sat, 08 Jan 2011 23:01:18 -0800 (PST)
In-Reply-To: <87d3o8mmly.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Hi Kevin,

On Sat, Jan 8, 2011 at 2:56 AM, Kevin Hilman <khilman@ti.com> wrote:
> Sumit Semwal <sumit.semwal@ti.com> writes:
>
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
>
> Minor nit: the hwmod and omap_device headers are not needed for this
> patch. =A0Please add them when needed (PATCH 8)
Thanks; yes,  - coming up in the next patch version.
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
