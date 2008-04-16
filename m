From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: [PATCH 2/9] Updated Kconfig and Makefile to add OMAP3 EVM Board
Date: Wed, 16 Apr 2008 17:34:41 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0018C8A6C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:37930 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758306AbYDPME7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 08:04:59 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: discussion@beagleboard.org


Updated Kconfig and Makefile to add OMAP3 EVM Board

Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    3 +++
 arch/arm/mach-omap2/Makefile |    1 +
 2 files changed, 4 insertions(+)

Index: my_branch/arch/arm/mach-omap2/Makefile
===================================================================
--- my_branch.orig/arch/arm/mach-omap2/Makefile	2008-04-16 14:39:51.000000000 +0530
+++ my_branch/arch/arm/mach-omap2/Makefile	2008-04-16 14:41:28.000000000 +0530
@@ -34,6 +34,7 @@
 					   board-sdp-hsmmc.o \
 					   board-3430sdp-usb.o \
 					   board-3430sdp-flash.o
+obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o

Index: my_branch/arch/arm/mach-omap2/Kconfig
===================================================================
--- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-16 14:40:02.000000000 +0530
+++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-16 14:41:28.000000000 +0530
@@ -106,3 +106,6 @@
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP3EVM
+	bool "OMAP 3530 EVM board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
