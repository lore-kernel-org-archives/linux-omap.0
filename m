From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 07/13] OMAP3: PM: allocate secure RAM context memory from low-mem
Date: Thu, 18 Nov 2010 19:54:52 -0600
Message-ID: <1290131698-6194-8-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51909 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756150Ab0KSBzC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 20:55:02 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

From: Tero Kristo <tero.kristo@nokia.com>

Currently memory is allocated from kernel heap, which is located at high-mem.
Low-mem allocation is needed due to limitation in ROMCode which mirrors
memory every 256MB of memory blocks back to the first block

Allocation needs to be done later in the process compared to the traditional
reserve as the size required to be allocated depends on the cpu type we are
booting on, and is done as part of the map_io path instead of the reserve
path

[nm@ti.com: modified to use memblock and rebased to 2.6.37-rc2]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/io.c     |   11 +++++++++++
 arch/arm/mach-omap2/pm.h     |    2 ++
 arch/arm/mach-omap2/pm34xx.c |   39 ++++++++++++++++++++++++++++++---------
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..6098f81 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -41,6 +41,7 @@
 #include <plat/omap-pm.h>
 #include <plat/powerdomain.h>
 #include "powerdomains.h"
+#include "pm.h"
 
 #include <plat/clockdomain.h>
 #include "clockdomains.h"
@@ -230,6 +231,13 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif
 
+static void __init _omap_pm_reserve_sdram_memblock(void)
+{
+	if (cpu_is_omap34xx())
+		omap3_pm_reserve_sdram_memblock();
+
+}
+
 static void __init _omap2_map_common_io(void)
 {
 	/* Normally devicemaps_init() would flush caches and tlb after
@@ -241,6 +249,9 @@ static void __init _omap2_map_common_io(void)
 
 	omap2_check_revision();
 	omap_sram_init();
+
+	/* Allocate the secure SRAM storage after sram init and cpu detect */
+	_omap_pm_reserve_sdram_memblock();
 }
 
 #ifdef CONFIG_ARCH_OMAP2420
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 39934ec..fcca056 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -114,11 +114,13 @@ struct omap3_secure_copy_data {
 
 #if defined(CONFIG_PM)
 extern int __init omap3_secure_copy_data_set(struct omap3_secure_copy_data *d);
+extern void __init omap3_pm_reserve_sdram_memblock(void);
 #else
 static inline int omap3_secure_copy_data_set(struct omap3_secure_copy_data *d)
 {
 	return -EINVAL;
 }
+static inline void omap3_pm_reserve_sdram_memblock(void) { }
 #endif
 
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index bbb1a40..7877f74 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
 
 #include <plat/sram.h>
 #include <plat/clockdomain.h>
@@ -60,6 +61,8 @@ static struct omap3_secure_copy_data secure_copy_data = {
 	.save_every_cycle = false,	/* explicit for readability */
 };
 
+#define OMAP3_SECURE_MAX_ALLOCATE_ADDRESS 0x8fffffff
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -198,7 +201,7 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
 		 */
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 		secure_ram_save_status = _omap_save_secure_sram((u32 *)
-				__pa(omap3_secure_ram_storage));
+				(omap3_secure_ram_storage));
 		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
 		if (!secure_copy_data.save_every_cycle)
 			secure_ram_saved = 1;
@@ -1065,14 +1068,6 @@ static int __init omap3_pm_init(void)
 	omap3_idle_init();
 
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
-		omap3_secure_ram_storage =
-			kmalloc(secure_copy_data.size, GFP_KERNEL);
-		if (!omap3_secure_ram_storage)
-			printk(KERN_ERR "Memory allocation failed when"
-					"allocating for secure sram context\n");
-
-	}
 
 	omap3_save_scratchpad_contents();
 err1:
@@ -1087,3 +1082,29 @@ err2:
 }
 
 late_initcall(omap3_pm_init);
+
+void __init omap3_pm_reserve_sdram_memblock(void)
+{
+	phys_addr_t size = secure_copy_data.size;
+	phys_addr_t paddr;
+	phys_addr_t max_addr = OMAP3_SECURE_MAX_ALLOCATE_ADDRESS;
+
+	if (!size || !cpu_is_omap34xx() || omap_type() == OMAP2_DEVICE_TYPE_GP)
+		return;
+
+	/*
+	 * On OMAP3 Silicon, due to ROM Code limitation, we should
+	 * not have the allocation beyond the first 256MB area.
+	 * This limitation is true for both OMAP3430 and 3630 and
+	 * all versions of the same.
+	 */
+	paddr = memblock_alloc_base(size, SZ_1M, max_addr);
+
+	if (!paddr) {
+		pr_err("%s: failed to reserve %x bytes\n",
+				__func__, size);
+		return;
+	}
+
+	omap3_secure_ram_storage = (void *)paddr;
+}
-- 
1.6.3.3

