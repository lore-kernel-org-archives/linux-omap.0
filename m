From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Thu,  7 May 2009 23:11:06 +0300
Message-ID: <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:59902 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZEGULX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:11:23 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1364924fga.17
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 13:11:22 -0700 (PDT)
In-Reply-To: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

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

