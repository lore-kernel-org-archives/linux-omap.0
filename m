From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: [PATCH 3/4] omap2 iommu: Set module information in omap2_iommu_ops
Date: Fri, 25 Mar 2011 17:18:01 +0200
Message-ID: <1301066282-8040-3-git-send-email-sakari.ailus@maxwell.research.nokia.com>
References: <4D8CB217.1050909@maxwell.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:64206 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab1CYPSP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:18:15 -0400
In-Reply-To: <4D8CB217.1050909@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, david.cohen@nokia.com, hiroshi.doyu@nokia.com

Set omap2_iommu_ops.module to point to THIS_MODULE.

Signed-off-by: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 14ee686..cf0c32a 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -342,6 +342,8 @@ static const struct iommu_functions omap2_iommu_ops = {
 	.save_ctx	= omap2_iommu_save_ctx,
 	.restore_ctx	= omap2_iommu_restore_ctx,
 	.dump_ctx	= omap2_iommu_dump_ctx,
+
+	.module		= THIS_MODULE,
 };
 
 static int __init omap2_iommu_init(void)
-- 
1.7.2.3

