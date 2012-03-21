From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 2/7] ARM: OMAP4: cpuidle - Declare the states with
 the driver declaration
Date: Wed, 21 Mar 2012 15:12:31 +0100
Message-ID: <4F69E1CF.8030703@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org> <CAORVsuV-0xQx6W0iKGO_UduESFwdD-44vsBAcVXD0Yy-VB_eGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58837 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030462Ab2CUOMf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 10:12:35 -0400
Received: by bkcik5 with SMTP id ik5so935918bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 07:12:34 -0700 (PDT)
In-Reply-To: <CAORVsuV-0xQx6W0iKGO_UduESFwdD-44vsBAcVXD0Yy-VB_eGw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On 03/21/2012 02:31 PM, Jean Pihet wrote:
> On Wed, Mar 21, 2012 at 10:27 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> The cpuidle API allows to declare statically the states in the drive=
r
>> structure. Let's use it.
>> We do no longer need the fill_cstate function called at runtime and
>> by the way adding more instructions at boot time.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-omap2/cpuidle44xx.c |   56 +++++++++++++++++++++----=
------------
>>   1 files changed, 32 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2=
/cpuidle44xx.c
>> index 1210229..cd6bee7 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>> @@ -148,21 +148,38 @@ DEFINE_PER_CPU(struct cpuidle_device, omap4_id=
le_dev);
>>   struct cpuidle_driver omap4_idle_driver =3D {
>>         .name =3D         "omap4_idle",
>>         .owner =3D        THIS_MODULE,
>> +       .states =3D {
>> +               {
>> +                       /* C1 - CPU0 ON + CPU1 ON + MPU ON */
>> +                       .exit_latency =3D 2 + 2,
>> +                       .target_residency =3D 5,
>> +                       .flags =3D CPUIDLE_FLAG_TIME_VALID,
>> +                       .enter =3D omap4_enter_idle,
>> +                       .name =3D "C1",
>> +                       .desc =3D "MPUSS ON"
>> +               },
> ...
>> +       },
>> +       .state_count =3D OMAP4_NUM_STATES,
>>   };
>>
>> -static inline void _fill_cstate(struct cpuidle_driver *drv,
>> -                                       int idx, const char *descr)
>> -{
>> -       struct cpuidle_state *state =3D&drv->states[idx];
>> -
>> -       state->exit_latency     =3D cpuidle_params_table[idx].exit_l=
atency;
>> -       state->target_residency =3D cpuidle_params_table[idx].target=
_residency;
>> -       state->flags            =3D CPUIDLE_FLAG_TIME_VALID;
>> -       state->enter            =3D omap4_enter_idle;
>> -       sprintf(state->name, "C%d", idx + 1);
>> -       strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
>> -}
> I am OK with this change, which makes the code more readable (and so
> maintainable).
>
>> -
>>   static inline struct omap4_idle_statedata *_fill_cstate_usage(
>>                                         struct cpuidle_device *dev,
>>                                         int idx)
>> @@ -196,37 +213,28 @@ int __init omap4_idle_init(void)
>>         if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
>>                 return -ENODEV;
>>
>> -
>> -       drv->safe_state_index =3D -1;
>>         dev =3D&per_cpu(omap4_idle_dev, cpu_id);
>>         dev->cpu =3D cpu_id;
>>
>> -       /* C1 - CPU0 ON + CPU1 ON + MPU ON */
>> -       _fill_cstate(drv, 0, "MPUSS ON");
>> -       drv->safe_state_index =3D 0;
> I would keep this or add a clear comment that C1 is the safe state.

Actually with the driver's states declaration, the safe_state_index is=20
initialized to zero, which means the default safe_state is always 0 wit=
h=20
the new API. But I can add the initialization anyway in the structure=20
declaration if you want.

> ...
>
> Thanks,
> Jean
>
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


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
