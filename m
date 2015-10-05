From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/4] ARM: OMAP2+: timer: Remove secure timer for DRA7xx HS devices
Date: Mon, 5 Oct 2015 18:28:22 -0500
Message-ID: <1444087704-1429-3-git-send-email-s-anna@ti.com>
References: <1444087704-1429-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444087704-1429-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Timer 12 on DRA7 SoCs is reserved for secure usage on high-secure (HS)
devices. The timer cannot be used by the kernel on HS devices, but is
available on regular general purpose (GP) devices. This is similar to the
behavior on OMAP3 devices, so extend the logic used in commit ad24bde8f102
("ARM: OMAP3: Dynamically disable secure timer nodes for secure devices")
to remove the secure timer on DRA7xx SoCs at run-time based on the SoC
device type.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a55655127ef2..1e346aa0a687 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -193,8 +193,8 @@ static struct device_node * __init omap_get_timer_dt(const struct of_device_id *
 /**
  * omap_dmtimer_init - initialisation function when device tree is used
  *
- * For secure OMAP3 devices, timers with device type "timer-secure" cannot
- * be used by the kernel as they are reserved. Therefore, to prevent the
+ * For secure OMAP3/DRA7xx devices, timers with device type "timer-secure"
+ * cannot be used by the kernel as they are reserved. Therefore, to prevent the
  * kernel registering these devices remove them dynamically from the device
  * tree on boot.
  */
@@ -202,7 +202,7 @@ static void __init omap_dmtimer_init(void)
 {
 	struct device_node *np;
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx() && !soc_is_dra7xx())
 		return;
 
 	/* If we are a secure device, remove any secure timer nodes */
-- 
2.6.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
