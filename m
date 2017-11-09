From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 04/28] clk: ti: clkctrl: use fallback udelay approach if timekeeping is suspended
Date: Thu, 9 Nov 2017 11:15:14 +0200
Message-ID: <1510218917-1725-2-git-send-email-t-kristo@ti.com>
References: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

In certain cases it is possible that the timekeeping has been suspended
already when attempting to disable/enable a clkctrl clock. This will
happen at least on am43xx platform when attempting to enable / disable
the clockevent source itself, burping out a warning from timekeeping core.

The sequence of events leading to this:
-> timekeeping_suspend()
 -> clockevents_suspend()
  -> omap_clkevt_idle()
   -> omap_hwmod_idle()
    -> _omap4_clkctrl_clk_disable()
     -> _omap4_is_timeout()

Avoid the issue by checking if the timekeeping is suspended and using
the fallback udelay approach for checking timeouts.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clkctrl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 284ba449..38dbcc1 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 #include <linux/delay.h>
+#include <linux/timekeeping.h>
 #include "clock.h"
 
 #define NO_IDLEST			0x1
@@ -90,7 +91,18 @@ static bool _omap4_is_ready(u32 val)
 
 static bool _omap4_is_timeout(union omap4_timeout *time, u32 timeout)
 {
-	if (unlikely(_early_timeout)) {
+	/*
+	 * There are two special cases where ktime_to_ns() can't be
+	 * used to track the timeouts. First one is during early boot
+	 * when the timers haven't been initialized yet. The second
+	 * one is during suspend-resume cycle while timekeeping is
+	 * being suspended / resumed. Clocksource for the system
+	 * can be from a timer that requires pm_runtime access, which
+	 * will eventually bring us here with timekeeping_suspended,
+	 * during both suspend entry and resume paths. This happens
+	 * at least on am43xx platform.
+	 */
+	if (unlikely(_early_timeout || timekeeping_suspended)) {
 		if (time->cycles++ < timeout) {
 			udelay(1);
 			return false;
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
