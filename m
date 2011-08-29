From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 1/2] OMAP3+: voltage / oscillator parameter segregation
Date: Mon, 29 Aug 2011 09:07:36 -0700
Message-ID: <87liucw69j.fsf@ti.com>
References: <1312385355-17029-1-git-send-email-t-kristo@ti.com>
	<1312385355-17029-2-git-send-email-t-kristo@ti.com>
	<CAOMWX4cTsoK_ejOq861wNMiUDJYjcvPtc+jLo3z398D-Y2e39w@mail.gmail.com>
	<87zkivwybn.fsf@ti.com>
	<d74484cd55c8314a364af834fbbede0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:49195 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793Ab1H2QHm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 12:07:42 -0400
Received: by mail-gy0-f177.google.com with SMTP id 20so5236292gyh.8
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 09:07:41 -0700 (PDT)
In-Reply-To: <d74484cd55c8314a364af834fbbede0f@mail.gmail.com> (Vishwanath
	Sripathy's message of "Sat, 27 Aug 2011 14:59:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

>> >> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-
>> omap2/opp3xxx_data.c
>> >> index d95f3f9..b5d8294 100644
>> >> --- a/arch/arm/mach-omap2/opp3xxx_data.c
>> >> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
>> >> @@ -26,6 +26,16 @@
>> >> =C2=A0#include "pm.h"
>> >>
>> >> =C2=A0/* 34xx */
>> >> +/* OMAP VP parameter values */
>> >> +#define OMAP3430_VP1_VLIMITTO_VDDMIN =C2=A0 0x14
>> >> +#define OMAP3430_VP1_VLIMITTO_VDDMAX =C2=A0 0x42
>> >> +#define OMAP3430_VP2_VLIMITTO_VDDMIN =C2=A0 0x18
>> >> +#define OMAP3430_VP2_VLIMITTO_VDDMAX =C2=A0 0x2c

>>> NAK -> we should be using voltages here -> depending on the PMIC
>>> used, the rounding factor may not map to TWL4030.
>>
>> Agreed.
>>
>> > I had posted patch for this earlier I believe in series
>> > http://marc.info/?l=3Dlinux-omap&m=3D130741297821372&w=3D2
>>
>> I know you're a bit distracted currently ;) but is there any chance
>> you can refresh at least this patch:
>>
>>     OMAP3+: PM: VP: use uV for max and min voltage limits
>>
>> from your series on top of my current pm-wip/voltdm branch?
>>
>> If not, maybe point us to an archived version and Tero can pick it u=
p
>> and add it to this series.  After a quick search, I couldn't find it
>> in the marc.info archives.
>
> Below link should help I suppose.
> https://patchwork.kernel.org/patch/855172/
>

Yes, Tero should pick this one up and add it to his series to address
Nishanth's concerns.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
