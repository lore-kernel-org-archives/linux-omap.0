From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP: HWMOD: Bug fixes in hwmod structure definitions
Date: Tue, 23 Feb 2010 19:45:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321A204BB@dbde02.ent.ti.com>
References: <1266483755-22878-1-git-send-email-thara@ti.com>
 <alpine.DEB.2.00.1002181348120.24812@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49943 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538Ab0BWOPx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 09:15:53 -0500
In-Reply-To: <alpine.DEB.2.00.1002181348120.24812@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Paul Walmsley [mailto:paul@pwsan.com]
>>Sent: Friday, February 19, 2010 2:20 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH] OMAP: HWMOD: Bug fixes in hwmod structure definitions
>>
>>Hello Thara,
>>
>>some comments.
>>
>>On Thu, 18 Feb 2010, Thara Gopinath wrote:
>>
>>> This patch corrects the width of some variables in hwmod structures
>>> where the values to be stored in these variables exceed the current
>>> field width.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> ---
>>>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++---
>>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-
>>omap/include/plat/omap_hwmod.h
>>> index 921990e..06a7f20 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> @@ -258,7 +258,7 @@ struct omap_hwmod_sysconfig {
>>>  	u16 sysc_offs;
>>>  	u16 syss_offs;
>>>  	u8 idlemodes;
>>> -	u8 sysc_flags;
>>> +	u16 sysc_flags;
>>
>>This part is fine.
>>
>>>  	u8 clockact;
>>>  };
>>>
>>> @@ -280,9 +280,9 @@ struct omap_hwmod_sysconfig {
>>>  struct omap_hwmod_omap2_prcm {
>>>  	s16 module_offs;
>>>  	u8 prcm_reg_id;
>>> -	u8 module_bit;
>>> +	u32 module_bit;
>>>  	u8 idlest_reg_id;
>>> -	u8 idlest_idle_bit;
>>> +	u32 idlest_idle_bit;
>>>  	u8 idlest_stdby_bit;
>>>  };
>>
>>This part I don't understand.  These are bit shifts in a 32 bit register,
>>e.g., (1 << idlest_idle_bit), so how could these ever exceed 31?

Hi Paul,

Oh... ok. I was under the impression these bits are to be assigned the value
1 << shift.. My bad.. Do you want me to re sumbmit the patch with just the
first fix.

Regards
Thara

>>
>>
>>- Paul
