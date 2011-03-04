From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Fri,  4 Mar 2011 18:55:23 +0530
Message-ID: <1299245123-23444-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57969 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758463Ab1CDNZi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 08:25:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On OMAP4, the PRCM recommended sequence for enabling
a module after power-on-reset is
-1- Force clkdm to SW_WKUP
-2- Configure desired module mode to "enable" or "auto"
-3- Wait for the desired module idle status to be FUNC
-4- Program clkdm in HW_AUTO(if supported)

This sequence applies to all older OMAPs' as well,
however since they use autodeps, it makes sure that
no clkdm is in IDLE, and hence not requiring a force
SW_WKUP when a module is being enabled.

OMAP4 does not need to support autodeps, because
of the dyanamic dependency feature, wherein
the HW takes care of waking up a clockdomain from
idle and hence the module, whenever an interconnect
access happens to the given module.
Autodeps were mainly needed on older OMAPs' as
this was not the case back then, and a module
access with the module/clkdm in idle would cause
an abort.

Fix the clkdm_clk_enable api to handle
this sequence on OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
The patch is based on 'integration-2.6.39' branch
of git://git.pwsan.com/linux-integration because
of dependencies with other patches in the branch.

 arch/arm/mach-omap2/clock.c           |    4 ++++
 arch/arm/mach-omap2/clockdomain.c     |    7 ++++++-
 arch/arm/mach-omap2/clockdomain44xx.c |    9 ++-------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 46d03cc..1cf6786 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -322,6 +322,10 @@ int omap2_clk_enable(struct clk *clk)
 		}
 	}
 
+	/* If clockdomain supports hardware control, enable it */
+	if (clk->clkdm)
+		clkdm_allow_idle(clk->clkdm);
+
 	return 0;
 
 oce_err3:
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index a0341de..9e1164f 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -825,7 +825,12 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	if (!arch_clkdm || !arch_clkdm->clkdm_clk_enable)
 		return -EINVAL;
 
-	if (atomic_inc_return(&clkdm->usecount) > 1)
+	/*
+	 * For arch's with no autodeps, clkcm_clk_enable
+	 * should be called for every clock instance that is
+	 * enabled, so the clkdm can be force woken up.
+	 */
+	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
 		return 0;
 
 	/* Clockdomain now has one enabled downstream clock */
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index a1a4ecd..6f38d47 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -95,13 +95,8 @@ static void omap4_clkdm_deny_idle(struct clockdomain *clkdm)
 
 static int omap4_clkdm_clk_enable(struct clockdomain *clkdm)
 {
-	bool hwsup = false;
-
-	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
-					clkdm->cm_inst, clkdm->clkdm_offs);
-
-	if (!hwsup)
-		clkdm_wakeup(clkdm);
+	/* For every clock enable, force wakeup the clkdm */
+	clkdm_wakeup(clkdm);
 
 	return 0;
 }
-- 
1.7.0.4

