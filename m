From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH] ARM: omap_hwmod: Fix up resource names when booted with
 devicetree
Date: Thu, 6 Sep 2012 01:35:13 +0530
Message-ID: <5047B079.6040209@ti.com>
References: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com> <5037A9CE.1080809@ti.com> <50476143.3010509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab2IEUFY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 16:05:24 -0400
In-Reply-To: <50476143.3010509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org



On 9/5/2012 7:57 PM, Benoit Cousson wrote:
> Hi Paul,
> 
> On 08/24/2012 06:20 PM, Peter Ujfalusi wrote:
>> Hi Paul,
>>
>> On 08/24/2012 06:38 PM, Paul Walmsley wrote:
>>> Do we need both this one and your '[PATCH] driver core: Check if r->name 
>>> is valid in platform_get_resource_byname()' ?  Or would that second patch 
>>> be enough?  Is the crash happening in the platform_get_resource_byname() 
>>> iterator?
>>
>> The crash happens in platform_get_resource_byname(). What I see as a problem
>> that when we boot without DT the r->name is configured for the hwmods. If we
>> boot with DT we discard the resources created by the OF (which also have the
>> r->name configured). We replace the resources from hwmods but we do not fix up
>> the resource names (which is done in other cases).
>> I have sent the patch for the drivers core as well since I think it is a good
>> practice anyway to check for NULL pointer before strcmp().
>>
>> Either is good, but IMHO we should fix this in omap_hwmod (at least).
> 
> Yes, clearly we do have a corner case today due to the mix of hwmod /
> DTS resource management.
> - Legacy boot + hwmod resources is OK
> - DTS boot with DTS resources will be OK
> - DTS boot with hwmod resources is not OK since the resource name will
>   not be populated in the case resources are not named :-(
> 
> If you are OK, I'll take that patch along with Vaibhav one to handle
> properly the resources from DTS long with the DTS patches I'm queuing
> for 3.7.
> 

Benoit,
Note that this patch will add device name to all resources, since none
of the resource will have name property and may break drivers;
especially after my patch which respects DT resources.

Also I just read the thread you started sometime back on _byname api,
not sure that was the conclusion, but it seems like it is not
recommended to use _byname. The driver should be fixed while converting
to DT.

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060861.html

Thanks,
Vaibhav

> Thanks,
> Benoit
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
