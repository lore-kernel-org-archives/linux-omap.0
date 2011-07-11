From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP2+: PM: fix watchdog boot when runtime PM is disabled
Date: Mon, 11 Jul 2011 16:21:24 -0700
Message-ID: <1310426484-30083-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54724 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752488Ab1GKXV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 19:21:27 -0400
Received: by mail-iy0-f169.google.com with SMTP id 8so4869749iyl.0
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 16:21:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Fix boot crash in watchdog driver when runtime PM is disabled.

When runtime PM is disabled, devices should be left enabled so that
all device accesses in drivers will succeed even though the runtime PM
get/put calls are noops.

This is already the case for all devices, but the WDT init has its
own hwmod postsetup which was not taking this into account.

This fixes a boot crash where the first device access in the WDT probe
function would crash a booting kernel.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, as this is a boot crash, it should probably be queued for v3.0.
However, since OMAP2PLUS_TYPICAL always enables runtime PM, this is
unlikely to be seen unless specifically testing with runtime PM disabled.

 arch/arm/mach-omap2/io.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 441e79d..95c08aa 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -395,7 +395,11 @@ void __init omap2_init_common_infrastructure(void)
 	 * XXX ideally we could detect whether the MPU WDT was currently
 	 * enabled here and make this conditional
 	 */
+#ifdef CONFIG_PM_RUNTIME
 	postsetup_state = _HWMOD_STATE_DISABLED;
+#else
+	postsetup_state = _HWMOD_STATE_ENABLED;
+#endif
 	omap_hwmod_for_each_by_class("wd_timer",
 				     _set_hwmod_postsetup_state,
 				     &postsetup_state);
-- 
1.7.6

