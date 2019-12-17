From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 2/3] ARM: OMAP2+: Introduce check for OP-TEE in omap_secure_init()
Date: Tue, 17 Dec 2019 18:47:44 -0500
Message-ID: <20191217234745.4434-3-afd@ti.com>
References: <20191217234745.4434-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217234745.4434-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

This check and associated flag can be used to signal the presence
of OP-TEE on the platform. This can be used to determine which
SMC calls to make to perform secure operations.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/omap-secure.c | 14 ++++++++++++++
 arch/arm/mach-omap2/omap-secure.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index e936732cdc4f..39d8070aede6 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 
 #include <asm/cacheflush.h>
 #include <asm/memblock.h>
@@ -20,6 +21,18 @@
 
 static phys_addr_t omap_secure_memblock_base;
 
+bool optee_available;
+
+static void __init omap_optee_init_check(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_path("/firmware/optee");
+	if (np && of_device_is_available(np))
+		optee_available = true;
+	of_node_put(np);
+}
+
 /**
  * omap_sec_dispatcher: Routine to dispatch low power secure
  * service routines
@@ -166,4 +179,5 @@ u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag)
 
 void __init omap_secure_init(void)
 {
+	omap_optee_init_check();
 }
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 9aeeb236a224..78a1c4f04bbe 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -10,6 +10,8 @@
 #ifndef OMAP_ARCH_OMAP_SECURE_H
 #define OMAP_ARCH_OMAP_SECURE_H
 
+#include <linux/types.h>
+
 /* Monitor error code */
 #define  API_HAL_RET_VALUE_NS2S_CONVERSION_ERROR	0xFFFFFFFE
 #define  API_HAL_RET_VALUE_SERVICE_UNKNWON		0xFFFFFFFF
@@ -72,6 +74,7 @@ extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
 extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
 extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
 
+extern bool optee_available;
 void omap_secure_init(void);
 
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
-- 
2.17.1
