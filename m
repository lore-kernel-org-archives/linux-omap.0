From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: Enable GPIO module-level wakeups
Date: Thu, 10 Sep 2009 08:53:08 -0700
Message-ID: <1252597988-23561-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:40357 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbZIJPxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 11:53:09 -0400
Received: by pzk14 with SMTP id 14so182358pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 08:53:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Chan <mikechan@google.com>, rschultz@google.com

Currently, only GPIOs in the wakeup domain (GPIOs in bank 0) are
enabled as wakups.  This patch also enables GPIOs in the PER
powerdomain (banks 2-6) to be used as possible wakeup sources.

In addition, this patch ensures that all GPIO wakeups can wakeup
the MPU using the PM_MPUGRPSEL_<pwrdm> registers.

NOTE: this doesn't enable the individual GPIOs as wakeups, this simply
enables the per-bank wakeups at the powerdomain level.

This problem was discovered by Mike Chan when preventing the CORE
powerdomain from going into retention/off.  When CORE was allowed to
hit retention, GPIO wakeups via IO pad were working fine, but when
CORE remained on, GPIO module-level wakeups were not working properly.

To test, prevent CORE from going inactive/retention/off, thus
preventing the IO chain from being armed:

  # echo 3 > /debug/pm_debug/core_pwrdm/suspend

This ensures that GPIO wakeups happen via module-level wakeups and
not via IO pad.

Tested on 3430SDP using the touchscreen GPIO (gpio 2, in WKUP)
Tested on Zoom2 using the QUART interrup GPIO  (gpio 102, in PER)

Also, c.f. OMAP PM wiki for troubleshooting GPIO wakeup issues:
http://elinux.org/OMAP_Power_Management

Reported-by: Mike Chan <mikechan@google.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3d62b06..8166118 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -918,6 +918,16 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
+	/* Enable GPIO wakeups in PER */
+	prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
+			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
+			  OMAP3430_EN_GPIO6, OMAP3430_PER_MOD, PM_WKEN);
+	/* and allow them to wake up MPU */
+	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
+			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
+			  OMAP3430_GRPSEL_GPIO6,
+			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
+
 	/* Don't attach IVA interrupts */
 	prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
 	prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
-- 
1.6.4

