From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 12/12] CORE OFF macro added, disabled by default
Date: Mon, 1 Sep 2008 19:12:50 +0530 (IST)
Message-ID: <63425.192.168.10.89.1220276570.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47102 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbYIANm4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 09:42:56 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81Dgpth000768
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:42:56 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m81DgmB2022197
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:42:49 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds a macro to enable/disbale CORE OFF support
in CPUIdle. It is kept disabled by default.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    6 ++++++
 arch/arm/mach-omap2/cpuidle34xx.c       |    4 ++++
 arch/arm/plat-omap/Kconfig              |   12 ++++++++++++
 3 files changed, 22 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
18:27:27.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
18:29:53.000000000 +0530
@@ -248,7 +248,11 @@ void omap_init_power_states(void)
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;

 	/* C6 . MPU OFF + Core OFF */
+#ifdef CONFIG_OMAP_CPUIDLE_CORE_OFF
+	omap3_power_states[OMAP3_STATE_C6].valid = 1;
+#else
 	omap3_power_states[OMAP3_STATE_C6].valid = 0;
+#endif
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
 	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
 	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
Index: linux-omap-2.6/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/Kconfig	2008-09-01
18:12:34.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/Kconfig	2008-09-01 18:29:53.000000000 +0530
@@ -87,6 +87,18 @@ config OMAP_SMARTREFLEX_TESTING

 	  WARNING: Enabling this option may cause your device to hang!

+config OMAP_CPUIDLE_CORE_OFF
+	bool "CORE OFF support in CPUIdle"
+	depends on ARCH_OMAP34XX
+	default n
+	help
+	  Say Y if you want to enable CORE OFF support in CPUIdle
+
+	  Currently some drivers don't work well with OFF support
+	  enabled in CPUIlde. Once all device drivers are adapted
+	  to work with OFF mode in CPUIdle, this MACRO will be
+	  removed.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig	2008-09-01
18:12:34.000000000 +0530
+++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig	2008-09-01
18:32:33.000000000 +0530
@@ -174,6 +174,7 @@ CONFIG_ARCH_OMAP3=y
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_SMARTREFLEX=y
 # CONFIG_OMAP_SMARTREFLEX_TESTING is not set
+# CONFIG_OMAP_CPUIDLE_CORE_OFF is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
@@ -286,6 +287,11 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=19
 # CONFIG_KEXEC is not set

 #
+# CPUIdle
+#
+# CONFIG_CPU_IDLE is not set
+
+#
 # CPU Frequency scaling
 #
 # CONFIG_CPU_FREQ is not set


