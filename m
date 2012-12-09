From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/12] ARM: OMAP2+: CM: use the cached copy of the
 clockdomain's hwsup state
Date: Sun, 09 Dec 2012 13:03:25 -0700
Message-ID: <20121209200324.3196.65545.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40200 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758921Ab2LIUFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:05:08 -0500
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Avoid some unnecessary CM IP block reads by using the cached copy of
the clockdomain's hardware-supervised idle state.  This should
simplify the code slightly and save a few hundred nanoseconds in these
paths.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm2xxx.c |   19 ++-----------------
 arch/arm/mach-omap2/cm3xxx.c |   14 ++------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 6774a53..8ca13cd 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -285,14 +285,7 @@ static void omap2xxx_clkdm_deny_idle(struct clockdomain *clkdm)
 
 static int omap2xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 {
-	bool hwsup = false;
-
-	if (!clkdm->clktrctrl_mask)
-		return 0;
-
-	hwsup = omap2xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-					      clkdm->clktrctrl_mask);
-	if (!hwsup && clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+	if (!clkdm_in_hwsup(clkdm) && clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
 		omap2xxx_clkdm_wakeup(clkdm);
 
 	return 0;
@@ -300,15 +293,7 @@ static int omap2xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 
 static int omap2xxx_clkdm_clk_disable(struct clockdomain *clkdm)
 {
-	bool hwsup = false;
-
-	if (!clkdm->clktrctrl_mask)
-		return 0;
-
-	hwsup = omap2xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-					      clkdm->clktrctrl_mask);
-
-	if (!hwsup && clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
+	if (!clkdm_in_hwsup(clkdm) && clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
 		omap2xxx_clkdm_sleep(clkdm);
 
 	return 0;
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 9061c30..75872134 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -227,8 +227,6 @@ static void omap3xxx_clkdm_deny_idle(struct clockdomain *clkdm)
 
 static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 {
-	bool hwsup = false;
-
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
@@ -243,10 +241,7 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 		return 0;
 	}
 
-	hwsup = omap3xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-					      clkdm->clktrctrl_mask);
-
-	if (hwsup) {
+	if (clkdm_in_hwsup(clkdm)) {
 		/* Disable HW transitions when we are changing deps */
 		omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 						clkdm->clktrctrl_mask);
@@ -263,8 +258,6 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 
 static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
 {
-	bool hwsup = false;
-
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
@@ -280,10 +273,7 @@ static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
 		return 0;
 	}
 
-	hwsup = omap3xxx_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
-					      clkdm->clktrctrl_mask);
-
-	if (hwsup) {
+	if (clkdm_in_hwsup(clkdm)) {
 		/* Disable HW transitions when we are changing deps */
 		omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 						clkdm->clktrctrl_mask);


