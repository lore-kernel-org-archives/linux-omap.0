From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 04/20] ARM: OMAP4: PM: update ROM return address for OSWR and OFF
Date: Tue, 12 Jun 2012 18:31:19 +0300
Message-ID: <1339515095-9908-5-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab2FLPb5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:31:57 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Carlos Leija <cileija@ti.com>

From: Carlos Leija <cileija@ti.com>

At wakeup from OFF/OSWR CPU1 will call secure HAL service through a local
secure dispatcher with MMU off (from omap-headsmp.S), thus ROM will save
a PA return address. Later in the wakeup, when SMC driver calls an RPC through
omap4_secure_dispatcher (MMU is on now), ROM code won't log the new return
address as RPCs are handled different. Thus ROM will attempt to return to
a PA address when the MMU is on and the system will hang.

We need to do this for OSWR state and OFF state of mpu power domain,
not just for device off(mpu pd OFF).

Original workaround was written by:
  Carlos Leija <cileija@ti.com>
  Praneeth Bajjuri <praneeth@ti.com>
  Bryan Buckley <bryan.buckley@ti.com>

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap-secure.h |    1 +
 arch/arm/mach-omap2/omap-secure.c              |   36 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

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
 
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index d9ae4a5..36ec5a5 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
+#include <linux/cpu_pm.h>
 
 #include <asm/cacheflush.h>
 #include <asm/memblock.h>
@@ -21,6 +22,8 @@
 #include <plat/omap-secure.h>
 #include <mach/omap-secure.h>
 
+#include "common.h"
+
 static phys_addr_t omap_secure_memblock_base;
 
 /**
@@ -71,3 +74,36 @@ phys_addr_t omap_secure_ram_mempool_base(void)
 {
 	return omap_secure_memblock_base;
 }
+
+#ifdef CONFIG_CPU_PM
+static int secure_notifier(struct notifier_block *self, unsigned long cmd,
+			   void *v)
+{
+	switch (cmd) {
+	case CPU_CLUSTER_PM_EXIT:
+		/*
+		 * Dummy dispatcher call after OSWR and OFF
+		 * Restore the right return Kernel address (with MMU on) for
+		 * subsequent calls to secure ROM. Otherwise the return address
+		 * will be to a PA return address and the system will hang.
+		 */
+		omap_secure_dispatcher(OMAP4_PPA_SERVICE_0,
+				       FLAG_START_CRITICAL,
+				       0, 0, 0, 0, 0);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block secure_notifier_block = {
+	.notifier_call = secure_notifier,
+};
+
+static int __init secure_pm_init(void)
+{
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		cpu_pm_register_notifier(&secure_notifier_block);
+	return 0;
+}
+early_initcall(secure_pm_init);
+#endif
-- 
1.7.4.1

