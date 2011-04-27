From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH FOR 2.6.39] omap: iommu: Return IRQ_HANDLED in fault handler when no fault occured
Date: Wed, 27 Apr 2011 16:03:02 +0200
Message-ID: <1303912982-10309-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:41469 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825Ab1D0OCr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 10:02:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Cohen <dacohen@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>

The iommu shares an interrupt line with the OMAP3 ISP. The iommu
interrupt handler must check the fault status and return IRQ_HANDLED
when no fault occured.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/plat-omap/iommu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

The OMAP3 ISP IOMMU got broken in 2.6.39-rc1 by

commit d594f1f31afe13edd8c02f3854a65cc58cfb3b74
Author: David Cohen <dacohen@gmail.com>
Date:   Wed Feb 16 19:35:51 2011 +0000

    omap: IOMMU: add support to callback during fault handling
    
    Add support to register an isr for IOMMU fault situations and adapt it
    to allow such (*isr)() to be used as fault callback. Drivers using IOMMU
    module might want to be informed when errors happen in order to debug it
    or react.
    
    Signed-off-by: David Cohen <dacohen@gmail.com>
    Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

This patch fixes it and should be pushed to mainline in 2.6.39. The OMAP3 ISP
driver, new in 2.6.39, would otherwise be totally broken until 2.6.40.

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 8a51fd5..34fc31e 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -793,6 +793,8 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	clk_enable(obj->clk);
 	errs = iommu_report_fault(obj, &da);
 	clk_disable(obj->clk);
+	if (errs == 0)
+		return IRQ_HANDLED;
 
 	/* Fault callback or TLB/PTE Dynamic loading */
 	if (obj->isr && !obj->isr(obj, da, errs, obj->isr_priv))
-- 
Regards,

Laurent Pinchart

