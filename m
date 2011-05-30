From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/2] OMAP3 IOMMU fixes
Date: Mon, 30 May 2011 14:47:07 +0200
Message-ID: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:40796 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1E3MrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 08:47:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: teemu.tuominen@cybercom.com

Hi everybody,

Here are two OMAP3 IOMMU fixes required to support big and/or unaligned memory
buffers.

Laurent Pinchart (2):
  omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
  omap3: iovmm: Support non page-aligned buffers in iommu_vmap

 arch/arm/plat-omap/iovmm.c |   46 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 36 insertions(+), 10 deletions(-)

-- 
Regards,

Laurent Pinchart

