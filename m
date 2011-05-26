From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 8/8] OMAP: cpufreq: minor file header updates
Date: Wed, 25 May 2011 17:48:30 -0700
Message-ID: <BANLkTikJAATwHCANc5r=5=G+o47vWbVdtg@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-9-git-send-email-nm@ti.com>
 <8739k2jovp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51478 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754254Ab1EZAsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 20:48:51 -0400
Received: by mail-wy0-f178.google.com with SMTP id 33so175757wyb.23
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 17:48:50 -0700 (PDT)
In-Reply-To: <8739k2jovp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 25, 2011 at 17:18, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> Minor file header updates to reflect 2011 for omap2-cpufreq code
>> and remove misleading OMAP3 reference in omap1 cpufreq code.
>>
>> Should probably be squashed to:
>> "OMAP: cpufreq: Split OMAP1 and OMAP2PLUS CPUfreq drivers."
>>
>> Reported-by: Todd Poynor <toddpoynor@google.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach=
-omap2/omap2plus-cpufreq.c
>> index 594100e..2482c71 100644
>> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> @@ -8,7 +8,7 @@
>> =A0 *
>> =A0 * =A0Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
>> =A0 *
>> - * Copyright (C) 2007-2008 Texas Instruments, Inc.
>> + * Copyright (C) 2007-20011 Texas Instruments, Inc.
>
> Wow, you're really wanting to have copyright coverage well into the
> future ! =A0;)

I must be on a timemachine ;).. will fix :D

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
