From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while
 arch_iommu is in use
Date: Fri, 25 Mar 2011 14:37:55 -0500
Message-ID: <AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44736 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753136Ab1CYTiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 15:38:06 -0400
Received: by mail-ww0-f45.google.com with SMTP id 36so979880wwi.2
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 12:37:55 -0700 (PDT)
In-Reply-To: <4D8CB106.7030608@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Cohen David Abraham <david.cohen@nokia.com>

On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Hi,
>
> This patchset is aimed to fix a problem in arch_iommu implementation
> references. When an actual arch_iommu implementation is not loaded while
> iommu_get() is being called results to a kernel oops, as well as
> removing an arch_iommu implementation which is in use.

How about fixing the dependency instead? Right now iommu2 depends on
iommu because of the calls to
install_iommu_arch/uninstall_iommu_arch... we should change that
dependency to iommu depend on iommu2. Something like iommu (plat)
querying iommu2 (mach) for devices to install.

This way depmod (if I'm not mistaken) can do its job, you won't be
able to remove iommu2 in the middle of execution nor install iommu
without its mach counterpart being there first, it should also fix
clients depending on this modules, e.g "modprobe bridgedriver" would
only install iommu and bridgedriver, with this new dependency iommu2
should be installed as well. BTW same happens with omap mailbox.

$ lsmod
iovmm                   7225  1 bridgedriver
iommu                  11084  2 bridgedriver,iovmm
iommu2                  4783  1 iommu

I can send as a patch if the mailer screws the spacing, also just
copy-pasted and played with the pointers, if needed we can give better
naming.

Regards,

Omar

---

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index adb083e..ab2f9a9 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -341,15 +341,47 @@ static const struct iommu_functions omap2_iommu_ops = {
 	.dump_ctx	= omap2_iommu_dump_ctx,
 };

+/**
+ * install_iommu_arch - Install archtecure specific iommu functions
+ * @ops:	a pointer to architecture specific iommu functions
+ *
+ * There are several kind of iommu algorithm(tlb, pagetable) among
+ * omap series. This interface installs such an iommu algorighm.
+ **/
+int install_iommu_arch(const struct iommu_functions **ops)
+{
+	if (*ops)
+		return -EBUSY;
+	*ops = &omap2_iommu_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(install_iommu_arch);
+
+/**
+ * uninstall_iommu_arch - Uninstall archtecure specific iommu functions
+ * @ops:	a pointer to architecture specific iommu functions
+ *
+ * This interface uninstalls the iommu algorighm installed previously.
+ **/
+void uninstall_iommu_arch(const struct iommu_functions **ops)
+{
+	if (*ops != &omap2_iommu_ops)
+		pr_err("%s: not your arch\n", __func__);
+
+	*ops = NULL;
+}
+EXPORT_SYMBOL_GPL(uninstall_iommu_arch);
+
 static int __init omap2_iommu_init(void)
 {
-	return install_iommu_arch(&omap2_iommu_ops);
+	return 0;
 }
 module_init(omap2_iommu_init);

 static void __exit omap2_iommu_exit(void)
 {
-	uninstall_iommu_arch(&omap2_iommu_ops);
+	/* Do nothing */
 }
 module_exit(omap2_iommu_exit);

diff --git a/arch/arm/plat-omap/include/plat/iommu.h
b/arch/arm/plat-omap/include/plat/iommu.h
index 174f1b9..1c8e7ee 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -177,9 +177,6 @@ extern int iommu_set_isr(const char *name,
 extern void iommu_save_ctx(struct iommu *obj);
 extern void iommu_restore_ctx(struct iommu *obj);

-extern int install_iommu_arch(const struct iommu_functions *ops);
-extern void uninstall_iommu_arch(const struct iommu_functions *ops);
-
 extern int foreach_iommu_device(void *data,
 				int (*fn)(struct device *, void *));

diff --git a/arch/arm/plat-omap/include/plat/iommu2.h
b/arch/arm/plat-omap/include/plat/iommu2.h
index 10ad05f..8189f58 100644
--- a/arch/arm/plat-omap/include/plat/iommu2.h
+++ b/arch/arm/plat-omap/include/plat/iommu2.h
@@ -80,6 +80,9 @@
 #define MMU_RAM_MIXED_MASK	(1 << MMU_RAM_MIXED_SHIFT)
 #define MMU_RAM_MIXED		MMU_RAM_MIXED_MASK

+extern int install_iommu_arch(const struct iommu_functions **ops);
+extern void uninstall_iommu_arch(const struct iommu_functions **ops);
+
 /*
  * register accessors
  */
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 8a51fd5..f088929 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -37,38 +37,6 @@ static struct platform_driver omap_iommu_driver;
 static struct kmem_cache *iopte_cachep;

 /**
- * install_iommu_arch - Install archtecure specific iommu functions
- * @ops:	a pointer to architecture specific iommu functions
- *
- * There are several kind of iommu algorithm(tlb, pagetable) among
- * omap series. This interface installs such an iommu algorighm.
- **/
-int install_iommu_arch(const struct iommu_functions *ops)
-{
-	if (arch_iommu)
-		return -EBUSY;
-
-	arch_iommu = ops;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(install_iommu_arch);
-
-/**
- * uninstall_iommu_arch - Uninstall archtecure specific iommu functions
- * @ops:	a pointer to architecture specific iommu functions
- *
- * This interface uninstalls the iommu algorighm installed previously.
- **/
-void uninstall_iommu_arch(const struct iommu_functions *ops)
-{
-	if (arch_iommu != ops)
-		pr_err("%s: not your arch\n", __func__);
-
-	arch_iommu = NULL;
-}
-EXPORT_SYMBOL_GPL(uninstall_iommu_arch);
-
-/**
  * iommu_save_ctx - Save registers for pm off-mode support
  * @obj:	target iommu
  **/
@@ -1072,10 +1040,15 @@ static void iopte_cachep_ctor(void *iopte)

 static int __init omap_iommu_init(void)
 {
+	int err;
 	struct kmem_cache *p;
 	const unsigned long flags = SLAB_HWCACHE_ALIGN;
 	size_t align = 1 << 10; /* L2 pagetable alignement */

+	err = install_iommu_arch(&arch_iommu);
+	if (err)
+		return err;
+
 	p = kmem_cache_create("iopte_cache", IOPTE_TABLE_SIZE, align, flags,
 			      iopte_cachep_ctor);
 	if (!p)
@@ -1090,6 +1063,8 @@ static void __exit omap_iommu_exit(void)
 {
 	kmem_cache_destroy(iopte_cachep);

+	uninstall_iommu_arch(&arch_iommu);
+
 	platform_driver_unregister(&omap_iommu_driver);
 }
 module_exit(omap_iommu_exit);
