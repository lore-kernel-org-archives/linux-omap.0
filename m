From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/8] ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in active
Date: Wed, 20 Feb 2013 15:27:48 +0530
Message-ID: <1361354272-18089-5-git-send-email-santosh.shilimkar@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34999 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933984Ab3BTJ53 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 04:57:29 -0500
In-Reply-To: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

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
index 932d5e6..9e1e8c8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1337,7 +1337,8 @@ static void _enable_sysc(struct omap_hwmod *oh)
 
 	clkdm = _get_clkdm(oh);
 	if (sf & SYSC_HAS_SIDLEMODE) {
-		if (oh->flags & HWMOD_SWSUP_SIDLE) {
+		if (oh->flags & HWMOD_SWSUP_SIDLE ||
+				oh->flags & HWMOD_SWSUP_SIDLE_ACT) {
 			idlemode = HWMOD_IDLEMODE_NO;
 		} else {
 			if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 23f530b..c191035 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -451,6 +451,9 @@ struct omap_hwmod_omap4_prcm {
  *     enabled.  This prevents the hwmod code from being able to
  *     enable and reset the IP block early.  XXX Eventually it should
  *     be possible to query the clock framework for this information.
+ * HWMOD_SWSUP_SIDLE_ACT: omap_hwmod code should manually bring the module out of
+ *     idle, but rely on smart-idle to the put it back in idle, so the wakeups
+ *     are still functional (Only known case for now is UART)
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -462,6 +465,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
 #define HWMOD_EXT_OPT_MAIN_CLK			(1 << 9)
+#define HWMOD_SWSUP_SIDLE_ACT			(1 << 10)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
1.7.9.5

