From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Add support to Nokia N810 WiMAX
Date: Tue,  1 Jul 2008 10:53:39 +0300
Message-ID: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58737 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbYGAHyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 03:54:36 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m617sJhi001307
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 10:54:33 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This adds basic booting support and selects CONFIG_MACH_NOKIA_N810 since
most of the HW and configuration are the same in N810 and N810 WiMAX.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/Kconfig      |    5 +++++
 arch/arm/mach-omap2/board-n810.c |   10 ++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 072aded..bb6d695 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -45,6 +45,11 @@ config MACH_NOKIA_N810
 	bool "Nokia N810"
 	depends on MACH_NOKIA_N800
 
+config MACH_NOKIA_N810_WIMAX
+	bool "Nokia N810 WiMAX"
+	depends on MACH_NOKIA_N800
+	select MACH_NOKIA_N810
+
 config MACH_OMAP2_TUSB6010
 	bool
 	depends on ARCH_OMAP2 && ARCH_OMAP2420
diff --git a/arch/arm/mach-omap2/board-n810.c b/arch/arm/mach-omap2/board-n810.c
index fb0e61f..8609a0b 100644
--- a/arch/arm/mach-omap2/board-n810.c
+++ b/arch/arm/mach-omap2/board-n810.c
@@ -35,3 +35,13 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.init_machine	= nokia_n810_init,
 	.timer		= &omap_timer,
 MACHINE_END
+
+MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= nokia_n800_map_io,
+	.init_irq	= nokia_n800_init_irq,
+	.init_machine	= nokia_n810_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.5.5.4

