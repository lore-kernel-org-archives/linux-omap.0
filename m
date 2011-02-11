From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: fix compile-time warnings
Date: Fri, 11 Feb 2011 14:35:00 +0530
Message-ID: <1297415100-15912-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55544 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727Ab1BKJFQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 04:05:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

This patch fixes these warnings when building kernel for OMAP3EVM
only.

  CC      arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.o
arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:95: warning:
 'dsp_24xx_wkdeps' defined but not used
arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:119: warning:
 'mpu_24xx_wkdeps' defined but not used
arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:147: warning:
 'core_24xx_wkdeps' defined but not used

The problem should be noticed when building for other OMAP3
platforms (only) as well.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index e6f0d18..8134bb3 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -89,6 +89,8 @@ static struct clkdm_dep gfx_sgx_wkdeps[] = {
 
 /* 24XX-specific possible dependencies */
 
+#ifdef CONFIG_ARCH_OMAP2
+
 /* Wakeup dependency source arrays */
 
 /* 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP */
@@ -168,6 +170,7 @@ static struct clkdm_dep core_24xx_wkdeps[] = {
 	{ NULL },
 };
 
+#endif /* CONFIG_ARCH_OMAP2 */
 
 /* 2430-specific possible wakeup dependencies */
 
-- 
1.7.2.2

