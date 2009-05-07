From: Mikkel Christensen <mlc@ti.com>
Subject: [PATCH 3/3] OMAP3:zoom2: Makefile and Kconfig for Zoom2 board
Date: Thu,  7 May 2009 16:42:06 -0500
Message-ID: <1241732526-6218-4-git-send-email-mlc@ti.com>
References: <1241732526-6218-1-git-send-email-mlc@ti.com>
 <1241732526-6218-2-git-send-email-mlc@ti.com>
 <1241732526-6218-3-git-send-email-mlc@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42118 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZEGVi1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 17:38:27 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n47LcMC7010114
	for <linux-omap@vger.kernel.org>; Thu, 7 May 2009 16:38:28 -0500
In-Reply-To: <1241732526-6218-3-git-send-email-mlc@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mikkel Christensen <mlc@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

This patch adds OMAP3 Zoom2 board to the Makefile and Kconfig.

Signed-off-by: Mikkel Christensen <mlc@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    4 ++++
 arch/arm/mach-omap2/Makefile |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 64ab386..0b16255 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -67,3 +67,7 @@ config MACH_OMAP_3430SDP
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+config MACH_OMAP_ZOOM2
+	bool "OMAP3 Zoom2 board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
\ No newline at end of file
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c49d9bf..fe4485f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -48,7 +48,9 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
-
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+					   mmc-twl4030.o \
+					   board-zoom2-debugboard.o
 # Platform specific device init code
 ifeq ($(CONFIG_USB_MUSB_SOC),y)
 obj-y					+= usb-musb.o
-- 
1.5.4.3

