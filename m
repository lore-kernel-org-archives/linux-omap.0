From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/2] regulator: cpcap: Fix standby mode
Date: Fri,  7 Jul 2017 22:08:12 +0200
Message-ID: <20170707200813.20371-2-sebastian.reichel@collabora.co.uk>
References: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

While working on the audio-codec I noticed, that the
low power mode of the regulators are not properly
supported. This fixes the issue for vaudio.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/regulator/cpcap-regulator.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index cc98aceed1c1..65da6dba0b82 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -121,6 +121,7 @@ struct cpcap_regulator {
 		.enable_val = (mode_val),				\
 		.disable_val = (off_val),				\
 		.ramp_delay = (volt_trans_time),			\
+		.of_map_mode = cpcap_map_mode,				\
 	},								\
 	.assign_reg = (assignment_reg),					\
 	.assign_mask = (assignment_mask),				\
@@ -211,13 +212,23 @@ static int cpcap_regulator_disable(struct regulator_dev *rdev)
 	return error;
 }
 
+static unsigned int cpcap_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case CPCAP_BIT_AUDIO_LOW_PWR:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_NORMAL;
+	}
+}
+
 static unsigned int cpcap_regulator_get_mode(struct regulator_dev *rdev)
 {
 	int value;
 
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &value);
 
-	if (!(value & CPCAP_BIT_AUDIO_LOW_PWR))
+	if (value & CPCAP_BIT_AUDIO_LOW_PWR)
 		return REGULATOR_MODE_STANDBY;
 
 	return REGULATOR_MODE_NORMAL;
@@ -230,10 +241,10 @@ static int cpcap_regulator_set_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
-		value = CPCAP_BIT_AUDIO_LOW_PWR;
+		value = 0;
 		break;
 	case REGULATOR_MODE_STANDBY:
-		value = 0;
+		value = CPCAP_BIT_AUDIO_LOW_PWR;
 		break;
 	default:
 		return -EINVAL;
-- 
2.13.2
