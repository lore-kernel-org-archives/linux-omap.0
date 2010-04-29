From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Thu, 29 Apr 2010 07:12:58 -0700
Message-ID: <87pr1i5out.fsf@deeprootsystems.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-5-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-7-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-9-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-10-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-11-git-send-email-omar.ramirez@ti.com>
	<1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
	<t2j94a0d4531004280046g49d9a0f9j60a6147b86a1854f@mail.gmail.com>
	<4BD8430B.80909@ti.com> <87bpd3h774.fsf@deeprootsystems.com>
	<4BD863FE.80804@ti.com> <4BD869A1.8070808@ti.com>
	<87zl0nfofv.fsf@deeprootsystems.com> <4BD884D9.8010204@ti.com>
	<87zl0ncne2.fsf@deeprootsystems.com> <4BD98C37.3030806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48792 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354Ab0D3SJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 14:09:35 -0400
Received: by pwj9 with SMTP id 9so306764pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 11:09:33 -0700 (PDT)
In-Reply-To: <4BD98C37.3030806@ti.com> (Benoit Cousson's message of "Thu\, 29 Apr 2010 15\:40\:07 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

Benoit Cousson <b-cousson@ti.com> writes:

> On 4/28/2010 10:50 PM, Kevin Hilman wrote:
>> Nishanth Menon<nm@ti.com>  writes:
>>
>>> Kevin Hilman had written, on 04/28/2010 12:59 PM, the following:
>>>> Omar Ramirez Luna<omar.ramirez@ti.com>  writes:
>>>>
>>>>> On 4/28/2010 11:36 AM, Menon, Nishanth wrote:
>>>>>> Kevin Hilman had written, on 04/28/2010 11:29 AM, the following:
>>>>>>> Omar Ramirez Luna<omar.ramirez@ti.com>   writes:
>>>>>>>
>>>>>>>> On 4/28/2010 2:46 AM, Felipe Contreras wrote:
>>>>>>>>> On Wed, Apr 28, 2010 at 4:29 AM, Omar Ramirez Luna<omar.ramirez@ti.com>    wrote:
>>>>>>>>>> This patch switches to use DM timer framework instead of
>>>>>>>>>> a custom one for GPT timers, currently dsp can make use of
>>>>>>>>>> gpt 5, 6, 7 or 8.
>>>>>>>>> I heard someone that was using gpt 8 for something else. Is it
>>>>>>>>> possible to configure dsp-bridge to not use it?
>>>>>>>>>
>>>>>>>> There are two scenarios:
>>>>>>>>
>>>>>>>> 1. The request comes from the DSP side (afaik for video use case), the
>>>>>>>> change should be in the DSP side binaries to request some other gpt
>>>>>>>> instead. I don't know how possible is to get this changed.
>>>>>>>>
>>>>>>>> 2. bridge driver also requests gpt8 whenever a mmu fault is triggered,
>>>>>>>> this to set a timer to interrupt the dsp after the mmu fault dump has
>>>>>>>> been finished, I think this can be easily replaced in bridge to use
>>>>>>>> some other gpt, but "1" is still there. (besides a new patch is needed
>>>>>>>> to remove direct access to dm timer inside ue_deh and make it to go
>>>>>>>> through dsp-clock)
>>>>>>> Why does Bridge care at all which specific timers it requests?  They
>>>>>>> are all the same, with the exception of GPT1 which is in the WKUP
>>>>>>> powerdomain and already used as the kernel clocksource.
>>>>>>>
>>>>>>> Bridge should just use the generic _request() instead of
>>>>>>> _request_specific()
>>>>>>>
>>>>>> trouble I believe is that DSP BIOS uses a specific timer.
>>>>>>
>>>>> yes, dsp side wants:
>>>>> bios -->  GPT5 (only used during boot up ->  baseimage load)
>>>>> load monitoring -->  GPT 6 (used while the dsp is awake)
>>>>> AV Sync -->  GPT 8 (based on use case)
>>>>>
>>>>> to generate the interrupt for mmu fault case it needs one connected to
>>>>> the dsp interrupt line and only 5, 6, 7 or 8 apply.
>>>>
>>>> Then DSP bios is broken by hard-coding *general purpose* timers.
>>>   /me just eats my own words.
>>> Not really.. I just got educated internally that DSP does not get
>>> interrupts from all GPTs.
>>> Ref: http://focus.ti.com/pdfs/wtbu/SWPU114Q_PrelimFinal_EPDF_03_05_2009.pdf
>>> page 1753 ->  only mentioned these timers can generate interrupts for
>>> DSP, and hence for BIOS's usage.
>>
>> OK, now that part makes sense.
>
> This issue will be even worse on OMAP4 with the CortexM3 (aka Ducati),
> because several IPs like GPIO or GPTIMER will have different IRQ /
> functionality / power partitioning depending of the instance.
> One of the proposed solution we considered, at least for the GPTIMERs,
> was to add an extra API that can allow to request a timer based on the
> needed capabilities and not based on index.
>
> We can easily encode in each GPTIMER HWMOD the specificity of an
> instance like (HAS_DSP_IRQ, HAS_IPU_IRQ, HAS_PWM, IN_WKUP_DOMAIN,
> IN_AUDIO_DOMAIN...).
> Driver can then use a request_timer_per_functionalies(HAS_DSP_IRQ |
> HAS_IPU_IRQ...).
> It will allow driver to be much more independent of the current IP
> implementation for an OMAP version.
>
> Any thoughts?

Yes, this sounds much better.  It makes a lot more sense than
hard-coding specific GPT numbers.

Kevin
