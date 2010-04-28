From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Wed, 28 Apr 2010 14:57:17 -0500
Message-ID: <4BD8931D.7080307@ti.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-4-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-5-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-6-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-7-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-8-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-9-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-10-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-11-git-send-email-omar.ramirez@ti.com>	<1272418167-12630-12-git-send-email-omar.ramirez@ti.com>	<t2j94a0d4531004280046g49d9a0f9j60a6147b86a1854f@mail.gmail.com>	<4BD8430B.80909@ti.com> <87bpd3h774.fsf@deeprootsystems.com>	<4BD863FE.80804@ti.com> <4BD869A1.8070808@ti.com> <87zl0nfofv.fsf@deeprootsystems.com> <4BD884D9.80
 10204@ti.com> <4BD891F8.7000609@nt.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41280 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab0D1T51 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 15:57:27 -0400
In-Reply-To: <4BD891F8.7000609@nt.tu-darmstadt.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

Vladimir Pantelic had written, on 04/28/2010 02:52 PM, the following:
> Nishanth Menon wrote:
[...]

>>>>> trouble I believe is that DSP BIOS uses a specific timer.
>>>>>
>>>> yes, dsp side wants:
>>>> bios --> GPT5 (only used during boot up -> baseimage load)
>>>> load monitoring --> GPT 6 (used while the dsp is awake)
>>>> AV Sync --> GPT 8 (based on use case)
>>>>
>>>> to generate the interrupt for mmu fault case it needs one connected to
>>>> the dsp interrupt line and only 5, 6, 7 or 8 apply.
>>> Then DSP bios is broken by hard-coding *general purpose* timers.
>>  /me just eats my own words.
>> Not really.. I just got educated internally that DSP does not get
>> interrupts from all GPTs.
>> Ref: http://focus.ti.com/pdfs/wtbu/SWPU114Q_PrelimFinal_EPDF_03_05_2009.pdf
>> page 1753 -> only mentioned these timers can generate interrupts for
>> DSP, and hence for BIOS's usage. Added to this, the fact that GPT PWM is
>> usable on 9,10,11 as well, makes me believe this is something to
>> consider as part of board design based on which peripherals one uses and
>> their constraints. BIOS is not at fault here to use the resources it
>> requires, but is part of system design to look at options, constraints
>> and select the ones appropriately..
>>
>> A similar example is mux pins, you have options to plug to one of many
>> options, but if you plug in both a interrupt and a data line to the same
>> pin which could run in two different modes, there is a problem there
>> right? Alright, that is too obvious i suppose....
> 
> Yes, just that pin mux issues are pretty obvious reading the TRM and DM,
> but the fact that bridge blocks GPT5,6 and 8 is not.
> 
> You are telling me that using all 4 GPTs for PWM or input event capture
> is not possible when using dspbridge? As I understand, bridge mostly
> uses 2 of the GPTs (6 for load monitoring, 8 for sync/mmu fault), so
> I think moving GPT8 to 7 should make both sides happy, no?

Seriously, is this debate going to close even then?
case a) some other guy is gonna use GPT7 then we are all screwed again
case b) the DSPBIOS guys need more GPT to do something else later on (I 
dont know what.. but just guessing), again screwed?
case c) *what if* some bloke is already using GPT7 for some reason of 
his own and he already has a board working, is'nt he screwed if we 
switch to GPT7 now?

-- 
Regards,
Nishanth Menon
