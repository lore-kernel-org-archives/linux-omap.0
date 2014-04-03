From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [GIT PULL FOR v3.16] OMAP IOMMU fixes
Date: Fri, 04 Apr 2014 00:11:52 +0200
Message-ID: <2312051.xNuD1CfeZH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:52304 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaDCWJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2014 18:09:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Hi Joerg,

The following changes since commit 8944b7d495a00ae44d19ce945b5032a86dcdf7f0:

  Merge branch 'next' (2014-03-04 23:41:51 +0100)

are available in the git repository at:

  git://linuxtv.org/pinchartl/media.git iommu/omap

for you to fetch changes up to f42ed2dcc15e39a189458cfab69d7f2b902cc3e6:

  iommu/omap: Fix map protection value handling (2014-04-03 23:35:39 +0200)

I will need to base an OMAP3 ISP patch set on top of this, and I would like to 
get it merged in v3.16 as well. In order to avoid bisection breakages, could 
you merge this right on top of v3.15-rc1 when it will be out and provide a 
stable branch that can then be merged in the Linux media tree ?


----------------------------------------------------------------
Laurent Pinchart (3):
      iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
      iommu/omap: Remove comment about supporting single page mappings only
      iommu/omap: Fix map protection value handling

Suman Anna (3):
      iommu/omap: Correct init value of iotlb_entry valid field
      iommu/omap: Remove omap_iommu_domain_has_cap() function
      iommu/omap: Move to_iommu definition from omap-iopgtable.h

 drivers/iommu/omap-iommu.c     | 31 ++++++++++++-------------------
 drivers/iommu/omap-iopgtable.h |  3 ---
 2 files changed, 12 insertions(+), 22 deletions(-)

-- 
Regards,

Laurent Pinchart

