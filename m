From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP3+: am33xx id: Add new am33xx specific function to check dev_feature
Date: Wed, 8 May 2013 12:28:33 +0530
Message-ID: <1367996313-6676-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58173 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484Ab3EHHEH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 May 2013 03:04:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Layout of DEV_FEATURE register (offset = 0x604) is different
between TI81xx and AM33xx device, so create separate function
which will check for features available on specific AM33xx SoC
and set the flags accordingly.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/control.h |    5 +++++
 arch/arm/mach-omap2/id.c      |   13 +++++++++++++
 arch/arm/mach-omap2/io.c      |    2 +-
 arch/arm/mach-omap2/soc.h     |    1 +
 4 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index e6c3281..4acdfc5 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -358,6 +358,11 @@
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH		0x2
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
 
+/* DEV Feature register to identify AM33XX features */
+#define AM33XX_DEV_FEATURE		0x604
+#define AM33XX_SGX_SHIFT		29
+#define AM33XX_SGX_MASK			(1 << AM33XX_SGX_SHIFT)
+
 /* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9bc5a18..02feef7 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -302,6 +302,19 @@ void __init ti81xx_check_features(void)
 	omap3_cpuinfo();
 }
 
+void __init am33xx_check_features(void)
+{
+	u32 status;
+
+	omap_features = OMAP3_HAS_NEON;
+
+	status = omap_ctrl_readl(AM33XX_DEV_FEATURE);
+	if (status & AM33XX_SGX_MASK)
+		omap_features |= OMAP3_HAS_SGX;
+
+	omap3_cpuinfo();
+}
+
 void __init omap3xxx_check_revision(void)
 {
 	const char *cpu_rev;
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 09abf99..06a8946 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -576,7 +576,7 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE));
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
-	ti81xx_check_features();
+	am33xx_check_features();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index ccef2dd..7d8722c 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -424,6 +424,7 @@ void omap4xxx_check_revision(void);
 void omap5xxx_check_revision(void);
 void omap3xxx_check_features(void);
 void ti81xx_check_features(void);
+void am33xx_check_features(void);
 void omap4xxx_check_features(void);
 
 /*
-- 
1.7.0.4

