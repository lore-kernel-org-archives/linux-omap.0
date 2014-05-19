From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Mon, 19 May 2014 16:00:44 -0400
Message-ID: <537A62EC.1080806@ti.com>
References: <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com> <5375079E.3060305@ti.com> <537615EA.3020809@ti.com> <20140516212942.GK12881@atomide.com> <537A3544.1050307@linaro.org> <20140519172338.GJ4849@atomide.com> <537A408F.7070301@ti.com> <20140519175157.GK4849@atomide.com> <537A4827.30604@linaro.org> <20140519193622.GA11945@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59223 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaESUBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 16:01:15 -0400
In-Reply-To: <20140519193622.GA11945@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Alex Shi <alex.shi@linaro.org>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

On Monday 19 May 2014 03:36 PM, Tony Lindgren wrote:
> * Daniel Lezcano <daniel.lezcano@linaro.org> [140519 11:07]:
>> On 05/19/2014 07:51 PM, Tony Lindgren wrote:
>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [140519 10:35]:
>>>> On Monday 19 May 2014 01:23 PM, Tony Lindgren wrote:
>>>>> * Daniel Lezcano <daniel.lezcano@linaro.org> [140519 09:46]:
>>>>>> On 05/16/2014 11:29 PM, Tony Lindgren wrote:
>>>>>>>
>>>>>>> And just to recap, this problem can be reproduced with current
>>>>>>> Linux next with omap2plus_defconfig with CONFIG_CPU_IDLE enabled. The
>>>>>>> system should hang during the boot at some point.
>>>>>>
>>>>>> I can take the time to investigate a bit more but not right now. What is
>>>>>> your deadline before committing the reverts ?
>>>>>
>>>>> Well we do have several automated build and boot systems failing
>>>>> because of this with multi_v7_defconfig. And users are complaining,
>>>>> see this report from Tobias Jakobi:
>>>>>
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=75421
>>>>>
>>>>> It seems that doing the revert is not enough based on the
>>>>> page above.
>>>>>
>>>> Thats not true. The above link used the half patch and not the
>>>> updated patch. Updated patch worked for Alex also. As you can
>>>> see they saw RCU stalls and they go away after the updated patch.
>>>>
>>>> Can you please point them to try out the updated patch ?
>>>
>>> OK good point. I added a link to the updated patch in
>>> bugzilla.
>>>
>>>>> I'd prefer we'd fix this issue properly for sure, it seems that
>>>>> we're not quite understanding what's going on. And this might
>>>>> hit other platforms too when they start implementing deeper
>>>>> PM idle states in the mainline kernel.
>>>>>
>>>> I am certain that the updated patch fixed the regression
>>>> for sure. The issue is really not generic enough since its related
>>>> an OMAP ROM errata which needs that special handling of
>>>> interrupt re-trigger etc. You don't need that for other platforms
>>>> so they are not likely get affected.
>>>
>>> OK makes sense to me considering the ROM code. Daniel, are you OK
>>> with that or do you still want to investigate further?
>>
>> For the moment I am a bit short in time for some other tasks. So feel free
>> to apply the revert and I will look for a proper fix when I will have time.
> 
> Added Tobias to Cc. At the bugzilla link Tobias is saying
> he used the right patch from Santosh to test and it still 
> fails.
> 
The link of the patch in bugzilla shows that it was not the updated
patch and that was my reference point. The other bugzilla issue seems to
be different and mostly not related to cpuidle. I could be wrong.

----------------------

dmesg | grep idle:
cpuidle: using governor ladder
cpuidle: using governor menu

grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*:
(now attached as 'cpuidle states')

The 'BUG' looks like this:
BUG: scheduling while atomic: swapper/1/0/0xffff0000
Modules linked in: ctr ccm btrfs xor xor_neon zlib_inflate zlib_deflate omapfb cfbfillrect cfbimgblt cfbcopyarea raid6_pq arc4 wl12xx wlcore mac80211 cfg80211 rfkill usb_storage snd_soc_omap_hdmi snd_soc_omap_hdmi_card wlcore_sdio
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W     3.15.0-rc5+ #1
Backtrace: 
[<c001152c>] (dump_backtrace) from [<c00116c8>] (show_stack+0x18/0x1c)
 r6:eb894000 r5:00000001 r4:00000000 r3:00000000
[<c00116b0>] (show_stack) from [<c0430a94>] (dump_stack+0x7c/0x98)
[<c0430a18>] (dump_stack) from [<c042ec10>] (__schedule_bug+0x48/0x60)
 r4:00000000 r3:00000153
[<c042ebc8>] (__schedule_bug) from [<c0432248>] (__schedule+0x41c/0x4b4)
 r4:2b9fe000 r3:00000000
[<c0431e2c>] (__schedule) from [<c04323d4>] (schedule+0x38/0x88)
 r10:eb894000 r9:eb894000 r8:00000000 r7:eb894000 r6:c05b0450 r5:c05b04a0
 r4:eb894000
[<c043239c>] (schedule) from [<c04326fc>] (schedule_preempt_disabled+0x10/0x14)
[<c04326ec>] (schedule_preempt_disabled) from [<c006d8f0>] (cpu_startup_entry+0xec/0x22c)
[<c006d804>] (cpu_startup_entry) from [<c00131a4>] (secondary_start_kernel+0xe8/0x100)
 r7:c05de240
[<c00130bc>] (secondary_start_kernel) from [<80008664>] (0x80008664)
 r4:ab87c06a r3:c000864c
----------------------


