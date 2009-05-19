From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] ARM: OMAP1: Misc clean-up
Date: Tue, 19 May 2009 16:36:09 -0700
Message-ID: <20090519233609.12760.14330.stgit@localhost>
References: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55831 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbZESXgP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:36:15 -0400
In-Reply-To: <20090519232905.12760.15490.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Remove unnecessary Kconfig line and allow compile of MBOX_FWK.
Also allow building USB on Nokia 770.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Kconfig          |    1 -
 arch/arm/mach-omap1/Makefile         |    4 ++++
 arch/arm/mach-omap1/board-nokia770.c |    1 +
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index cd8de89..55ecc01 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -46,7 +46,6 @@ config MACH_OMAP_H2
 config MACH_OMAP_H3
 	bool "TI H3 Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
-#	select GPIOEXPANDER_OMAP
     	help
 	  TI OMAP 1710 H3 board support. Say Y here if you have such
 	  a board.
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 1bda8f5..6867cd3 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -13,6 +13,10 @@ obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
 
+# DSP
+obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
+mailbox_mach-objs		:= mailbox.o
+
 led-y := leds.o
 
 # Specific board support
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index d1ed136..8780ca6 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -35,6 +35,7 @@
 #include <mach/omapfb.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
+#include <mach/usb.h>
 
 #define ADS7846_PENDOWN_GPIO	15
 

