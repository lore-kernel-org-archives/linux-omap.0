From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 03/13] OMAP3: PM: make secure ram save size configurable
Date: Thu, 18 Nov 2010 19:54:48 -0600
Message-ID: <1290131698-6194-4-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55459 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758428Ab0KSBzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 20:55:03 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

OMAP3 users of HS/EMU devices at times choose to use their
own PPA which could be configured to use different sized storage
area based on their security needs. Convert the hardcoded size
define to a more configurable form to map to these users. we introduce
the structure omap3_secure_copy_data to describe PPA specific behavior
we will further populate in follow on patches. secure_copy_data_set
is introduced to allow for board files to populate custom parameters
as desired.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.h     |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c |   27 ++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0d75bfd..c0af788 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -85,4 +85,27 @@ extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 
+/**
+ * struct omap3_secure_copy_data - describe behavior for the secure ram copy
+ * @size:	size of copy to be saved - this is based on the PPA used
+ *		secure ram size could be configured to various sizes, this is
+ *		the size used + 64 byte header required.
+ *
+ * Different platforms use different security PPAs based on their unique needs.
+ * This structure describes the delta behavior expected for these custom
+ * platforms. The defaults are configured for official TI OMAP3 PPA behavior.
+ */
+struct omap3_secure_copy_data {
+	u32 size;
+};
+
+#if defined(CONFIG_PM)
+extern int __init omap3_secure_copy_data_set(struct omap3_secure_copy_data *d);
+#else
+static inline int omap3_secure_copy_data_set(struct omap3_secure_copy_data *d)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 75c0cd1..633b696 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -54,6 +54,11 @@
 #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
+/* Secure ram save size - store the defaults */
+static struct omap3_secure_copy_data secure_copy_data = {
+	.size = 0x803F,
+};
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -154,6 +159,26 @@ static void omap3_core_restore_context(void)
 	omap_dma_global_context_restore();
 }
 
+/**
+ * omap3_secure_copy_data_set() - set up the secure ram copy size
+ * @data - platform specific customization
+ *
+ * This function should be invoked by the board's init_irq function to update
+ * data prior to pm_init call is invoked. This call be done to update based on
+ * ppa used on that platform.
+ *
+ * Returns -EINVAL for bad values, and 0 if all good.
+ */
+int __init omap3_secure_copy_data_set(struct omap3_secure_copy_data *data)
+{
+	if (!data || !data->size)
+		return -EINVAL;
+
+	memcpy(&secure_copy_data, data, sizeof(secure_copy_data));
+
+	return 0;
+}
+
 /*
  * FIXME: This function should be called before entering off-mode after
  * OMAP3 secure services have been accessed. Currently it is only called
@@ -1038,7 +1063,7 @@ static int __init omap3_pm_init(void)
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
-			kmalloc(0x803F, GFP_KERNEL);
+			kmalloc(secure_copy_data.size, GFP_KERNEL);
 		if (!omap3_secure_ram_storage)
 			printk(KERN_ERR "Memory allocation failed when"
 					"allocating for secure sram context\n");
-- 
1.6.3.3

