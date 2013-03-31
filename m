From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] RX-51: ARM errata 430973 workaround
Date: Sun, 31 Mar 2013 15:54:23 +0200
Message-ID: <1364738063-23868-1-git-send-email-pali.rohar@gmail.com>
References: <20130328155803.GT10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130328155803.GT10155@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

Closed and signed Nokia X-Loader bootloader stored in RX-51 nand does n=
ot set
IBE bit in ACTLR and starting kernel in non-secure mode. So direct writ=
e to
ACTLR by our kernel does not working and the code for ARM errata 430973=
 in
commit 7ce236fcd6fd45b0441a2d49acb2ceb2de2e8a47 that sets IBE bit is a =
noop.

In order to have workaround for ARM errata 430973 from non-secure world=
 on
RX-51 we needs Secure Monitor Call to set IBE BIT in ACTLR.

This patch adds RX-51 specific SMC support and sets IBE bit in ACTLR du=
ring
board init code for ARM errata 430973 workaround.

Because all the setup and what arguments are required for SMC are compl=
etely
different from SoC to SoC it is not possible to create generic SMC hand=
ling.
Code in omap-smc.S looks identical but it is not. So RX-51 needs anothe=
r code.

ARM errata 430973 workaround is needed for thumb-2 ISA compiled userspa=
ce
binaries. Without this workaround thumb-2 binaries crashing. So with th=
is
patch it is possible to recompile and run applications/binaries with th=
umb-2
ISA on RX-51.

Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/Makefile            |    1 +
 arch/arm/mach-omap2/board-rx51-secure.c |   66 +++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/board-rx51-secure.h |   36 +++++++++++++++++
 arch/arm/mach-omap2/board-rx51-smc.S    |   34 ++++++++++++++++
 arch/arm/mach-omap2/board-rx51.c        |    7 ++++
 5 files changed, 144 insertions(+)
 create mode 100644 arch/arm/mach-omap2/board-rx51-secure.c
 create mode 100644 arch/arm/mach-omap2/board-rx51-secure.h
 create mode 100644 arch/arm/mach-omap2/board-rx51-smc.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 37c4e09..cc4665d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -244,6 +244,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51.o sd=
ram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-peripherals.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-video.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-camera.o
+obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-smc.o board-rx51-secure=
=2Eo
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+=3D board-zoom.o board-zoom-peripheral=
s.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+=3D board-zoom-display.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+=3D board-zoom-debugboard.o
diff --git a/arch/arm/mach-omap2/board-rx51-secure.c b/arch/arm/mach-om=
ap2/board-rx51-secure.c
new file mode 100644
index 0000000..361dc78
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-secure.c
@@ -0,0 +1,66 @@
+/*
+ * RX51 Secure PPA API.
+ *
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ *
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <asm/cacheflush.h>
+
+#include "board-rx51-secure.h"
+
+/**
+ * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
+ * @idx: The PPA API index
+ * @flag: The flag indicating criticality of operation
+ * @nargs: Number of valid arguments out of four.
+ * @arg1, arg2, arg3 args4: Parameters passed to secure API
+ *
+ * Return the non-zero error value on failure.
+ */
+u32 rx51_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1, u32=
 arg2,
+			   u32 arg3, u32 arg4)
+{
+	u32 ret;
+	u32 param[5];
+
+	param[0] =3D nargs+1;
+	param[1] =3D arg1;
+	param[2] =3D arg2;
+	param[3] =3D arg3;
+	param[4] =3D arg4;
+
+	/*
+	 * Secure API needs physical address
+	 * pointer for the parameters
+	 */
+	flush_cache_all();
+	outer_clean_range(__pa(param), __pa(param + 5));
+	ret =3D rx51_ppa_smc(idx, flag, __pa(param));
+
+	return ret;
+}
+
+/**
+ * rx51_secure_update_aux_cr: Routine to modify the contents of Auxili=
ary Control Register
+ *  @set_bits: bits to set in ACR
+ *  @clr_bits: bits to clear in ACR
+ *
+ * Return the non-zero error value on failure.
+*/
+u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits)
+{
+	u32 acr;
+
+	/* Read ACR */
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=3Dr" (acr));
+	acr &=3D ~clear_bits;
+	acr |=3D set_bits;
+
+	return rx51_secure_dispatcher(RX51_PPA_WRITE_ACR,
+			       FLAG_START_CRITICAL,
+			       1,acr,0,0,0);
+}
diff --git a/arch/arm/mach-omap2/board-rx51-secure.h b/arch/arm/mach-om=
ap2/board-rx51-secure.h
new file mode 100644
index 0000000..61c760b
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-secure.h
@@ -0,0 +1,36 @@
+/*
+ * board-rx51-secure.h: OMAP Secure infrastructure header.
+ *
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef OMAP_RX51_SECURE_H
+#define OMAP_RX51_SECURE_H
+
+/* HAL API error codes */
+#define  API_HAL_RET_VALUE_OK           0x00
+#define  API_HAL_RET_VALUE_FAIL         0x01
+
+/* Secure HAL API flags */
+#define FLAG_START_CRITICAL             0x4
+#define FLAG_IRQFIQ_MASK                0x3
+#define FLAG_IRQ_ENABLE                 0x2
+#define FLAG_FIQ_ENABLE                 0x1
+#define NO_FLAG                         0x0
+
+/* Secure PPA(Primary Protected Application) APIs */
+#define RX51_PPA_L2_INVAL               40
+#define RX51_PPA_WRITE_ACR              42
+
+#ifndef __ASSEMBLER__
+
+extern u32 rx51_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
+                                u32 arg1, u32 arg2, u32 arg3, u32 arg4=
);
+extern u32 rx51_ppa_smc(u32 id, u32 flag, u32 pargs);
+
+extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
+#endif /* __ASSEMBLER__ */
+#endif /* OMAP_RX51_SECURE_H */
diff --git a/arch/arm/mach-omap2/board-rx51-smc.S b/arch/arm/mach-omap2=
/board-rx51-smc.S
new file mode 100644
index 0000000..70e2eb7
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-smc.S
@@ -0,0 +1,34 @@
+/*
+ * RX51 secure APIs file.
+ *
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ *
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+/**
+ * u32 rx51_ppa_smc(u32 id, u32 flag, u32 pargs)
+ * Low level common routine for secure HAL and PPA APIs.
+ * @id: Secure Service ID
+ * @flag: Flag to indicate the criticality of operation
+ * @pargs: Physical address of parameter list starting
+ *          with number of parametrs
+ */
+ENTRY(rx51_ppa_smc)
+	.arch_extension sec
+	stmfd	sp!, {r4-r12, lr}
+	mov	r12, r0		@ Copy the secure service ID
+	mov	r3, r2		@ Copy the pointer to va_list in R3
+	mov	r2, r1		@ Copy the flags in R2
+	mov	r1, #0x0	@ Process ID - 0
+	mov	r6, #0xff	@ Indicate new Task call
+	dsb
+	dmb
+	smc	#1		@ call PPA service
+	ldmfd	sp!, {r4-r12, pc}
+ENDPROC(rx51_ppa_smc)
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
index 03663c2..74f83a5 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -32,6 +32,7 @@
 #include "gpmc.h"
 #include "pm.h"
 #include "sdram-nokia.h"
+#include "board-rx51-secure.h"
=20
 #define RX51_GPIO_SLEEP_IND 162
=20
@@ -105,6 +106,12 @@ static void __init rx51_init(void)
 	rx51_peripherals_init();
 	rx51_camera_init();
=20
+#ifdef CONFIG_ARM_ERRATA_430973
+	printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\n");
+	/* set IBE to 1 */
+	rx51_secure_update_aux_cr(1 << 6, 0);
+#endif
+
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
--=20
1.7.10.4
