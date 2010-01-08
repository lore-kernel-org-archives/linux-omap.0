From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/13] OMAP3: PM: Force write last pad config register into save area
Date: Fri,  8 Jan 2010 09:59:30 -0800
Message-ID: <1262973571-25796-13-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-9-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-10-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-11-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-12-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47107 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab0AHR75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:57 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so160327pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:57 -0800 (PST)
In-Reply-To: <1262973571-25796-12-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Due to OMAP3 erratas 1.157, 1.185 the save of the last pad register
(ETK_D14 and ETK_D15) can fail sometimes when there is simultaneous
OCP access to the SCM register area. Fixed by writing the last
register to the save area.

Also, optimized the delay loop for the HW save to include an udelay(1),
which limits the number of unnecessary HW accesses to SCM register area
during the save.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Acked-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 96075bf..31762ca 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 #include <plat/sram.h>
 #include <plat/clockdomain.h>
@@ -126,7 +127,15 @@ static void omap3_core_save_context(void)
 	/* wait for the save to complete */
 	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
 			& PADCONF_SAVE_DONE))
-		;
+		udelay(1);
+
+	/*
+	 * Force write last pad into memory, as this can fail in some
+	 * cases according to erratas 1.157, 1.185
+	 */
+	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
+		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
+
 	/* Save the Interrupt controller context */
 	omap_intc_save_context();
 	/* Save the GPMC context */
-- 
1.6.6.rc2.1.g42108

