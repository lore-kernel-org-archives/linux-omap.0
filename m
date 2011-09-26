From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 3/6] OMAP4460: Temperature sensor data
Date: Mon, 26 Sep 2011 09:55:19 +0530
Message-ID: <CAJ6a13YCkps5R4drFVp=it2cv1eMP1=hVX0ArccF3Hej4EwRPg@mail.gmail.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
	<1316705361-12175-4-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1109222319210.10719@utopia.booyaka.com>
	<CAJ6a13bKycJYKa9CG8sgPr8PMO62RYZJ=_UD3ZfjoYQm4GbN0A@mail.gmail.com>
	<alpine.DEB.2.00.1109240141310.22872@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49606 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750881Ab1IZEZV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 00:25:21 -0400
Received: by mail-wy0-f172.google.com with SMTP id 21so3722746wyh.31
        for <linux-omap@vger.kernel.org>; Sun, 25 Sep 2011 21:25:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109240141310.22872@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Sat, Sep 24, 2011 at 1:18 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 23 Sep 2011, J, KEERTHY wrote:
>
>> On Fri, Sep 23, 2011 at 11:33 AM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> >
>> > On Thu, 22 Sep 2011, Keerthy wrote:
>> >
>> >> @@ -0,0 +1,175 @@
>> >> +/*
>> >> + * OMAP system control module header file
>> >> + *
>> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://ww=
w.ti.com/
>> >> + * Author: J Keerthy <j-keerthy@ti.com>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or
>> >> + * modify it under the terms of the GNU General Public License
>> >> + * version 2 as published by the Free Software Foundation.
>> >> + *
>> >> + * This program is distributed in the hope that it will be usefu=
l, but
>> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he GNU
>> >> + * General Public License for more details.
>> >> + *
>> >> + * You should have received a copy of the GNU General Public Lic=
ense
>> >> + * along with this program; if not, write to the Free Software
>> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> >> + * 02110-1301 USA
>> >> + *
>> >> + */
>> >> +
>> >> +#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>> >> +#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>> >
>> > You're also missing important #includes here for things like mutex=
es
>> > and kernel types that you use later on in the file.
>>
>> Those header files are included in c files.
>
> And how does that affect my comment?
>
>> >> +#define OMAP_ADC_START_VALUE =A0 =A0530
>> >> +#define OMAP_ADC_END_VALUE =A0 =A0 =A0923
>> >
>> > Are these OMAP4460, OMAP4xxx, or OMAP2+ specific?
>>
>> OMAP4460. I will pass even these values through pdata
>> since they differ from platform to platform.
>
> So then the macro names need to include "OMAP4460" or whatever SoC
> they are first valid for.
>
>> >> +
>> >> +/**
>> >> + * struct omap4460plus_scm_dev_attr - device attributes for scm
>> >
>> > There are loads of references to 'omap4460plus' when it seems to m=
e that
>> > much of this driver should also apply to OMAP4430 also. =A0Shouldn=
't this
>> > driver be named something like 'omap4430plus_scm' or even
>> > better 'omap4_scm' ?
>>
>> This is used by hwmod. Hence keeping it in the header file.
>
> Did you even read my comment before responding?

Sorry about this. OMAP4430 and OMAP4460 temperature sensors are differe=
nt.
The register layout and the functionalities differ. The OMAP4430 temper=
ature
sensor is not accurate. The SCM driver can be generic but the temperatu=
re
sensor driver should be OMAP4460 onwards. Please let me know if this is=
 fine?

>
>
> - Paul



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
