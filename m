From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 5/5] OMAP3: PM: Enable GPIO module-level wakeups
Date: Fri,  2 Oct 2009 11:14:55 -0700
Message-ID: <1254507295-11381-6-git-send-email-khilman@deeprootsystems.com>
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
 <1254507295-11381-2-git-send-email-khilman@deeprootsystems.com>
 <1254507295-11381-3-git-send-email-khilman@deeprootsystems.com>
 <1254507295-11381-4-git-send-email-khilman@deeprootsystems.com>
 <1254507295-11381-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:43925 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025AbZJBSPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 14:15:01 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so1347643pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 02 Oct 2009 11:15:05 -0700 (PDT)
In-Reply-To: <1254507295-11381-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

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
index cf6ea9f..378c2f6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -639,6 +639,16 @@ static void __init prcm_setup_regs(void)
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
1.6.4.3

