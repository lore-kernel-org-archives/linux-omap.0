From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/2] Revert "ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common"
Date: Mon, 11 Jun 2012 18:47:05 +0200
Message-ID: <1339433225-30042-3-git-send-email-b-cousson@ti.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2FKQrv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 12:47:51 -0400
In-Reply-To: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

This reverts commit 6ba5a69ee92c29c2ffc814dad6ac61c4cd49090c.

Conflicts:

	arch/arm/mach-omap2/Makefile

Neither prm_clkdm nor cm_clkdm does exist on OMAP4.
Remove the common definition that does not make sense anymore
since it is not common for OMAP2+ platforms.

Please note that these clock domains are probably non existant
on OMAP 2 & 3 and thus should be removed in all the
clockdomain files.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile                     |    1 -
 arch/arm/mach-omap2/clockdomain44xx.c            |    6 -----
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   10 +++++++++
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 -
 arch/arm/mach-omap2/clockdomains_common_data.c   |   24 ----------------------
 5 files changed, 10 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..bc7d239 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -116,7 +116,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
-clockdomain-common			+= clockdomains_common_data.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomains2xxx_3xxx_data.o
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index 4f04dd1..935c7f0 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -51,9 +51,6 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
 	struct clkdm_dep *cd;
 	u32 mask = 0;
 
-	if (!clkdm->prcm_partition)
-		return 0;
-
 	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
 		if (!cd->clkdm)
 			continue; /* only happens if data is erroneous */
@@ -106,9 +103,6 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
 
-	if (!clkdm->prcm_partition)
-		return 0;
-
 	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
 					clkdm->cm_inst, clkdm->clkdm_offs);
 
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 839145e..0a6a048 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -89,3 +89,13 @@ struct clockdomain wkup_common_clkdm = {
 	.pwrdm		= { .name = "wkup_pwrdm" },
 	.dep_bit	= OMAP_EN_WKUP_SHIFT,
 };
+
+struct clockdomain prm_common_clkdm = {
+	.name		= "prm_clkdm",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+};
+
+struct clockdomain cm_common_clkdm = {
+	.name		= "cm_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+};
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index c534258..bd7ed13 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -430,8 +430,6 @@ static struct clockdomain *clockdomains_omap44xx[] __initdata = {
 	&l4_wkup_44xx_clkdm,
 	&emu_sys_44xx_clkdm,
 	&l3_dma_44xx_clkdm,
-	&prm_common_clkdm,
-	&cm_common_clkdm,
 	NULL
 };
 
diff --git a/arch/arm/mach-omap2/clockdomains_common_data.c b/arch/arm/mach-omap2/clockdomains_common_data.c
deleted file mode 100644
index 615b1f0..0000000
--- a/arch/arm/mach-omap2/clockdomains_common_data.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * OMAP2+-common clockdomain data
- *
- * Copyright (C) 2008-2012 Texas Instruments, Inc.
- * Copyright (C) 2008-2010 Nokia Corporation
- *
- * Paul Walmsley, Jouni Högander
- */
-
-#include <linux/kernel.h>
-#include <linux/io.h>
-
-#include "clockdomain.h"
-
-/* These are implicit clockdomains - they are never defined as such in TRM */
-struct clockdomain prm_common_clkdm = {
-	.name		= "prm_clkdm",
-	.pwrdm		= { .name = "wkup_pwrdm" },
-};
-
-struct clockdomain cm_common_clkdm = {
-	.name		= "cm_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-};
-- 
1.7.0.4

