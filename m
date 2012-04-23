From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 02/17][V2] ARM: OMAP4: cpuidle - Declare the states with
 the driver declaration
Date: Tue, 24 Apr 2012 00:11:46 +0200
Message-ID: <4F95D3A2.9010201@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org> <1333570371-1389-3-git-send-email-daniel.lezcano@linaro.org> <87vcl8a5wb.fsf@ti.com> <4F901A03.9080000@linaro.org> <4F9561F7.3000306@linaro.org> <878vhml6ku.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38248 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2DWWLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 18:11:47 -0400
Received: by wejx9 with SMTP id x9so16961wej.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 15:11:46 -0700 (PDT)
In-Reply-To: <878vhml6ku.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 04/23/2012 07:08 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> On 04/19/2012 03:58 PM, Daniel Lezcano wrote:
>>> On 04/10/2012 12:37 AM, Kevin Hilman wrote:
>>>> Daniel Lezcano<daniel.lezcano@linaro.org>   writes:
>>>>
>>>>> The cpuidle API allows to declare statically the states in the dr=
iver
>>>>> structure. Let's use it.
>>>>> We do no longer need the fill_cstate function called at runtime a=
nd
>>>>> by the way adding more instructions at boot time.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>>>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>>>>> Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>>>> ---
>>>>>    arch/arm/mach-omap2/cpuidle44xx.c |   57
>>>>> +++++++++++++++++++++---------------
>>>>>    1 files changed, 33 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c
>>>>> b/arch/arm/mach-omap2/cpuidle44xx.c
>>>>> index ee0bc50..6d86b59 100644
>>>>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>>>>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>>>>> @@ -132,21 +132,39 @@ struct cpuidle_driver omap4_idle_driver =3D=
 {
>>>>>        .name                =3D "omap4_idle",
>>>>>        .owner                =3D THIS_MODULE,
>>>>>        .en_core_tk_irqen        =3D 1,
>>>>> +    .states =3D {
>>>>> +        {
>>>>> +            /* C1 - CPU0 ON + CPU1 ON + MPU ON */
>>>>> +            .exit_latency =3D 2 + 2,
>>>>> +            .target_residency =3D 5,
>>>>> +            .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>>>> +            .enter =3D omap4_enter_idle,
>>>>> +            .name =3D "C1",
>>>>> +            .desc =3D "MPUSS ON"
>>>>> +        },
>>>>> +        {
>>>>> +                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR *=
/
>>>>> +            .exit_latency =3D 328 + 440,
>>>>> +            .target_residency =3D 960,
>>>>> +            .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>>>> +            .enter =3D omap4_enter_idle,
>>>>> +            .name =3D "C2",
>>>>> +            .desc =3D "MPUSS CSWR",
>>>>> +        },
>>>>> +        {
>>>>> +            /* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
>>>>> +            .exit_latency =3D 460 + 518,
>>>>> +            .target_residency =3D 1100,
>>>>> +            .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>>>> +            .enter =3D omap4_enter_idle,
>>>>> +            .name =3D "C3",
>>>>> +            .desc =3D "MPUSS OSWR",
>>>>> +        },
>>>>> +    },
>>>>> +    .state_count =3D OMAP4_NUM_STATES,
>>>>
>>>> I think you can drop OMAP4_NUM_STATES here, and just use:
>>>>
>>>>      .state_count =3D ARRAY_SIZE(omap4_idle_driver.states),
>>>>
>>>> Then drop OMAP4_NUM_STATES all together in patch 3.
>>>
>>> Ok.
>>
>> I said 'ok' but it is not :)
>>
>> omap4_idle_driver.states has a fixed length which is CPUIDLE_STATE_M=
AX (8).
>> We need to define it manually as 3 for now.
>
> I don't see the connection between the two.
>
> Why can't you use ARRAY_SIZE(), and just have an error check later in
> the init to see if state_count>  max.


Maybe I misunderstood but you say:

=2Estate_count =3D ARRAY_SIZE(omap4_idle_driver.states),

As in the cpuidle structure, the state array is CPUIDLE_STATE_MAX,=20
ARRAY_SIZE will always return 8, not the number of the initialized stat=
es.

Anyway, I modified the patchset to use ARRAY_SIZE on the omap4_idle_dat=
a=20
array, so we have:

=2Estate_count =3D ARRAY_SIZE(omap4_idle_data),

   -- Daniel

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
