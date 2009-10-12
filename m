From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] OMAP3 PM restore observability settings after off mode
Date: Mon, 12 Oct 2009 18:03:10 +0300
Message-ID: <1255359790-10407-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31049 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932533AbZJLPEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 11:04:46 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9CF32e0005933
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 10:03:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch restores the observability settings after resuming from off mode.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/debobs.c             |    9 +++++++++
 arch/arm/mach-omap2/pm34xx.c             |    4 ++++
 arch/arm/plat-omap/include/mach/debobs.h |    1 +
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/debobs.c b/arch/arm/mach-omap2/debobs.c
index 4fbabef..d25b9a2 100644
--- a/arch/arm/mach-omap2/debobs.c
+++ b/arch/arm/mach-omap2/debobs.c
@@ -190,6 +190,15 @@ static inline int __init _new_debobs_pad(struct debobs_pad *pad, char *name,
 
 /* Public functions */
 
+void debobs_restore(void)
+{
+	struct debobs_pad *p = &debobs_pads[0];
+	int i;
+
+	for (i = 0; i < NUM_OF_DEBOBS_PADS; i++, p++)
+		debobs_set(&p->core_obs, p->core_obs.value);
+}
+
 void debug_gpio_set(unsigned gpio, int value)
 {
 	if (!debobs_initialized)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 553fe02..20c7ea2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -42,6 +42,7 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/dma.h>
+#include <mach/debobs.h>
 #include <asm/tlbflush.h>
 
 #include "cm.h"
@@ -124,6 +125,9 @@ static void omap3_core_restore_context(void)
 	/* Restore the interrupt controller context */
 	omap3_intc_restore_context();
 	omap_dma_global_context_restore();
+	/* restore debobs context */
+	debobs_restore();
+
 }
 
 static void omap3_save_secure_ram_context(u32 target_mpu_state)
diff --git a/arch/arm/plat-omap/include/mach/debobs.h b/arch/arm/plat-omap/include/mach/debobs.h
index 67f765d..1e04bcd 100644
--- a/arch/arm/plat-omap/include/mach/debobs.h
+++ b/arch/arm/plat-omap/include/mach/debobs.h
@@ -3,5 +3,6 @@
 
 void debug_gpio_set(unsigned gpio, int value);
 int debug_gpio_get(unsigned gpio);
+void debobs_restore(void);
 
 #endif
-- 
1.6.2.4

