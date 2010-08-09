From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/5] OMAP4: runtime: Enable PM runtime core for OMAP4
Date: Mon,  9 Aug 2010 20:06:22 +0530
Message-ID: <1281364586-26323-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57216 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab0HIOgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 10:36:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

The PM runtime core functions are implemented in pm_bus.c
which needs to be compiled for CONFIG_ARCH_OMAP4 for
runtime api's to work.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 800b430..18db759 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -50,7 +50,7 @@ ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o pm_bus.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
-- 
1.5.4.7

