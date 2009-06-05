From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: PM: Fix the pwrdm_enable/disable_hdwr_sar funcs
Date: Fri,  5 Jun 2009 18:30:53 +0530
Message-ID: <1244206853-4426-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59001 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZFENBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 09:01:00 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n55D0uIG022535
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 08:01:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

The pwrdm_enable_hdwr_sar/pwrdm_disable_hdwr_sar do not
actually set/reset the SAVEANDRESTORE bit in the PWSTCTRL
register but modify some other bit instead.
This happens due to the OMAP3430ES2_SAVEANDRESTORE_SHIFT
being defined as (1 << 4) instead of just 4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 06fee29..d4ea370 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -411,7 +411,7 @@
 /* PM_PREPWSTST_CAM specific bits */
 
 /* PM_PWSTCTRL_USBHOST specific bits */
-#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		(1 << 4)
+#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
 
 /* RM_RSTST_PER specific bits */
 
-- 
1.5.4.7

