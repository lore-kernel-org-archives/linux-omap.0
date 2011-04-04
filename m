From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu is in use
Date: Mon, 4 Apr 2011 16:05:49 +0200
Message-ID: <201104041605.50480.laurent.pinchart@ideasonboard.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <201103301556.56822.laurent.pinchart@ideasonboard.com> <BANLkTi=SocUuraFrX04LEhei1foJ8DDOHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:58067 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab1DDOFc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 10:05:32 -0400
In-Reply-To: <BANLkTi=SocUuraFrX04LEhei1foJ8DDOHw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

Hi David,

On Wednesday 30 March 2011 17:50:17 David Cohen wrote:
> On Wed, Mar 30, 2011 at 4:56 PM, Laurent Pinchart wrote:
> > On Wednesday 30 March 2011 15:50:37 Sakari Ailus wrote:
> >> Laurent Pinchart wrote:
> >> > On Wednesday 30 March 2011 10:16:56 Sakari Ailus wrote:
> >> >> Laurent Pinchart wrote:
> >> >>> On Friday 25 March 2011 20:37:55 Ramirez Luna, Omar wrote:
> >> >>>> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus wrote:
> >> >>>>> Hi,
> >> >>>>> 
> >> >>>>> This patchset is aimed to fix a problem in arch_iommu
> >> >>>>> implementation references. When an actual arch_iommu
> >> >>>>> implementation is not loaded while iommu_get() is being called
> >> >>>>> results to a kernel oops, as well as removing an arch_iommu
> >> >>>>> implementation which is in use.
> >> >>>> 
> >> >>>> How about fixing the dependency instead? Right now iommu2 depends
> >> >>>> on iommu because of the calls to
> >> >>>> install_iommu_arch/uninstall_iommu_arch... we should change that
> >> >>>> dependency to iommu depend on iommu2. Something like iommu (plat)
> >> >>>> querying iommu2 (mach) for devices to install.
> >> >>> 
> >> >>> The reason why iommu depends on iommu2 and not the other way around
> >> >>> is because several mach-specific iommu implementations should be
> >> >>> able to coexist in the same kernel. The right one should be loaded
> >> >>> at runtime.
> >> >>> 
> >> >>> I think that Sakari's patches correcty fix the problems he noticed.
> >> >>> However, they won't fix one basic issue, which is that the iommu2
> >> >>> module won't be automatically pulled in when the omap3isp module is
> >> >>> loaded. The omap3isp driver will then fail to probe the device.
> >> >>> That's better than crashing though.
> >> >> 
> >> >> One option would be to specify the name of the module in the platform
> >> >> data and request_module() that in omap_iommu_probe(). This would
> >> >> solve the issue, not sure how pretty is this though.
> >> > 
> >> > Do we need that ? My understanding is that a machine will need a
> >> > single mach- specific iommu implementation only. Drivers shouldn't
> >> > need to care about that.
> >> 
> >> Well, no more than that there would have to be a driver for the IOMMU
> >> for that very hardware.
> >> 
> >> > The iommu implementation should be automatically selected based on the
> >> > machine time.
> >> 
> >> Machine type?
> >> 
> >> I agree, but where is the selection made?
> > 
> > The selection can be made by board code, or by the iommu implementations
> > themselves if they're compiled in.
> 
> I prefer the first option. The second one will make the current
> implementation be even more OMAP-only.
> We have basically 3 layers:
> IOVMM, IOMMU_GENERIC and IOMMU_SPECIFIC. The middle one should be
> generic and don't care about machine types. The later one can be
> handled by board code as it's machine specific and, for most of the
> cases, I see no reason to let any other implementation besides the
> machine type's to be loaded.
> 
> But the generic layer should not depend on any specific one. If
> somebody decides to load the specific layer after the generic one, it
> cannot be a problem.

Let me try to summarize the issue and the requirements.

IOMMU support on OMAP platforms uses an OMAP-specific implementation, divided 
into 3 layers:

- the IOVMM layer (arch/arm/plat-omap/iovmm.ko) deals with virtual address 
space management
- the IOMMU layer (arch/arm/plat-omap/iommu.ko) controls the IOMMU hardware, 
and deals with TLB and page tables
- the IOMMU platform-specific layers (arch/arm/mach-omap2/iommu2.ko) handles 
the IOMMU implementation variants between various OMAP platforms

Drivers depend on iovmm and iommu. They must not depend on iommu2.ko.

The only existing platform-specific IOMMU layer is iommu2.ko for OMAP2+. An 
OMAP1 implementation is being worked on, and other implementations might be 
needed for OMAP4 and/or OMAP5.

Building a kernel image that will run on all OMAP platforms isn't possible at 
the moment but is being worked on. Such a kernel image will need to include 
all the platform-specific IOMMU layers, and the correct layer will need to be 
selected at runtime.

If a driver tries to request and use an IOMMU before the platform-specific 
IOMMU layer is initialized, the request will fail. We thus need to ensure that 
the correct platform-specific IOMMU layer is initialized before IOMMU users 
are initialized.

I can see several ways to fix the problem.

- Turn the iommu and iommu2 options from tristate to bool. The downside is 
that the kernel image will get slightly bigger.

- Merge the iommu and iommu2 modules together. This will temporarily fix the 
problem, but a proper solution will still be needed for the OMAP1 (and maybe 
OMAP5) IOMMU layers.

- Auto-load the correct platform-specific IOMMU module based on modaliases 
created from the platform name. The platform-specific modules will need to 
check at runtime whether they support the current platform to avoid conflicts 
when several of those modules will be compiled in.

The second solution is the simplest, but it's a workaround. On the other hand, 
it's hard to design a proper solution before we know the requirements of the 
other OMAP platforms that have an IOMMU incompatible with iommu2.ko, so it 
might be better to postpone the decision until we have a real use case.

-- 
Regards,

Laurent Pinchart
