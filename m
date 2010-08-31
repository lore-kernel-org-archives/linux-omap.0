From: kishon <a0393678@ti.com>
Subject: Re: [RFC: PATCH] OMAP: hwmod: New API to modify the autoidle bits
 of sysconfig register
Date: Tue, 31 Aug 2010 20:11:14 +0530
Message-ID: <4C7D148A.8040403@ti.com>
References: <1282823155-18328-1-git-send-email-kishon@ti.com> <878w3o9l6f.fsf@deeprootsystems.com> <4C7C91D8.5030809@ti.com> <958980504a3ab43f3a7c5d86e968ea67@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50694 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491Ab0HaOlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 10:41:39 -0400
In-Reply-To: <958980504a3ab43f3a7c5d86e968ea67@secure211.sgcpanel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Basak, Partha" <p-basak2@ti.com>



On Tuesday 31 August 2010 01:43 PM, Felipe Balbi wrote:
> On Tue, 31 Aug 2010 10:53:36 +0530, kishon<a0393678@ti.com>  wrote:
>    
>>       Though driver shouldn't be using hwmod directly, there is no
>> corresponding API in omap_device to do the same. So we are planning to
>>       store the omap_hwmod structure in platform_data during
>> arch_initcall (in the callback to omap_hwmod_for_each_by_class). So
>> whenever the
>>       AUTOIDLE bits need to be reset or set, we pass the stored
>> omap_hwmod structure to this API. Currently, the functions that needs
>> AUTOIDLE
>>       bit to be modified (omap_st_on, omap_st_off) resides in plat-omap.
>>      
> couldn't your API instead be something like:
>
> int omap_hwmod_set_autoidle(struct device *dev, u8 autoidle)
> {
> 	struct omap_hwmod *oh = dev_to_hwmod(dev);
>
> 	if (!oh)
> 		return -ENODEV;
> 	[...]
>
> 	return 0;
> }
>    
     Balbi,
         I couldn't find "dev_to_hwmod()" function. Do you actually mean 
implementing dev_to_hwmod() function?
     I created this API based on "omap_hwmod_set_slave_idlemode()" 
present in lo (omap_hwmod.c) for changing the smart idle bit
     of SYSCONFIG register.

     -Kishon
