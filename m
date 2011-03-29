From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu is in use
Date: Tue, 29 Mar 2011 17:44:22 +0200
Message-ID: <201103291744.22713.laurent.pinchart@ideasonboard.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <4D8F738D.3090100@maxwell.research.nokia.com> <AANLkTi=_ZzpkP3vvKhu8AKa-66MG11nbVZwGOjpC87pL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53934 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1C2PoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 11:44:04 -0400
In-Reply-To: <AANLkTi=_ZzpkP3vvKhu8AKa-66MG11nbVZwGOjpC87pL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

Hi,

On Monday 28 March 2011 03:42:23 Ramirez Luna, Omar wrote:
> On Sun, Mar 27, 2011 at 12:27 PM, Sakari Ailus wrote:
> > Ramirez Luna, Omar wrote:
> >> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus wrote:
> >>> This patchset is aimed to fix a problem in arch_iommu implementation
> >>> references. When an actual arch_iommu implementation is not loaded
> >>> while iommu_get() is being called results to a kernel oops, as well as
> >>> removing an arch_iommu implementation which is in use.
> >> 
> >> How about fixing the dependency instead? Right now iommu2 depends on
> >> iommu because of the calls to
> >> install_iommu_arch/uninstall_iommu_arch... we should change that
> >> dependency to iommu depend on iommu2. Something like iommu (plat)
> >> querying iommu2 (mach) for devices to install.
> > 
> > There is no direct dependency from a driver using the generic API to a
> > particular implementation of the iommu. This comes from the design of
> > the iommu framework. The generic layer shouldn't depend on particular
> > implementation(s).
> 
> IMHO there is, take as an example bridgedriver (it is arm/omap
> dependent), so it depends on iommu providing the mach-omap2
> implementation. I imagine isp for omap imposes the same dependency,
> even more your patchset enforces that dependency.

The problem is that drivers don't depend on particular iommu implementations 
(they only use symbols from the generic iommu layer), but they require the 
implementation to be present. Maybe the implementation should be registered at 
runtime by board code, or should be compiled in (bool instead of tristate) and 
check if the current mach supports the implementation (with cpu_is_* or 
similar) before registering it.

> Basically, if there is no "arch_iommu" the iommu driver does not work,
> and if there was an "arch_iommu" but it was removed then the driver
> crashes.
> 
> Now, there could be architectures that does not depend on a particular
> implementation but this iommu driver doesn't support them because if
> there is no arch_iommu operations, it does nothing or crashes.
> 
> > What comes to the patch, it works as long as there's only one iommu
> > implementation loaded / compiled to the kernel. I wonder if this kind of
> > limitation can be accepted.
> 
> Which is the way iommu choose to work, like I said if there is no
> arch_iommu nothing works, most of APIs in iommu depend on an machine
> specific implementation. To fix that it is not the scope of my
> proposal.
> 
> If indeed iommu can function without a machine specific implementation
> then a redesign needs to be made, but to me the same approach as I did
> needs to be followed: if there is mach implementation (e.g.: iommu2.c)
> the generic API needs to depend on it, otherwise the module can be
> removed and crash the kernel; OTOH if there is no mach implementation,
> then iommu should not depend on it to be installed as you point out,
> this could be handled in plat/iommu.h among with:
> 
> #if defined(CONFIG_ARCH_OMAP1)
> #error "iommu for this processor not implemented yet"
> #else
> #include <plat/iommu2.h>
> #endif
> 
> A new else defining the install/uninstall_arch_iommu functions or
> simply reversing the check to be OMAP2+ and error on anything else.

-- 
Regards,

Laurent Pinchart
