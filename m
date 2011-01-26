From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Wed, 26 Jan 2011 10:49:41 +0100
Message-ID: <AANLkTikJY2bf=ryXFAkJNZVU2A38wvEAmxipy8gJTow1@mail.gmail.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com>
	<8d92d0aaa1ed67af244e8b50f9de372e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56770 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1AZJtm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 04:49:42 -0500
Received: by qwa26 with SMTP id 26so728010qwa.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 01:49:42 -0800 (PST)
In-Reply-To: <8d92d0aaa1ed67af244e8b50f9de372e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

On Mon, Jan 24, 2011 at 3:55 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Jean
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
>> Sent: Monday, January 24, 2011 7:51 PM
>> To: Thomas Renninger; linux-omap@vger.kernel.org
>> Cc: Jean Pihet
>> Subject: [PATCH] perf: add OMAP support for the new power events
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The patch adds the new power management trace points for
>> the OMAP architecture.
>>
>> The trace points are for:
>> - default idle handler. Since the cpuidle framework is
>> =A0 instrumented in the generic way there is no need to
>> =A0 add trace points in the OMAP specific cpuidle handler;
>> - cpufreq (DVFS),
>> - SoC clocks changes (enable, disable, set_rate),
>> - change of power domains next power states.
>>
>> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS
>>
> [....]
>
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
>> omap2/powerdomain.c
>> index eaed0df..e1feb50 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -19,12 +19,15 @@
>> =A0#include <linux/list.h>
>> =A0#include <linux/errno.h>
>> =A0#include <linux/string.h>
>> +#include <trace/events/power.h>
>> +
>> =A0#include "cm2xxx_3xxx.h"
>> =A0#include "prcm44xx.h"
>> =A0#include "cm44xx.h"
>> =A0#include "prm2xxx_3xxx.h"
>> =A0#include "prm44xx.h"
>>
>> +#include <asm/cpu.h>
>> =A0#include <plat/cpu.h>
>> =A0#include "powerdomain.h"
>> =A0#include "clockdomain.h"
>> @@ -406,8 +409,11 @@ int pwrdm_set_next_pwrst(struct powerdomain
>> *pwrdm, u8 pwrst)
>> =A0 =A0 =A0 pr_debug("powerdomain: setting next powerstate for %s to
>> %0x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->name, pwrst);
>>
>> - =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
>> + =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_power_domain_target(pwrdm->name, pwr=
st,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 smp_processor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_set_next_pwrst=
(pwrdm, pwrst);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>> =A0}
> We need to track the actual power domain transitions as well
> at hardware level.
Agree

> Can you please look at "pwrdm_pre_transition()" and
> "pwrdm_post_transition()"
> This code keep track of it using the next power state
> and prev-power state.
The current API only has 'trace_power_domain_target' which tracks the
desired target state.
I think we need an extra tracer 'trace_power_domain_hitstate' so that
the trace parser can compare the desired ('target') and actually hit
('hitstate') states.

Thanks,
Jean

>
> Regards,
> Santosh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
