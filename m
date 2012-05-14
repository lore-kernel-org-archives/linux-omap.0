From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 12/19] ARM: OMAP4: PM: update ROM return address for OSWR and OFF
Date: Mon, 14 May 2012 13:18:43 +0300
Message-ID: <1336990730-26892-13-git-send-email-t-kristo@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38457 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860Ab2ENKTi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:19:38 -0400
In-Reply-To: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Carlos Leija <cileija@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Bryan Buckley <bryan.buckley@ti.com>

From: Carlos Leija <cileija@ti.com>

At wakeup from OFF/OSWR CPU1 will call secure HAL service through a local
secure dispatcher with MMU off, thus ROM will save a PA return address.
Later in the wakeup, when SMC driver calls an RPC through
omap4_secure_dispatcher (MMU is on now), ROM code won't log the new return
address as RPCs are handled different. Thus ROM will attempt to return to
a PA address when the MMU is on and the system will hang.

We need to do this for OSWR state and OFF state of mpu power domain,
not just for device off(mpu pd OFF).

Signed-off-by: Carlos Leija <cileija@ti.com>
Signed-off-by: Praneeth Bajjuri <praneeth@ti.com>
Signed-off-by: Bryan Buckley <bryan.buckley@ti.com>
[t-kristo@ti.com: merged the two patches into one]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap-secure.h |    1 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c      |   13 +++++++++++++
 arch/arm/mach-omap2/pm.h                       |    1 +
 arch/arm/mach-omap2/pm44xx.c                   |    8 ++++++++
 4 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/include/mach/omap-secure.h
index c90a435..d9bde61 100644
--- a/arch/arm/mach-omap2/include/mach/omap-secure.h
+++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
@@ -43,6 +43,7 @@
 #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 
 /* Secure PPA(Primary Protected Application) APIs */
+#define OMAP4_PPA_SERVICE_0		0x21
 #define OMAP4_PPA_L2_POR_INDEX		0x23
 #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
 
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index f555ac2..1f06f97 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -52,6 +52,8 @@
 
 #include <plat/omap44xx.h>
 
+#include <mach/omap-secure.h>
+
 #include "iomap.h"
 #include "common.h"
 #include "omap4-sar-layout.h"
@@ -384,6 +386,17 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
 
 	if (omap4_mpuss_read_prev_context_state()) {
+		/*
+		 * Dummy dispatcher call after OSWR and OFF
+		 * Restore the right return Kernel address (with MMU on) for
+		 * subsequent calls to secure ROM. Otherwise the return address
+		 * will be to a PA return address and the system will hang.
+		 */
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_RETURN_ADDRESS_ERRATUM))
+			omap_secure_dispatcher(OMAP4_PPA_SERVICE_0,
+					       FLAG_START_CRITICAL,
+					       0, 0, 0, 0, 0);
+
 		restore_ivahd_tesla_regs();
 		restore_l3instr_regs();
 	}
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b971f6f..1d24b96 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -132,6 +132,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 
 #define PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM	(1 << 0)
 #define PM_OMAP4_ROM_L3INSTR_ERRATUM		(1 << 1)
+#define PM_OMAP4_ROM_RETURN_ADDRESS_ERRATUM	(1 << 2)
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
 extern u16 pm44xx_errata;
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 8591df2..215b80e 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -282,6 +282,14 @@ static int __init omap4_pm_init(void)
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
 		pm44xx_errata |= PM_OMAP4_ROM_L3INSTR_ERRATUM;
 
+	/*
+	 * Restore the right return Kernel address (with MMU on) for
+	 * subsequent calls to secure ROM. Otherwise the return address
+	 * will be to a PA return address and the system will hang.
+	 */
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		pm44xx_errata |= PM_OMAP4_ROM_RETURN_ADDRESS_ERRATUM;
+
 #ifdef CONFIG_SUSPEND
 	omap_pm_suspend = omap4_pm_suspend;
 #endif
-- 
1.7.4.1

