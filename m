From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 2/3] [OMAP] htcherald: Modify Makefiles and Kconfig for HTC
	Herald
Date: Sat, 3 Oct 2009 21:58:30 -0700
Message-ID: <6cb013310910032158h30473f83r79bb9bab8e9937fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:61283 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZJDE70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Oct 2009 00:59:26 -0400
Received: by gxk4 with SMTP id 4so2854195gxk.8
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2009 21:58:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The Makefiles and Kconfig files were modified to include the new
HTC Herald board support and LCD panel configuration code.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/Kconfig  |    6 ++++++
 arch/arm/mach-omap1/Makefile |    1 +
 drivers/video/omap/Makefile  |    1 +
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 55ecc01..0341d7b 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -56,6 +56,12 @@ config MACH_OMAP_HTCWIZARD
 	help
 	  HTC Wizard smartphone support (AKA QTEK 9100, ...)

+config MACH_HERALD
+	bool "HTC Herald"
+	depends on ARCH_OMAP850
+	help
+	  HTC Herald smartphone support (AKA T-Mobile Wing, ...)
+
 config MACH_OMAP_OSK
 	bool "TI OSK Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 6867cd3..87e539a 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MACH_OMAP_PALMTT)		+= board-palmtt.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
+obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o

 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index b63b198..49226a1 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -35,6 +35,7 @@ objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
+objs-y$(CONFIG_MACH_HERALD) += lcd_htcherald.o

 omapfb-objs := $(objs-yy)

-- 
1.5.6.3
