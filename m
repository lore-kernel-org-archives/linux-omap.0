From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: OMAP2+: Fix multiple randconfig errors with
 SOC_OMAP and SOC_OMAP_NOOP
Date: Thu, 23 Feb 2012 16:54:17 -0800
Message-ID: <20120224005417.16794.52875.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63368 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959Ab2BXAyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:54:19 -0500
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org

If we don't have ARCH_OMAP2, 3 or 4 selected randconfig will always
fail with multiple errors as the CPU and MACHINE are not set.

Fix this by changing arch/arm/Makefile to build mach-omap2 based on
ARCH_OMAP2PLUS. And let's introduce SOC_OMAP and SOC_OMAP_NOOP that
allow randconfig to generate buildable .config files.

Note that we can also remove few uncecssary ARCH_OMAP2PLUS lines
as they are all within if ARCH_OMAP2PLUS block.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Makefile           |    4 +--
 arch/arm/mach-omap2/Kconfig |   51 +++++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1683bfb..ea69448 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -164,9 +164,7 @@ machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
 machine-$(CONFIG_ARCH_OMAP1)		:= omap1
-machine-$(CONFIG_ARCH_OMAP2)		:= omap2
-machine-$(CONFIG_ARCH_OMAP3)		:= omap2
-machine-$(CONFIG_ARCH_OMAP4)		:= omap2
+machine-$(CONFIG_ARCH_OMAP2PLUS)	:= omap2
 machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 337f98d..c4ae0a7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -21,16 +21,12 @@ config ARCH_OMAP2PLUS_TYPICAL
 	  Compile a kernel suitable for booting most boards
 
 config ARCH_OMAP2
-	bool "TI OMAP2"
-	depends on ARCH_OMAP2PLUS
-	default y
+	bool
 	select CPU_V6
 	select MULTI_IRQ_HANDLER
 
 config ARCH_OMAP3
-	bool "TI OMAP3"
-	depends on ARCH_OMAP2PLUS
-	default y
+	bool
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARCH_HAS_OPP
@@ -39,9 +35,7 @@ config ARCH_OMAP3
 	select MULTI_IRQ_HANDLER
 
 config ARCH_OMAP4
-	bool "TI OMAP4"
-	default y
-	depends on ARCH_OMAP2PLUS
+	bool
 	select CACHE_L2X0
 	select CPU_V7
 	select ARM_GIC
@@ -56,36 +50,58 @@ config ARCH_OMAP4
 	select ARM_CPU_SUSPEND if PM
 
 comment "OMAP Core Type"
-	depends on ARCH_OMAP2
+
+config SOC_OMAP
+	bool
 
 config SOC_OMAP2420
 	bool "OMAP2420 support"
-	depends on ARCH_OMAP2
 	default y
+	select SOC_OMAP
+	select ARCH_OMAP2
 	select OMAP_DM_TIMER
 	select ARCH_OMAP_OTG
 
 config SOC_OMAP2430
 	bool "OMAP2430 support"
-	depends on ARCH_OMAP2
 	default y
+	select SOC_OMAP
+	select ARCH_OMAP2
 	select ARCH_OMAP_OTG
 
 config SOC_OMAP3430
 	bool "OMAP3430 support"
-	depends on ARCH_OMAP3
 	default y
+	select SOC_OMAP
+	select ARCH_OMAP3
 	select ARCH_OMAP_OTG
 
 config SOC_OMAPTI81XX
 	bool "TI81XX support"
-	depends on ARCH_OMAP3
 	default y
+	select SOC_OMAP
+	select ARCH_OMAP3
 
 config SOC_OMAPAM33XX
 	bool "AM33XX support"
-	depends on ARCH_OMAP3
 	default y
+	select SOC_OMAP
+	select ARCH_OMAP3
+
+config SOC_OMAP44XX
+	bool "OMAP44XX support"
+	default y
+	select SOC_OMAP
+	select ARCH_OMAP4
+
+config SOC_OMAP_NOOP
+	bool
+	depends on !SOC_OMAP
+	default y
+	select ARCH_OMAP2
+	select ARCH_OMAP3
+	select ARCH_OMAP4
+	select MACH_OMAP_GENERIC
 
 config OMAP_PACKAGE_ZAF
        bool
@@ -112,17 +128,17 @@ config OMAP_PACKAGE_CBS
        bool
 
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2PLUS
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP2+ board"
-	depends on ARCH_OMAP2PLUS
 	select USE_OF
 	default y
 	help
 	  Support for generic TI OMAP2+ boards using Flattened Device Tree.
 	  More information at Documentation/devicetree
 
+if SOC_OMAP
+
 config MACH_OMAP2_TUSB6010
 	bool
 	depends on ARCH_OMAP2 && SOC_OMAP2420
@@ -343,6 +359,7 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+endif
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3

