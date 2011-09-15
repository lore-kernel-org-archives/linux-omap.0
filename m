From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 01/11] OMAP: TWL: Clean up mode and ops mask passed from board files
Date: Thu, 15 Sep 2011 16:51:57 +0530
Message-ID: <1316085727-15023-2-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59775 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933371Ab1IOLWo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:44 -0400
In-Reply-To: <1316085727-15023-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

The TWL driver seems to set the default .valid_modes_mask to
(REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY) and .valid_ops_mask
to (REGULATOR_CHANGE_VOLTAGE | REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS)
for all the registered regulators.

There is no need for all the board files to pass this information
additionally, when the driver already sets them by default.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    5 --
 arch/arm/mach-omap2/board-3430sdp.c          |   30 --------------
 arch/arm/mach-omap2/board-4430sdp.c          |   10 -----
 arch/arm/mach-omap2/board-cm-t35.c           |   10 -----
 arch/arm/mach-omap2/board-devkit8000.c       |   13 ------
 arch/arm/mach-omap2/board-igep0020.c         |   11 -----
 arch/arm/mach-omap2/board-ldp.c              |    9 ----
 arch/arm/mach-omap2/board-omap3beagle.c      |   10 -----
 arch/arm/mach-omap2/board-omap3evm.c         |   14 -------
 arch/arm/mach-omap2/board-omap3logic.c       |    5 --
 arch/arm/mach-omap2/board-omap3pandora.c     |   26 ------------
 arch/arm/mach-omap2/board-omap3stalker.c     |    8 ----
 arch/arm/mach-omap2/board-omap3touchbook.c   |   10 -----
 arch/arm/mach-omap2/board-overo.c            |    5 --
 arch/arm/mach-omap2/board-rm680.c            |    4 --
 arch/arm/mach-omap2/board-rx51-peripherals.c |   55 --------------------------
 arch/arm/mach-omap2/board-zoom-peripherals.c |   14 -------
 arch/arm/mach-omap2/twl-common.c             |   44 --------------------
 18 files changed, 0 insertions(+), 283 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 2028464..32154f4 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -156,11 +156,6 @@ static struct regulator_init_data sdp2430_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(sdp2430_vmmc1_supplies),
 	.consumer_supplies	= &sdp2430_vmmc1_supplies[0],
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bd600cf..01ce6df 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -306,10 +306,6 @@ static struct regulator_init_data sdp3430_vaux1 = {
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -319,10 +315,6 @@ static struct regulator_init_data sdp3430_vaux2 = {
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -332,10 +324,6 @@ static struct regulator_init_data sdp3430_vaux3 = {
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies		= ARRAY_SIZE(sdp3430_vaux3_supplies),
 	.consumer_supplies		= sdp3430_vaux3_supplies,
@@ -347,10 +335,6 @@ static struct regulator_init_data sdp3430_vaux4 = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -359,11 +343,6 @@ static struct regulator_init_data sdp3430_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(sdp3430_vmmc1_supplies),
 	.consumer_supplies	= sdp3430_vmmc1_supplies,
@@ -375,10 +354,6 @@ static struct regulator_init_data sdp3430_vmmc2 = {
 		.min_uV			= 1850000,
 		.max_uV			= 1850000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(sdp3430_vmmc2_supplies),
 	.consumer_supplies	= sdp3430_vmmc2_supplies,
@@ -389,11 +364,6 @@ static struct regulator_init_data sdp3430_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(sdp3430_vsim_supplies),
 	.consumer_supplies	= sdp3430_vsim_supplies,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..acfbed0 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -511,11 +511,6 @@ static struct regulator_init_data sdp4430_vaux1 = {
 		.min_uV			= 1000000,
 		.max_uV			= 3000000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(sdp4430_vaux_supply),
 	.consumer_supplies      = sdp4430_vaux_supply,
@@ -526,11 +521,6 @@ static struct regulator_init_data sdp4430_vusim = {
 		.min_uV			= 1200000,
 		.max_uV			= 2900000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 3af8aab..e6e909d 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -348,11 +348,6 @@ static struct regulator_init_data cm_t35_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(cm_t35_vmmc1_supply),
 	.consumer_supplies	= cm_t35_vmmc1_supply,
@@ -363,11 +358,6 @@ static struct regulator_init_data cm_t35_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(cm_t35_vsim_supply),
 	.consumer_supplies	= cm_t35_vsim_supply,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index b6002ec..7bfbe5f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -275,11 +275,6 @@ static struct regulator_init_data devkit8000_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(devkit8000_vmmc1_supply),
 	.consumer_supplies	= devkit8000_vmmc1_supply,
@@ -290,10 +285,6 @@ static struct regulator_init_data devkit8000_vpll1 = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(devkit8000_vpll1_supplies),
 	.consumer_supplies	= devkit8000_vpll1_supplies,
@@ -305,10 +296,6 @@ static struct regulator_init_data devkit8000_vio = {
 		.min_uV                 = 1800000,
 		.max_uV                 = 1800000,
 		.apply_uV               = true,
-		.valid_modes_mask       = REGULATOR_MODE_NORMAL
-			| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask         = REGULATOR_CHANGE_MODE
-			| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(devkit8000_vio_supply),
 	.consumer_supplies      = devkit8000_vio_supply,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 2521823..3e0c54c 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -231,11 +231,6 @@ static struct regulator_init_data igep_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(igep_vmmc1_supply),
 	.consumer_supplies      = igep_vmmc1_supply,
@@ -250,11 +245,6 @@ static struct regulator_init_data igep_vio = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.apply_uV		= 1,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(igep_vio_supply),
 	.consumer_supplies      = igep_vio_supply,
@@ -266,7 +256,6 @@ static struct regulator_consumer_supply igep_vmmc2_supply[] = {
 
 static struct regulator_init_data igep_vmmc2 = {
 	.constraints		= {
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
 		.always_on		= 1,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(igep_vmmc2_supply),
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 218764c..8a81b92 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -214,11 +214,6 @@ static struct regulator_init_data ldp_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(ldp_vmmc1_supply),
 	.consumer_supplies	= ldp_vmmc1_supply,
@@ -235,10 +230,6 @@ static struct regulator_init_data ldp_vaux1 = {
 		.min_uV			= 3000000,
 		.max_uV			= 3000000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies		= ARRAY_SIZE(ldp_vaux1_supplies),
 	.consumer_supplies		= ldp_vaux1_supplies,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a7923ca..0da3c9c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -338,11 +338,6 @@ static struct regulator_init_data beagle_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(beagle_vmmc1_supply),
 	.consumer_supplies	= beagle_vmmc1_supply,
@@ -353,11 +348,6 @@ static struct regulator_init_data beagle_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(beagle_vsim_supply),
 	.consumer_supplies	= beagle_vsim_supply,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c452b3f..f2508dc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -286,11 +286,6 @@ static struct regulator_init_data omap3evm_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(omap3evm_vmmc1_supply),
 	.consumer_supplies	= omap3evm_vmmc1_supply,
@@ -301,11 +296,6 @@ static struct regulator_init_data omap3evm_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(omap3evm_vsim_supply),
 	.consumer_supplies	= omap3evm_vsim_supply,
@@ -441,10 +431,6 @@ static struct regulator_init_data omap3evm_vio = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(omap3evm_vio_supply),
 	.consumer_supplies	= omap3evm_vio_supply,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 703aeb5..90584e2 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -64,11 +64,6 @@ static struct regulator_init_data omap3logic_vmmc1 = {
 		.name			= "VMMC1",
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(omap3logic_vmmc1_supply),
 	.consumer_supplies      = omap3logic_vmmc1_supply,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 080d7bd..37638d3 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -362,11 +362,6 @@ static struct regulator_init_data pandora_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(pandora_vmmc1_supply),
 	.consumer_supplies	= pandora_vmmc1_supply,
@@ -377,11 +372,6 @@ static struct regulator_init_data pandora_vmmc2 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(pandora_vmmc2_supply),
 	.consumer_supplies	= pandora_vmmc2_supply,
@@ -393,10 +383,6 @@ static struct regulator_init_data pandora_vaux1 = {
 		.min_uV			= 3000000,
 		.max_uV			= 3000000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(pandora_vcc_lcd_supply),
 	.consumer_supplies	= pandora_vcc_lcd_supply,
@@ -408,10 +394,6 @@ static struct regulator_init_data pandora_vaux2 = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(pandora_usb_phy_supply),
 	.consumer_supplies	= pandora_usb_phy_supply,
@@ -423,10 +405,6 @@ static struct regulator_init_data pandora_vaux4 = {
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(pandora_vaux4_supplies),
 	.consumer_supplies	= pandora_vaux4_supplies,
@@ -438,10 +416,6 @@ static struct regulator_init_data pandora_vsim = {
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(pandora_adac_supply),
 	.consumer_supplies	= pandora_adac_supply,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8e10498..92116f2 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -218,10 +218,6 @@ static struct regulator_init_data omap3stalker_vmmc1 = {
 	.constraints		= {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-		| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-		| REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(omap3stalker_vmmc1_supply),
 	.consumer_supplies	= omap3stalker_vmmc1_supply,
@@ -232,10 +228,6 @@ static struct regulator_init_data omap3stalker_vsim = {
 	.constraints		= {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-		| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-		| REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(omap3stalker_vsim_supply),
 	.consumer_supplies	= omap3stalker_vsim_supply,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 852ea04..d97dc67 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -181,11 +181,6 @@ static struct regulator_init_data touchbook_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(touchbook_vmmc1_supply),
 	.consumer_supplies	= touchbook_vmmc1_supply,
@@ -196,11 +191,6 @@ static struct regulator_init_data touchbook_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(touchbook_vsim_supply),
 	.consumer_supplies	= touchbook_vsim_supply,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f0b8489..baee16b 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -428,11 +428,6 @@ static struct regulator_init_data overo_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(overo_vmmc1_supply),
 	.consumer_supplies	= overo_vmmc1_supply,
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 7dfed24..5015db7 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -41,10 +41,6 @@ static struct regulator_consumer_supply rm680_vemmc_consumers[] = {
 static struct regulator_init_data rm680_vemmc = {
 	.constraints =	{
 		.name			= "rm680_vemmc",
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_STATUS
-					| REGULATOR_CHANGE_MODE,
 	},
 	.num_consumer_supplies		= ARRAY_SIZE(rm680_vemmc_consumers),
 	.consumer_supplies		= rm680_vemmc_consumers,
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 5a886cd..498c8dd 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -464,10 +464,6 @@ static struct regulator_init_data rx51_vaux1 = {
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
 		.always_on		= true, /* due battery cover sensor */
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(rx51_vaux1_consumers),
 	.consumer_supplies	= rx51_vaux1_consumers,
@@ -478,10 +474,6 @@ static struct regulator_init_data rx51_vaux2 = {
 		.name			= "VCSI",
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(rx51_vaux2_supply),
 	.consumer_supplies	= rx51_vaux2_supply,
@@ -494,10 +486,6 @@ static struct regulator_init_data rx51_vaux3_cam = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -507,11 +495,6 @@ static struct regulator_init_data rx51_vaux3_mmc = {
 		.min_uV			= 2800000,
 		.max_uV			= 3000000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(rx51_vaux3_supply),
 	.consumer_supplies	= rx51_vaux3_supply,
@@ -523,10 +506,6 @@ static struct regulator_init_data rx51_vaux4 = {
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -534,11 +513,6 @@ static struct regulator_init_data rx51_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(rx51_vmmc1_supply),
 	.consumer_supplies	= rx51_vmmc1_supply,
@@ -551,11 +525,6 @@ static struct regulator_init_data rx51_vmmc2 = {
 		.max_uV			= 3000000,
 		.always_on		= true, /* due VIO leak to AIC34 VDDs */
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(rx51_vmmc2_supplies),
 	.consumer_supplies	= rx51_vmmc2_supplies,
@@ -568,9 +537,6 @@ static struct regulator_init_data rx51_vpll1 = {
 		.max_uV			= 1800000,
 		.apply_uV		= true,
 		.always_on		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE,
 	},
 };
 
@@ -581,9 +547,6 @@ static struct regulator_init_data rx51_vpll2 = {
 		.max_uV			= 1800000,
 		.apply_uV		= true,
 		.always_on		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE,
 	},
 };
 
@@ -593,10 +556,6 @@ static struct regulator_init_data rx51_vsim = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(rx51_vsim_supply),
 	.consumer_supplies	= rx51_vsim_supply,
@@ -606,11 +565,6 @@ static struct regulator_init_data rx51_vio = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(rx51_vio_supplies),
 	.consumer_supplies	= rx51_vio_supplies,
@@ -622,9 +576,6 @@ static struct regulator_init_data rx51_vintana1 = {
 		.min_uV			= 1500000,
 		.max_uV			= 1500000,
 		.always_on		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE,
 	},
 };
 
@@ -635,9 +586,6 @@ static struct regulator_init_data rx51_vintana2 = {
 		.max_uV			= 2750000,
 		.apply_uV		= true,
 		.always_on		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE,
 	},
 };
 
@@ -647,9 +595,6 @@ static struct regulator_init_data rx51_vintdig = {
 		.min_uV			= 1500000,
 		.max_uV			= 1500000,
 		.always_on		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE,
 	},
 };
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6d0aa4f..58b5ad0 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -126,11 +126,6 @@ static struct regulator_init_data zoom_vmmc1 = {
 	.constraints = {
 		.min_uV			= 1850000,
 		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(zoom_vmmc1_supply),
 	.consumer_supplies      = zoom_vmmc1_supply,
@@ -142,10 +137,6 @@ static struct regulator_init_data zoom_vmmc2 = {
 		.min_uV			= 1850000,
 		.max_uV			= 1850000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(zoom_vmmc2_supply),
 	.consumer_supplies      = zoom_vmmc2_supply,
@@ -156,11 +147,6 @@ static struct regulator_init_data zoom_vsim = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(zoom_vsim_supply),
 	.consumer_supplies      = zoom_vsim_supply,
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index daa056e..a1d4046 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -88,10 +88,6 @@ static struct regulator_init_data omap3_vdac_idata = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(omap3_vdda_dac_supplies),
 	.consumer_supplies	= omap3_vdda_dac_supplies,
@@ -106,10 +102,6 @@ static struct regulator_init_data omap3_vpll2_idata = {
 	.constraints = {
 		.min_uV                 = 1800000,
 		.max_uV                 = 1800000,
-		.valid_modes_mask       = REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask         = REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies		= ARRAY_SIZE(omap3_vpll2_supplies),
 	.consumer_supplies		= omap3_vpll2_supplies,
@@ -158,10 +150,6 @@ static struct regulator_init_data omap4_vdac_idata = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -170,11 +158,6 @@ static struct regulator_init_data omap4_vaux2_idata = {
 		.min_uV			= 1200000,
 		.max_uV			= 2800000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -183,11 +166,6 @@ static struct regulator_init_data omap4_vaux3_idata = {
 		.min_uV			= 1000000,
 		.max_uV			= 3000000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -201,11 +179,6 @@ static struct regulator_init_data omap4_vmmc_idata = {
 		.min_uV			= 1200000,
 		.max_uV			= 3000000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(omap4_vmmc_supply),
 	.consumer_supplies      = omap4_vmmc_supply,
@@ -216,11 +189,6 @@ static struct regulator_init_data omap4_vpp_idata = {
 		.min_uV			= 1800000,
 		.max_uV			= 2500000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -228,10 +196,6 @@ static struct regulator_init_data omap4_vana_idata = {
 	.constraints = {
 		.min_uV			= 2100000,
 		.max_uV			= 2100000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -239,10 +203,6 @@ static struct regulator_init_data omap4_vcxio_idata = {
 	.constraints = {
 		.min_uV			= 1800000,
 		.max_uV			= 1800000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
@@ -251,10 +211,6 @@ static struct regulator_init_data omap4_vusb_idata = {
 		.min_uV			= 3300000,
 		.max_uV			= 3300000,
 		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
 	},
 };
 
-- 
1.7.1

