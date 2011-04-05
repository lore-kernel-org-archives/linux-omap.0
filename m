From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/4] OMAP2+: clockdomain: Add SoC support for clkdm_is_idle
Date: Tue,  5 Apr 2011 18:14:55 +0530
Message-ID: <1302007497-10525-3-git-send-email-rnayak@ti.com>
References: <1302007497-10525-1-git-send-email-rnayak@ti.com>
 <1302007497-10525-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40617 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab1DEMpT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 08:45:19 -0400
In-Reply-To: <1302007497-10525-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Add the SoC specific implemention for clkdm_is_idle
for OMAP2/3 and OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   12 ++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c      |    7 +++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 48d0db7..3cdf95b 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/errno.h>
 #include <plat/prcm.h>
 #include "prm.h"
 #include "prm2xxx_3xxx.h"
@@ -146,6 +147,15 @@ static void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 		_clkdm_del_autodeps(clkdm);
 }
 
+static int omap2_clkdm_is_idle(struct clockdomain *clkdm)
+{
+	if (!clkdm->clktrctrl_mask)
+		return -EINVAL;
+
+	return omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+}
+
 static void _enable_hwsup(struct clockdomain *clkdm)
 {
 	if (cpu_is_omap24xx())
@@ -252,6 +262,7 @@ struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_wakeup		= omap2_clkdm_wakeup,
 	.clkdm_allow_idle	= omap2_clkdm_allow_idle,
 	.clkdm_deny_idle	= omap2_clkdm_deny_idle,
+	.clkdm_is_idle		= omap2_clkdm_is_idle,
 	.clkdm_clk_enable	= omap2_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap2_clkdm_clk_disable,
 };
@@ -269,6 +280,7 @@ struct clkdm_ops omap3_clkdm_operations = {
 	.clkdm_wakeup		= omap3_clkdm_wakeup,
 	.clkdm_allow_idle	= omap3_clkdm_allow_idle,
 	.clkdm_deny_idle	= omap3_clkdm_deny_idle,
+	.clkdm_is_idle		= omap2_clkdm_is_idle,
 	.clkdm_clk_enable	= omap2_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap2_clkdm_clk_disable,
 };
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index a1a4ecd..4b10727 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -93,6 +93,12 @@ static void omap4_clkdm_deny_idle(struct clockdomain *clkdm)
 					clkdm->cm_inst, clkdm->clkdm_offs);
 }
 
+static int omap4_clkdm_is_idle(struct clockdomain *clkdm)
+{
+	return omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
+				clkdm->cm_inst, clkdm->clkdm_offs);
+}
+
 static int omap4_clkdm_clk_enable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
@@ -132,6 +138,7 @@ struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_wakeup		= omap4_clkdm_wakeup,
 	.clkdm_allow_idle	= omap4_clkdm_allow_idle,
 	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
+	.clkdm_is_idle		= omap4_clkdm_is_idle,
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
 };
-- 
1.7.0.4

