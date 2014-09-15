From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/9] arm: omap: irq: move irq.c to drivers/irqchip/
Date: Mon, 15 Sep 2014 16:15:02 -0500
Message-ID: <1410815709-462-3-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54199 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbaIOVQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 17:16:04 -0400
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Just move the code over as it has no dependencies
on arch/arm/ anymore.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Kconfig                                  | 1 +
 arch/arm/mach-omap2/Makefile                                 | 3 +--
 drivers/irqchip/Kconfig                                      | 5 +++++
 drivers/irqchip/Makefile                                     | 1 +
 arch/arm/mach-omap2/irq.c => drivers/irqchip/irq-omap-intc.c | 9 +++++----
 5 files changed, 13 insertions(+), 6 deletions(-)
 rename arch/arm/mach-omap2/irq.c => drivers/irqchip/irq-omap-intc.c (98%)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 11ccf0b..691d62a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -86,6 +86,7 @@ config ARCH_OMAP2PLUS
 	select PINCTRL
 	select SOC_BUS
 	select TI_PRIV_EDMA
+	select OMAP_IRQCHIP
 	help
 	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 69bbcba..0b6095c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -10,7 +10,6 @@ obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
 	 omap_device.o sram.o drm.o
 
-omap-2-3-common				= irq.o
 hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
 					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
@@ -20,7 +19,7 @@ secure-common				= omap-smc.o omap-secure.o
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += $(hwmod-common) $(secure-common)
-obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
+obj-$(CONFIG_SOC_AM33XX) += $(hwmod-common)
 obj-$(CONFIG_SOC_OMAP5)	 += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_DRA7XX) += $(hwmod-common) $(secure-common)
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b8632bf..9d539de 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -75,6 +75,11 @@ config OR1K_PIC
 	bool
 	select IRQ_DOMAIN
 
+config OMAP_IRQCHIP
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 73052ba..d0a2613 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARCH_MOXART)		+= irq-moxart.o
 obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
+obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
diff --git a/arch/arm/mach-omap2/irq.c b/drivers/irqchip/irq-omap-intc.c
similarity index 98%
rename from arch/arm/mach-omap2/irq.c
rename to drivers/irqchip/irq-omap-intc.c
index b2993e4..1478f1a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -17,15 +17,16 @@
 #include <linux/io.h>
 
 #include <asm/exception.h>
-#include <asm/mach/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#include "soc.h"
-#include "common.h"
-#include "../../drivers/irqchip/irqchip.h"
+#include "irqchip.h"
+
+/* Define these here for now until we drop all board-files */
+#define OMAP24XX_IC_BASE	0x480fe000
+#define OMAP34XX_IC_BASE	0x48200000
 
 /* selected INTC register offsets */
 
-- 
2.0.1.563.g66f467c

