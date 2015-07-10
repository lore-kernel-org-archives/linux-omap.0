From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: OMAP2+: Remove module references from IOMMU machine layer
Date: Fri, 10 Jul 2015 15:43:05 -0500
Message-ID: <1436560985-5947-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The OMAP IOMMU driver has been adapted to the IOMMU framework
for a while now, and it no longer supports being built as a
module. Cleanup all the module related references both from
the code and in the build.

While at it, also relocate a comment around the initcall to
avoid a checkpatch strict warning about using a blank line
after function/struct/union/enum declarations.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/Makefile     |  3 +--
 arch/arm/mach-omap2/omap-iommu.c | 13 +------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 903c85be2897..d4579f856b25 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -234,8 +234,7 @@ obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o
 # EMU peripherals
 obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
 
-iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
-obj-y					+= $(iommu-m) $(iommu-y)
+obj-$(CONFIG_OMAP_IOMMU)		+= omap-iommu.o
 
 # OMAP2420 MSDI controller integration support ("MMC")
 obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 4068350f9059..8867eb4025bf 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/of.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -63,15 +62,5 @@ static int __init omap_iommu_init(void)
 
 	return omap_hwmod_for_each_by_class("mmu", omap_iommu_dev_init, NULL);
 }
-/* must be ready before omap3isp is probed */
 omap_subsys_initcall(omap_iommu_init);
-
-static void __exit omap_iommu_exit(void)
-{
-	/* Do nothing */
-}
-module_exit(omap_iommu_exit);
-
-MODULE_AUTHOR("Hiroshi DOYU");
-MODULE_DESCRIPTION("omap iommu: omap device registration");
-MODULE_LICENSE("GPL v2");
+/* must be ready before omap3isp is probed */
-- 
2.4.4
