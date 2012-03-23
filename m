From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 3/9] ARM: OMAP3: cpuidle - set enable_off_mode as
 static
Date: Fri, 23 Mar 2012 13:38:10 +0100
Message-ID: <4F6C6EB2.70101@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org> <1332494794-7810-3-git-send-email-daniel.lezcano@linaro.org> <CAORVsuVBC2TgVyt-PFWV878mXpM1GqETQnzdVi0ZYH-2x8D4nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55289 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386Ab2CWMiM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 08:38:12 -0400
Received: by eaaq12 with SMTP id q12so997779eaa.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 05:38:10 -0700 (PDT)
In-Reply-To: <CAORVsuVBC2TgVyt-PFWV878mXpM1GqETQnzdVi0ZYH-2x8D4nQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On 03/23/2012 01:22 PM, Jean Pihet wrote:
> On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> This variable is only used in the pm-debug.c file.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-omap2/pm-debug.c |    2 +-
>>   arch/arm/mach-omap2/pm.h       |   30 ++++++++++++----------------=
--
>>   2 files changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm=
-debug.c
>> index 814bcd9..86aa398 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -38,7 +38,7 @@
>>   #include "prm2xxx_3xxx.h"
>>   #include "pm.h"
>>
>> -u32 enable_off_mode;
>> +static u32 enable_off_mode;
> It is stil needed in cpuidle34xx.c.

ok.

>>   #ifdef CONFIG_DEBUG_FS
>>   #include<linux/debugfs.h>
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index af73a86..f5c3072 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -25,6 +25,18 @@ extern int omap4_idle_init(void);
>>   extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *u=
nused);
>>   extern int (*omap_pm_suspend)(void);
>>
>> +/*
>> + * cpuidle mach specific parameters
>> + *
>> + * The board code can override the default C-states definition usin=
g
>> + * omap3_pm_init_cpuidle
>> + */
>> +struct cpuidle_params {
>> +       u32 exit_latency;       /* exit_latency =3D sleep + wake-up =
latencies */
>> +       u32 target_residency;
>> +       u8 valid;               /* validates the C-state */
>> +};
>> +
> Is this move needed? This will be removed in a later patch.

No, I think I did a bad manipulation.

>>   #if defined(CONFIG_PM_OPP)
>>   extern int omap3_opp_init(void);
>>   extern int omap4_opp_init(void);
>> @@ -39,27 +51,9 @@ static inline int omap4_opp_init(void)
>>   }
>>   #endif
>>
>> -/*
>> - * cpuidle mach specific parameters
>> - *
>> - * The board code can override the default C-states definition usin=
g
>> - * omap3_pm_init_cpuidle
>> - */
>> -struct cpuidle_params {
>> -       u32 exit_latency;       /* exit_latency =3D sleep + wake-up =
latencies */
>> -       u32 target_residency;
>> -       u8 valid;               /* validates the C-state */
>> -};
>> -
>>   extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>>   extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, i=
nt state);
>>
>> -#ifdef CONFIG_PM_DEBUG
>> -extern u32 enable_off_mode;
>> -#else
>> -#define enable_off_mode 0
>> -#endif
>> -
>>   #if defined(CONFIG_PM_DEBUG)&&  defined(CONFIG_DEBUG_FS)
>>   extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev=
);
>>   #else
>> --
>> 1.7.5.4
>>
>
> Jean


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
