From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used OMAP4 onwards
Date: Tue, 27 Mar 2012 15:28:31 +0530
Message-ID: <1332842311-12308-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58859 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757944Ab2C0J6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Mar 2012 05:58:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Some functions like _omap4_disable_module() and _omap4_wait_target_disable()
are (will be) used on all OMAPs OMAP4 and beyond which support module level
control. Fix the error checks in these functions to return if called on
any platform pre OMAP4 (i.e OMAP2 and OMAP3) instead of checking for
!cpu_is_omap44xx(). This avoids having to update the error check with a
'&& !cpu_is_omap54xx()' when OMAP5 is introduced and possibly similar updates
when further OMAP generations are added.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8ac26f2..f2a9afa 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
  */
 static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 {
-	if (!cpu_is_omap44xx())
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return 0;
 
 	if (!oh)
@@ -838,7 +838,7 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 	int v;
 
 	/* The module mode does not exist prior OMAP4 */
-	if (!cpu_is_omap44xx())
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return -EINVAL;
 
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
-- 
1.7.1

