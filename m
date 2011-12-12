From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix: Don't wait for the idle status if modulemode is not supported
Date: Mon, 12 Dec 2011 15:39:47 +0100
Message-ID: <1323700787-5934-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34942 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab1LLOj5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 09:39:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

If the module does not have any modulemode, the _disable_module function
will do nothing. There is then no point waiting for a idle status change.

It will remove the following warnings.

[    0.331848] omap_hwmod: dmm: _wait_target_disable failed
[    0.339935] omap_hwmod: emif_fw: _wait_target_disable failed
[    0.348358] omap_hwmod: l3_main_1: _wait_target_disable failed
[    0.356964] omap_hwmod: l3_main_2: _wait_target_disable failed
[    0.365600] omap_hwmod: l4_abe: _wait_target_disable failed
[    0.373931] omap_hwmod: l4_cfg: _wait_target_disable failed
[    0.382263] omap_hwmod: l4_per: _wait_target_disable failed
[    0.391113] omap_hwmod: l4_wkup: _wait_target_disable failed
[    0.399536] omap_hwmod: dma_system: _wait_target_disable failed
[    0.408325] omap_hwmod: dss_core: _wait_target_disable failed
[    0.416839] omap_hwmod: dss_dispc: _wait_target_disable failed
[    0.425445] omap_hwmod: dss_dsi1: _wait_target_disable failed
[    0.433990] omap_hwmod: dss_dsi2: _wait_target_disable failed
[    0.442504] omap_hwmod: dss_hdmi: _wait_target_disable failed
[    0.451019] omap_hwmod: dss_rfbi: _wait_target_disable failed
[    0.459564] omap_hwmod: dss_venc: _wait_target_disable failed
[    0.489471] omap_hwmod: mailbox: _wait_target_disable failed
[    0.505920] omap_hwmod: spinlock: _wait_target_disable failed

Note: For such module, the state is managed automatically by HW according
to clock domain transition. It is then not possible to wait for idle even
later in the _idle function since the status will change at clock domain
boundary.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 207a2ff..dc9acac 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -710,16 +710,16 @@ static void _enable_module(struct omap_hwmod *oh)
  * @oh: struct omap_hwmod *
  *
  * Disable the PRCM module mode related to the hwmod @oh.
- * No return value.
+ * Return EINVAL if the modulemode is not supported and 0 in case of success.
  */
-static void _disable_module(struct omap_hwmod *oh)
+int _disable_module(struct omap_hwmod *oh)
 {
 	/* The module mode does not exist prior OMAP4 */
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return;
+		return -EINVAL;
 
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
-		return;
+		return -EINVAL;
 
 	pr_debug("omap_hwmod: %s: _disable_module\n", oh->name);
 
@@ -727,6 +727,8 @@ static void _disable_module(struct omap_hwmod *oh)
 				    oh->clkdm->cm_inst,
 				    oh->clkdm->clkdm_offs,
 				    oh->prcm.omap4.clkctrl_offs);
+
+	return 0;
 }
 
 /**
@@ -1537,11 +1539,20 @@ static int _idle(struct omap_hwmod *oh)
 	if (oh->class->sysc)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
-	_disable_module(oh);
-	ret = _wait_target_disable(oh);
-	if (ret)
-		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
-			oh->name);
+	ret = _disable_module(oh);
+
+	/*
+	 * If the module does not have any modulemode, the previous
+	 * function will do nothing. There is then no point waiting
+	 * for a idle status change.
+	 */
+	if (!ret) {
+		ret = _wait_target_disable(oh);
+		if (ret)
+			pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
+				oh->name);
+	}
+
 	/*
 	 * The module must be in idle mode before disabling any parents
 	 * clocks. Otherwise, the parent clock might be disabled before
-- 
1.7.0.4

