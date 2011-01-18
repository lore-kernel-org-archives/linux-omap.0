From: Martin Hostettler <martin@neutronstar.dyndns.org>
Subject: [PATCH] omap iommu: Gracefully fail iommu_enable if no arch_iommu is registered.
Date: Tue, 18 Jan 2011 22:45:04 +0100
Message-ID: <1295387104-17885-1-git-send-email-martin@neutronstar.dyndns.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55204 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab1ARVpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 16:45:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Martin Hostettler <martin@neutronstar.dyndns.org>

In a modular build of the iommu code it's possible that the arch iommu code
isn't loaded when trying to enable the iommu. Instead of blindly following a
null pointer return -NODEV in that case.

Signed-off-by: Martin Hostettler <martin@neutronstar.dyndns.org>
---
 arch/arm/plat-omap/iommu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 6cd151b..c1c6887 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -104,6 +104,9 @@ static int iommu_enable(struct iommu *obj)
 	if (!obj)
 		return -EINVAL;
 
+	if (!arch_iommu)
+		return -ENODEV;
+
 	clk_enable(obj->clk);
 
 	err = arch_iommu->enable(obj);
-- 
1.7.1

