From: Fernando Guzman Lugo <fernando.lugo@ti.com>
Subject: [PATCHv6 3/4] omap: iovmm - replace __iounmap with iounmap
Date: Tue, 14 Dec 2010 07:07:26 -0600
Message-ID: <1292332047-8206-4-git-send-email-fernando.lugo@ti.com>
References: <1292332047-8206-1-git-send-email-fernando.lugo@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292332047-8206-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi.DOYU@nokia.com, linux@arm.linux.org.uk, h-kanigeri2@ti.com
Cc: felipe.contreras@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, "Guzman Lugo, Fernando" <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Guzman Lugo, Fernando <x0095840@ti.com>

__iounmap function is wrong for OMAP architecture,
instead use iounmap which will call to the correct function.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 93a34d9..fa6e643 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -821,7 +821,7 @@ void iommu_kunmap(struct iommu *obj, u32 da)
 	struct sg_table *sgt;
 	typedef void (*func_t)(const void *);
 
-	sgt = unmap_vm_area(obj, da, (func_t)__iounmap,
+	sgt = unmap_vm_area(obj, da, (func_t)iounmap,
 			    IOVMF_LINEAR | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-- 
1.7.3.2
