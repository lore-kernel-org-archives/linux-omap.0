From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 3/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
Date: Fri, 24 Feb 2012 17:15:43 +0200
Message-ID: <1330096546-20477-4-git-send-email-t-kristo@ti.com>
References: <1330096546-20477-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab2BXPQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 10:16:02 -0500
In-Reply-To: <1330096546-20477-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

IO Daisychain feature has to be triggered whenever there is a change in
device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).

Now devices can idle independent of the powerdomain, there can be a
window where device is idled and corresponding powerdomain can be
ON/INACTIVE state. In such situations, since both module wake up is
enabled at padlevel as well as io daisychain sequence is triggered,
there will be 2 PRCM interrupts (Module async wake up via swakeup and
IO Pad interrupt). But as PRCM Interrupt handler clears the Module
Padlevel WKST bit in the first interrupt, module specific interrupt
handler will not triggered for the second time

Also look at detailed explanation given by Rajendra at
http://www.spinics.net/lists/linux-serial/msg04480.html

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
 arch/arm/mach-omap2/pm.c         |    7 +++++++
 arch/arm/mach-omap2/pm.h         |    1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5192cab..b052f11 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -152,6 +152,7 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "mux.h"
+#include "pm.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
@@ -1535,8 +1536,10 @@ static int _enable(struct omap_hwmod *oh)
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
 			((oh->_state == _HWMOD_STATE_IDLE) &&
-			 oh->mux->pads_dynamic)))
+			 oh->mux->pads_dynamic))) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+		omap_trigger_wuclk_ctrl();
+	}
 
 	_add_initiator_dep(oh, mpu_oh);
 
@@ -1622,8 +1625,10 @@ static int _idle(struct omap_hwmod *oh)
 		clkdm_hwmod_disable(oh->clkdm, oh);
 
 	/* Mux pins for device idle if populated */
-	if (oh->mux && oh->mux->pads_dynamic)
+	if (oh->mux && oh->mux->pads_dynamic) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+		omap_trigger_wuclk_ctrl();
+	}
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..e8b54eb 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -25,6 +25,7 @@
 #include "clockdomain.h"
 #include "pm.h"
 #include "twl-common.h"
+#include "prm44xx.h"
 
 static struct omap_device_pm_latency *pm_lats;
 
@@ -64,6 +65,12 @@ static void omap2_init_processor_devices(void)
 	}
 }
 
+void omap_trigger_wuclk_ctrl(void)
+{
+	if (cpu_is_omap44xx())
+		omap4_trigger_wuclk_ctrl();
+}
+
 /* Types of sleep_switch used in omap_set_pwrdm_state */
 #define FORCEWAKEUP_SWITCH	0
 #define LOWPOWERSTATE_SWITCH	1
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b737b11..de0a453 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,6 +22,7 @@ extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 extern int omap4_idle_init(void);
+extern void omap_trigger_wuclk_ctrl(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
-- 
1.7.4.1

