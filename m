From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] OMAP IOMMU Fixes for DT-clients
Date: Wed, 3 Sep 2014 18:58:30 -0500
Message-ID: <1409788712-10741-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58699 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932561AbaICX66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 19:58:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Florian Vaussard <florian.vaussard@epfl.ch>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Hi,

Following are couple of minor fixes to the OMAP IOMMU driver for DT-based
client devices. The first patch adds an additional check to detect invalid
usage of IOMMU API for devices with no IOMMUs, and the second patch fixes
the failure to attach to an OMAP IOMMU for properly configured DT devices.
The kernel does not yet have any OMAP IOMMU users represented in DT, so
this failure is not currently seen, but will be seen when users like OMAP3
ISP or OMAP4 remoteprocs are converted to DT.

regards
Suman

Suman Anna (2):
  iommu/omap: Check for valid archdata in attach_dev
  iommu/omap: Fix iommu archdata name for DT-based devices

 drivers/iommu/omap-iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.0.4

