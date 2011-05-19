From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 08/13] OMAP2+: PM: provide the next timer event API to PM modules
Date: Thu, 19 May 2011 14:02:33 +0200
Message-ID: <BANLkTik9Kki2E=NxTXPhdpEk5DcjKbZYeQ@mail.gmail.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
	<1305739950-11695-9-git-send-email-j-pihet@ti.com>
	<4DD4CDDB.5040607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38342 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab1ESMCd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 08:02:33 -0400
Received: by qyg14 with SMTP id 14so1484076qyg.19
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 05:02:33 -0700 (PDT)
In-Reply-To: <4DD4CDDB.5040607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Santosh,

On Thu, May 19, 2011 at 9:59 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Jean,
>
> On 5/18/2011 11:02 PM, jean.pihet@newoldbits.com wrote:
>>
>> From: Jean Pihet<j-pihet@ti.com>
>>
>> Provide omap_pm_tick_nohz_get_sleep_length_us so that the code
>> from the OMAP PM modules can use it.
>>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm-debug.c | =A0 =A07 ++++---
>> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 | =A0 15 +++++++++++++++
>> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 | =A0 12 ++++++++----
>> =A03 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm-debug.c
>> b/arch/arm/mach-omap2/pm-debug.c
>> index 0b896d4..24e5c31 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -141,9 +141,10 @@ void omap2_pm_dump(int mode, int resume, unsign=
ed int
>> us)
>> =A0 =A0 =A0 =A0if (!resume)
>> =A0#ifdef CONFIG_NO_HZ
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"--- Going to %s %s (ne=
xt timer after %u ms)\n",
>> s1, s2,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0jiffies_to_msecs(get_ne=
xt_timer_interrupt(jiffies)
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 jiffies));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"--- Going to %s %s (ne=
xt timer after %lu ms)\n",
>> s1, s2,
>> +
>> =A0DIV_ROUND_UP(omap_pm_tick_nohz_get_sleep_length_us(),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 1000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
>> =A0#else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "--- Going to %s %s\=
n", s1, s2);
>> =A0#endif
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 37a4801..0c451e3 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -14,6 +14,8 @@
>> =A0#include<linux/io.h>
>> =A0#include<linux/err.h>
>> =A0#include<linux/opp.h>
>> +#include<linux/hrtimer.h>
>> +#include<linux/tick.h>
>>
>> =A0#include<plat/omap-pm.h>
>> =A0#include<plat/omap_device.h>
>> @@ -30,6 +32,7 @@ static struct omap_device_pm_latency *pm_lats;
>> =A0struct cpuidle_params *cpuidle_params_override_table;
>> =A0#endif
>>
>> +#ifdef CONFIG_PM_DEBUG
>> =A0u32 enable_off_mode;
>> =A0EXPORT_SYMBOL(enable_off_mode);
>>
>> @@ -37,6 +40,7 @@ int omap2_pm_debug;
>> =A0u32 sleep_while_idle;
>> =A0u32 wakeup_timer_seconds;
>> =A0u32 wakeup_timer_milliseconds;
>> +#endif
>>
>> =A0static struct device *mpu_dev;
>> =A0static struct device *iva_dev;
>> @@ -292,6 +296,7 @@ void omap3_pm_init_cpuidle(struct cpuidle_params
>> *cpuidle_board_params)
>> =A0}
>> =A0#endif
>>
>> +#ifdef CONFIG_PM_DEBUG
>> =A0void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
>> =A0{
>> =A0 =A0 =A0 =A0u32 tick_rate, cycles;
>> @@ -308,4 +313,14 @@ void omap2_pm_wakeup_on_timer(u32 seconds, u32
>> milliseconds)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" (%d ticks at %d ticks/sec.)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seconds, milliseconds, cycles, tick_r=
ate);
>> =A0}
>> +EXPORT_SYMBOL(omap2_pm_wakeup_on_timer);
>> +#endif
>> +
>> +#ifdef CONFIG_NO_HZ
>> +unsigned long omap_pm_tick_nohz_get_sleep_length_us(void)
>> +{
>> + =A0 =A0 =A0 return ktime_to_us(tick_nohz_get_sleep_length());
>> +}
>> +EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
>
> This wrapper seems to be un-necesssary. You can directly use
> "ktime_to_us(tick_nohz_get_sleep_length())" instead.
No because tick_nohz_get_sleep_length is not exported to modules.

>
> Regards
> Santosh
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
