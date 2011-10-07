From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv2 5/7] ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
Date: Fri, 7 Oct 2011 23:17:49 +0530
Message-ID: <1318009671-12813-6-git-send-email-vishwanath.bs@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43421 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab1JGRzP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 13:55:15 -0400
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

IO Daisychain feature has to be triggered whenever there is a change in
device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).

Now devices can idle independent of the powerdomain, there can be a window where device
is idled and corresponding powerdomain can be ON/INACTIVE state. In such situations,
since both module wake up is enabled at padlevel as well as io daisychain sequence is
triggered, there will be 2 PRCM interrupts (Module async wake up via swakeup and IO Pad
interrupt). But as PRCM Interrupt handler clears the Module Padlevel WKST bit in the
first interrupt, module specific interrupt handler will not triggered for the second time

Also look at detailed explanation given by Rajendra at
http://www.spinics.net/lists/linux-serial/msg04480.html

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
This has been tested on OMAP3 using Chain Handler + UART Runtime patches [1]. Special
thanks to GOvind for testing and confirming this behaviour on UART3.
[1]: git://gitorious.org/runtime_3-0/runtime_3-0.git v6_uart_runtime

 arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
 arch/arm/mach-omap2/pm.c         |   11 +++++++++++
 arch/arm/mach-omap2/pm.h         |    1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..070f3f5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -151,6 +151,7 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "mux.h"
+#include "pm.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
@@ -1462,8 +1463,10 @@ static int _enable(struct omap_hwmod *oh)
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
 			((oh->_state == _HWMOD_STATE_IDLE) &&
-			 oh->mux->pads_dynamic)))
+			 oh->mux->pads_dynamic))) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+		omap_trigger_wuclk_ctrl();
+	}
 
 	_add_initiator_dep(oh, mpu_oh);
 
@@ -1553,8 +1556,10 @@ static int _idle(struct omap_hwmod *oh)
 		clkdm_hwmod_disable(oh->clkdm, oh);
 
 	/* Mux pins for device idle if populated */
-	if (oh->mux && oh->mux->pads_dynamic)
+	if (oh->mux && oh->mux->pads_dynamic) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+		omap_trigger_wuclk_ctrl();
+	}
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 472bf22..79be7af 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -23,6 +23,8 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "pm.h"
+#include "prm2xxx_3xxx.h"
+#include "prm44xx.h"
 
 static struct omap_device_pm_latency *pm_lats;
 
@@ -95,6 +97,15 @@ static void omap2_init_processor_devices(void)
 	}
 }
 
+void omap_trigger_wuclk_ctrl(void)
+{
+	if (cpu_is_omap34xx())
+		omap3_trigger_wuclk_ctrl();
+
+	if (cpu_is_omap44xx())
+		omap4_trigger_wuclk_ctrl();
+}
+
 /* Types of sleep_switch used in omap_set_pwrdm_state */
 #define FORCEWAKEUP_SWITCH	0
 #define LOWPOWERSTATE_SWITCH	1
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4e166ad..05c2da2 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -21,6 +21,7 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+void omap_trigger_wuclk_ctrl(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
-- 
1.7.0.4

