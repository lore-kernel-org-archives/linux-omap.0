From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: [RFC][PATCH] Add support for TMP105
Date: Tue, 25 May 2010 17:42:58 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B32B4012@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Adds the driver support for the TMP105 temperature sensor device. The
interface is I2C.The driver supports the read of the temperature values.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/Kconfig |    3 ++-
 drivers/hwmon/lm75.c  |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a4a5352..7a137d5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -483,7 +483,8 @@ config SENSORS_LM75
 		- NXP's LM75A
 		- ST Microelectronics STDS75
 		- TelCom (now Microchip) TCN75
-		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
+		- Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175, 
+			TMP275
 
 	  This driver supports driver model based binding through board
 	  specific I2C device tables.
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 8ae2cfe..5646342 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -46,6 +46,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	tcn75,
 	tmp100,
 	tmp101,
+	tmp105,
 	tmp175,
 	tmp275,
 	tmp75,
@@ -220,6 +221,7 @@ static const struct i2c_device_id lm75_ids[] = {
 	{ "tcn75", tcn75, },
 	{ "tmp100", tmp100, },
 	{ "tmp101", tmp101, },
+	{ "tmp105", tmp105, },
 	{ "tmp175", tmp175, },
 	{ "tmp275", tmp275, },
 	{ "tmp75", tmp75, },
-- 
1.5.4.7

