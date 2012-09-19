From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 09/15] tidspbridge: Remove unused hw_mmu_map_attrs_t::donotlockmpupage field
Date: Wed, 19 Sep 2012 14:06:57 +0200
Message-ID: <1348056423-25573-10-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35804 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184Ab2ISMGj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:39 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |    4 ----
 drivers/staging/tidspbridge/hw/hw_mmu.h       |    1 -
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index cc538ea..5cd85dc 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -1508,10 +1508,6 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 			return -EINVAL;
 		}
 	}
-	if (attrs & DSP_MAPDONOTLOCK)
-		hw_attrs.donotlockmpupage = 1;
-	else
-		hw_attrs.donotlockmpupage = 0;
 
 	if (attrs & DSP_MAPVMALLOCADDR) {
 		return mem_map_vmalloc(dev_ctxt, mpu_addr, virt_addr,
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.h b/drivers/staging/tidspbridge/hw/hw_mmu.h
index 7f960cd..37fc4d4 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.h
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.h
@@ -39,7 +39,6 @@ struct hw_mmu_map_attrs_t {
 	enum hw_endianism_t endianism;
 	enum hw_element_size_t element_size;
 	enum hw_mmu_mixed_size_t mixed_size;
-	bool donotlockmpupage;
 };
 
 extern hw_status hw_mmu_enable(const void __iomem *base_address);
-- 
1.7.8.6

