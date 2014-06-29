From: Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/13] ARM: OMAP2+: hwmod: Introduce a flag to deassert the HW reset line
Date: Sun, 29 Jun 2014 18:21:39 +0200
Message-ID: <1404058907-21112-6-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Hans J . Koch" <hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

hwmod's hardreset lines are not deasserted after a reset.
Add the HWMOD_INIT_DEASSERT_HARD_RESET flag to deassert those after a
successful reset.

This is required to get the PRU-ICSS in a usable state on am33xx SoCs.

Signed-off-by: Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f7bb435..1e56b65 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2622,6 +2622,8 @@ static int __init _setup_reset(struct omap_hwmod *oh)
 
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		r = _reset(oh);
+	if (!r && oh->flags & HWMOD_INIT_DEASSERT_HARD_RESET)
+		r = _deassert_hardreset(oh, oh->name);
 
 	return r;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 0f97d63..c41d44d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -514,6 +514,7 @@ struct omap_hwmod_omap4_prcm {
  * HWMOD_SWSUP_SIDLE_ACT: omap_hwmod code should manually bring the module
  *     out of idle, but rely on smart-idle to the put it back in idle,
  *     so the wakeups are still functional (Only known case for now is UART)
+ * HWMOD_INIT_DEASSERT_HARD_RESET: deassert the HW reset line at boot
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -528,6 +529,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_BLOCK_WFI				(1 << 10)
 #define HWMOD_FORCE_MSTANDBY			(1 << 11)
 #define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
+#define HWMOD_INIT_DEASSERT_HARD_RESET		(1 << 13)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
