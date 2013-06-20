From: J Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/4] MFD: Palmas: Add TPS659038 PMIC support
Date: Thu, 20 Jun 2013 16:35:16 +0530
Message-ID: <1371726316-10078-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, sameo@linux.intel.com
Cc: broonie@kernel.org, j-keerthy@ti.com, ldewangan@nvidia.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

The Patch adds TPS659038 PMIC support in the palmas mfd driver.
The TPS659038 has almost the same registers as of the earlier
supported variants of PALMAS family such as the TWL6035.

The critical differences between TPS659038 and TWL6035 being:

1) TPS659038 has nothing related to battery charging and back up battery stuff.
2) TPS659038 does not have does not have SMPS10(Boost) step up convertor.
3) TPS659038 does not have Battery detection and anything related to battery.
4) SD card detection, Battery presence detection, Vibrator, USB OTG are missing
   when compared to TWL6035.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/palmas.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index ad2edd6..8b20055 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -233,12 +233,17 @@ static void palmas_dt_to_pdata(struct i2c_client *i2c,
 }
 
 static unsigned int palmas_features = PALMAS_PMIC_FEATURE_SMPS10_BOOST;
+static unsigned int tps659038_features;
 
 static const struct of_device_id of_palmas_match_tbl[] = {
 	{
 		.compatible = "ti,palmas",
 		.data = &palmas_features,
 	},
+	{
+		.compatible = "ti,tps659038",
+		.data = &tps659038_features,
+	},
 	{ },
 };
 
-- 
1.7.5.4
