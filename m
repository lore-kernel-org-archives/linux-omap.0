From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP2/4: PM: Boot message is not an error/info, and not helpful, remove it
Date: Mon, 30 May 2011 16:02:07 +0530
Message-ID: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48259 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab1E3KcR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 06:32:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>

The commit '99aa18278e' removed the boot messege for OMAP3. Do the same
for OMAP2 and OMAP4 since it's really just noise in the boot log
and PM init is always called.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
Generated against mainline v3.0-rc1.

 arch/arm/mach-omap2/pm24xx.c |    1 -
 arch/arm/mach-omap2/pm44xx.c |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index df3ded6..5970759 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -442,7 +442,6 @@ static int __init omap2_pm_init(void)
 	if (!cpu_is_omap24xx())
 		return -ENODEV;
 
-	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
 	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..a6259d6 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -103,8 +103,6 @@ static int __init omap4_pm_init(void)
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
 
-	pr_err("Power Management for TI OMAP4.\n");
-
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		pr_err("Failed to setup powerdomains\n");
-- 
1.6.0.4

