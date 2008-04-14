From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: [PATCH 1/4] Updating Kconfig and Makefile for OMAP3 EVM support
Date: Mon, 14 Apr 2008 17:36:50 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0018C8603@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57036 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605AbYDNMGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 08:06:55 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m3EC6nWu011106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2008 07:06:54 -0500
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m3EC6mbS002014
	for <linux-omap@vger.kernel.org>; Mon, 14 Apr 2008 07:06:49 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Updated Kconfig and Makefile for OMAP3 EVM support

Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |   10 +++++++---
 arch/arm/mach-omap2/Makefile |    1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: my_branch/arch/arm/mach-omap2/Kconfig
===================================================================
--- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-14 16:07:11.000000000 +0530
+++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-14 16:07:41.000000000 +0530
@@ -98,10 +98,14 @@
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP2430
 
+config MACH_OMAP_2430OSK
+	bool "OMAP 2430 OSK board"
+	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
-config MACH_OMAP_2430OSK
-	bool "OMAP 2430 OSK board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+config MACH_OMAP3EVM
+	bool "OMAP 3530 EVM board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX

Index: my_branch/arch/arm/mach-omap2/Makefile
===================================================================
--- my_branch.orig/arch/arm/mach-omap2/Makefile	2008-04-14 16:07:11.000000000 +0530
+++ my_branch/arch/arm/mach-omap2/Makefile	2008-04-14 16:07:41.000000000 +0530
@@ -34,6 +34,7 @@
 					   board-sdp-hsmmc.o \
 					   board-3430sdp-usb.o \
 					   board-3430sdp-flash.o
+obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3-evm.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
