From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH] OMAP2: Add pm_bus.c file for OMAP2 architecture
Date: Mon, 13 Sep 2010 14:14:41 +0530
Message-ID: <1284367481-10508-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60047 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723Ab0IMIow (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Sep 2010 04:44:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

This patch adds pm_bus.o for OMAP2 architecture which is required
while using PM runtime APIs on OMAP2.

This patch series is created on "origin/pm-core" and is
tested on 2430 SDP board (with watchdog and GPIO patches
using PM runtime APIs. These patches would be sent to
LO mailing list soon).

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 56133d4..a88b75a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -51,7 +51,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o pm_bus.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
-- 
1.7.0.4

