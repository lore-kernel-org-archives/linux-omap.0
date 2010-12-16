From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/5] OMAP4: PM: Do not assume clkdm supports hw transitions
Date: Thu, 16 Dec 2010 18:16:45 +0530
Message-ID: <1292503605-14523-2-git-send-email-rnayak@ti.com>
References: <1292503605-14523-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58255 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab0LPMrA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 07:47:00 -0500
In-Reply-To: <1292503605-14523-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

omap_set_pwrdm_state today assumes a clkdm supports hw_auto
transitions and hence leaves some which do not support this
in sw wkup state preventing low power transitions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
Changes in v2:
Rebased the patch on the previous patch in the series

The below branch is updated with this version of the patch
git://gitorious.org/omap-pm/linux.git for_2.6.38/power

 arch/arm/mach-omap2/pm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux/arch/arm/mach-omap2/pm.c
===================================================================
--- linux.orig/arch/arm/mach-omap2/pm.c	2010-12-16 11:47:35.000000000 +0530
+++ linux/arch/arm/mach-omap2/pm.c	2010-12-16 11:48:49.073228787 +0530
@@ -95,8 +95,7 @@
 
 /*
  * This sets pwrdm state (other than mpu & core. Currently only ON &
- * RET are supported. Function is assuming that clkdm doesn't have
- * hw_sup mode enabled.
+ * RET are supported.
  */
 int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
@@ -137,7 +136,10 @@
 
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
-		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		if (pwrdm->pwrdm_clkdms[0]->flags & CLKDM_CAN_ENABLE_AUTO)
+			omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		else
+			omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
 		break;
 	case LOWPOWERSTATE_SWITCH:
 		pwrdm_set_lowpwrstchange(pwrdm);
