From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 07/24] OMAP: Add Secure HAL and monitor mode API infrastructure.
Date: Sat, 24 Sep 2011 11:44:27 +0530
Message-ID: <1316844884-21700-8-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1IXGPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 02:15:06 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP secure/emulation devices, certain APIs are exported by secure
code. Add an infrastructure so that relevant operations on secure
devices can be implemented using it.

While at this, rename omap44xx-smc.S to omap-smc.S since the common APIs
can be used on other OMAP's too.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |   11 ++--
 arch/arm/mach-omap2/include/mach/omap-secure.h     |   40 +++++++++++++++
 arch/arm/mach-omap2/omap-secure.c                  |   52 ++++++++++++++++++++
 arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} |   23 +++++++++
 4 files changed, 121 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-secure.h
 create mode 100644 arch/arm/mach-omap2/omap-secure.c
 rename arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} (70%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..663f28a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,10 +11,11 @@ hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
 					  clkt_dpll.o clkt_clksel.o
+secure-common                          = omap-smc.o omap-secure.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
+obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
@@ -24,11 +25,11 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_omap-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 # Functions loaded to SRAM
 obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
new file mode 100644
index 0000000..26e7bcc
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
@@ -0,0 +1,40 @@
+/*
+ * omap-secure.h: OMAP Secure infrastructure header.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef OMAP_ARCH_OMAP_SECURE_H
+#define OMAP_ARCH_OMAP_SECURE_H
+
+/* Monitor error code */
+#define  API_HAL_RET_VALUE_NS2S_CONVERSION_ERROR	0xFFFFFFFE
+#define  API_HAL_RET_VALUE_SERVICE_UNKNWON		0xFFFFFFFF
+
+/* HAL API error codes */
+#define  API_HAL_RET_VALUE_OK		0x00
+#define  API_HAL_RET_VALUE_FAIL		0x01
+
+/* Secure HAL API flags */
+#define FLAG_START_CRITICAL		0x4
+#define FLAG_IRQFIQ_MASK		0x3
+#define FLAG_IRQ_ENABLE			0x2
+#define FLAG_FIQ_ENABLE			0x1
+#define NO_FLAG				0x0
+
+
+/* Secure low power HAL API index */
+#define OMAP4_HAL_SAVESECURERAM_INDEX	0x1a
+#define OMAP4_HAL_SAVEHW_INDEX		0x1b
+#define OMAP4_HAL_SAVEALL_INDEX		0x1c
+#define OMAP4_HAL_SAVEGIC_INDEX		0x1d
+
+extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
+				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
+
+#endif /* OMAP_ARCH_OMAP_SECURE_H */
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
new file mode 100644
index 0000000..e5a606e
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -0,0 +1,52 @@
+/*
+ * OMAP Secure API infrastructure.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+
+#include <mach/omap-secure.h>
+
+/**
+ * omap_sec_dispatcher: Routine to dispatch low power secure
+ * service routines
+ * @idx: The HAL API index
+ * @flag: The flag indicating criticality of operation
+ * @nargs: Number of valid arguments out of four.
+ * @arg1, arg2, arg3 args4: Parameters passed to secure API
+ *
+ * Return the non-zero error value on failure.
+ */
+u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32 arg2,
+							 u32 arg3, u32 arg4)
+{
+	u32 ret;
+	u32 param[5];
+
+	param[0] = nargs;
+	param[1] = arg1;
+	param[2] = arg2;
+	param[3] = arg3;
+	param[4] = arg4;
+
+	/*
+	 * Secure API needs physical address
+	 * pointer for the parameters
+	 */
+	flush_cache_all();
+	outer_clean_range(__pa(param), __pa(param + 5));
+	ret = omap_smc2(idx, flag, __pa(param));
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-omap2/omap-smc.S
similarity index 70%
rename from arch/arm/mach-omap2/omap44xx-smc.S
rename to arch/arm/mach-omap2/omap-smc.S
index e69d37d..f6441c1 100644
--- a/arch/arm/mach-omap2/omap44xx-smc.S
+++ b/arch/arm/mach-omap2/omap-smc.S
@@ -31,6 +31,29 @@ ENTRY(omap_smc1)
 	ldmfd   sp!, {r2-r12, pc}
 ENDPROC(omap_smc1)
 
+/**
+ * u32 omap_smc2(u32 id, u32 falg, u32 pargs)
+ * Low level common routine for secure HAL and PPA APIs.
+ * @id: Application ID of HAL APIs
+ * @flag: Flag to indicate the criticality of operation
+ * @pargs: Physical address of parameter list starting
+ *	    with number of parametrs
+ */
+ENTRY(omap_smc2)
+	stmfd   sp!, {r4-r12, lr}
+	mov	r3, r2
+	mov	r2, r1
+	mov	r1, #0x0	@ Process ID
+	mov	r6, #0xff
+	mov	r12, #0x00	@ Secure Service ID
+	mov	r7, #0
+	mcr	p15, 0, r7, c7, c5, 6
+	dsb
+	dmb
+	smc	#0
+	ldmfd   sp!, {r4-r12, pc}
+ENDPROC(omap_smc2)
+
 ENTRY(omap_modify_auxcoreboot0)
 	stmfd   sp!, {r1-r12, lr}
 	ldr	r12, =0x104
-- 
1.7.4.1

