From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH v4 3/3] OMAP3:zoom2: Makefile and Kconfig for Zoom2 board
Date: Thu, 21 May 2009 05:29:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5129A10@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59315 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611AbZETX7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:59:07 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4KNx3P4027194
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 18:59:09 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4KNx2pA008806
	for <linux-omap@vger.kernel.org>; Thu, 21 May 2009 05:29:02 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


From: Vikram Pandita <vikram.pandita@ti.com>

This patch adds OMAP3 Zoom2 board to the Makefile and Kconfig.

Signed-off-by: Mikkel Christensen <mlc@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Kconfig  |    4 ++++
 arch/arm/mach-omap2/Makefile |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 64ab386..f6cf903 100644
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
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c49d9bf..986a935 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -48,7 +48,9 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
-
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+					   mmc-twl4030.o \
+					   board-zoom-debugboard.o
 # Platform specific device init code
 ifeq ($(CONFIG_USB_MUSB_SOC),y)
 obj-y					+= usb-musb.o
-- 
1.6.0.3.613.g9f8f13

