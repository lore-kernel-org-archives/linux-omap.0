From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] regulator: twl: Remove references to 32kHz clock from DT bindings
Date: Mon,  4 Jun 2012 17:26:36 +0100
Message-ID: <1338827196-7823-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Due to the lack of a generic clock API we'd had the 32kHz clock in the
regulator driver but this is definitely a Linux-specific thing and now
we have a clock API hopefully the code can be moved elsewhere. Try to
avoid getting DTs deployed relying on the 32kHz clock by removing it
from the bindings, grep seems to tell me it's not currently used anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/regulator/twl-regulator.txt |    1 -
 drivers/regulator/twl-regulator.c                             |    2 --
 2 files changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
index 0c3395d..658749b 100644
--- a/Documentation/devicetree/bindings/regulator/twl-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -15,7 +15,6 @@ For twl6030 regulators/LDOs
   - "ti,twl6030-vusb" for VUSB LDO
   - "ti,twl6030-v1v8" for V1V8 LDO
   - "ti,twl6030-v2v1" for V2V1 LDO
-  - "ti,twl6030-clk32kg" for CLK32KG RESOURCE
   - "ti,twl6030-vdd1" for VDD1 SMPS
   - "ti,twl6030-vdd2" for VDD2 SMPS
   - "ti,twl6030-vdd3" for VDD3 SMPS
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index c739071..7d57405 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1109,7 +1109,6 @@ static u8 twl_get_smps_mult(void)
 #define TWL6030_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6030, label)
 #define TWL6025_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6025, label)
 #define TWLFIXED_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLFIXED, label)
-#define TWLRES_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLRES, label)
 #define TWLSMPS_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLSMPS, label)
 
 static const struct of_device_id twl_of_match[] __devinitconst = {
@@ -1157,7 +1156,6 @@ static const struct of_device_id twl_of_match[] __devinitconst = {
 	TWLFIXED_OF_MATCH("ti,twl6030-vusb", VUSB),
 	TWLFIXED_OF_MATCH("ti,twl6030-v1v8", V1V8),
 	TWLFIXED_OF_MATCH("ti,twl6030-v2v1", V2V1),
-	TWLRES_OF_MATCH("ti,twl6030-clk32kg", CLK32KG),
 	TWLSMPS_OF_MATCH("ti,twl6025-smps3", SMPS3),
 	TWLSMPS_OF_MATCH("ti,twl6025-smps4", SMPS4),
 	TWLSMPS_OF_MATCH("ti,twl6025-vio", VIO),
-- 
1.7.10
