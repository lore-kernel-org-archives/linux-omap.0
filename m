From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 2/7] [OMAP] Add allowance for extra IRQ space
Date: Mon, 19 Jul 2010 21:07:41 -0700
Message-ID: <1279598866-18716-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0GTEH6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 00:07:58 -0400
Received: by iwn7 with SMTP id 7so5354123iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Jul 2010 21:07:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds a configuration option that boards can specify that
gives them an additional 64 or 128 IRQ lines to play with.  This is
most useful if there are external interrupt-producing devices connected
to the board.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/plat-omap/Kconfig             |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h |    6 +++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 5bc7a79..5ebbd91 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -20,6 +20,24 @@ config OMAP_GPIO_EXTRA128
 	  Add an extra 128 gpio numbers to the available GPIO pool. This is
 	  available for boards that need extra gpios for external devices.
 
+config OMAP_IRQ_EXTRA
+	int
+	default 128 if OMAP_IRQ_EXTRA128
+	default 64 if OMAP_IRQ_EXTRA64
+	default 0
+
+config OMAP_IRQ_EXTRA64
+	bool
+	help
+	  Add an extra 64 irq numbers to the available IRQ pool. This is
+	  available for boards that need extra interrupts for external devices.
+
+config OMAP_IRQ_EXTRA128
+	bool
+	help
+	  Add an extra 128 irq numbers to the available IRQ pool. This is
+	  available for boards that need extra interrupts for external devices.
+
 config ARCH_OMAP_OTG
 	bool
 
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index c01d9f0..2f14c78 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -409,7 +409,11 @@
 #define TWL_IRQ_END		TWL6030_IRQ_END
 #endif
 
-#define NR_IRQS			TWL_IRQ_END
+/*
+ * Some boards require extra irq capacity to support external
+ * devices that generate interrupts.
+ */
+#define NR_IRQS			(TWL_IRQ_END + CONFIG_OMAP_IRQ_EXTRA)
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
-- 
1.7.0.4

