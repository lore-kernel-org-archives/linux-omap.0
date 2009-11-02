From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES revisions
Date: Mon, 2 Nov 2009 08:13:21 -0600
Message-ID: <4AEEE901.6010000@ti.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>	 <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com>	 <4ADE5EE4.2030901@ti.com> <71a0d6ff0911020512k478a3f1du929f2abed42be07a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38594 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZKBONU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 09:13:20 -0500
In-Reply-To: <71a0d6ff0911020512k478a3f1du929f2abed42be07a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Alexander Shishkin had written, on 11/02/2009 07:12 AM, the following:
> 2009/10/21 Nishanth Menon <nm@ti.com>:
>> Paul Walmsley had written, on 10/20/2009 06:14 PM, the following:
>>> Hi Vikram, Nishanth, Richard,
>>>
>>> a few comments on this:
>>>
>>> On Tue, 20 Oct 2009, Vikram Pandita wrote:
>>>
>>>> Add bits for future expansion of omap_chip_id type field.
>>>> This is needed to accomodate 3630ES1 chip id which is bit10
>>> ...
>>>
>>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
>>>> b/arch/arm/plat-omap/include/plat/cpu.h
>>>> index 7cb0556..922bf1c 100644
>>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>>> @@ -45,7 +45,7 @@ int omap_type(void);
>>>>   struct omap_chip_id {
>>>>        u8 oc;
>>>> -       u8 type;
>>>> +       u32 type;
>>>>  };
>>> Just wanted to understand the motivation for using the u32.
>>> Earlier in the life of these patches, two comments were mentioned: the
>>> desire to 'futureproof' and the desire to reserve space for other
>>> 34xx-family parts.
>>>
>>> Regarding 'futureproofing:' that's part of the reason that a separate
>>> struct was defined for this: to prevent code that uses it from depending on
>>> the size of the type.  (Originally it was a typedef, but Linus hates
>>> typedefs...)  So it shouldn't matter how big or small the type is here, as
>>> long as it can handle all of the bits allocated for it.
>>>
>>> Also mentioned was the idea of reserving space for other 34xx-family
>>> chips.  I'd suggest simply renumbering the bits when and if those versions
>>> appear.  Code that uses the omap_chip_id system should always use the macros
>>> (e.g. CHIP_IS_OMAP3430) and not encode separate bit shift values, so
>>> renumbering should be completely safe and transparent for core code.  Module
>>> code shouldn't be using the omap_chip code, it's for core usage only.
>>>
>>> So, since only one bit is being added, why not continue the use of the u8?
>>>  Then when the next bits need to be added, the type can be expanded at that
>>> point, and the bits renumbered if necessary.  This should be a completely
>>> transparent operation for code that uses it.  Vikram's original patch:
>>>
>>>    http://patchwork.kernel.org/patch/54847/
>>>
>>> should be fine.
>> Assumptions:
>> a) omap_chip_id is supposedly constant for all devices within the same
>> family. 3630, 3430 rev x will belong to the same family.
> If my understanding of the matter is correct, that's only possible if
> you can foretell the total number of upcoming 34xx revisions worth
> mentioning in the code. Also, can you please elaborate on why is it
> supposed to be constant?
The assumption I made was that omap_chip_id structure was to store info 
regarding the chip and used by the pm framework. The term constant, 
which I used, is probably wrong in this context, esp considering that we 
cannot foretell all the upcoming revisions of the 34xx family.

> 
>> Issues with the strategy of restricting to the current 8 bits:
>> a) Why extrabits now:
>> we have 8 bits now and we would have used all 8 bits with 3630 with the
>> mentioned patch. What do we do with the next revision of 3430? Do we want to
>> increase the size once it comes along? OR Do we want to do it right now? Why
>> wait till we get additional silicons to go figure how to add those bits as
>> Richard pointed out, when there could be one more in the pipeline?
> But this code will have to be revisited for each additional silicon
> revision anyway, right? Why reserve now?
> 
Agreed, that is one of the possible approaches we could take (and seems 
to be the common consensus), we can review the structure at a later 
point of time.

http://patchwork.kernel.org/patch/54847/ seems to be the right direction 
for now at least.

-- 
Regards,
Nishanth Menon
