From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/19] ARM: OMAP4: PM: update ROM return address for OSWR and OFF
Date: Fri, 20 Apr 2012 12:33:45 +0300
Message-ID: <1334914432-26456-13-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48161 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab2DTJep (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:34:45 -0400
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
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
 2 files changed, 14 insertions(+), 0 deletions(-)

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
index 2ae5e2c..b4ca6f3 100644
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
+		if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+			omap_secure_dispatcher(OMAP4_PPA_SERVICE_0,
+					       FLAG_START_CRITICAL,
+					       0, 0, 0, 0, 0);
+
 		restore_ivahd_tesla_regs();
 		restore_l3instr_regs();
 	}
-- 
1.7.4.1

