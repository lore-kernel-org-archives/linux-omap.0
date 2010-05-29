From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 7/8] OMAP: PM: Allowing an early init of pm debugfs driver.
Date: Sat, 29 May 2010 22:02:27 +0530
Message-ID: <1275150748-15386-8-git-send-email-thara@ti.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
 <1275150748-15386-2-git-send-email-thara@ti.com>
 <1275150748-15386-3-git-send-email-thara@ti.com>
 <1275150748-15386-4-git-send-email-thara@ti.com>
 <1275150748-15386-5-git-send-email-thara@ti.com>
 <1275150748-15386-6-git-send-email-thara@ti.com>
 <1275150748-15386-7-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37809 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757401Ab0E2Qcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 12:32:39 -0400
In-Reply-To: <1275150748-15386-7-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch changes the pm_db_init from arch initcall to a postcore
initcall. With arch initcall, it is impossible for pm driver that
gets initialized prior to this driver to use one of the
pm debug fs entries during its init. Making it a postcore initcall
ensures that this drver gets initialized early on before any pm
drivers.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 4280006..b239c16 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -611,6 +611,6 @@ static int __init pm_dbg_init(void)
 
 	return 0;
 }
-arch_initcall(pm_dbg_init);
+postcore_initcall(pm_dbg_init);
 
 #endif
-- 
1.7.0.rc1.33.g07cf0f

