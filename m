From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in iommu_vmap
Date: Wed, 31 Aug 2011 18:56:26 +0200
Message-ID: <201108311856.26969.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com> <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com> <20110831130642.GQ12940@amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:60997 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808Ab1HaQz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 12:55:58 -0400
In-Reply-To: <20110831130642.GQ12940@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

Hi Joerg,

On Wednesday 31 August 2011 15:06:42 Roedel, Joerg wrote:
> On Wed, Aug 31, 2011 at 06:52:08AM -0400, Ohad Ben-Cohen wrote:
> > On Mon, Aug 29, 2011 at 10:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > omap_iovmm requires page-aligned buffers, and that sometimes causes
> > > omap3isp failures (i.e. whenever the buffer passed from userspace is
> > > not page-aligned).
> > > 
> > > Remove this limitation by rounding the address of the first page entry
> > > down, and adding the offset back to the device address.
> > 
> > I'm having second thoughts about this.
> > 
> > Obviously it works for omap3isp and its users because the buffer gets
> > mapped and everyone is happy.
> > 
> > But I'm not sure this is a valid IOMMU interface that the kernel
> > should have, because effectively we're now mapping physical memory
> > which nobody asked us to, and which might contain sensitive stuff we
> > don't want to give the device (e.g. a remote processor which might be
> > running rogue code) access to.
> > 
> > Thoughts ?
> 
> Do you mean the parts of the pages you map to the device that are not in
> the requested range (basically everything before offset and all after
> size)?
> This issue exists in other iommu drivers as well. It is inherent to how
> the dma-api is defined and how the iommu hardware works.
> The dma-api can work on byte granularity while the hardware usually only
> works on page granularity.

True, but if we implement address rounding transparently in the IOMMU layer 
Ohad's concern can be valid, depending on whether the device is trusted. If we 
decide to push address rounding to the drivers that decision can be made on a 
per-device basis. However, drivers are usually not aware of what granularity 
the IOMMU works on, so that wouldn't be straightforward and clean.

-- 
Regards,

Laurent Pinchart
