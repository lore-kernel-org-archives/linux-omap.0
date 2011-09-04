From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 12/25] OMAP: Add support to allocate the memory for secure RAM
Date: Sun, 4 Sep 2011 19:24:13 +0530
Message-ID: <1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47626 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590Ab1IDN4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 09:56:03 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Allocate the memory to save secure ram context which needs
to be done when MPU is hitting off mode.

The ROM code expects a physical address to this memory
and hence use memblock APIs to reserve this memory as part
of .reserve() callback.

Maximum possible size is allocated and can cater to OMAP3XXX / OMAP4XXX
secure RAM size requirements.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap-secure.h |    4 +++
 arch/arm/mach-omap2/omap-secure.c              |   29 ++++++++++++++++++++++++
 arch/arm/plat-omap/common.c                    |    3 ++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
index 26e7bcc..e2f95a0 100644
--- a/arch/arm/mach-omap2/include/mach/omap-secure.h
+++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
@@ -26,6 +26,8 @@
 #define FLAG_FIQ_ENABLE			0x1
 #define NO_FLAG				0x0
 
+/* Maximum Secure memory storage size */
+#define OMAP_SECURE_RAM_STORAGE	(88 * SZ_1K)
 
 /* Secure low power HAL API index */
 #define OMAP4_HAL_SAVESECURERAM_INDEX	0x1a
@@ -36,5 +38,7 @@
 extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
+extern phys_addr_t omap_secure_ram_mempool_base(void);
+extern int omap_secure_ram_reserve_memblock(void);
 
 #endif /* OMAP_ARCH_OMAP_SECURE_H */
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index e5a606e..69f3c72 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -13,11 +13,14 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
 
 #include <asm/cacheflush.h>
 
 #include <mach/omap-secure.h>
 
+static phys_addr_t omap_secure_memblock_base;
+
 /**
  * omap_sec_dispatcher: Routine to dispatch low power secure
  * service routines
@@ -50,3 +53,29 @@ u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32 arg2,
 
 	return ret;
 }
+
+/* Allocate the memory to save secure ram */
+int __init omap_secure_ram_reserve_memblock(void)
+{
+	phys_addr_t paddr;
+	u32 size = OMAP_SECURE_RAM_STORAGE;
+
+	size = ALIGN(size, SZ_1M);
+	paddr = memblock_alloc(size, SZ_1M);
+	if (!paddr) {
+		pr_err("%s: failed to reserve %x bytes\n",
+				__func__, size);
+		return -ENOMEM;
+	}
+	memblock_free(paddr, size);
+	memblock_remove(paddr, size);
+
+	omap_secure_memblock_base = paddr;
+
+	return 0;
+}
+
+phys_addr_t omap_secure_ram_mempool_base(void)
+{
+	return omap_secure_memblock_base;
+}
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index d9f10a3..827f896 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -21,6 +21,8 @@
 #include <plat/vram.h>
 #include <plat/dsp.h>
 
+#include <mach/omap-secure.h>
+
 
 #define NO_LENGTH_CHECK 0xffffffff
 
@@ -65,4 +67,5 @@ void __init omap_reserve(void)
 	omapfb_reserve_sdram_memblock();
 	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
+	omap_secure_ram_reserve_memblock();
 }
-- 
1.7.4.1

