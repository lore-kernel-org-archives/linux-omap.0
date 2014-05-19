From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Mon, 19 May 2014 20:06:31 +0200
Message-ID: <537A4827.30604@linaro.org>
References: <5373DD94.8030208@ti.com> <5374F35E.5040900@ti.com> <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com> <5375079E.3060305@ti.com> <537615EA.3020809@ti.com> <20140516212942.GK12881@atomide.com> <537A3544.1050307@linaro.org> <20140519172338.GJ4849@atomide.com> <537A408F.7070301@ti.com> <20140519175157.GK4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:46356 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaESSGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 14:06:21 -0400
Received: by mail-we0-f181.google.com with SMTP id w61so5720710wes.26
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 11:06:19 -0700 (PDT)
In-Reply-To: <20140519175157.GK4849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Alex Shi <alex.shi@linaro.org>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On 05/19/2014 07:51 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [140519 10:35]:
>> On Monday 19 May 2014 01:23 PM, Tony Lindgren wrote:
>>> * Daniel Lezcano <daniel.lezcano@linaro.org> [140519 09:46]:
>>>> On 05/16/2014 11:29 PM, Tony Lindgren wrote:
>>>>>
>>>>> And just to recap, this problem can be reproduced with current
>>>>> Linux next with omap2plus_defconfig with CONFIG_CPU_IDLE enabled.=
 The
>>>>> system should hang during the boot at some point.
>>>>
>>>> I can take the time to investigate a bit more but not right now. W=
hat is
>>>> your deadline before committing the reverts ?
>>>
>>> Well we do have several automated build and boot systems failing
>>> because of this with multi_v7_defconfig. And users are complaining,
>>> see this report from Tobias Jakobi:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D75421
>>>
>>> It seems that doing the revert is not enough based on the
>>> page above.
>>>
>> Thats not true. The above link used the half patch and not the
>> updated patch. Updated patch worked for Alex also. As you can
>> see they saw RCU stalls and they go away after the updated patch.
>>
>> Can you please point them to try out the updated patch ?
>
> OK good point. I added a link to the updated patch in
> bugzilla.
>
>>> I'd prefer we'd fix this issue properly for sure, it seems that
>>> we're not quite understanding what's going on. And this might
>>> hit other platforms too when they start implementing deeper
>>> PM idle states in the mainline kernel.
>>>
>> I am certain that the updated patch fixed the regression
>> for sure. The issue is really not generic enough since its related
>> an OMAP ROM errata which needs that special handling of
>> interrupt re-trigger etc. You don't need that for other platforms
>> so they are not likely get affected.
>
> OK makes sense to me considering the ROM code. Daniel, are you OK
> with that or do you still want to investigate further?

=46or the moment I am a bit short in time for some other tasks. So feel=
=20
free to apply the revert and I will look for a proper fix when I will=20
have time.

Thanks
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
