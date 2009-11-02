From: manjugk@ti.com
Subject: [PATCH v2] [OMAP3_PM] Fix omap zoom2 defconfig build error
Date: Mon,  2 Nov 2009 16:51:20 +0530
Message-ID: <1257160880-13641-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54232 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472AbZKBLV2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Nov 2009 06:21:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, dedekind1@gmail.com, felipe.balbi@nokia.com, Manjunatha GK <manjugk@ti.com>

From: Manjunatha GK <manjugk@ti.com>

The omap zoom2 defconfig build breaks on linux-omap-pm(with pm branch)
when CONFIG_DEBUG_FS is not enabled. This patch fixes the build issue.
Kernel booting tested on omap zoom2 board.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 767ebbc..3a42615 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -625,4 +625,6 @@ arch_initcall(pm_dbg_init);
 
 #else
 void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
+int pm_dbg_regset_init(int reg_set) {}
+int pm_dbg_regset_save(int reg_set) {}
 #endif
-- 
1.6.0.4

