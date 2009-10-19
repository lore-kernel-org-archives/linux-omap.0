From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/1] OMAP3: PM: enable UART3 module wakeups
Date: Mon, 19 Oct 2009 15:14:42 -0700
Message-ID: <1255990482-16201-2-git-send-email-khilman@deeprootsystems.com>
References: <1255990482-16201-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:41757 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153AbZJSWOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 18:14:40 -0400
Received: by mail-px0-f171.google.com with SMTP id 1so734958pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 15:14:45 -0700 (PDT)
In-Reply-To: <1255990482-16201-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

UART3 is in the PER powerdomain.  If PER goes idle/inactive
independently of CORE, for UART3 to wakeup it must have its wakeup
enable bits setup in PM_WKEN_PER.  This patch enables these bits.

The reason it works when PER and CORE work together is because when
CORE goes inactive/retention, the IOPAD wakeups are enabled and
trigger UART3 wakeup.

Without this patch, when the UART inactivity timer fires for UART3,
its clocks are disabled and it's unable to wakeup so will be unusable
until PER is awoken by another source.

Another way of testing is by keeping CORE on during suspend but
allowing PER to hit retention

  # echo 3 > /debug/pm_debug/core_pwrdm/suspend

then enter suspend

  # echo mem > /sys/power/state

Without this patch, UART3 will be unable to wakeup the system.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 378c2f6..8946319 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -639,14 +639,15 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
-	/* Enable GPIO wakeups in PER */
+	/* Enable wakeups in PER */
 	prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
 			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
-			  OMAP3430_EN_GPIO6, OMAP3430_PER_MOD, PM_WKEN);
+			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3,
+			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
 	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
 			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
-			  OMAP3430_GRPSEL_GPIO6,
+			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3,
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
-- 
1.6.4.3

