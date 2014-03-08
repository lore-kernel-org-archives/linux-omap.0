From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Sat, 08 Mar 2014 13:04:52 +0200
Message-ID: <531AF954.5040509@iki.fi>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:46508 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751156AbaCHLEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Mar 2014 06:04:55 -0500
In-Reply-To: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>

Hi Laurent,

Laurent Pinchart wrote:
> along with a patch series that ports the OMAP3 ISP driver to the DMA API. I
> will submit that one for review once the IOMMU patches get accepted and after
> fixing a couple of remaining bugs (I'm aware that I have broken userspace
> PFNMAP buffers).
>
> Laurent Pinchart (5):
>    iommu/omap: Use the cache cleaning API
>    iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
>    iommu/omap: Flush the TLB only after updating translation table
>      entries
>    iommu/omap: Remove comment about supporting single page mappings only
>    iommu/omap: Fix map protection value handling
>
>   drivers/iommu/omap-iommu.c | 68 ++++++++++++++++------------------------------
>   1 file changed, 23 insertions(+), 45 deletions(-)

Until I have time to read and think about the rest, for the series,

Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>

-- 
Sakari Ailus
sakari.ailus@iki.fi
