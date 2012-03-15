From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] ARM: OMAP2+: I2C: always compile I2C reset code, even if
 I2C driver is not built
Date: Thu, 15 Mar 2012 10:30:40 +0000
Message-ID: <E1S87xA-0000N4-2z@rmk-PC.arm.linux.org.uk>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55316 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab2COKap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 06:30:45 -0400
In-Reply-To: <20120315102845.GB16389@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

During kernel init, we reset all IP blocks on the OMAP that we can,
even if there is no driver compiled for that IP block.  Unlike most IP
blocks, the I2C block requires some extra programming for this to
work.  This reset code is incorrectly omitted when the I2C driver is
deselected.  In this circumstance, the build breaks.  Fix by compiling
the I2C reset code unconditionally.

Problem reported by Russell King <linux@arm.linux.org.uk>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bd76394..56a6e98 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o
+	 common.o gpio.o dma.o wd_timer.o display.o i2c.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
@@ -182,9 +182,6 @@ obj-$(CONFIG_OMAP_IOMMU)		+= iommu2.o
 iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
 obj-y					+= $(iommu-m) $(iommu-y)
 
-i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
-obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
-
 ifneq ($(CONFIG_TIDSPBRIDGE),)
 obj-y					+= dsp.o
 endif
-- 
1.7.4.4

