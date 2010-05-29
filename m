From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 3/4] [OMAP] Add allowance for extra IRQ space
Date: Fri, 28 May 2010 22:28:06 -0700
Message-ID: <1275110887-2918-4-git-send-email-darkstar6262@gmail.com>
References: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55618 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0E2Fen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 01:34:43 -0400
Received: by gwaa12 with SMTP id a12so1566772gwa.19
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 22:34:42 -0700 (PDT)
In-Reply-To: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linwizard-devel@lists.sf.net, Cory Maccarrone <darkstar6262@gmail.com>

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
index 52f61f6..a225622 100644
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

