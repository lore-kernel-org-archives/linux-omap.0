From: kishon <a0393678@ti.com>
Subject: Re: [RFC: PATCH] OMAP: hwmod: New API to modify the autoidle bits
 of sysconfig register
Date: Fri, 03 Sep 2010 14:38:41 +0530
Message-ID: <4C80BB19.4020004@ti.com>
References: <1282823155-18328-1-git-send-email-kishon@ti.com> <878w3o9l6f.fsf@deeprootsystems.com> <4C7C91D8.5030809@ti.com> <958980504a3ab43f3a7c5d86e968ea67@secure211.sgcpanel.com> <4C7D148A.8040403@ti.com> <4C7D2AD8.9050808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43020 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371Ab0ICJI7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Sep 2010 05:08:59 -0400
In-Reply-To: <4C7D2AD8.9050808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Felipe Balbi <me@felipebalbi.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Paul Walmsley <paul@pwsan.com>, "Basak, Partha" <p-basak2@ti.com>



On Tuesday 31 August 2010 09:46 PM, Cousson, Benoit wrote:
> On 8/31/2010 4:41 PM, ABRAHAM, KISHON VIJAY wrote:
>    
>>
>> On Tuesday 31 August 2010 01:43 PM, Felipe Balbi wrote:
>>      
>>> On Tue, 31 Aug 2010 10:53:36 +0530, kishon<a0393678@ti.com>    wrote:
>>>
>>>        
>>>>         Though driver shouldn't be using hwmod directly, there is no
>>>> corresponding API in omap_device to do the same. So we are planning to
>>>>         store the omap_hwmod structure in platform_data during
>>>> arch_initcall (in the callback to omap_hwmod_for_each_by_class). So
>>>> whenever the
>>>>         AUTOIDLE bits need to be reset or set, we pass the stored
>>>> omap_hwmod structure to this API. Currently, the functions that needs
>>>> AUTOIDLE
>>>>         bit to be modified (omap_st_on, omap_st_off) resides in plat-omap.
>>>>
>>>>          
>>> couldn't your API instead be something like:
>>>
>>> int omap_hwmod_set_autoidle(struct device *dev, u8 autoidle)
>>> {
>>> 	struct omap_hwmod *oh = dev_to_hwmod(dev);
>>>
>>> 	if (!oh)
>>> 		return -ENODEV;
>>> 	[...]
>>>
>>> 	return 0;
>>> }
>>>
>>>        
>>        Balbi,
>>            I couldn't find "dev_to_hwmod()" function. Do you actually mean
>> implementing dev_to_hwmod() function?
>>        I created this API based on "omap_hwmod_set_slave_idlemode()"
>> present in lo (omap_hwmod.c) for changing the smart idle bit
>>        of SYSCONFIG register.
>>
>>        -Kishon
>>      
> That API does not exist. And since a device can contains several hwmods,
> like in your case, this API cannot exist in that form.
>
> The real issue is that we do not want to expose any API relative to PRCM
> management to the driver. Even if you hide that behind some pdata, it is
> still the driver that will call it.
>
> I know that some IPs like MUSB or McBSP requires some unusual idle mode
> change due to HW bugs, but in general, you should try to find a better
> way to handle that in the core framework if possible.
>
>    
     Benoit,

     I see the trend of using specific flags in hwmod which gets set
     in pm_runtime_get_sync() for scenarios like this where auto idle
     bits or smart idle bits need to be set/reset at runtime. The problem
     in the case of sidetone in MCBSP is that we don't call get_sync or
     put_sync for sidetone separately.
     There is only two options we can think of for sidetone
         1) Always disable autoidle for sidetone (I'm not sure if this will
     have some power implications).
         2) Use of the above API.

     Would be helpful if you can also suggest us some other options as well.

     -Kishon
> Regards,
> Benoit
>    
