From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: PM: Fix Zoom3 defconfig build
Date: Fri, 12 Mar 2010 17:32:21 +0530
Message-ID: <1268395341-14457-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47597 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab0CLLmU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 06:42:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Manjunatha GK <manjugk@ti.com>

The zoom3 defconfig build is broken with pm branch.

This patch fixes the build by enabling CPU_FREQ options in defconfig.

Build and boot tested on Zoom3 board.

Build error log:
arch/arm/mach-omap2/clock3xxx_data.c: In function 'omap3xxx_clk_init':
arch/arm/mach-omap2/clock3xxx_data.c:3563: error: 'struct clk_functions' has no member named 'clk_init_cpufreq_table'
arch/arm/mach-omap2/clock3xxx_data.c:3564: error: 'omap3_clk_init_cpufreq_table' undeclared (first use in this function)
arch/arm/mach-omap2/clock3xxx_data.c:3564: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/clock3xxx_data.c:3564: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1


Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/configs/omap_zoom3_defconfig |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index ff8ac3d..f615e3a 100644
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -323,8 +323,24 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.16
 #
 # CPU Power Management
 #
-# CONFIG_CPU_FREQ is not set
-# CONFIG_CPU_IDLE is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_TABLE=y
+# CONFIG_CPU_FREQ_DEBUG is not set
+CONFIG_CPU_FREQ_STAT=y
+# CONFIG_CPU_FREQ_STAT_DETAILS is not set
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_GOV_LADDER=y
+CONFIG_CPU_IDLE_GOV_MENU=y
 
 #
 # Floating point emulation
-- 
1.6.0.4

