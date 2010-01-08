From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 6/6] Regulator: Makefile modified to include TWL4030-PMIC specific file
Date: Fri,  8 Jan 2010 23:28:18 +0530
Message-ID: <1262973498-32685-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56365 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab0AHR61 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 12:58:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Makefile is modified so that board-omap35x-twl4030-pmic.c gets compiled
for the platforms having TWL4030 as the PMIC.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b32678b..181be39 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
 					   mmc-twl4030.o
+obj-$(CONFIG_PMIC_TWL4030)		+= board-omap35x-twl4030-pmic.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
 obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
-- 
1.6.2.4

