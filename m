From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 00/13] OMAP IOMMU DT adaptation for 3.15
Date: Sun, 2 Mar 2014 23:35:30 -0600
Message-ID: <531414A2.8040100@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com> <20140228230000.GW13624@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35831 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaCCFgX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 00:36:23 -0500
In-Reply-To: <20140228230000.GW13624@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joerg Roedel <joro@8bytes.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

On 02/28/2014 05:00 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [140228 12:46]:
>> Hi Joerg, Tony,
>>
>> This is an updated series of the OMAP IOMMU DT adaptation intended
>> for 3.15 merge window, addressing the comments from the v2 series.
>> This series is rebased onto 3.14-rc4, and the only change to bindings
>> is to drop the dma-window property.
>>
>> The first 7 patches in the series are in drivers/iommu, with the first
>> 3 patches performing some cleanup. The DT bindings and adaptation are
>> done in patches 4 and 5.
>>
>> Tony,
>> Patches 8 through 13 are in arch/arm/mach-omap2 layer, so I am guessing
>> these would have to go through your tree. Of these, patches 8 and 9 are
>> cleanup fixes to get OMAP3 IVA MMU working, patches 10 & 11 are fixes
>> required with DT-boot for OMAP3/4, patches 12 & 13 add the OMAP5 support.
>
> Are patches 8 to 13 OK to apply separately from the iommu patches or
> do they need to wait for the iommu patches to get merged first?
>

Yeah, they don't have any direct dependencies. Patches 8, 9 and 12 are 
totally independent. Patches 10, 11 and 13 add the needed platform data 
or archdata to get the corresponding DT iommu devices functional by any 
users (OMAP3 ISP is the only user in kernel). The only remote dependency 
is the compatible string names used in the pdata-quirks.

regards
Suman
