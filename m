From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 3/8] omap3: pm: Correcting the sys_offmode signal polarity
Date: Sat, 26 Feb 2011 17:55:34 +0530
Message-ID: <1298723139-1693-4-git-send-email-leslyam@ti.com>
References: <1298723139-1693-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47241 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab1BZMWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Feb 2011 07:22:33 -0500
In-Reply-To: <1298723139-1693-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Changing the polarity of the sys_offmode signal to active low,
to get a High to Low transition on the NSLEEP1 of PM IC when OMAP is
entering offmode. Because on PM IC the power resources (LDO, DCDC regulators)
associated with P1 group which is controlled by NSLEEP1 are set to sleep,
when there is transition form High to Low.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e46f4b5..8a7c756 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1034,6 +1034,10 @@ static int __init omap3_pm_init(void)
 
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
+	/* Changing the polarity of the sys_offmode signal to active low */
+	omap2_prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL_MASK,
+			OMAP3430_GR_MOD, OMAP3_PRM_POLCTRL_OFFSET);
+
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
-- 
1.7.0.4

