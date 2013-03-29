From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: AM33xx: hwmod: Add missing sysc definition to wdt1 entry
Date: Fri, 29 Mar 2013 22:40:16 +0530
Message-ID: <1364577017-22562-2-git-send-email-hvaibhav@ti.com>
References: <1364577017-22562-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46967 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391Ab3C2RSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Mar 2013 13:18:30 -0400
In-Reply-To: <1364577017-22562-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, tony@atomide.com, santosh.shilimkar@ti.com, benoit.cousson@linaro.org, Vaibhav Hiremath <hvaibhav@ti.com>

This patch adds sysc definitions to the wdt1 hwmod entry, which in-turn
makes sure that sysc idle bit-fields are configured to valid state on
enable/disable callbacks.

With the recent submitted patch from Santosh Shilimkar,
"ARM: OMAP2+: hwmod: Don't call _init_mpu_rt_base if no sysc"
(commit: 4a98c2d89), it is required to add sysconf
information to each valid hwmod entry, else device will not be
come out from idle state properly and leads to below kernel
crash  -

[2.190237] Unhandled fault: external abort on non-linefetch (0x1028) at
0xf9e35034
[2.198325] Internal error: : 1028 [#1] SMP ARM
[2.203101] Modules linked in:
[2.206334] CPU: 0    Not tainted  (3.9.0-rc3-00059-gd114294#1)
[2.212679] PC is at omap_wdt_disable.clone.5+0xc/0x60
[2.218090] LR is at omap_wdt_probe+0x184/0x1fc

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <benoit.cousson@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 61c98f1..3ce2ff8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -28,6 +28,7 @@
 #include "prm-regbits-33xx.h"
 #include "i2c.h"
 #include "mmc.h"
+#include "wd_timer.h"
 
 /*
  * IP blocks
@@ -2087,8 +2088,21 @@ static struct omap_hwmod am33xx_uart6_hwmod = {
 };
 
 /* 'wd_timer' class */
+static struct omap_hwmod_class_sysconfig wdt_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x10,
+	.syss_offs	= 0x14,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SIDLEMODE |
+			SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
 static struct omap_hwmod_class am33xx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
+	.sysc		= &wdt_sysc,
+	.pre_shutdown	= &omap2_wd_timer_disable,
 };
 
 /*
@@ -2099,6 +2113,7 @@ static struct omap_hwmod am33xx_wd_timer1_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &am33xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.main_clk	= "wdt1_fck",
 	.prcm		= {
 		.omap4	= {
-- 
1.7.0.4

