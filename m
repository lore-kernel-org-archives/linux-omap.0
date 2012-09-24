From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 00/15] tidspbridge driver MMU-related cleanups
Date: Tue, 25 Sep 2012 01:15:16 +0200
Message-ID: <5440295.qvmhmnK8Sf@avalon>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com> <CAB-zwWixOeCPoV=F1E8t7_6AdgCTLQhC72_G35+dSnaJsTwonA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:49791 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab2IXXOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 19:14:40 -0400
In-Reply-To: <CAB-zwWixOeCPoV=F1E8t7_6AdgCTLQhC72_G35+dSnaJsTwonA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Omar,

On Friday 21 September 2012 11:18:56 Ramirez Luna, Omar wrote:
> On Wed, Sep 19, 2012 at 7:06 AM, Laurent Pinchart wrote:
> > Hello,
> > 
> > Here's the second version of my tidspbridge MMU-related cleanup patches.
> > The first version has been sent privately only, don't try to search the
> > mailing list archive for it :-)
> > 
> > Replacing hw/hw_mmu.c and part of core/tiomap3430.c with generic IOMMU
> > calls should be less difficult now. Anyone would like to give it a try?
> > 
> > Laurent Pinchart (14):
> >   tidspbridge: hw_mmu: Reorder functions to avoid forward declarations
> >   tidspbridge: hw_mmu: Removed unused functions
> >   tidspbridge: tiomap3430: Reorder functions to avoid forward
> >     declarations
> >   tidspbridge: tiomap3430: Remove unneeded dev_context local variables
> >   tidspbridge: tiomap3430: Factor out common page release code
> >   tidspbridge: tiomap3430: Remove ul_ prefix
> >   tidspbridge: tiomap3430: Remove unneeded local variables
> >   tidspbridge: Fix VM_PFNMAP mapping
> >   tidspbridge: Remove unused hw_mmu_map_attrs_t::donotlockmpupage field
> >   arm: omap: iommu: Include required headers in iommu.h and iopgtable.h
> >   tidspbridge: Use constants defined in IOMMU platform headers
> >   tidspbridge: Simplify pte_update and mem_map_vmalloc functions
> >   tidspbridge: Use correct types to describe physical, MPU, DSP
> >     addresses
> >   tidspbridge: Replace hw_mmu_map_attrs_t structure with a prot
> >     bitfield
> 
> Thanks, tested on beagle-xM, they look good!
> 
> Can you submit them to Greg KH and devel@driverdev.osuosl.org,
> preferably with a 'staging:' prefix along with the current subject.

I'll do that after getting Felipe's feedback (as well as yours if possible 
:-)) on the VM_PFNMAP patch split that I've posted today.

> The only thing of concern is that:
> ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
> 
> Might be taking a different path than these to mainline[1].
> 
> Cheers,
> 
> Omar
> 
> ---
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg76319.html

-- 
Regards,

Laurent Pinchart

