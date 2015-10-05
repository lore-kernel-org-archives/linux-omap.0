From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/4] ARM: OMAP: dmtimer: check for fixed timers during config
Date: Mon, 5 Oct 2015 18:28:21 -0500
Message-ID: <1444087704-1429-2-git-send-email-s-anna@ti.com>
References: <1444087704-1429-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444087704-1429-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The omap_dm_timer_set_source() function provides a means for client
users to configure the mux parent for a GPTimer's functional clock.
However, not all timers are configurable (Eg: Timer12 on DRA7 is fed
by an internal 32k oscillator clock, and does not have configurable
parent clocks). So, check for such cases and proceed with out throwing
an error.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/dmtimer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8ca94d379bc3..4c48b52c4a7c 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -36,6 +36,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/device.h>
@@ -504,6 +505,12 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (IS_ERR(timer->fclk))
 		return -EINVAL;
 
+#if defined(CONFIG_COMMON_CLK)
+	/* Check if the clock has configurable parents */
+	if (clk_hw_get_num_parents(__clk_get_hw(timer->fclk)) < 2)
+		return 0;
+#endif
+
 	switch (source) {
 	case OMAP_TIMER_SRC_SYS_CLK:
 		parent_name = "timer_sys_ck";
-- 
2.6.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
