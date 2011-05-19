From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 1/6 v2] OMAP2+: cpufreq: free up table on exit
Date: Thu, 19 May 2011 08:48:32 -0500
Message-ID: <BANLkTikCRRBZUH+GXt52uc1osXwkZ=FWdw@mail.gmail.com>
References: <1305704266-17623-2-git-send-email-nm@ti.com> <87liy39eac.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:37931 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932921Ab1ESNsz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 09:48:55 -0400
Received: by wye20 with SMTP id 20so2193428wye.6
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 06:48:52 -0700 (PDT)
In-Reply-To: <87liy39eac.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, May 19, 2011 at 05:26, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> freq_table allocated by opp_init_cpufreq_table in omap_cpu_init
>> needs to be freed in omap_cpu_exit.
>
> Actually it needs to be freed by a corresponding OPP layer function.
>
> IOW, what happens if the OPP core code switches from using kmalloc to
> static tables, or something else? =A0 =A0The cleanup should be done b=
y the
> same layer that does the init/alloc.

Agreed. We can introduce a new api in OPP layer to free up as well. I
will post a patch for it.
Regards,
Nishanth Menon

> Kevin
>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 =A03 +++
>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach=
-omap2/omap2plus-cpufreq.c
>> index d53ce23..e38ebb8 100644
>> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> @@ -26,6 +26,7 @@
>> =A0#include <linux/clk.h>
>> =A0#include <linux/io.h>
>> =A0#include <linux/opp.h>
>> +#include <linux/slab.h>
>> =A0#include <linux/cpu.h>
>>
>> =A0#include <asm/system.h>
>> @@ -216,6 +217,8 @@ static int __cpuinit omap_cpu_init(struct cpufre=
q_policy *policy)
>> =A0static int omap_cpu_exit(struct cpufreq_policy *policy)
>> =A0{
>> =A0 =A0 =A0 clk_exit_cpufreq_table(&freq_table);
>> + =A0 =A0 kfree(freq_table);
>> + =A0 =A0 freq_table =3D NULL;
>> =A0 =A0 =A0 clk_put(mpu_clk);
>> =A0 =A0 =A0 return 0;
>> =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
