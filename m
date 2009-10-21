From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES revisions
Date: Wed, 21 Oct 2009 23:18:45 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA23E99D@dbde02.ent.ti.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>
 <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36696 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638AbZJURsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 13:48:46 -0400
In-Reply-To: <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com]
>Sent: Tuesday, October 20, 2009 6:15 PM
>To: Pandita, Vikram; Woodruff, Richard; Menon, Nishanth
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES revisions
>
>Hi Vikram, Nishanth, Richard,
>
>a few comments on this:
>
>On Tue, 20 Oct 2009, Vikram Pandita wrote:
>
>> Add bits for future expansion of omap_chip_id type field.
>> This is needed to accomodate 3630ES1 chip id which is bit10
>
>...
>
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>> index 7cb0556..922bf1c 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -45,7 +45,7 @@ int omap_type(void);
>>
>>  struct omap_chip_id {
>>  	u8 oc;
>> -	u8 type;
>> +	u32 type;
>>  };
>
>Just wanted to understand the motivation for using the u32.
>
>Earlier in the life of these patches, two comments were mentioned: the
>desire to 'futureproof' and the desire to reserve space for other
>34xx-family parts.
>
>Regarding 'futureproofing:' that's part of the reason that a separate
>struct was defined for this: to prevent code that uses it from depending
>on the size of the type.  (Originally it was a typedef, but Linus hates
>typedefs...)  So it shouldn't matter how big or small the type is here, as
>long as it can handle all of the bits allocated for it.
>
>Also mentioned was the idea of reserving space for other 34xx-family
>chips.  I'd suggest simply renumbering the bits when and if those versions
>appear.  Code that uses the omap_chip_id system should always use the
>macros (e.g. CHIP_IS_OMAP3430) and not encode separate bit shift values,
>so renumbering should be completely safe and transparent for core code.
>Module code shouldn't be using the omap_chip code, it's for core usage
>only.
>
>So, since only one bit is being added, why not continue the use of the u8?
>Then when the next bits need to be added, the type can be expanded at that
>point, and the bits renumbered if necessary.  This should be a completely
>transparent operation for code that uses it.  Vikram's original patch:
>
>    http://patchwork.kernel.org/patch/54847/

My preference is to go with version one patch.
As and when required, should we add the bits.


>
>should be fine.
>
>Or am I missing something?
>
>
>- Paul

