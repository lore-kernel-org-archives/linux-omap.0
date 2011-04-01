From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/10] omap init_early changes for irq and timer init
Date: Fri, 01 Apr 2011 14:09:18 +0530
Message-ID: <4D958F36.6060208@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com> <4D92E21F.6030608@ti.com> <20110330182211.GE18334@atomide.com> <4D943871.4030206@ti.com> <20110331173212.GB21887@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:58360 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088Ab1DAIjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 04:39:32 -0400
Received: by mail-gy0-f181.google.com with SMTP id 4so1516912gyh.12
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 01:39:32 -0700 (PDT)
In-Reply-To: <20110331173212.GB21887@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 3/31/2011 11:02 PM, Tony Lindgren wrote:
> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110331 01:14]:
>> On 3/30/2011 11:52 PM, Tony Lindgren wrote:
>>
>>> What it does not have is the code to dedicate gpt1 for PM
>>> code, which can be done later once all the other dmtimer
>>> changes are done.
>>>
>> Which not possible to do unless you plan to hack generic
>> timer framework or waste additional timer hardware for
>> this.
>
> Well an extra timer hardware would only be needed on omap2&  3.
>
> But hey, if it makes sense to do or not to do is a different
> set of patches. At least we now have an option to play with it.
>
>>> For removing the old interface, I don't see any reason to
>>> select timer combinations on omap3 other than omap3_timer
>>> and omap3_beagle_timer.
>>>
>>> If there's need, any new valid sane combinations can be esily
>>> added, although I seriously doubt that we'll need more for
>>> omap3.
>>>
>> May be I am wrong but the point is about the merit of the
>> solution even if there are only couple of board files where
>> we use that interface.
>>
>> It much cleaner and simpler to say timerid=X, from board
>> file rather than creating a "struct sys_timer" instance
>> and putting that in timer code.
>
> Well the timerid=X adds yet another interface and more calls from
> board-*.c to the common code. And it requires more changes if beagle
> boards want to use the system clock as the source clock instead
> of the 32KiHZ source.
>
> Maybe let's call the omap3_beagle_timer omap3_secure_timer instead?
>
> That should solve your issue of having the board name show up
> in the generic code, no?
>
Sorry about picking up on names but that was not
my point. I agree with you on reducing interfaces so
I step back on this point.

>>>> At least I don't see other solution than using GPT1
>>>> for wakeup.
>>>
>>> Right, there's no other way to wake except gpt1 or wake-up
>>> enabled gpio lines. But we don't need to use gpt1 during
>>> runtime at all.
>>>
>> This is not entirely correct and I think this is the point
>> where we are not on same page. During runtime, gpt1 clock
>> event is not used for tick generation but it's kept
>> programmed because low power state switch via
>> get triggered any time and on any CPU.
>
> Well ideally we would not program it during runtime at all
> because it's slow to program. I don't think that can be
> currently done with the sys_timer.
>
>> This is the same problem as X86 APIC timer + HPET
>> switching and I worked with Thomas G and Russell
>> to get this working on ARM platforms using generic
>> timer framework. No hacking is needed in PM code
>> for this.
>
> Except we should improve things eventually where we don't
> need to program the slow external timer during runtime
> if we have local timers.
>
This is already the case now. On OMAP4 running system,
CPU use their own local timers and rq's. There is no
broadcasting. Whenever there is a need of it like
the situations where local-timers die (low power
states), timer system switches to broad-cast timer
which is wakeup capable. GPT1 in our case. This
is all managed by timer framework and works seamlessly.

> Hmm maybe I'm wrong and you got that working already?
>
I don't think you are wrong. All your points are
correct. The only missing point was the necessity
of GPT1 registered as clock-event to allow
dynamic switching between clock-events.

That's where I was saying that we are not
left with GPT1 for PM debug feature.

Regards
Santosh




