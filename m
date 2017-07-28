From: Josue Albarran <j-albarran@ti.com>
Subject: [PATCH 1/2] iommu/omap: Fix disabling of MMU upon a fault
Date: Fri, 28 Jul 2017 15:49:13 -0500
Message-ID: <1501274954-20973-2-git-send-email-j-albarran@ti.com>
References: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Fernando Guzman Lugo <fernando.lugo@ti.com>

The IOMMU framework lets its client users be notified on a
MMU fault and allows them to either handle the interrupt by
dynamic reloading of an appropriate TLB/PTE for the offending
fault address or to completely restart/recovery the device
and its IOMMU.

The OMAP remoteproc driver performs the latter option, and
does so after unwinding the previous mappings. The OMAP IOMMU
fault handler however disables the MMU and cuts off the clock
upon a MMU fault at present, resulting in an interconnect abort
during any subsequent operation that touches the MMU registers.

So, disable the IP-level fault interrupts instead of disabling
the MMU, to allow continued MMU register operations as well as
to avoid getting interrupted again.

Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
[s-anna@ti.com: add commit description]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Josue Albarran <j-albarran@ti.com>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 641e035cf866..10c9de8de45d 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -786,7 +786,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!report_iommu_fault(domain, obj->dev, da, 0))
 		return IRQ_HANDLED;
 
-	iommu_disable(obj);
+	iommu_write_reg(obj, 0, MMU_IRQENABLE);
 
 	iopgd = iopgd_offset(obj, da);
 
-- 
2.7.4
