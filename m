From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 09/11] ARM: OMAP4: hwmod: add support for hwmod autoidle flag
Date: Tue, 25 Sep 2012 19:05:40 +0300
Message-ID: <1348589142-11983-10-git-send-email-t-kristo@ti.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41912 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757357Ab2IYQGK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 12:06:10 -0400
In-Reply-To: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

If a hwmod is in HWAUTO mode, it will idle automatically and should not
be accounted for in the clkdm / pwrdm usecounts. Thus, flag modules in
such mode as autoidle during init, and ignore these in subsequent
usecount calculations.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c            |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 4f01c8f..af88ae5 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1063,6 +1063,9 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
+	if (oh->flags & HWMOD_AUTOIDLE)
+		return 0;
+
 	return _clkdm_clk_hwmod_enable(clkdm);
 }
 
@@ -1094,6 +1097,9 @@ int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
+	if (oh->flags & HWMOD_AUTOIDLE)
+		return 0;
+
 	return _clkdm_clk_hwmod_disable(clkdm);
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f826917..6807b02 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2377,6 +2377,9 @@ static int __init _register(struct omap_hwmod *oh)
 	INIT_LIST_HEAD(&oh->slave_ports);
 	spin_lock_init(&oh->_lock);
 
+	if (cpu_is_omap44xx() && oh->prcm.omap4.modulemode == MODULEMODE_HWCTRL)
+		oh->flags |= HWMOD_AUTOIDLE;
+
 	oh->_state = _HWMOD_STATE_REGISTERED;
 
 	/*
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0f840a9..36130f9 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -440,6 +440,7 @@ struct omap_hwmod_omap4_prcm {
  *     in order to complete the reset. Optional clocks will be disabled
  *     again after the reset.
  * HWMOD_16BIT_REG: Module has 16bit registers
+ * HWMOD_AUTOIDLE: Module is controlled automatically by hardware
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -450,6 +451,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_NO_IDLEST				(1 << 6)
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
+#define HWMOD_AUTOIDLE				(1 << 9)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
1.7.4.1

