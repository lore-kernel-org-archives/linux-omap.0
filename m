From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH 3/3] OMAP4: Enable Turbo and Nitro OPP for OMAP4
Date: Wed, 16 Feb 2011 11:48:32 +0530
Message-ID: <1297837112-8924-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32772 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398Ab1BPGSh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 01:18:37 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1G6IYZ8004668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:18:36 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

All OMAP4 boards support OPP-Turbo (800M) and OPP-Nitro (1G).
Enable them by default in OPPTable. For 800Mhz devices where
OPP-Nitro is not supported, OPP-Nitro should be disabled
from board file.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/mach-omap2/opp4xxx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 705fe9a..48d79e5 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -31,9 +31,9 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
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

