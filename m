From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [GIT PULL v2 FOR v3.16] OMAP IOMMU fixes
Date: Thu, 17 Apr 2014 01:43:56 +0200
Message-ID: <698874884.ItkCjuKUDv@avalon>
References: <2312051.xNuD1CfeZH@avalon> <1527771.aIpQeXENtj@avalon> <20140416192923.GA2742@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34383 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbaDPXnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 19:43:53 -0400
In-Reply-To: <20140416192923.GA2742@8bytes.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Hi Joerg,

On Wednesday 16 April 2014 21:31:58 Joerg Roedel wrote:
> On Wed, Apr 16, 2014 at 04:51:56PM +0200, Laurent Pinchart wrote:
> > The following changes since commit 
c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> >   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> > 
> > are available in the git repository at:
> >   git://linuxtv.org/pinchartl/media.git iommu/omap
> > 
> > for you to fetch changes up to 286f600bc890347f7ec7bd50d33210d53a9095a3:
> >   iommu/omap: Fix map protection value handling (2014-04-16 16:30:18
> >   +0200)
> > 
> > Compared to the v1 pull request, the patches have been rebased directly on
> > top of v3.15-rc1.
> > 
> > ----------------------------------------------------------------
> > 
> > Laurent Pinchart (3):
> >       iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
> >       iommu/omap: Remove comment about supporting single page mappings
> >       only
> >       iommu/omap: Fix map protection value handling
> > 
> > Suman Anna (3):
> >       iommu/omap: Correct init value of iotlb_entry valid field
> >       iommu/omap: Remove omap_iommu_domain_has_cap() function
> >       iommu/omap: Move to_iommu definition from omap-iopgtable.h
> >  
> >  drivers/iommu/omap-iommu.c     | 31 ++++++++++++-------------------
> >  drivers/iommu/omap-iopgtable.h |  3 ---
> >  2 files changed, 12 insertions(+), 22 deletions(-)
> 
> Pulled, thanks Laurent. You can use the arm/omap branch to base your
> work on (when I pushed it, which will probably happen tomorrow).

Thank you.

-- 
Regards,

Laurent Pinchart

