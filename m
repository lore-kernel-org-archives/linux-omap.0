From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] bus: ti-sysc: Remove unpaired sysc_clkdm_deny_idle()
Date: Fri,  6 Sep 2019 13:01:54 -0700
Message-ID: <20190906200154.6510-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vignesh Raghavendra <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Commit d098913a10f8 ("bus: ti-sysc: Fix clock handling for no-idle
quirks") fixed handling for no-idle quirk modules that are not enabled
by the bootloader.

But it also caused unpaired clockdomain calls that won't allow idling
the system. That's because clkdm_allow_idle_nolock() and
clkdm_deny_idle_nolock() have usage count with clkdm->forcewake_count.

Let's drop the unpaired sysc_clkdm_deny_idle() to fix idling of devices.

Fixes: d098913a10f8 ("bus: ti-sysc: Fix clock handling for no-idle quirks")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2363,7 +2363,6 @@ static void ti_sysc_idle(struct work_struct *work)
 	 */
 	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE |
 				 SYSC_QUIRK_NO_IDLE_ON_INIT)) {
-		sysc_clkdm_deny_idle(ddata);
 		sysc_disable_main_clocks(ddata);
 		sysc_disable_opt_clocks(ddata);
 		sysc_clkdm_allow_idle(ddata);
-- 
2.23.0
