From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around __omap2_set_globals
Date: Wed, 9 May 2012 01:22:03 +0530
Message-ID: <1336506724-5494-4-git-send-email-hvaibhav@ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755597Ab2EHUEP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 16:04:15 -0400
In-Reply-To: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

The function __omap2_set_globals() can be common across all
platforms/architectures, even in case of omap4, internally it
calls same set of functions as in __omap2_set_globals() function
(except for sdrc).
This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
so that we can reuse same function across omap2/3/4...

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Kconfig  |    8 ++++++++
 arch/arm/mach-omap2/common.c |    8 +-------
 arch/arm/mach-omap2/common.h |    5 +++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0685dc8..a432f3e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -20,12 +20,16 @@ config ARCH_OMAP2PLUS_TYPICAL
 	help
 	  Compile a kernel suitable for booting most boards

+config SOC_HAS_OMAP2_SDRC
+	bool "OMAP2 SDRAM Controller support"
+
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V6
 	select MULTI_IRQ_HANDLER
+	select SOC_HAS_OMAP2_SDRC

 config ARCH_OMAP3
 	bool "TI OMAP3"
@@ -37,6 +41,7 @@ config ARCH_OMAP3
 	select PM_OPP if PM
 	select ARM_CPU_SUSPEND if PM
 	select MULTI_IRQ_HANDLER
+	select SOC_HAS_OMAP2_SDRC

 config ARCH_OMAP4
 	bool "TI OMAP4"
@@ -64,18 +69,21 @@ config SOC_OMAP2420
 	default y
 	select OMAP_DM_TIMER
 	select ARCH_OMAP_OTG
+	select SOC_HAS_OMAP2_SDRC

 config SOC_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
 	default y
 	select ARCH_OMAP_OTG
+	select SOC_HAS_OMAP2_SDRC

 config SOC_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3
 	default y
 	select ARCH_OMAP_OTG
+	select SOC_HAS_OMAP2_SDRC

 config SOC_OMAPTI81XX
 	bool "TI81XX support"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 1549c11..ad8626d 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -29,8 +29,6 @@

 /* Global address base setup code */

-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-
 static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 {
 	omap2_set_globals_tap(omap2_globals);
@@ -39,8 +37,6 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 	omap2_set_globals_prcm(omap2_globals);
 }

-#endif
-
 #if defined(CONFIG_SOC_OMAP2420)

 static struct omap_globals omap242x_globals = {
@@ -170,9 +166,7 @@ static struct omap_globals omap4_globals = {

 void __init omap2_set_globals_443x(void)
 {
-	omap2_set_globals_tap(&omap4_globals);
-	omap2_set_globals_control(&omap4_globals);
-	omap2_set_globals_prcm(&omap4_globals);
+	__omap2_set_globals(&omap4_globals);
 }

 void __init omap4_map_io(void)
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 0e95efc..87b132e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -122,7 +122,12 @@ void omap2_set_globals_am33xx(void);

 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
+#if defined(CONFIG_SOC_HAS_OMAP2_SDRC)
 void omap2_set_globals_sdrc(struct omap_globals *);
+#else
+static inline void omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
+{ }
+#endif
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);

--
1.7.0.4

