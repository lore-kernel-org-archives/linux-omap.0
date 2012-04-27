From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/6] ARM: OMAP2+: hwmod: use init-time function ptrs for enable/disable module
Date: Fri, 27 Apr 2012 13:05:36 -0700
Message-ID: <1335557140-10854-3-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50887 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965Ab2D0UEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 16:04:50 -0400
Received: by dadn15 with SMTP id n15so1796625dad.16
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 13:04:49 -0700 (PDT)
In-Reply-To: <1335557140-10854-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The enable/disable module functions are specific to SoCs with
OMAP4-class PRCM.  Rather than use cpu_is* checks at runtime inside
the enable/disable module functions, use cpu_is at init time to
initialize function pointers only for SoCs that need them.

NOTE: the cpu_is* check for _enable_module was different than
      the one for _disable_module, and this patch uses
      cpu_is_omap44xx() for both.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   22 +++++++++++-----------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 939032a..a978350 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -779,10 +779,6 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
  */
 static void _omap4_enable_module(struct omap_hwmod *oh)
 {
-	/* The module mode does not exist prior OMAP4 */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return;
-
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
 		return;
 
@@ -1571,10 +1567,6 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 {
 	int v;
 
-	/* The module mode does not exist prior OMAP4 */
-	if (!cpu_is_omap44xx())
-		return -EINVAL;
-
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
 		return -EINVAL;
 
@@ -1814,7 +1806,8 @@ static int _enable(struct omap_hwmod *oh)
 	}
 
 	_enable_clocks(oh);
-	_omap4_enable_module(oh);
+	if (oh->enable_module)
+		oh->enable_module(oh);
 
 	r = _wait_target_ready(oh);
 	if (!r) {
@@ -1870,7 +1863,8 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 
-	_omap4_disable_module(oh);
+	if (oh->disable_module)
+		oh->disable_module(oh);
 
 	/*
 	 * The module must be in idle mode before disabling any parents
@@ -1975,7 +1969,8 @@ static int _shutdown(struct omap_hwmod *oh)
 	if (oh->_state == _HWMOD_STATE_ENABLED) {
 		_del_initiator_dep(oh, mpu_oh);
 		/* XXX what about the other system initiators here? dma, dsp */
-		_omap4_disable_module(oh);
+		if (oh->disable_module)
+			oh->disable_module(oh);
 		_disable_clocks(oh);
 		if (oh->clkdm)
 			clkdm_hwmod_disable(oh->clkdm, oh);
@@ -2063,6 +2058,11 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		return -EINVAL;
 	}
 
+	if (cpu_is_omap44xx()) {
+		oh->enable_module = _omap4_enable_module;
+		oh->disable_module = _omap4_disable_module;
+	}
+
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
 	return 0;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 14dde32..0dbe8cf 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -564,6 +564,9 @@ struct omap_hwmod {
 	u8				_int_flags;
 	u8				_state;
 	u8				_postsetup_state;
+
+	void (*enable_module)(struct omap_hwmod *oh);
+	int (*disable_module)(struct omap_hwmod *oh);
 };
 
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
-- 
1.7.9.2

