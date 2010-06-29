From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] omap2/3/4: Select all omaps and boards by default
Date: Tue, 29 Jun 2010 14:47:35 +0300
Message-ID: <20100629114735.16008.76563.stgit@baageli.muru.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64390 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab0F2LrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:47:23 -0400
In-Reply-To: <20100629113229.16008.2931.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Select all omaps and boards by default

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d306aa1..4802988 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -5,17 +5,20 @@ menu "TI OMAP2/3/4 Specific Features"
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_OMAP2PLUS
+	default y
 	select CPU_V6
 
 config ARCH_OMAP3
 	bool "TI OMAP3"
 	depends on ARCH_OMAP2PLUS
+	default y
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI
 	select ARM_L1_CACHE_SHIFT_6
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
+	default y
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
@@ -26,17 +29,20 @@ comment "OMAP Core Type"
 config ARCH_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP2
+	default y
 	select OMAP_DM_TIMER
 	select ARCH_OMAP_OTG
 
 config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
+	default y
 	select ARCH_OMAP_OTG
 
 config ARCH_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3
+	default y
 	select ARCH_OMAP_OTG
 
 config OMAP_PACKAGE_ZAF
@@ -63,6 +69,7 @@ comment "OMAP Board Type"
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP2
+	default y
 
 config MACH_OMAP2_TUSB6010
 	bool
@@ -72,63 +79,75 @@ config MACH_OMAP2_TUSB6010
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on ARCH_OMAP2
+	default y
 	select OMAP_PACKAGE_ZAF
 	select OMAP_DEBUG_DEVICES
 
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
 	depends on ARCH_OMAP2
+	default y
 	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2
+	default y
 	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_DEVKIT8000
 	bool "DEVKIT8000 board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CUS
 	select OMAP_MUX
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OVERO
 	bool "Gumstix Overo board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3_TOUCHBOOK
 	bool "OMAP3 Touch Book"
 	depends on ARCH_OMAP3
+	default y
 	select BACKLIGHT_CLASS_DEVICE
 
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_NOKIA_N800
@@ -143,6 +162,7 @@ config MACH_NOKIA_N810_WIMAX
 config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
 	depends on ARCH_OMAP2420
+	default y
 	select OMAP_PACKAGE_ZAC
 	select MACH_NOKIA_N800
 	select MACH_NOKIA_N810
@@ -151,42 +171,50 @@ config MACH_NOKIA_N8X0
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP_ZOOM2
 	bool "OMAP3 Zoom2 board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBP
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CUS
 	select OMAP_MUX
 
 config MACH_IGEP0020
 	bool "IGEP v2 board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_SBC3530
 	bool "OMAP3 SBC STALKER board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CUS
 	select OMAP_MUX
 
 config MACH_OMAP_3630SDP
 	bool "OMAP3630 SDP board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBP
 
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
+	default y
 	depends on ARCH_OMAP4
 
 config OMAP3_EMU

