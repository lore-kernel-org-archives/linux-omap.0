From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Mon, 28 Feb 2011 17:33:31 +0100
Message-ID: <AANLkTikgi_MpkPvhzMbnq_F6MbZE0W7+5OnWr=6WgtTn@mail.gmail.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com>
	<ec45f3f591691ce6a5253dfb70cc8e90@mail.gmail.com>
	<AANLkTiktdLja39dC38E_LciYZK7+pTp3_Sgm9jf5FA4R@mail.gmail.com>
	<5dad46ab75a15145f907aeca53f769c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38725 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab1B1Qdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 11:33:32 -0500
Received: by qwd7 with SMTP id 7so2957267qwd.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 08:33:31 -0800 (PST)
In-Reply-To: <5dad46ab75a15145f907aeca53f769c1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

Hi Kevin,

Can you please check this patch? From the previous discussions I
understood it was OK.
This one has been submitted to and l-o and l-a-k MLs. How will this
one be merged in?

Thanks,
Jean

On Mon, Feb 21, 2011 at 9:53 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
>> Sent: Monday, February 21, 2011 2:14 PM
>> To: Santosh Shilimkar
>> Cc: Kevin Hilman; Thomas Renninger; linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; Jean Pihet-XID
>> Subject: Re: [PATCH] perf: add OMAP support for the new power events
>>
>> Hi Santosh,
>>
>
> [...]
>
>> >> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
>> >> omap2/pm34xx.c
>> >> index 2f864e4..d1cc3f4 100644
>> >> --- a/arch/arm/mach-omap2/pm34xx.c
>> >> +++ b/arch/arm/mach-omap2/pm34xx.c
>> >> @@ -29,6 +29,7 @@
>> >> =A0#include <linux/delay.h>
>> >> =A0#include <linux/slab.h>
>> >> =A0#include <linux/console.h>
>> >> +#include <trace/events/power.h>
>> >>
>> >> =A0#include <plat/sram.h>
>> >> =A0#include "clockdomain.h"
>> >> @@ -519,8 +520,14 @@ static void omap3_pm_idle(void)
>> >> =A0 =A0 =A0 if (omap_irq_pending() || need_resched())
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >>
>> >> + =A0 =A0 trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> >> + =A0 =A0 trace_cpu_idle(1, smp_processor_id());
>> >> +
>> >
>> > This default idle code won't be used when you enable the
>> > CONFIG_CPUIDLE. That case the cpuidle34xx.c idle code gets
>> > registered.
>> That is correct. OMAP has a default idle handler (omap3_pm_idle) and
>> a
>> cpuidle handler (omap3_enter_idle in
>> arch/arm/mach-omap2/cpuidle34xx.c).
>>
>> > Shouldn't you patch that code instead? This is more or less
>> > dead code and it is just like default idle code when idle
>> > drivers isn't registered.
>> The cpuidle framework already is instrumented in a generic way. This
>> code adds the instrumentation to the default idle handler so that
>> all
>> cases are covered. BTW the patch description gives that information.
>>
>> If there is dead code then it is not only the code from this patch
>> but
>> all the code for the default idle handler.
>>
> I read your change log. It says.
>
>>> The trace points are for:
>>> - default idle handler. Since the cpuidle framework is
>>> =A0 instrumented in the generic way there is no need to
>>> =A0 add trace points in the OMAP specific cpuidle handler;
> Now code in cpuilde34xx.c is also OMAP specific and hence the
> confusion at least for me.
> Regarding dead code, I meant existing code of default handler.
>
> Thanks for clarification.
>
> Regards,
> Santosh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
