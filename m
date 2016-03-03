From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
Date: Thu, 3 Mar 2016 14:12:04 +0530
Message-ID: <1456994525-20573-2-git-send-email-lokeshvutla@ti.com>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456994525-20573-1-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Introduce a dt property, ti,no-idle, that prevents an IP to idle at any
point. This is to handle Errata i877, which tells that GMAC clocks
cannot be disabled.

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Tested-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 1 +
 arch/arm/mach-omap2/omap_hwmod.c                    | 9 ++++++++-
 arch/arm/mach-omap2/omap_hwmod.h                    | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 739bc48..21e71a5 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -23,6 +23,7 @@ Optional properties:
   during suspend.
 - ti,no-reset-on-init: When present, the module should not be reset at init
 - ti,no-idle-on-init: When present, the module should not be idled at init
+- ti,no-idle: When present, the module is never allowed to idle.
 
 Example:
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e9f65fe..b6d62e4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2200,6 +2200,11 @@ static int _enable(struct omap_hwmod *oh)
  */
 static int _idle(struct omap_hwmod *oh)
 {
+	if (oh->flags & HWMOD_NO_IDLE) {
+		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
+		return 0;
+	}
+
 	pr_debug("omap_hwmod: %s: idling\n", oh->name);
 
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
@@ -2504,6 +2509,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 			oh->flags |= HWMOD_INIT_NO_RESET;
 		if (of_find_property(np, "ti,no-idle-on-init", NULL))
 			oh->flags |= HWMOD_INIT_NO_IDLE;
+		if (of_find_property(np, "ti,no-idle", NULL))
+			oh->flags |= HWMOD_NO_IDLE;
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
@@ -2630,7 +2637,7 @@ static void __init _setup_postsetup(struct omap_hwmod *oh)
 	 * XXX HWMOD_INIT_NO_IDLE does not belong in hwmod data -
 	 * it should be set by the core code as a runtime flag during startup
 	 */
-	if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
+	if ((oh->flags & (HWMOD_INIT_NO_IDLE | HWMOD_NO_IDLE)) &&
 	    (postsetup_state == _HWMOD_STATE_IDLE)) {
 		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
 		postsetup_state = _HWMOD_STATE_ENABLED;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 76bce11..7c7a311 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -525,6 +525,8 @@ struct omap_hwmod_omap4_prcm {
  *     or idled.
  * HWMOD_OPT_CLKS_NEEDED: The optional clocks are needed for the module to
  *     operate and they need to be handled at the same time as the main_clk.
+ * HWMOD_NO_IDLE: Do not idle the hwmod at all. Useful to handle certain
+ *     IPs like CPSW on DRA7, where clocks to this module cannot be disabled.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -541,6 +543,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
 #define HWMOD_RECONFIG_IO_CHAIN			(1 << 13)
 #define HWMOD_OPT_CLKS_NEEDED			(1 << 14)
+#define HWMOD_NO_IDLE				(1 << 15)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
