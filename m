From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES revisions
Date: Tue, 20 Oct 2009 20:15:45 -0500
Message-ID: <4ADE60C1.9060503@ti.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com> <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com> <4ADE5EE4.2030901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbZJUBPm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 21:15:42 -0400
In-Reply-To: <4ADE5EE4.2030901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon had written, on 10/20/2009 08:07 PM, the following:
> Paul Walmsley had written, on 10/20/2009 06:14 PM, the following:
>> Hi Vikram, Nishanth, Richard,
>>
>> a few comments on this:
>>
>> On Tue, 20 Oct 2009, Vikram Pandita wrote:
>>
>>> Add bits for future expansion of omap_chip_id type field.
>>> This is needed to accomodate 3630ES1 chip id which is bit10
>> ...
>>
>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>>> index 7cb0556..922bf1c 100644
>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>> @@ -45,7 +45,7 @@ int omap_type(void);
>>>  
>>>  struct omap_chip_id {
>>>  	u8 oc;
>>> -	u8 type;
>>> +	u32 type;
>>>  };
>> Just wanted to understand the motivation for using the u32.  
>>
>> Earlier in the life of these patches, two comments were mentioned: the 
>> desire to 'futureproof' and the desire to reserve space for other 
>> 34xx-family parts.
>>
>> Regarding 'futureproofing:' that's part of the reason that a separate 
>> struct was defined for this: to prevent code that uses it from depending 
>> on the size of the type.  (Originally it was a typedef, but Linus hates 
>> typedefs...)  So it shouldn't matter how big or small the type is here, as 
>> long as it can handle all of the bits allocated for it.
>>
>> Also mentioned was the idea of reserving space for other 34xx-family 
>> chips.  I'd suggest simply renumbering the bits when and if those versions 
>> appear.  Code that uses the omap_chip_id system should always use the 
>> macros (e.g. CHIP_IS_OMAP3430) and not encode separate bit shift values, 
>> so renumbering should be completely safe and transparent for core code.  
>> Module code shouldn't be using the omap_chip code, it's for core usage 
>> only.
>>
>> So, since only one bit is being added, why not continue the use of the u8?  
>> Then when the next bits need to be added, the type can be expanded at that 
>> point, and the bits renumbered if necessary.  This should be a completely 
>> transparent operation for code that uses it.  Vikram's original patch:
>>
>>     http://patchwork.kernel.org/patch/54847/
>>
>> should be fine.
> 
> Assumptions:
> a) omap_chip_id is supposedly constant for all devices within the same 
> family. 3630, 3430 rev x will belong to the same family.
> b) we prefer bitops to using cpu_is_blahblah() for reasons of 
> performance (if it could be argued so)..
> 
> Issues with the strategy of restricting to the current 8 bits:
> a) Why extrabits now:
> we have 8 bits now and we would have used all 8 bits with 3630 with the 
> mentioned patch. What do we do with the next revision of 3430? Do we 
> want to increase the size once it comes along? OR Do we want to do it 
> right now? Why wait till we get additional silicons to go figure how to 
> add those bits as Richard pointed out, when there could be one more in 
> the pipeline?
> 
> b) How much extra bits should we add?
> It does not matter when you pull in extra bits - u'd have to go u16 for 
> next rev of 3430, it is gonna be a single entry, what if we end up (god 
> forbid) further revisions of 3630 or even a new gen of omap3 family - 
> call it 3XYZ devices?
> Further how expensive is it to add the u16 Vs u32 size from a memory 
> usage perspective?
> 
> Either way, we could choose:
> a) We can choose to stick with u8 and take the next rev of 3430 ES 
> revision when the time is right
> b) we can choose to stick with u16 for the known future (+allowing for 5 
> more revisions of silicons) of OMAP3.
> c) We can choose to say - no one really knows how many ES/variants of a 
> silicon family could happen for OMAP3/OMAP4/5/6/7 etc.. and choose u32 
> giving us a limit beyond which we might choose to rearchitect things.
> 
> The choice is upto this community to make.. options are very easy to 
> implement ;).
> 
forgot to add an important option (if I understood Paul correctly):
d) Renumber and change the implementation of GE macros.. and check if 
any other places we have'nt mixed up stuff.

-- 
Regards,
Nishanth Menon
/me feels much better now ;)
