From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [GIT PULL FOR v3.16] OMAP IOMMU fixes
Date: Wed, 16 Apr 2014 16:28:05 +0200
Message-ID: <6806421.DjEURPCCWM@avalon>
References: <2312051.xNuD1CfeZH@avalon> <20140416140107.GA3627@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:59680 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161180AbaDPO2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 10:28:03 -0400
In-Reply-To: <20140416140107.GA3627@8bytes.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Hi Joerg,

On Wednesday 16 April 2014 16:01:07 Joerg Roedel wrote:
> Hi Laurent,
> 
> On Fri, Apr 04, 2014 at 12:11:52AM +0200, Laurent Pinchart wrote:
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
> Can you please rebase this to v3.15-rc1 and send a new pull request? I
> get a lot of commits besides these when I pull into v3.15-rc1.

Sure. The branch was based on top of your iommu master branch, I'll rebase on 
top of v3.15-rc1 and resend a pull request.

-- 
Regards,

Laurent Pinchart

