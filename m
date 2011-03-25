From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: [PATCH 2/4] omap iommu: Add module information to struct iommu_functions
Date: Fri, 25 Mar 2011 17:18:00 +0200
Message-ID: <1301066282-8040-2-git-send-email-sakari.ailus@maxwell.research.nokia.com>
References: <4D8CB217.1050909@maxwell.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:63978 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab1CYPSV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:18:21 -0400
In-Reply-To: <4D8CB217.1050909@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, david.cohen@nokia.com, hiroshi.doyu@nokia.com

Whichever module that implements the struct, may not be unloaded while it's
in use.  Prepare to this by adding module reference to the structure.

Signed-off-by: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
---
 arch/arm/plat-omap/include/plat/iommu.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 69230d6..26fefb4 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -79,6 +79,7 @@ struct iotlb_lock {
 /* architecture specific functions */
 struct iommu_functions {
 	unsigned long	version;
+	struct module *module;
 
 	int (*enable)(struct iommu *obj);
 	void (*disable)(struct iommu *obj);
-- 
1.7.2.3

