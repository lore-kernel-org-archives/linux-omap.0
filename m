From: abhijitpagare@ti.com
Subject: [PATCH 2/3] ARM: OMAP4: PM: Upgrade the makefile for power domain initialisations
Date: Fri, 14 Aug 2009 16:29:13 +0530
Message-ID: <1250247553-22525-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57238 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbZHNK7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 06:59:19 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7EAxEVZ016363
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 05:59:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>

From: Abhijit Pagare <abhijitpagare@ti.com>

This Patch upgrades the Makefile for Power Domain Framework

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3322292..1a18026 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o clock.o prcm.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o clock.o prcm.o powerdomain.o
 
 omap-2-3-common				= irq.o sdrc.o
 prcm-common				= powerdomain.o
-- 
1.5.4.7

