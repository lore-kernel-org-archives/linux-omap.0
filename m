From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 23/30] ARM: omap2: select twl4030 support on boards that need it
Date: Sun,  2 Oct 2011 16:45:53 +0200
Message-ID: <1317566760-25681-24-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

These three boards unconditionally use the twl4030 driver
from the board-zoom-display.c file. Make sure that the driver
is always there.
We also need to select the I2C core so we are able to build
that driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..4deeade 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -253,6 +253,8 @@ config MACH_OMAP_ZOOM2
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
 	select REGULATOR_FIXED_VOLTAGE
+	select TWL4030_CORE
+	select I2C
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
@@ -263,6 +265,8 @@ config MACH_OMAP_ZOOM3
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
 	select REGULATOR_FIXED_VOLTAGE
+	select TWL4030_CORE
+	select I2C
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35/CM-T3730 modules"
@@ -304,6 +308,8 @@ config MACH_OMAP_3630SDP
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBP
+	select TWL4030_CORE
+	select I2C
 
 config MACH_TI8168EVM
 	bool "TI8168 Evaluation Module"
-- 
1.7.5.4
