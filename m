From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2/3: Reorganize Makefile to add omap4 support
Date: Tue, 19 May 2009 18:58:14 +0530
Message-ID: <1242739694-12170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49378 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbZESN2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 09:28:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

From: Tony Lindgren <tony@atomide.com>

We don't necessarily want to compile in irq.o and sdrc.o for omap4.
Also, clock and prcm may not be implemented initially.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c49d9bf..bf3827a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,9 +3,14 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sdrc.o control.o prcm.o clock.o mux.o \
-		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
-		clockdomain.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+
+omap-2-3-common				= irq.o sdrc.o
+prcm-common				= prcm.o powerdomain.o
+clock-common				= clock.o clockdomain.o
+
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
+obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
-- 
1.5.4.7

