From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: [PATCH 1/4] omap iommu: Check existence of arch_iommu
Date: Fri, 25 Mar 2011 17:17:59 +0200
Message-ID: <1301066282-8040-1-git-send-email-sakari.ailus@maxwell.research.nokia.com>
References: <4D8CB217.1050909@maxwell.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:63456 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab1CYPSU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:18:20 -0400
In-Reply-To: <4D8CB217.1050909@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, david.cohen@nokia.com, hiroshi.doyu@nokia.com

Check that the arch_iommu has been installed before trying to use it. This
will lead to kernel oops if the arch_iommu isn't there.

Signed-off-by: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
---
 arch/arm/plat-omap/iommu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index b1107c0..f0fea0b 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -104,6 +104,9 @@ static int iommu_enable(struct iommu *obj)
 	if (!obj)
 		return -EINVAL;
 
+	if (!arch_iommu)
+		return -ENOENT;
+
 	clk_enable(obj->clk);
 
 	err = arch_iommu->enable(obj);
-- 
1.7.2.3

