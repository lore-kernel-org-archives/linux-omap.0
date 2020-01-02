From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v4 3/4] ARM: OMAP2+: Use ARM SMC Calling Convention when OP-TEE is available
Date: Thu, 2 Jan 2020 16:19:42 -0500
Message-ID: <20200102211943.20480-4-afd@ti.com>
References: <20200102211943.20480-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102211943.20480-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

On High-Security(HS) OMAP2+ class devices a couple actions must be
performed from the ARM TrustZone during boot. These traditionally can be
performed by calling into the secure ROM code resident in this secure
world using legacy SMC calls. Optionally OP-TEE can replace this secure
world functionality by replacing the ROM after boot. ARM recommends a
standard calling convention is used for this interaction (SMC Calling
Convention). We check for the presence of OP-TEE and use this type of
call to perform the needed actions, falling back to the legacy OMAP ROM
call if OP-TEE is not available.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/common.h      |  2 +-
 arch/arm/mach-omap2/omap-secure.c | 27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h |  2 ++
 arch/arm/mach-omap2/omap-smc.S    |  6 +++---
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 223b37c48389..3b1fd8e7d705 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -255,7 +255,7 @@ extern void gic_dist_disable(void);
 extern void gic_dist_enable(void);
 extern bool gic_dist_disabled(void);
 extern void gic_timer_retrigger(void);
-extern void omap_smc1(u32 fn, u32 arg);
+extern void _omap_smc1(u32 fn, u32 arg);
 extern void omap4_sar_ram_init(void);
 extern void __iomem *omap4_get_sar_ram_base(void);
 extern void omap4_mpuss_early_init(void);
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index 568646660081..d00e3c72e37d 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2013 Pali Rohár <pali.rohar@gmail.com>
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -17,12 +18,17 @@
 #include <asm/cacheflush.h>
 #include <asm/memblock.h>
 
+#include "common.h"
 #include "omap-secure.h"
 
 static phys_addr_t omap_secure_memblock_base;
 
 bool optee_available;
 
+#define OMAP_SIP_SMC_STD_CALL_VAL(func_num) \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_32, \
+	ARM_SMCCC_OWNER_SIP, (func_num))
+
 static void __init omap_optee_init_check(void)
 {
 	struct device_node *np;
@@ -71,6 +77,27 @@ u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32 arg2,
 	return ret;
 }
 
+void omap_smccc_smc(u32 fn, u32 arg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(OMAP_SIP_SMC_STD_CALL_VAL(fn), arg,
+		      0, 0, 0, 0, 0, 0, &res);
+	WARN(res.a0, "Secure function call 0x%08x failed\n", fn);
+}
+
+void omap_smc1(u32 fn, u32 arg)
+{
+	/*
+	 * If this platform has OP-TEE installed we use ARM SMC calls
+	 * otherwise fall back to the OMAP ROM style calls.
+	 */
+	if (optee_available)
+		omap_smccc_smc(fn, arg);
+	else
+		_omap_smc1(fn, arg);
+}
+
 /* Allocate the memory to save secure ram */
 int __init omap_secure_ram_reserve_memblock(void)
 {
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 78a1c4f04bbe..736e594365f4 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -62,6 +62,8 @@
 
 extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+extern void omap_smccc_smc(u32 fn, u32 arg);
+extern void omap_smc1(u32 fn, u32 arg);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
 extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-smc.S
index fd2bcd91f4a1..d4832845a4e8 100644
--- a/arch/arm/mach-omap2/omap-smc.S
+++ b/arch/arm/mach-omap2/omap-smc.S
@@ -18,18 +18,18 @@
  * the monitor API number. It uses few CPU registers
  * internally and hence they need be backed up including
  * link register "lr".
- * Function signature : void omap_smc1(u32 fn, u32 arg)
+ * Function signature : void _omap_smc1(u32 fn, u32 arg)
  */
 	.arch armv7-a
 	.arch_extension sec
-ENTRY(omap_smc1)
+ENTRY(_omap_smc1)
 	stmfd   sp!, {r2-r12, lr}
 	mov	r12, r0
 	mov 	r0, r1
 	dsb
 	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
-ENDPROC(omap_smc1)
+ENDPROC(_omap_smc1)
 
 /**
  * u32 omap_smc2(u32 id, u32 falg, u32 pargs)
-- 
2.17.1
