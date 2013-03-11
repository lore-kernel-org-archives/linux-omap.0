From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby for musb
Date: Mon, 11 Mar 2013 21:49:00 +0200
Message-ID: <1363031340-9382-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:63444 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab3CKTtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 15:49:12 -0400
Received: by mail-ee0-f41.google.com with SMTP id c13so2456184eek.28
        for <linux-omap@vger.kernel.org>; Mon, 11 Mar 2013 12:49:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>

For some unknown reason, allowing hwmod to control MIDLEMODE causes
core_pwrdm to not hit idle states for musb in DM3730 at least.
I've verified that setting any MIDLEMODE value other than "force
standby" before enabling the device causes subsequent suspend
attempts to fail with core_pwrdm not entering idle states, even
if the driver is unloaded and "force standby" is restored before
suspend attempt. To recover from this, soft reset can be used, but
that's not suitable solution for suspend.

Keeping the register set at force standby (reset value) makes it work
and device still functions properly, as musb has driver-controlled
OTG_FORCESTDBY register that controls MSTANDBY signal.
Note that TI PSP kernels also have similar workarounds.

This patch also fixes HWMOD_SWSUP_MSTANDBY documentation to match the
actual flag name.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod.c           |    7 +++++--
 arch/arm/mach-omap2/omap_hwmod.h           |    9 +++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 ++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c2c798c..a202a47 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1368,7 +1368,9 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	}
 
 	if (sf & SYSC_HAS_MIDLEMODE) {
-		if (oh->flags & HWMOD_SWSUP_MSTANDBY) {
+		if (oh->flags & HWMOD_FORCE_MSTANDBY) {
+			idlemode = HWMOD_IDLEMODE_FORCE;
+		} else if (oh->flags & HWMOD_SWSUP_MSTANDBY) {
 			idlemode = HWMOD_IDLEMODE_NO;
 		} else {
 			if (sf & SYSC_HAS_ENAWAKEUP)
@@ -1440,7 +1442,8 @@ static void _idle_sysc(struct omap_hwmod *oh)
 	}
 
 	if (sf & SYSC_HAS_MIDLEMODE) {
-		if (oh->flags & HWMOD_SWSUP_MSTANDBY) {
+		if ((oh->flags & HWMOD_SWSUP_MSTANDBY) ||
+		    (oh->flags & HWMOD_FORCE_MSTANDBY)) {
 			idlemode = HWMOD_IDLEMODE_FORCE;
 		} else {
 			if (sf & SYSC_HAS_ENAWAKEUP)
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index d43d9b6..d5dc935 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -427,8 +427,8 @@ struct omap_hwmod_omap4_prcm {
  *
  * HWMOD_SWSUP_SIDLE: omap_hwmod code should manually bring module in and out
  *     of idle, rather than relying on module smart-idle
- * HWMOD_SWSUP_MSTDBY: omap_hwmod code should manually bring module in and out
- *     of standby, rather than relying on module smart-standby
+ * HWMOD_SWSUP_MSTANDBY: omap_hwmod code should manually bring module in and
+ *     out of standby, rather than relying on module smart-standby
  * HWMOD_INIT_NO_RESET: don't reset this module at boot - important for
  *     SDRAM controller, etc. XXX probably belongs outside the main hwmod file
  *     XXX Should be HWMOD_SETUP_NO_RESET
@@ -459,6 +459,10 @@ struct omap_hwmod_omap4_prcm {
  *     correctly, or this is being abused to deal with some PM latency
  *     issues -- but we're currently suffering from a shortage of
  *     folks who are able to track these issues down properly.
+ * HWMOD_FORCE_MSTANDBY: Always keep MIDLEMODE bits cleared so that device
+ *     is kept in force-standby mode. Failing to do so causes PM problems
+ *     with musb on OMAP3630 at least. Note that musb has a dedicated register
+ *     to control MSTANDBY signal when MIDLEMODE is set to force-standby.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -471,6 +475,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_16BIT_REG				(1 << 8)
 #define HWMOD_EXT_OPT_MAIN_CLK			(1 << 9)
 #define HWMOD_BLOCK_WFI				(1 << 10)
+#define HWMOD_FORCE_MSTANDBY			(1 << 11)
 
 /*
  * omap_hwmod._int_flags definitions
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ac7e03e..5112d04 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1707,9 +1707,14 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 	 * Erratum ID: i479  idle_req / idle_ack mechanism potentially
 	 * broken when autoidle is enabled
 	 * workaround is to disable the autoidle bit at module level.
+	 *
+	 * Enabling the device in any other MIDLEMODE setting but force-idle
+	 * causes core_pwrdm not enter idle states at least on OMAP3630.
+	 * Note that musb has OTG_FORCESTDBY register that controls MSTANDBY
+	 * signal when MIDLEMODE is set to force-idle.
 	 */
 	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
-				| HWMOD_SWSUP_MSTANDBY,
+				| HWMOD_FORCE_MSTANDBY,
 };
 
 /* usb_otg_hs */
-- 
1.7.9.5

