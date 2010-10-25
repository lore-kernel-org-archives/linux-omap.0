From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCHv5 3/4] iovmm: replace __iounmap with omap_iounmap
Date: Mon, 25 Oct 2010 13:52:10 -0500
Message-ID: <1288032731-541-4-git-send-email-x0095840@ti.com>
References: <1288032731-541-1-git-send-email-x0095840@ti.com>
 <1288032731-541-2-git-send-email-x0095840@ti.com>
 <1288032731-541-3-git-send-email-x0095840@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288032731-541-3-git-send-email-x0095840@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: felipe.contreras@nokia.com, tony@atomide.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

Omap platform is omap_iounmap function.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 93a34d9..5489ca9 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -821,7 +821,7 @@ void iommu_kunmap(struct iommu *obj, u32 da)
 	struct sg_table *sgt;
 	typedef void (*func_t)(const void *);
 
-	sgt = unmap_vm_area(obj, da, (func_t)__iounmap,
+	sgt = unmap_vm_area(obj, da, (func_t)omap_iounmap,
 			    IOVMF_LINEAR | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-- 
1.6.3.3
