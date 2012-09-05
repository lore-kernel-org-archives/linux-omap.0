From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: omap_hwmod: Fix up resource names when booted with
 devicetree
Date: Wed, 5 Sep 2012 16:46:26 +0200
Message-ID: <504765C2.3010600@ti.com>
References: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com> <5037A9CE.1080809@ti.com> <50476143.3010509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758151Ab2IEOqi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 10:46:38 -0400
In-Reply-To: <50476143.3010509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Peter,

I will just slighty change the subject since it is a omap_device.c patch and not an omap_hwmod.c one.

ARM: OMAP: omap_device: Fix up resource names when booted with devicetree

Regards,
Benoit

On 09/05/2012 04:27 PM, Benoit Cousson wrote:
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
> Thanks,
> Benoit
> 

