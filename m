From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Add local timer support for Device Tree
Date: Mon, 9 Jul 2012 18:55:14 +0530
Message-ID: <CAMQu2gwm8q2MXBS93-Rj+80imdFNBAuqMDB4pG9G2G7x+XzQxw@mail.gmail.com>
References: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
 <1341839470-5586-3-git-send-email-santosh.shilimkar@ti.com> <20120709131549.GI1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46255 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab2GINZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 09:25:36 -0400
Received: by qabj34 with SMTP id j34so1623942qab.11
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 06:25:34 -0700 (PDT)
In-Reply-To: <20120709131549.GI1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

On Mon, Jul 9, 2012 at 6:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120709 06:16]:
>> Add cortex-a9 local timer  support for all OMAP4 based
>> SOCs using DT.
> ...
>
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/clocksource.h>
>>  #include <linux/clockchips.h>
>>  #include <linux/slab.h>
>> +#include <linux/of.h>
>>
>>  #include <asm/mach/time.h>
>>  #include <plat/dmtimer.h>
>> @@ -384,9 +385,13 @@ static void __init omap4_timer_init(void)
>>       if (omap_rev() != OMAP4430_REV_ES1_0) {
>>               int err;
>>
>> -             err = twd_local_timer_register(&twd_local_timer);
>> -             if (err)
>> -                     pr_err("twd_local_timer_register failed %d\n", err);
>> +             if (of_have_populated_dt()) {
>> +                     twd_local_timer_of_register();
>> +             } else {
>> +                     err = twd_local_timer_register(&twd_local_timer);
>> +                     if (err)
>> +                             pr_err("twd_local_timer_register failed %d\n", err);
>> +             }
>>       }
>>  #endif
>>  }
>
> How about just return after twd_local_timer_of_register() instead?
> That avoids nesting the code further.
>
Yep. Make sense. Will consider that in next version.

Regards
Santosh
