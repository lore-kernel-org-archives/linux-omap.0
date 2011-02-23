From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Wed, 23 Feb 2011 14:16:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BBE29B0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com>
 <4D5A75FF.5040703@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024B83BF08@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD4894D@dbde02.ent.ti.com>
 <4D623ED8.4050906@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD489B1@dbde02.ent.ti.com>
 <4D6273FE.3000205@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD48BED@dbde02.ent.ti.com>,<4D62F7E0.1000102@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BBE29A4@dbde02.ent.ti.com>,<4D643E6A.5020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755139Ab1BWIqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 03:46:46 -0500
In-Reply-To: <4D643E6A.5020705@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

>From: Cousson, Benoit
>Sent: Wednesday, February 23, 2011 4:23 AM
>To: Premi, Sanjeev
>Cc: linux-omap@vger.kernel.org; Paul Walmsley
>Subject: Re: hwmod: multi-omap: disabling smartreflex on AM3517
>
>On 2/22/2011 2:48 PM, Premi, Sanjeev wrote:
>> On 2/21/2011 4:41 PM, Premi, Sanjeev wrote:
>>>
>>> [...]
>>>
>>>>> The comment is already there BTW, so you just have to replace that by some
>>>>> real code:-)
>>>>
>>>> [sp] I have already added real code, but the problem lies here:
>>>>        On same file (few lines up) omap_chip.oc is assigned value of
>>>>        CHIP_IS_OMAP3430. CHIP_IS_AM3517 now needs to be added to all
>>>>        places where CHIP_IS_OMAP3430ES3_1 is chosen.
>>>>
>>>>        All this to support a chip that differs in 4 peripherals and IVA.
>>>>        ... and this is what I was planning to minimize.
>>>
>>> This is what we've being using for some time to handle small diff
>>> between ES.
>>>
>>>>        Leaving aside AM3517; we have AM3703 - same as OMAP3630 but without
>>>>        IVA and SGX. Here obviously hwmods for either of IVA, SGX shouldn't
>>>>        be initialized. Isn't it?
>>>>
>>>>        Creating CHIP_IS_ ... here would be an overkill. Thoughts?
>>>
>>> It depends how many variant you plan to do :-) We still have some room
>>> for 18 more variants / chip.
>>>
>>> You can still create a new CHIP_IS, and add a alias
>>> CHIP_IS_OMAP36XX_COMMON = CHIP_IS_OMAP3630 | CHIP_IS_AM3703 and then
>>> replace all the existing entry with that alias.
>>
>> [sp] This means we would need 5 bits for AM37xx devices. Adding another
>>       5 bits for OMAP35xx and 3 bits for AM35xx device, we are left with
>>       only 5. (Assuming no further silicon revisions across these devices)
>>
>>      We will be short of bits when support for TI814x variants come in.
>>      Also, there are going to be too many ORs for the HWMODs that are
>>      reused across the ARM Cortex-A8 family.
>>
>>      In my previous mail, I was proposing simpler scheme where default
>>      definition is "inclusive" as now; and then ones not applicable for
>>      each specific device is simply "excluded" from consideration before
>>      HWMODs are initialized.
>>
>>>
>>> If we want to avoid using these defines, you will have potentially to
>>> add a feature entry in every hwmod / clock / power domain entry that
>>> already uses the omap_chip today.
>>> And then during the init we can filter on both the chip revision and
>>> chip features.
>>> The drawback is that we are going to waste at least 300 x 32 bits to
>>> store that :-)
>>> Whereas with the extra CHIP_IS_, it is just a couple of defines... no
>>> memory impact.
>>
>> [sp] It is not just one additional bit; but 1 bit for the family e.g.
>>       CHIP_IS_OMAP36XX_COMMON; and then one per variant.
>>
>>       Much less than 300x32 but still lot of code changes compared to
>>       actual difference between the devices.
>>
>>>
>>> In between, you can consider a hwmod class to feature mapping, in order
>>> to know what hwmod class will be excluded if the feature is not there
>>> during the iteration.
>>
>> [sp] Here is what I had been proposing with one hwmod as example.
>>
>> static struct omap_hwmod omap34xx_sr1_hwmod = {
>>       .name           = "sr1_hwmod",
>>
>> ...removed much of code...
>>
>>       .select         = true;         /* new flag. True by default. */
>> };
>>
>> Later:
>>
>> int __init omap3xxx_hwmod_init(void)
>> {
>>       if (cpu_is_omap3505()) {
>>               omap3505_hwmod_select();
>>       }
>>       else if (cpu_is_omap3517()) {
>>               omap3505_hwmod_select();
>>       }
>>       else if (cpu_is_omap34xx()) {
>>               if (cpu_is_omap3503())
>>                       omap3503_hwmod_select();
>>               else if (cpu_is_omap3515())
>>                       omap3515_hwmod_select();
>>       }
>>       ...and so on...
>>
>>       return omap_hwmod_init(omap3xxx_hwmods);
>> }
>>
>> where,
>>
>> void __init omap3505_hwmod_select(void)
>> {
>>       omap34xx_sr1_hwmod.select = false;
>>       omap34xx_sr2_hwmod.select = false;
>>
>>       ... etc. etc. ...
>> }
>>
>> And the omap_hwmod_init() first checks for .select to be true.
>> Current processing works as is.
>>
>> This way, we don't need additional bits per chip variant; and
>> we reuse the existing "feature" bits.
>
>Since you have to add some extra fields anyway, I'd rather add a full
>feature entry.
>It will avoid adding all this code and it will be much more scalable.
>Here you have to update the code and add an extra function for every new
>variant.

[sp] In reality, if we go this route, we don't really need any other field.
     for this purpose.
     
     Once the required HWMODs are selected at init time, we shouldn't need
     any runtime check for applicability - via omap_chip OR otherwise - at
     runtime; but there are other implications so i would rather leave it
     there for now.
     
     Have you looked at the RFC i submitted yesterday - that illustrates
     the change better.

>Do not forget that since OMAP4 we are generating this file, that's why I
>clearly prefer to rely on data information rather that some function.

[sp] This doesn't impact/chhange the auto generation. Because auto-generated
     code can have the select field true by default.

     I am still to understand the differences between OMAP4430 and OMAP4440,
     but wouldn't it be easy to handle the "selection" process in a function.
     Of course, it depends upon how the generation is being done.
>
>Or, we can potentially consider building severals omapxxxx_hwmods lists
>and init only the relevant one based on features.
>
>omap_hwmod_init(omap3xxx_hwmods);
>if (omap3_has_smartreflex())
>        omap_hwmod_init(omap3xxx_sr_hwmods);
>if (omap3_has_iva())
>        omap_hwmod_init(omap3xxx_iva_hwmods);

[sp] So now let us look at differences between AM3517 and OMAP35x.
     1) No smart reflex, No IVA in AM3517.
        => Easily handled by feature as in illustration above.

     2) Voltage domains are collapsed in AM3517. No scalability.
        => Does it really merit to be called feature?
	
     3) These IPs are different - EMAC, USB, VPFE - coming from the
        DaVinci processor series.
	=> Again, they are not features. We can go overboard and
	   make them one viz. davinci_emac, davinci_usb, ...
	   But, would this really scale up as more peripherals are
	   added in each of the AM35x, AM37x and TI816x series.

~sanjeev

>...
>
>This is still not super scalable for my point of view, but much easier
>to handle and update. The advantage being, it will not increase the
>memory usage at all.
>The omap_hwmod_init will just have to be slightly updated to allow
>multiple init.
>
>Regards,
>Benoit
>