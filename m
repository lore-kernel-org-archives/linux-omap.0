From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 1/2] ARM: OMAP: Add secure function omap_smc3() which calling instruction smc #1
Date: Wed, 10 Jul 2013 14:59:04 +0200
Message-ID: <1373461145-9812-2-git-send-email-pali.rohar@gmail.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <1373461145-9812-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373461145-9812-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Other secure functions omap_smc1() and omap_smc2() calling instruction =
smc #0
but Nokia RX-51 board needs to call smc #1 for PPA access.

Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/omap-secure.h |    1 +
 arch/arm/mach-omap2/omap-smc.S    |   22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/om=
ap-secure.h
index 0e72917..c4586f4 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -51,6 +51,7 @@
 extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
+extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
=20
diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-=
smc.S
index f6441c1..5c02b8d 100644
--- a/arch/arm/mach-omap2/omap-smc.S
+++ b/arch/arm/mach-omap2/omap-smc.S
@@ -1,9 +1,11 @@
 /*
- * OMAP44xx secure APIs file.
+ * OMAP34xx and OMAP44xx secure APIs file.
  *
  * Copyright (C) 2010 Texas Instruments, Inc.
  * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ * Copyright (C) 2013 Pali Roh=C3=A1r <pali.rohar@gmail.com>
  *
  * This program is free software,you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -54,6 +56,24 @@ ENTRY(omap_smc2)
 	ldmfd   sp!, {r4-r12, pc}
 ENDPROC(omap_smc2)
=20
+/**
+ * u32 omap_smc3(u32 service_id, u32 process_id, u32 flag, u32 pargs)
+ * Low level common routine for secure HAL and PPA APIs via smc #1
+ * r0 - @service_id: Secure Service ID
+ * r1 - @process_id: Process ID
+ * r2 - @flag: Flag to indicate the criticality of operation
+ * r3 - @pargs: Physical address of parameter list
+ */
+ENTRY(omap_smc3)
+	stmfd	sp!, {r4-r12, lr}
+	mov	r12, r0		@ Copy the secure service ID
+	mov	r6, #0xff	@ Indicate new Task call
+	dsb
+	dmb
+	smc	#1		@ call PPA service
+	ldmfd	sp!, {r4-r12, pc}
+ENDPROC(omap_smc3)
+
 ENTRY(omap_modify_auxcoreboot0)
 	stmfd   sp!, {r1-r12, lr}
 	ldr	r12, =3D0x104
--=20
1.7.10.4
