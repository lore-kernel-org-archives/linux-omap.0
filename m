From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] omap iommu: fix wrong condition check in while loop
Date: Mon, 28 Sep 2009 14:27:20 +0300
Message-ID: <1254137240-32555-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52595 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbZI1L1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 07:27:21 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n8SBQJ39017226
	for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2009 06:26:33 -0500
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n8SBRKrZ003086
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2009 14:27:20 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

It's worked fine so far since reset is done for the first time.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 88a44f1..3615b97 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -82,7 +82,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 		l = iommu_read_reg(obj, MMU_SYSSTATUS);
 		if (l & MMU_SYS_RESETDONE)
 			break;
-	} while (time_after(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	if (!(l & MMU_SYS_RESETDONE)) {
 		dev_err(obj->dev, "can't take mmu out of reset\n");
-- 
1.6.0.4

