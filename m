From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: AM33xx: hwmod: Add INIT_NO_IDLE flag for debugss hwmod
Date: Wed, 9 Apr 2014 11:17:47 +0530
Message-ID: <1397022467-6166-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60899 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaDIFsY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Apr 2014 01:48:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, rnayak@ti.com, hvaibhav@ti.com, lokeshvutla@ti.com

During boot, when hwmod tries to cut clocks for debugss it always
gets stuck in transition state and throws the following warning:

[    0.139581] omap_hwmod: debugss: _wait_target_disable failed

As per the information provided by folks, clocks to debugss cannot be cut.
So adding HWMOD_INIT_NO_IDLE flag to debugss hwmod.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Tested on BeagleBone Black.

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 6b406ca..ec18ce0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -222,6 +222,7 @@ static struct omap_hwmod am33xx_debugss_hwmod = {
 	.name		= "debugss",
 	.class		= &am33xx_debugss_hwmod_class,
 	.clkdm_name	= "l3_aon_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "trace_clk_div_ck",
 	.prcm		= {
 		.omap4	= {
-- 
1.7.9.5

