From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu
 is in use
Date: Wed, 30 Mar 2011 16:50:37 +0300
Message-ID: <4D93352D.7090908@maxwell.research.nokia.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <201103291732.52620.laurent.pinchart@ideasonboard.com> <4D92E6F8.5070100@maxwell.research.nokia.com> <201103301137.10916.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:59489 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163Ab1C3Nuu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 09:50:50 -0400
In-Reply-To: <201103301137.10916.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

Laurent Pinchart wrote:
> Hi Sakari,

Hi Laurent,

> On Wednesday 30 March 2011 10:16:56 Sakari Ailus wrote:
>> Laurent Pinchart wrote:
>>> On Friday 25 March 2011 20:37:55 Ramirez Luna, Omar wrote:
>>>> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus wrote:
>>>>> Hi,
>>>>>
>>>>> This patchset is aimed to fix a problem in arch_iommu implementation
>>>>> references. When an actual arch_iommu implementation is not loaded
>>>>> while iommu_get() is being called results to a kernel oops, as well as
>>>>> removing an arch_iommu implementation which is in use.
>>>>
>>>> How about fixing the dependency instead? Right now iommu2 depends on
>>>> iommu because of the calls to
>>>> install_iommu_arch/uninstall_iommu_arch... we should change that
>>>> dependency to iommu depend on iommu2. Something like iommu (plat)
>>>> querying iommu2 (mach) for devices to install.
>>>
>>> The reason why iommu depends on iommu2 and not the other way around is
>>> because several mach-specific iommu implementations should be able to
>>> coexist in the same kernel. The right one should be loaded at runtime.
>>>
>>> I think that Sakari's patches correcty fix the problems he noticed.
>>> However, they won't fix one basic issue, which is that the iommu2 module
>>> won't be automatically pulled in when the omap3isp module is loaded. The
>>> omap3isp driver will then fail to probe the device. That's better than
>>> crashing though.
>>
>> One option would be to specify the name of the module in the platform
>> data and request_module() that in omap_iommu_probe(). This would solve
>> the issue, not sure how pretty is this though.
> 
> Do we need that ? My understanding is that a machine will need a single mach-
> specific iommu implementation only. Drivers shouldn't need to care about that. 

Well, no more than that there would have to be a driver for the IOMMU
for that very hardware.

> The iommu implementation should be automatically selected based on the machine 
> time.

Machine type?

I agree, but where is the selection made?

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
