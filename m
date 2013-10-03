From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] ARM: OMAP2+: Add support for auxdata
Date: Wed, 02 Oct 2013 22:17:00 -0700
Message-ID: <20131003051700.8444.10657.stgit@localhost>
References: <20131003051049.8444.16913.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28984 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756813Ab3JCFRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 01:17:02 -0400
In-Reply-To: <20131003051049.8444.16913.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

For few things we're still going to be needing platform
data for device tree based drivers. Let's set up auxdata
handling and do it in pdata-quirks.c so we have all the
legacy calls in one place.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c |    5 +----
 arch/arm/mach-omap2/common.h        |    3 ++-
 arch/arm/mach-omap2/pdata-quirks.c  |   11 ++++++++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index a66575f..3017a9d 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -35,10 +35,7 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 
 static void __init omap_generic_init(void)
 {
-	omap_sdrc_init(NULL, NULL);
-
-	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
-	pdata_quirks_init();
+	pdata_quirks_init(omap_dt_match_table);
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index fd059e0..c6aebf0 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -288,7 +288,8 @@ static inline void omap4_cpu_resume(void)
 
 #endif
 
-void pdata_quirks_init(void);
+void pdata_quirks_init(struct of_device_id *);
+void omap_pcs_legacy_init(int irq, void (*rearm)(void));
 
 struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d472db..c739631 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -11,6 +11,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of_platform.h>
 #include <linux/wl12xx.h>
 
 #include "common.h"
@@ -99,6 +100,10 @@ static void __init omap5_uevm_legacy_init(void)
 }
 #endif
 
+struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
+	{ /* sentinel */ },
+};
+
 static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
@@ -114,10 +119,14 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ /* sentinel */ },
 };
 
-void __init pdata_quirks_init(void)
+void __init pdata_quirks_init(struct of_device_id *omap_dt_match_table)
 {
 	struct pdata_init *quirks = pdata_quirks;
 
+	omap_sdrc_init(NULL, NULL);
+	of_platform_populate(NULL, omap_dt_match_table,
+			     omap_auxdata_lookup, NULL);
+
 	while (quirks->compatible) {
 		if (of_machine_is_compatible(quirks->compatible)) {
 			if (quirks->fn)

