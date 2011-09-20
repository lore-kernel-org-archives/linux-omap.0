From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu/omap: Fix build error with !IOMMU_SUPPORT
Date: Tue, 20 Sep 2011 12:54:38 +0200
Message-ID: <201109201254.39542.laurent.pinchart@ideasonboard.com>
References: <1316009259-18052-1-git-send-email-joerg.roedel@amd.com> <201109180202.23123.laurent.pinchart@ideasonboard.com> <20110920100146.GA2078@amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:58621 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1ITKyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 06:54:35 -0400
In-Reply-To: <20110920100146.GA2078@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Joerg,

On Tuesday 20 September 2011 12:01:46 Roedel, Joerg wrote:
> On Sat, Sep 17, 2011 at 08:02:22PM -0400, Laurent Pinchart wrote:
> > On Wednesday 14 September 2011 16:07:39 Joerg Roedel wrote:
> > > Without this patch it is possible to select the VIDEO_OMAP3
> > > driver which then selects OMAP_IOVMM. But the omap iommu
> > > driver is not compiled without IOMMU_SUPPORT enabled. Fix
> > > that by forcing OMAP_IOMMU and OMAP_IOVMM are enabled before
> > > VIDEO_OMAP3 can be selected.
> > 
> > What about making VIDEO_OMAP3 select IOMMU_SUPPORT instead then ? Your
> > patch would make the OMAP3 ISP driver disappear from the menu until
> > IOMMU_SUPPORT gets turned on, which can confuse users.
> 
> Using 'depends on' rather then 'selects' is common standard in Kconfig.
> You can't select PCI drivers without selecting PCI first, for example.

You wouldn't expect a PCI driver to work without PCI support. My concern is 
that most OMAP3 ISP users won't know that IOMMU supports is required. Feel 
free to ignore it though :-)

> Further selecting whole drivers implicitly isn't a good idea. This can
> grow out of control very quickly.

-- 
Regards,

Laurent Pinchart
