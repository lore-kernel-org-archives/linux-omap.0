From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH] iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF
Date: Thu,  7 Oct 2010 13:43:41 -0500
Message-ID: <1286477021-23169-1-git-send-email-x0095840@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, david.cohen@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

IV2 MMU capable addresses start from 0x11000000

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/iovmm.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 75965a1..c0344f4 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -286,7 +286,12 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 		/*
 		 * Reserve the first page for NULL
 		 */
-		start = PAGE_SIZE;
+		if (!strcmp(obj->name, "iva2"))
+			/* IVA2 MMU control starts from 0x11000000 */
+			start = 0x11000000;
+		else
+			start = PAGE_SIZE;
+
 		if (flags & IOVMF_LINEAR)
 			alignement = iopgsz_max(bytes);
 		start = roundup(start, alignement);
-- 
1.6.3.3
