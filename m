From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP3: PM: Fix zoom3 defconfig build
Date: Mon, 26 Apr 2010 18:48:22 +0530
Message-ID: <1272287902-4707-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42161 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621Ab0DZM50 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Apr 2010 08:57:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

The zoom3 defconfig build is broken with opp patches.
This patch will fix the same. Build and boot tested on
omap zoom3 board.

Build error log:
In file included from arch/arm/plat-omap/include/plat/omap-pm.h:21,
                 from arch/arm/mach-omap2/hsmmc.c:19:
arch/arm/plat-omap/include/plat/opp.h: In function 'opp_find_freq_exact':
arch/arm/plat-omap/include/plat/opp.h:255: error: implicit declaration of function 'ERR_PTR'

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/opp.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index dc9a0d9..6b38a20 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -15,6 +15,7 @@
 #define __ASM_ARM_OMAP_OPP_H
 
 #include <linux/cpufreq.h>
+#include <linux/err.h>
 
 #ifdef CONFIG_ARCH_OMAP3
 enum opp_t {
-- 
1.6.0.4

