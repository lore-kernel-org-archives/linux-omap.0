From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/55] ARM: OMAP3+: PRM: get rid of some unnecessary header files
Date: Mon, 31 Mar 2014 18:15:49 +0300
Message-ID: <1396278994-12624-11-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39091 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbaCaPRb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:31 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to make PRM a separate driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    1 +
 arch/arm/mach-omap2/prm3xxx.c     |    4 +---
 arch/arm/mach-omap2/prm44xx.c     |    5 ++---
 arch/arm/mach-omap2/prm_common.c  |    2 --
 arch/arm/mach-omap2/prminst44xx.c |    3 ---
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index a8e4b58..9da4c17 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -523,6 +523,7 @@ extern int omap_prcm_register_chain_handler(
 extern int omap_prcm_event_to_irq(const char *event);
 extern void omap_prcm_irq_prepare(void);
 extern void omap_prcm_irq_complete(void);
+void omap_pcs_legacy_init(int irq, void (*rearm)(void));
 
 # endif
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 9915cd6..f1d3e15 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -18,8 +18,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
-#include "soc.h"
-#include "common.h"
 #include "vp.h"
 #include "powerdomain.h"
 #include "prm3xxx.h"
@@ -40,7 +38,7 @@ static struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
 	.nr_regs		= 1,
 	.irqs			= omap3_prcm_irqs,
 	.nr_irqs		= ARRAY_SIZE(omap3_prcm_irqs),
-	.irq			= 11 + OMAP_INTC_START,
+	.irq			= 11 + NR_IRQS,
 	.read_pending_irqs	= &omap3xxx_prm_read_pending_irqs,
 	.ocp_barrier		= &omap3xxx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap3xxx_prm_save_and_clear_irqen,
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 206dcd9..27f4603 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -19,9 +19,6 @@
 #include <linux/io.h>
 
 
-#include "soc.h"
-#include "iomap.h"
-#include "common.h"
 #include "vp.h"
 #include "prm44xx.h"
 #include "prm54xx.h"
@@ -33,6 +30,8 @@
 
 /* Static data */
 
+#define OMAP44XX_IRQ_GIC_START	32
+
 static const struct omap_prcm_irq omap4_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",   0,      0),
 	OMAP_PRCM_IRQ("io",     9,      1),
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 5d5d564..b4ef9e4 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -28,12 +28,10 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 
-#include "soc.h"
 #include "prm2xxx_3xxx.h"
 #include "prm2xxx.h"
 #include "prm3xxx.h"
 #include "prm44xx.h"
-#include "common.h"
 #include "clock.h"
 
 /*
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index d4a7919..bd0e0da 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -16,8 +16,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "iomap.h"
-#include "common.h"
 #include "prcm-common.h"
 #include "prm44xx.h"
 #include "prm54xx.h"
@@ -26,7 +24,6 @@
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
-#include "soc.h"
 
 static void __iomem *_prm_bases[OMAP4_MAX_PRCM_PARTITIONS];
 
-- 
1.7.9.5

