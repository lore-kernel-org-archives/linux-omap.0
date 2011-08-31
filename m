From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
 iommu_vmap
Date: Wed, 31 Aug 2011 15:06:42 +0200
Message-ID: <20110831130642.GQ12940@amd.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:38053
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755541Ab1HaNGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:06:50 -0400
Content-Disposition: inline
In-Reply-To: <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Wed, Aug 31, 2011 at 06:52:08AM -0400, Ohad Ben-Cohen wrote:
> On Mon, Aug 29, 2011 at 10:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > omap_iovmm requires page-aligned buffers, and that sometimes causes
> > omap3isp failures (i.e. whenever the buffer passed from userspace is not
> > page-aligned).
> >
> > Remove this limitation by rounding the address of the first page entry
> > down, and adding the offset back to the device address.
> 
> I'm having second thoughts about this.
> 
> Obviously it works for omap3isp and its users because the buffer gets
> mapped and everyone is happy.
> 
> But I'm not sure this is a valid IOMMU interface that the kernel
> should have, because effectively we're now mapping physical memory
> which nobody asked us to, and which might contain sensitive stuff we
> don't want to give the device (e.g. a remote processor which might be
> running rogue code) access to.
> 
> Thoughts ?

Do you mean the parts of the pages you map to the device that are not in
the requested range (basically everything before offset and all after
size)?
This issue exists in other iommu drivers as well. It is inherent to how
the dma-api is defined and how the iommu hardware works.
The dma-api can work on byte granularity while the hardware usually only
works on page granularity.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

