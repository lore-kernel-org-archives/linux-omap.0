From: kishon <a0393678@ti.com>
Subject: Re: [RFC: PATCH] Fix to support multiple HWMODS for a single device
Date: Mon, 23 Aug 2010 21:50:01 +0530
Message-ID: <4C729FB1.2000907@ti.com>
References: <1282560403-30375-1-git-send-email-kishon@ti.com> <4C726051.9020703@ti.com> <0680EC522D0CC943BC586913CF3768C003B39A3A55@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57000 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584Ab0HWQUL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 12:20:11 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B39A3A55@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

Thanks Benoit for your review comments.

On Monday 23 August 2010 05:31 PM, Datta, Shubhrajyoti wrote:
>
>    
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
>> Sent: Monday, August 23, 2010 5:20 PM
>> To: ABRAHAM, KISHON VIJAY
>> Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
>> paul@pwsan.com
>> Subject: Re: [RFC: PATCH] Fix to support multiple HWMODS for a single
>> device
>>
>> Hi Vijay,
>>
>> On 8/23/2010 12:46 PM, ABRAHAM, KISHON VIJAY wrote:
>>      
>>> The current HWMOD code expects multiple HWMODS to be filled in
>>>        
>> consecutive
>>      
>>> memory location before passing to omap_device_build_ss().
>>>        
>> Just a minor comment: this is not the "The current HWMOD code" but the
>> omap_device core code.
>>
>>      
>>> Ignoring this
>>> will result in incorrect HWMOD data being extracted. This means before
>>>        
>> calling
>>      
>>> omap_device_build_ss() the user has to create memory chunks, copy all
>>>        
>> the HWMOD
>>      
>>> structures to it taking care of the mutex.
>>>        
>> I don't think it was an expectation, this is simply a bug :-)
>> So copying hwmod structures before calling this API is clearly not the
>> right way to do fix that...
>>
>>      
>>> This fix uses the pointer to pointer to OMAP_HWMOD structure passed to
>>> omap_device_build_ss() to correctly extract the appropriate
>>> OMAP_HWMOD structure.
>>>        
>> Yes, this is the proper way of fixing that.
>>
>>      
>>> This patch is created on top of origin/pm-wip/hwmods-omap4.
>>>        
>> You can do it on the mainline too, there is no dependency with lo/master
>> or pm-wip for that one. That fix will be able to go to mainline faster.
>>
>>      
>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>> ---
>>>    arch/arm/plat-omap/omap_device.c |   42 +++++++++++++++++++-----------
>>>        
>> --------
>>      
>>>    1 files changed, 21 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-
>>>        
>> omap/omap_device.c
>>      
>>> index d2b1609..e94bd7a 100644
>>> --- a/arch/arm/plat-omap/omap_device.c
>>> +++ b/arch/arm/plat-omap/omap_device.c
>>> @@ -257,12 +257,12 @@ static inline struct omap_device
>>>        
>> *_find_by_pdev(struct platform_device *pdev)
>>      
>>>     */
>>>    int omap_device_count_resources(struct omap_device *od)
>>>    {
>>> -	struct omap_hwmod *oh;
>>> +	struct omap_hwmod **oh;
>>>    	int c = 0;
>>>    	int i;
>>>
>>> -	for (i = 0, oh = *od->hwmods; i<   od->hwmods_cnt; i++, oh++)
>>> -		c += omap_hwmod_count_resources(oh);
>>> +	for (i = 0, oh = od->hwmods; i<   od->hwmods_cnt; i++, oh++)
>>> +		c += omap_hwmod_count_resources(*oh);
>>>        
>> In that case, you might prefer using array type of access in order to
>> make the code more readable (i.e. oh[i]). Or even avoid the oh variable.
>>
>>    +		c += omap_hwmod_count_resources(od->hwmods[i]);
>>
>> Just for my information, what kind of device are you working on that
>> require multiple hwmods?
>>      
>
> The McBSP qualifies for 2 hwmods and 1 device as OMAP3 has sidetone support also.
>
>    
>> Otherwise, this is a good catch. Thanks for fixing that.
>>
>> Regards,
>> Benoit
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>      
