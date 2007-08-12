From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in plat-omap/mmu.c
Date: Sun, 12 Aug 2007 09:13:44 +0200
Message-ID: <46BEB328.105@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030206040307000400060107"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------030206040307000400060107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix warning

arch/arm/plat-omap/mmu.c:1277: warning: initialization from
incompatible pointer type
arch/arm/plat-omap/mmu.c:1278: warning: initialization from
incompatible pointer type

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------030206040307000400060107
Content-Type: text/plain;
 name="01_plat_omap_mmu_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01_plat_omap_mmu_warning_patch.txt"

Index: linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_mem.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -335,13 +335,18 @@ void mbox_fbctl_upd(void) { }
 static ssize_t dsp_mem_read(struct file *file, char __user *buf, size_t count,
 			    loff_t *ppos)
 {
-	return __omap_mmu_mem_read(&dsp_mmu, (char __user *)buf, *ppos, count);
+	struct bin_attribute attr;
+
+	return __omap_mmu_mem_read(&dsp_mmu, &attr,
+				   (char __user *)buf, *ppos, count);
 }
 
 static ssize_t dsp_mem_write(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	return __omap_mmu_mem_write(&dsp_mmu,
+	struct bin_attribute attr;
+
+	return __omap_mmu_mem_write(&dsp_mmu, &attr,
 				    (char __user *)buf, *ppos, count);
 }
 
Index: linux-osk/arch/arm/plat-omap/mmu.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/mmu.c
+++ linux-osk/arch/arm/plat-omap/mmu.c
@@ -1178,8 +1178,9 @@ static ssize_t exmem_read(struct omap_mm
 	return count;
 }
 
-static ssize_t omap_mmu_mem_read(struct kobject *kobj, char *buf,
-				 loff_t offset, size_t count)
+static ssize_t omap_mmu_mem_read(struct kobject *kobj,
+				 struct bin_attribute * attr,
+				 char *buf, loff_t offset, size_t count)
 {
 	struct device *dev = to_dev(kobj);
 	struct omap_mmu *mmu = dev_get_drvdata(dev);
@@ -1245,8 +1246,9 @@ static ssize_t exmem_write(struct omap_m
 	return count;
 }
 
-static ssize_t omap_mmu_mem_write(struct kobject *kobj, char *buf,
-				  loff_t offset, size_t count)
+static ssize_t omap_mmu_mem_write(struct kobject *kobj,
+				  struct bin_attribute * attr,
+				  char *buf, loff_t offset, size_t count)
 {
 	struct device *dev = to_dev(kobj);
 	struct omap_mmu *mmu = dev_get_drvdata(dev);
@@ -1279,17 +1281,19 @@ static struct bin_attribute dev_attr_mem
 };
 
 /* To be obsolete for backward compatibility */
-ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu, char *buf,
-			    loff_t offset, size_t count)
+ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu,
+			    struct bin_attribute * attr,
+			    char *buf, loff_t offset, size_t count)
 {
-	return omap_mmu_mem_read(&mmu->dev.kobj, buf, offset, count);
+	return omap_mmu_mem_read(&mmu->dev.kobj, attr, buf, offset, count);
 }
 EXPORT_SYMBOL_GPL(__omap_mmu_mem_read);
 
-ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu, char *buf,
-			     loff_t offset, size_t count)
+ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu,
+			     struct bin_attribute * attr,
+			     char *buf, loff_t offset, size_t count)
 {
-	return omap_mmu_mem_write(&mmu->dev.kobj, buf, offset, count);
+	return omap_mmu_mem_write(&mmu->dev.kobj, attr, buf, offset, count);
 }
 EXPORT_SYMBOL_GPL(__omap_mmu_mem_write);
 
Index: linux-osk/include/asm-arm/arch-omap/mmu.h
===================================================================
--- linux-osk.orig/include/asm-arm/arch-omap/mmu.h
+++ linux-osk/include/asm-arm/arch-omap/mmu.h
@@ -190,7 +190,7 @@ void exmap_clear_mem_page(struct omap_mm
 int exmap_valid(struct omap_mmu *mmu, void *vadr, size_t len);
 
 /* To be obsolete for backward compatibility */
-ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu, char *buf, loff_t offset, size_t count);
-ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu, char *buf, loff_t offset, size_t count);
+ssize_t __omap_mmu_mem_read(struct omap_mmu *mmu, struct bin_attribute *, char *buf, loff_t offset, size_t count);
+ssize_t __omap_mmu_mem_write(struct omap_mmu *mmu, struct bin_attribute *, char *buf, loff_t offset, size_t count);
 
 #endif /* __ARCH_OMAP_MMU_H */


--------------030206040307000400060107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030206040307000400060107--
