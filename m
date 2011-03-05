From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH V2 1/3] OMAP4: Enable 800 MHz and 1 GHz MPU-OPP
Date: Sat,  5 Mar 2011 15:21:21 +0530
Message-ID: <1299318681-21348-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44378 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab1CEJv3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Mar 2011 04:51:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Shweta Gulati <shweta.gulati@ti.com>

Almost all OMAP4 boards support OPP 800 MHz and OPP 1 GHz.
Enable them in OPP Table. For small minority of boards which use
OMAP4430-800 MHz device OPP 1GHz is not supported,
OPP 1GHz should be disabled from board file.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-arm-kernel@lists.infradead.org 
---
 arch/arm/mach-omap2/opp4xxx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 57f1498..93b9744 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -71,9 +71,9 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* MPU OPP2 - OPP100 */
 	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
 	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", false, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
+	OPP_INITIALIZER("mpu", true, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
 	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", false, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
+	OPP_INITIALIZER("mpu", true, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
 	/* L3 OPP1 - OPP50 */
 	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-- 
1.7.0.4

