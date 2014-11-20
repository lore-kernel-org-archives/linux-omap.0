From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] drivers: bus: Move omap gpmc code to live under drivers
Date: Thu, 20 Nov 2014 14:28:21 -0800
Message-ID: <1416522501-14999-4-git-send-email-tony@atomide.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48131 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbaKTW3D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 17:29:03 -0500
In-Reply-To: <1416522501-14999-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>

Just move to drivers as further clean-up can now happen there
finally.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig                           | 1 +
 arch/arm/mach-omap2/Makefile                          | 2 +-
 drivers/bus/Kconfig                                   | 3 +++
 drivers/bus/Makefile                                  | 3 ++-
 arch/arm/mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c | 0
 5 files changed, 7 insertions(+), 2 deletions(-)
 rename arch/arm/mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c (100%)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f4d06ae..3021901 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -80,6 +80,7 @@ config ARCH_OMAP2PLUS
 	select GENERIC_IRQ_CHIP
 	select MACH_OMAP_GENERIC
 	select OMAP_DM_TIMER
+	select OMAP_GPMC
 	select PINCTRL
 	select SOC_BUS
 	select TI_PRIV_EDMA
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3e824f8..bd85741 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
+obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
 	 omap_device.o sram.o drm.o
 
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 603eb1b..09aacc8 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -27,6 +27,9 @@ config MVEBU_MBUS
 	  Driver needed for the MBus configuration on Marvell EBU SoCs
 	  (Kirkwood, Dove, Orion5x, MV78XX0 and Armada 370/XP).
 
+config OMAP_GPMC
+	bool
+
 config OMAP_OCP2SCP
 	tristate "OMAP OCP2SCP DRIVER"
 	depends on ARCH_OMAP2PLUS
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 2973c18..96e77dd 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
 obj-$(CONFIG_IMX_WEIM)	+= imx-weim.o
 obj-$(CONFIG_MVEBU_MBUS) += mvebu-mbus.o
-obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
+
+obj-$(CONFIG_OMAP_GPMC)		+= omap-gpmc.o
 
 # Interconnect bus driver for OMAP SoCs.
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
diff --git a/arch/arm/mach-omap2/gpmc.c b/drivers/bus/omap-gpmc.c
similarity index 100%
rename from arch/arm/mach-omap2/gpmc.c
rename to drivers/bus/omap-gpmc.c
-- 
2.1.3

