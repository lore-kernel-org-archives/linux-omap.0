From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 2/6] ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in active
Date: Wed, 15 May 2013 20:18:38 +0530
Message-ID: <1368629322-3170-3-git-send-email-rnayak@ti.com>
References: <1368629322-3170-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58313 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759384Ab3EOOtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 May 2013 10:49:50 -0400
In-Reply-To: <1368629322-3170-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, Rajendra Nayak <rnayak@ti.com>

Some IPs (like UART) need the sidle mode to be controlled in SW only
while they are active. Once they go inactive, they need the IP to be
put back in HW control so they are also wakeup capable.

The flag HWMOD_SWSUP_SIDLE takes care of IPs which need the sidle
mode to be *always* controlled in SWSUP. We now have a need to control
IPs sidle mode in SWSUP only while its active.

So define a new flag 'HWMOD_SWSUP_SIDLE_ACT' to help the framework
know about these new IP requirements.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod.h |    4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c28552b..5739429 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1356,7 +1356,8 @@ static void _enable_sysc(struct omap_hwmod *oh)
 
 	clkdm = _get_clkdm(oh);
 	if (sf & SYSC_HAS_SIDLEMODE) {
-		if (oh->flags & HWMOD_SWSUP_SIDLE) {
+		if (oh->flags & HWMOD_SWSUP_SIDLE ||
+		    oh->flags & HWMOD_SWSUP_SIDLE_ACT) {
 			idlemode = HWMOD_IDLEMODE_NO;
 		} else {
 			if (sf & SYSC_HAS_ENAWAKEUP)
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index fe59629..8498774 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -463,6 +463,9 @@ struct omap_hwmod_omap4_prcm {
  *     is kept in force-standby mode. Failing to do so causes PM problems
  *     with musb on OMAP3630 at least. Note that musb has a dedicated register
  *     to control MSTANDBY signal when MIDLEMODE is set to force-standby.
+ * HWMOD_SWSUP_SIDLE_ACT: omap_hwmod code should manually bring the module
+ *     out of idle, but rely on smart-idle to the put it back in idle,
+ *     so the wakeups are still functional (Only known case for now is UART)
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -476,6 +479,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_EXT_OPT_MAIN_CLK			(1 << 9)
 #define HWMOD_BLOCK_WFI				(1 << 10)
 #define HWMOD_FORCE_MSTANDBY			(1 << 11)
+#define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
1.7.9.5

