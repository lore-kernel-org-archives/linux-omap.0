From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Mon, 19 May 2014 18:45:56 +0200
Message-ID: <537A3544.1050307@linaro.org>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com> <5373C78E.7040301@linaro.org> <5373C8E8.6040208@ti.com> <5373CBB9.40506@linaro.org> <5373DD94.8030208@ti.com> <5374F35E.5040900@ti.com> <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com> <5375079E.3060305@ti.com> <537615EA.3020809@ti.com> <20140516212942.GK12881@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:56764 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbaESQpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 12:45:45 -0400
Received: by mail-we0-f179.google.com with SMTP id q59so5700193wes.24
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 09:45:44 -0700 (PDT)
In-Reply-To: <20140516212942.GK12881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Alex Shi <alex.shi@linaro.org>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On 05/16/2014 11:29 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [140516 06:43]:
>> Tony,
>>
>> On Thursday 15 May 2014 02:29 PM, Santosh Shilimkar wrote:
>>> On Thursday 15 May 2014 01:54 PM, Santosh Shilimkar wrote:
>>>> On Thursday 15 May 2014 01:50 PM, Daniel Lezcano wrote:
>>>>> On 05/15/2014 07:03 PM, Santosh Shilimkar wrote:
>>>
>>> [..]
>>>
>>>>>>> With above mentioned change, it should work. Other alternatives=
 is OMAP4 driver does
>>>>>>> its won registration where it can start the timer. The way it w=
as before the
>>>>>>> consolidation.
>>>>>>>
>>>>>>> Ofcourse if you have better fix, then great.
>>>>>>>
>>>>>> What is your suggestion. We *must* fix the regression asap. I th=
ink
>>>>>> $subject patch with an update to bctimer start under CPUIDLE_FLA=
G_COUPLED
>>>>>> seems a good way forward.
>>>>>>
>>>>>> Do let me know.
>>>>>
>>>>> Did you see Alex Shi's email [cc'ed] ? Reverting this change make=
s the panda ES to hang.
>>>>>
>>>> The hang is definitely due to the bctimer not started. As I said, =
I assumed it was and
>>>> then you corrected saying it is under the flag.
>>>>
>>>>> I am not convinced the culprit is this code you are trying to rev=
ert.
>>>>>
>>>> fair enough. Thats why I said if you have an alternative fix thats=
 great.
>>>>
>>> For record, below is updated patch with bctimer started which
>>> was missed in earlier version. I haven't tested it though.
>>>
>>> Alex,
>>> Please give a try with your test-case and see if you still see the =
hang.
>>> Am just curious about your issue and hence the request..
>>>
>> Alex tested below patch and he don't see the hang so the patch is
>> addressing the issue.
>>
>> If Daniel works out an alternate fix to avoid reverts, that will be =
great
>> but if not, we should merge the below patch. I let you take call on =
it.
>
> Daniel any news on this?
>
> And just to recap, this problem can be reproduced with current
> Linux next with omap2plus_defconfig with CONFIG_CPU_IDLE enabled. The
> system should hang during the boot at some point.

I can take the time to investigate a bit more but not right now. What i=
s=20
your deadline before committing the reverts ?

> And for the record, the omap3 hang fix is now posted to the lists as
> "[PATCH] ARM: OMAP2+: Fix DMA hang after off-idle". This should not
> have anything to do with the omap4 cpu_idle hang as omap4 does not
> currently lose context during idle.


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
