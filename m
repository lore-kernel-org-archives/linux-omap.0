From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] ARM: OMAP2+: Add hwmod flag for HWMOD_RECONFIG_IO_CHAIN
Date: Mon, 15 Sep 2014 20:11:55 -0700
Message-ID: <1410837126-31553-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19365 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753077AbaIPDMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 23:12:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Commit cc824534d4fe ("ARM: OMAP2+: hwmod: Rearm wake-up interrupts
for DT when MUSB is idled") fixed issues with hung UART wake-up
events by calling _reconfigure_io_chain() when MUSB is connected
or disconnected.

As pointed out by Paul Walmsley, we may need to also call
_reconfigure_io_chain() in other cases, so it should be a separate
flag. Let's add HWMOD_RECONFIG_IO_CHAIN as suggested by Paul.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c           | 4 ++--
 arch/arm/mach-omap2/omap_hwmod.h           | 4 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e91a4e..bd9990e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2185,7 +2185,7 @@ static int _enable(struct omap_hwmod *oh)
 			 oh->mux->pads_dynamic))) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 		_reconfigure_io_chain();
-	} else if (oh->flags & HWMOD_FORCE_MSTANDBY) {
+	} else if (oh->flags & HWMOD_RECONFIG_IO_CHAIN) {
 		_reconfigure_io_chain();
 	}
 
@@ -2293,7 +2293,7 @@ static int _idle(struct omap_hwmod *oh)
 	if (oh->mux && oh->mux->pads_dynamic) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
 		_reconfigure_io_chain();
-	} else if (oh->flags & HWMOD_FORCE_MSTANDBY) {
+	} else if (oh->flags & HWMOD_RECONFIG_IO_CHAIN) {
 		_reconfigure_io_chain();
 	}
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 0f97d63..512f809 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -514,6 +514,9 @@ struct omap_hwmod_omap4_prcm {
  * HWMOD_SWSUP_SIDLE_ACT: omap_hwmod code should manually bring the module
  *     out of idle, but rely on smart-idle to the put it back in idle,
  *     so the wakeups are still functional (Only known case for now is UART)
+ * HWMOD_RECONFIG_IO_CHAIN: omap_hwmod code needs to reconfigure wake-up 
+ *     events by calling _reconfigure_io_chain() when a device is enabled
+ *     or idled.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -528,6 +531,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_BLOCK_WFI				(1 << 10)
 #define HWMOD_FORCE_MSTANDBY			(1 << 11)
 #define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
+#define HWMOD_RECONFIG_IO_CHAIN			(1 << 13)
 
 /*
  * omap_hwmod._int_flags definitions
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e9516b4..61cd49d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1730,8 +1730,8 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 	 * Note that musb has OTG_FORCESTDBY register that controls MSTANDBY
 	 * signal when MIDLEMODE is set to force-idle.
 	 */
-	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
-				| HWMOD_FORCE_MSTANDBY,
+	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE |
+			  HWMOD_FORCE_MSTANDBY | HWMOD_RECONFIG_IO_CHAIN,
 };
 
 /* usb_otg_hs */
-- 
2.1.0

