From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu
 is in use
Date: Tue, 05 Apr 2011 18:20:48 +0300
Message-ID: <4D9B3350.5040706@maxwell.research.nokia.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <201104041605.50480.laurent.pinchart@ideasonboard.com> <4D9ADAD9.6000108@maxwell.research.nokia.com> <201104051323.42401.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:26332 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303Ab1DEPVA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 11:21:00 -0400
In-Reply-To: <201104051323.42401.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Cohen <dacohen@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

Laurent Pinchart wrote:
> Hi Sakari,

Hi Laurent,

> On Tuesday 05 April 2011 11:03:21 Sakari Ailus wrote:
>> Laurent Pinchart wrote:
> 
> [snip]
> 
>>> Let me try to summarize the issue and the requirements.
>>>
>>> IOMMU support on OMAP platforms uses an OMAP-specific implementation,
>>> divided into 3 layers:
>>>
>>> - the IOVMM layer (arch/arm/plat-omap/iovmm.ko) deals with virtual
>>> address space management
>>> - the IOMMU layer (arch/arm/plat-omap/iommu.ko) controls the IOMMU
>>> hardware, and deals with TLB and page tables
>>> - the IOMMU platform-specific layers (arch/arm/mach-omap2/iommu2.ko)
>>> handles the IOMMU implementation variants between various OMAP platforms
>>>
>>> Drivers depend on iovmm and iommu. They must not depend on iommu2.ko.
>>>
>>> The only existing platform-specific IOMMU layer is iommu2.ko for OMAP2+.
>>> An OMAP1 implementation is being worked on, and other implementations
>>> might be needed for OMAP4 and/or OMAP5.
>>>
>>> Building a kernel image that will run on all OMAP platforms isn't
>>> possible at the moment but is being worked on. Such a kernel image will
>>> need to include all the platform-specific IOMMU layers, and the correct
>>> layer will need to be selected at runtime.
>>>
>>> If a driver tries to request and use an IOMMU before the
>>> platform-specific IOMMU layer is initialized, the request will fail. We
>>> thus need to ensure that the correct platform-specific IOMMU layer is
>>> initialized before IOMMU users are initialized.
>>
>> Thanks for the summary!
>>
>>> I can see several ways to fix the problem.
>>>
>>> - Turn the iommu and iommu2 options from tristate to bool. The downside
>>> is that the kernel image will get slightly bigger.
>>>
>>> - Merge the iommu and iommu2 modules together. This will temporarily fix
>>> the problem, but a proper solution will still be needed for the OMAP1
>>> (and maybe OMAP5) IOMMU layers.
>>>
>>> - Auto-load the correct platform-specific IOMMU module based on
>>> modaliases created from the platform name. The platform-specific modules
>>> will need to check at runtime whether they support the current platform
>>> to avoid conflicts when several of those modules will be compiled in.
>>
>> I'd like to add option to auto-load the module based on the type of the
>> IOMMU.
> 
> Could you elaborate on that ?

The module name could be specified somewhere, but the question is then
where. There needs to be iommu name -> module name mapping somewhere
(can be distributed) and it must not be the end user of the iommu framework.

>> This is more generic since there could be several types of IOMMUs in
>> the same system, although in the scope of OMAPs we are likely to have always
>> just one.
>>
>> Extending the scope of the OMAP IOMMU would be nice, or to add functionality
>> to the current generic layer which doesn't do much at the moment.
>>
>> This is probably a bigger task and something to consider in the future,
>> though.
>>
>> I'd go with the third option you suggested since this one
>>
>> 1) solves the problem,
>> 2) doesn't appear to create new ones,
>> 3) doesn't add anything that would be incompatible with probable future
>> developments and
>> 4) is easy to implement.
>>
>>
>> Btw. There should be no devices created by the board code on those platforms
>> either. Wrong iommu device drivers may be loaded in addition, but this does
>> no more harm than compiling those in to the kernel in the first option.
>>
>>> The second solution is the simplest, but it's a workaround. On the other
>>> hand, it's hard to design a proper solution before we know the
>>> requirements of the other OMAP platforms that have an IOMMU incompatible
>>> with iommu2.ko, so it might be better to postpone the decision until we
>>> have a real use case.
>>
>> There are two options that I can think of: either a SoC-wide IOMMU
>> implementation or
> 
> That's one option, unless you

I sent that too early. :-P

... a device which does have an IOMMU, connected to e.g. a bus that uses
the IOMMU framework. This way there could be different types of IOMMUs
in a system.

But we don't have that yet.

So either we have just one or multiple types or IOMMUs in the system.

>> The problem of loading that module exists right now so it should have
>> some kind of solution. If we go with the second option right now it does
>> push this to direction I don't like too much. The next implementer has
>> to solve the problem instead, and it might be easier to implement this
>> right now, as we are all up-to-date with the issue.
> 
> We only have iommu2.ko at the moment. I've heard about an iommu1.ko being 
> worked on, but I don't have more information. We don't know whether the OMAP5 
> will be able to use the same IOMMU implementation. Without more information, 
> I'm quite reluctant to design and implement a generic solution that will end 
> up being useless because we missed information in the design stage.

For the scope of OMAPs the first and third solutions would be enough.

I have no strong opinion on this either way.

I think that for the fully generic case it's that there are multiple
different IOMMUs in the system and those are being used by different
devices. Some could be used by many, as the OMAP 4 auxiliary ARMs.

But making the loading fully generic within the scope of OMAPs makes no
sense.

Regards,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
