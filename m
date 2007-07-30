From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 8/8] ARM: OMAP: Add MMU TWL support for omap1
Date: Mon, 30 Jul 2007 14:04:05 +0300
Message-ID: <11857934633255-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934533223-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934552591-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934584117-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934604148-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11857934604148-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Table Walking Logic(TWL) is supported in omap1.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap1/mmu.c |   11 ++++++++++-
 arch/arm/plat-omap/mmu.c  |   45 +++++++++++++++++++--------------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index 876952e..66aa0d4 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-omap2/mmu.c
+ * linux/arch/arm/mach-omap1/mmu.c
  *
  * Support for non-MPU OMAP1 MMUs.
  *
@@ -329,6 +329,14 @@ static void omap1_mmu_interrupt(struct omap_mmu *mmu)
 	schedule_work(&mmu->irq_work);
 }
 
+static pgprot_t omap1_mmu_pte_get_attr(struct omap_mmu_tlb_entry *entry)
+{
+	/* 4KB AP position as default */
+	u32 attr = entry->ap >> 4;
+	attr <<= ((entry->pgsz == OMAP_MMU_CAM_PAGESIZE_1MB) ? 6:0);
+	return attr;
+}
+
 struct omap_mmu_ops omap1_mmu_ops = {
 	.startup	= omap1_mmu_startup,
 	.shutdown	= omap1_mmu_shutdown,
@@ -341,5 +349,6 @@ struct omap_mmu_ops omap1_mmu_ops = {
 	.cam_ram_alloc	= omap1_mmu_cam_ram_alloc,
 	.cam_ram_valid	= omap1_mmu_cam_ram_valid,
 	.interrupt	= omap1_mmu_interrupt,
+	.pte_get_attr	= omap1_mmu_pte_get_attr,
 };
 EXPORT_SYMBOL_GPL(omap1_mmu_ops);
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index cb675d4..b6ec844 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -684,12 +684,10 @@ int omap_mmu_load_pte_entry(struct omap_mmu *mmu,
 			    struct omap_mmu_tlb_entry *entry)
 {
 	int ret = -1;
-	if ((!entry->prsvd) && (mmu->ops->pte_get_attr)) {
-		/*XXX use PG_flag for prsvd */
-		ret = omap_mmu_load_pte(mmu, entry);
-		if (ret)
-			return ret;
-	}
+	/*XXX use PG_flag for prsvd */
+	ret = omap_mmu_load_pte(mmu, entry);
+	if (ret)
+		return ret;
 	if (entry->tlb)
 		ret = omap_mmu_load_tlb_entry(mmu, entry);
 	return ret;
@@ -701,8 +699,7 @@ int omap_mmu_clear_pte_entry(struct omap_mmu *mmu, unsigned long vadr)
 	int ret = omap_mmu_clear_tlb_entry(mmu, vadr);
 	if (ret)
 		return ret;
-	if (mmu->ops->pte_get_attr)
-		omap_mmu_clear_pte(mmu, vadr);
+	omap_mmu_clear_pte(mmu, vadr);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_mmu_clear_pte_entry);
@@ -1035,17 +1032,18 @@ EXPORT_SYMBOL_GPL(omap_mmu_disable);
 
 void omap_mmu_enable(struct omap_mmu *mmu, int reset)
 {
-	u32 val = OMAP_MMU_CNTL_MMU_EN;
+	u32 val = OMAP_MMU_CNTL_MMU_EN | MMU_CNTL_TWLENABLE;
 
 	if (likely(reset))
 		omap_mmu_reset(mmu);
 #if defined(CONFIG_ARCH_OMAP2) /* FIXME */
-	if (mmu->ops->pte_get_attr) {
-		omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd),
-				   OMAP_MMU_TTB);
-		val |= MMU_CNTL_TWLENABLE;
-	}
+	omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd),
+			   OMAP_MMU_TTB);
 #else
+	omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd) & 0xffff,
+			   OMAP_MMU_TTB_L);
+	omap_mmu_write_reg(mmu, (u32)virt_to_phys(mmu->twl_mm->pgd) >> 16,
+			   OMAP_MMU_TTB_H);
 	val |= OMAP_MMU_CNTL_RESET_SW;
 #endif
 	omap_mmu_write_reg(mmu, val, OMAP_MMU_CNTL);
@@ -1462,13 +1460,10 @@ int omap_mmu_register(struct omap_mmu *mmu)
 	if (!mmu->exmap_tbl)
 		return -ENOMEM;
 
-	if (mmu->ops->pte_get_attr) {
-		struct mm_struct *mm =  mm_alloc();
-		if (!mm) {
-			ret = -ENOMEM;
-			goto err_mm_alloc;
-		}
-		mmu->twl_mm = mm;
+	mmu->twl_mm = mm_alloc();
+	if (!mmu->twl_mm) {
+		ret = -ENOMEM;
+		goto err_mm_alloc;
 	}
 
 	ret = device_register(&mmu->dev);
@@ -1531,11 +1526,9 @@ void omap_mmu_unregister(struct omap_mmu *mmu)
 	kfree(mmu->exmap_tbl);
 	mmu->exmap_tbl = NULL;
 
-	if (mmu->ops->pte_get_attr) {
-		if (mmu->twl_mm) {
-			__mmdrop(mmu->twl_mm);
-			mmu->twl_mm = NULL;
-		}
+	if (mmu->twl_mm) {
+		__mmdrop(mmu->twl_mm);
+		mmu->twl_mm = NULL;
 	}
 
 	device_unregister(&mmu->dev);
-- 
1.5.3.rc3.24.g83b3d
