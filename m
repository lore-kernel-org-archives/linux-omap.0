From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Sat, 16 May 2009 13:05:47 +0300
Message-ID: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63079 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbZEPKFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:05:53 -0400
Received: by fxm2 with SMTP id 2so2342832fxm.37
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 03:05:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, Felipe Contreras <felipe.contreras@gmail.com>

This patch series cleanups up a bit the opap3-iommu device registration and
then allows registration from other parts of the code.

Currently the iva2 code (tidspbridge) is not using iommu, therefore it can't be
used as-is with the current omap iommu. By allowing devies to be registered
externaly (either isp, or iva2) this problem goes away.

Felipe Contreras (3):
  omap3-iommu: reorganize
  omap3-iommu: split init function into omap_iommu_add
  omap3-iommu: remote registration

 arch/arm/mach-omap2/omap3-iommu.c       |  130 ++++++++++++++-----------------
 arch/arm/plat-omap/include/mach/iommu.h |    2 +
 2 files changed, 62 insertions(+), 70 deletions(-)

