From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu
 is in use
Date: Tue, 05 Apr 2011 12:03:21 +0300
Message-ID: <4D9ADAD9.6000108@maxwell.research.nokia.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <201103301556.56822.laurent.pinchart@ideasonboard.com> <BANLkTi=SocUuraFrX04LEhei1foJ8DDOHw@mail.gmail.com> <201104041605.50480.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:45512 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698Ab1DEJDx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 05:03:53 -0400
In-Reply-To: <201104041605.50480.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Cohen <dacohen@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

Laurent Pinchart wrote:
> Hi David,

Hi Laurent, David, others,

> On Wednesday 30 March 2011 17:50:17 David Cohen wrote:
>> On Wed, Mar 30, 2011 at 4:56 PM, Laurent Pinchart wrote:
>>> On Wednesday 30 March 2011 15:50:37 Sakari Ailus wrote:
>>>> Laurent Pinchart wrote:
>>>>> On Wednesday 30 March 2011 10:16:56 Sakari Ailus wrote:
>>>>>> Laurent Pinchart wrote:
>>>>>>> On Friday 25 March 2011 20:37:55 Ramirez Luna, Omar wrote:
>>>>>>>> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> This patchset is aimed to fix a problem in arch_iommu
>>>>>>>>> implementation references. When an actual arch_iommu
>>>>>>>>> implementation is not loaded while iommu_get() is being called
>>>>>>>>> results to a kernel oops, as well as removing an arch_iommu
>>>>>>>>> implementation which is in use.
>>>>>>>>
>>>>>>>> How about fixing the dependency instead? Right now iommu2 depends
>>>>>>>> on iommu because of the calls to
>>>>>>>> install_iommu_arch/uninstall_iommu_arch... we should change that
>>>>>>>> dependency to iommu depend on iommu2. Something like iommu (plat)
>>>>>>>> querying iommu2 (mach) for devices to install.
>>>>>>>
>>>>>>> The reason why iommu depends on iommu2 and not the other way around
>>>>>>> is because several mach-specific iommu implementations should be
>>>>>>> able to coexist in the same kernel. The right one should be loaded
>>>>>>> at runtime.
>>>>>>>
>>>>>>> I think that Sakari's patches correcty fix the problems he noticed.
>>>>>>> However, they won't fix one basic issue, which is that the iommu2
>>>>>>> module won't be automatically pulled in when the omap3isp module is
>>>>>>> loaded. The omap3isp driver will then fail to probe the device.
>>>>>>> That's better than crashing though.
>>>>>>
>>>>>> One option would be to specify the name of the module in the platform
>>>>>> data and request_module() that in omap_iommu_probe(). This would
>>>>>> solve the issue, not sure how pretty is this though.
>>>>>
>>>>> Do we need that ? My understanding is that a machine will need a
>>>>> single mach- specific iommu implementation only. Drivers shouldn't
>>>>> need to care about that.
>>>>
>>>> Well, no more than that there would have to be a driver for the IOMMU
>>>> for that very hardware.
>>>>
>>>>> The iommu implementation should be automatically selected based on the
>>>>> machine time.
>>>>
>>>> Machine type?
>>>>
>>>> I agree, but where is the selection made?
>>>
>>> The selection can be made by board code, or by the iommu implementations
>>> themselves if they're compiled in.
>>
>> I prefer the first option. The second one will make the current
>> implementation be even more OMAP-only.
>> We have basically 3 layers:
>> IOVMM, IOMMU_GENERIC and IOMMU_SPECIFIC. The middle one should be
>> generic and don't care about machine types. The later one can be
>> handled by board code as it's machine specific and, for most of the
>> cases, I see no reason to let any other implementation besides the
>> machine type's to be loaded.
>>
>> But the generic layer should not depend on any specific one. If
>> somebody decides to load the specific layer after the generic one, it
>> cannot be a problem.
> 
> Let me try to summarize the issue and the requirements.
> 
> IOMMU support on OMAP platforms uses an OMAP-specific implementation, divided 
> into 3 layers:
> 
> - the IOVMM layer (arch/arm/plat-omap/iovmm.ko) deals with virtual address 
> space management
> - the IOMMU layer (arch/arm/plat-omap/iommu.ko) controls the IOMMU hardware, 
> and deals with TLB and page tables
> - the IOMMU platform-specific layers (arch/arm/mach-omap2/iommu2.ko) handles 
> the IOMMU implementation variants between various OMAP platforms
> 
> Drivers depend on iovmm and iommu. They must not depend on iommu2.ko.
> 
> The only existing platform-specific IOMMU layer is iommu2.ko for OMAP2+. An 
> OMAP1 implementation is being worked on, and other implementations might be 
> needed for OMAP4 and/or OMAP5.
> 
> Building a kernel image that will run on all OMAP platforms isn't possible at 
> the moment but is being worked on. Such a kernel image will need to include 
> all the platform-specific IOMMU layers, and the correct layer will need to be 
> selected at runtime.
> 
> If a driver tries to request and use an IOMMU before the platform-specific 
> IOMMU layer is initialized, the request will fail. We thus need to ensure that 
> the correct platform-specific IOMMU layer is initialized before IOMMU users 
> are initialized.

Thanks for the summary!

> I can see several ways to fix the problem.
> 
> - Turn the iommu and iommu2 options from tristate to bool. The downside is 
> that the kernel image will get slightly bigger.
> 
> - Merge the iommu and iommu2 modules together. This will temporarily fix the 
> problem, but a proper solution will still be needed for the OMAP1 (and maybe 
> OMAP5) IOMMU layers.
> 
> - Auto-load the correct platform-specific IOMMU module based on modaliases 
> created from the platform name. The platform-specific modules will need to 
> check at runtime whether they support the current platform to avoid conflicts 
> when several of those modules will be compiled in.

I'd like to add option to auto-load the module based on the type of the
IOMMU. This is more generic since there could be several types of IOMMUs
in the same system, although in the scope of OMAPs we are likely to have
always just one.

Extending the scope of the OMAP IOMMU would be nice, or to add
functionality to the current generic layer which doesn't do much at the
moment.

This is probably a bigger task and something to consider in the future,
though.

I'd go with the third option you suggested since this one

1) solves the problem,
2) doesn't appear to create new ones,
3) doesn't add anything that would be incompatible with probable future
developments and
4) is easy to implement.


Btw. There should be no devices created by the board code on those
platforms either. Wrong iommu device drivers may be loaded in addition,
but this does no more harm than compiling those in to the kernel in the
first option.

> The second solution is the simplest, but it's a workaround. On the other hand, 
> it's hard to design a proper solution before we know the requirements of the 
> other OMAP platforms that have an IOMMU incompatible with iommu2.ko, so it 
> might be better to postpone the decision until we have a real use case.

There are two options that I can think of: either a SoC-wide IOMMU
implementation or

The problem of loading that module exists right now so it should have
some kind of solution. If we go with the second option right now it does
push this to direction I don't like too much. The next implementer has
to solve the problem instead, and it might be easier to implement this
right now, as we are all up-to-date with the issue.

Just my 0,05 euros. :-)

Cheers,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
