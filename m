From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [PATCH v3] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug
Date: Wed, 30 Jan 2013 20:09:20 +0530
Message-ID: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37145 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618Ab3A3Ojr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 09:39:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, gururaja.hebbar@ti.com, linux@arm.linux.org.uk, hvaibhav@ti.com, vaibhav.bedia@ti.com

am33xx_cm_wait_module_ready() checks if register offset is NULL.

int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
{
	int i = 0;

	if (!clkctrl_offs)
		return 0;

In case of AM33xx, CLKCTRL register offset for different clock domains
are not uniformly placed. An example of this would be the RTC clock
domain with CLKCTRL offset at 0x00.
In such cases the module ready check is skipped which leads to a data
abort during boot-up when RTC registers is accessed.

Remove this check here to avoid checking module readiness for modules
with clkctrl register offset at 0x00.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
---
Changes in v3:
	- Since now there is separate cm33xx.c file which handles module
	ready checking for am33xx platform, use the same for the fix.
	- Also update subject to indicate am33xx platform name

Changes in v2:
	- update commit message to reflect the actual cause. Previous
	message conveyed a wrong/opposite message.

:100644 100644 058ce3c... 325a515... M	arch/arm/mach-omap2/cm33xx.c
 arch/arm/mach-omap2/cm33xx.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 058ce3c..325a515 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -241,9 +241,6 @@ int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(inst, cdoffs, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
1.7.9.5

