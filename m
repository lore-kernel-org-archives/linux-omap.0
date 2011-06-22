From: Girish S G <girishsg@ti.com>
Subject: [PATCH 1/2] OMAP4 :TWL6030: Regulator set the default behavior of LDO's
Date: Tue, 21 Jun 2011 19:24:41 -0500
Message-ID: <1308702281-12665-1-git-send-email-girishsg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39985 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756939Ab1FUX3u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jun 2011 19:29:50 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5LNTnwp002095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:49 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5LNTnio029070
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:49 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5LNTnPC003092
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:49 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Girish S G <girishsg@ti.com>

TWL6030 below table shows the default state each LDO's can
be put into.

	+---------------------------------------------------------------+
	| LDO 	|	Usage		|	state			|
	+---------------------------------------------------------------+
	| VANA 	| sources internal	| Always ON			|
	|	| analog voltage	|				|
	+---------------------------------------------------------------+
	| VAUX1	| eMMC			| MMC Driver needs to handle	|
	|	|			|  				|
	+---------------------------------------------------------------+
	| VAUX2	| A/V switch		| Driver needs to handle	|
	+---------------------------------------------------------------+
	| VAUX3 | 5MP CAMp		| Driver needs to handle	|
	+---------------------------------------------------------------+
	| VCXIO	| supplies DPLL's	| Can be put OFF when OMAP hits	|
	|	|			| OFF mode.			|
	+---------------------------------------------------------------+
	| VDAC	| HDMI, CDC chip	| Always ON			|
	+---------------------------------------------------------------+
	| VMMC	| MMC			| Driver needs to handle	|
	+---------------------------------------------------------------+
	| VPP	| VPP pins of OMAP	| Used while burning fuses in 	|
	|	|			| OMAP. This can be turned OFF 	|
	|	|			| by default when kernel comes 	|
	|	|			| up.				|
	+---------------------------------------------------------------+
	| VRTC	| VBRTC/RTC		| Always ON			|
	+---------------------------------------------------------------+
	| VUSB	| USB OTG pins		| Driver needs to handle	|
	+---------------------------------------------------------------+
	| VUSIM	| VDDS_SIM, SIM cage	| Driver needs to handle.	|
	+---------------------------------------------------------------+
	| CLK32K| 32KHz o/p clk		| WIFI/BT/FM/GPS driver needs	|
	|	|			| to handle			|
	+---------------------------------------------------------------+

 - VDAC, VANA, VCXIO and VRTC should be kept always ON. As per the table above.

Need REVISIT on below LDO's:
 - VAUX1 kept ON now. MMC driver needs to take care of enabling/disabling
   as needed. Issue seen with eMMC bootup with VAUX1 disabled by default.

 - VAUX3 is kept ON now. CAM/syslink should handle this regulator. This
   is only for 5MP camera on Blaze.

 - CLK32KG is pseudo regulator, on Blaze/panda it supplies GPS/WIFI/BT/FM/GPS
   Drivers should handle it. Keeping it always ON as of now.

Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    4 ++++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..04b7770 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -440,6 +440,7 @@ static struct regulator_init_data sdp4430_vmmc = {
 		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
 	.num_consumer_supplies  = 1,
 	.consumer_supplies      = sdp4430_vmmc_supply,
@@ -479,6 +480,7 @@ static struct regulator_init_data sdp4430_vana = {
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
 };
 
@@ -501,6 +503,7 @@ static struct regulator_init_data sdp4430_vdac = {
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
 };
 
@@ -519,6 +522,7 @@ static struct regulator_init_data sdp4430_vusb = {
 static struct regulator_init_data sdp4430_clk32kg = {
 	.constraints = {
 		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
 };
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 0cfe200..3415a5e 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -337,6 +337,7 @@ static struct regulator_init_data omap4_panda_vana = {
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
 };
 
@@ -359,6 +360,7 @@ static struct regulator_init_data omap4_panda_vdac = {
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
 };
 
@@ -377,6 +379,7 @@ static struct regulator_init_data omap4_panda_vusb = {
 static struct regulator_init_data omap4_panda_clk32kg = {
 	.constraints = {
 		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+		.always_on	= true,
 	},
 };
 
-- 
1.6.0.4

