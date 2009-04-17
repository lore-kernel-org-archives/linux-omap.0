From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] omap_iommu: Correct function name in the comment
Date: Fri, 17 Apr 2009 16:54:05 +0300
Message-ID: <1239976445-18356-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63278 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbZDQNzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 09:55:17 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3HDsqfO012048
	for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 16:55:13 +0300
Received: from localhost.localdomain (esdhcp040101.research.nokia.com [172.21.40.101])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n3HDs4mk001307
	for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 16:54:04 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Ameya Palande <ameya.palande@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 40e089f..0cec3f0 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -779,7 +779,7 @@ static int device_match_by_alias(struct device *dev, void *data)
 }
 
 /**
- * iommu_put() - Get iommu handler
+ * iommu_get() - Get iommu handler
  * @name:	target iommu name
  **/
 struct iommu *iommu_get(const char *name)
-- 
1.6.2.2

