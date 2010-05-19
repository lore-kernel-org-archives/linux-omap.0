From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/22] OMAP: CM: Move MAX_MODULE_READY_TIME to cm.h
Date: Tue, 18 May 2010 20:18:40 -0600
Message-ID: <20100519021838.19716.52696.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39773 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0ESCU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:20:59 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

The maximum timeout to wait for the PRCM to request that a module
exit idle or reach functionnal state is common to OMAP2/3/4 SoCs,
so, move it to the chip family-common cm.h include file.

Reduce the timeout from 20 ms to 2 ms.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm.c     |    3 ---
 arch/arm/mach-omap2/cm.h     |    9 +++++++++
 arch/arm/mach-omap2/cm4xxx.c |   18 +-----------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
index 58e4a1c..2d83565 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm.c
@@ -27,9 +27,6 @@
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
 
-/* MAX_MODULE_READY_TIME: max milliseconds for module to leave idle */
-#define MAX_MODULE_READY_TIME		20000
-
 static const u8 cm_idlest_offs[] = {
 	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
 };
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index b6ab183..bbc69df 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -144,4 +144,13 @@ static inline u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 #define OMAP24XX_CM_IDLEST_VAL		0
 #define OMAP34XX_CM_IDLEST_VAL		1
 
+/*
+ * MAX_MODULE_READY_TIME: max duration in microseconds to wait for the
+ * PRCM to request that a module exit the inactive state in the case of
+ * OMAP2 & 3.
+ * In the case of OMAP4 this is the max duration in microseconds for the
+ * module to reach the functionnal state from an inactive state.
+ */
+#define MAX_MODULE_READY_TIME		2000
+
 #endif
diff --git a/arch/arm/mach-omap2/cm4xxx.c b/arch/arm/mach-omap2/cm4xxx.c
index 4af76bb..af32a45 100644
--- a/arch/arm/mach-omap2/cm4xxx.c
+++ b/arch/arm/mach-omap2/cm4xxx.c
@@ -22,23 +22,7 @@
 #include <asm/atomic.h>
 
 #include "cm.h"
-
-/* XXX move this to cm.h */
-/* MAX_MODULE_READY_TIME: max milliseconds for module to leave idle */
-#define MAX_MODULE_READY_TIME			20000
-
-/*
- * OMAP4_PRCM_CM_CLKCTRL_IDLEST_MASK: isolates the IDLEST field in the
- * CM_CLKCTRL register.
- */
-#define OMAP4_PRCM_CM_CLKCTRL_IDLEST_MASK	(0x2 << 16)
-
-/*
- * OMAP4 prcm_mod u32 fields contain packed data: the CM ID in bit 16 and
- * the PRCM module offset address (from the CM module base) in bits 15-0.
- */
-#define OMAP4_PRCM_MOD_CM_ID_SHIFT		16
-#define OMAP4_PRCM_MOD_OFFS_MASK		0xffff
+#include "cm-regbits-44xx.h"
 
 /**
  * omap4_cm_wait_idlest_ready - wait for a module to leave idle or standby


