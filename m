From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 0/2] OMAP IOMMU Fixes for DT-clients
Date: Thu, 4 Sep 2014 17:27:28 -0500
Message-ID: <1409869650-26115-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58202 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755AbaIDW21 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Sep 2014 18:28:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Florian Vaussard <florian.vaussard@epfl.ch>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Hi,

This is an updated series addressing Laurent's review comments on
Patch1. Patch2 is unchanged from the previous series.

Patches are based on 3.17-rc3.

v1:
http://marc.info/?l=linux-omap&m=140978874026176&w=2

Suman Anna (2):
  iommu/omap: Check for valid archdata in attach_dev
  iommu/omap: Fix iommu archdata name for DT-based devices

 drivers/iommu/omap-iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.0.4

