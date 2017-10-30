From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/27] clk: ti: clkctrl: use fallback udelay approach if timekeeping is suspended
Date: Mon, 30 Oct 2017 15:04:22 +0200
Message-ID: <1509368685-29112-5-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

This will happen on certain platforms when entering / leaving suspend
and the system attempts to disable certain clocks at very early/late
phase, burping out a warning from timekeeping core. Avoid the issue
by checking if the timekeeping is suspended and using the fallback
udelay approach for checking timeouts.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clkctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 284ba449..91ddc92 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 #include <linux/delay.h>
+#include <linux/timekeeping.h>
 #include "clock.h"
 
 #define NO_IDLEST			0x1
@@ -90,7 +91,7 @@ static bool _omap4_is_ready(u32 val)
 
 static bool _omap4_is_timeout(union omap4_timeout *time, u32 timeout)
 {
-	if (unlikely(_early_timeout)) {
+	if (unlikely(_early_timeout || timekeeping_suspended)) {
 		if (time->cycles++ < timeout) {
 			udelay(1);
 			return false;
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
