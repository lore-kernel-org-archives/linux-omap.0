From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 2/3] regulator: cpcap: Add OF mode mapping
Date: Mon, 10 Jul 2017 16:33:40 +0200
Message-ID: <20170710143341.25543-3-sebastian.reichel@collabora.co.uk>
References: <20170710143341.25543-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710143341.25543-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add device tree mode mapping capabilities to the cpcap driver.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/regulator/cpcap-regulator.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index ce1cab320f6f..f541b80f1b54 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -123,6 +123,7 @@ struct cpcap_regulator {
 		.enable_val = (mode_val),				\
 		.disable_val = (off_val),				\
 		.ramp_delay = (volt_trans_time),			\
+		.of_map_mode = cpcap_map_mode,				\
 	},								\
 	.assign_reg = (assignment_reg),					\
 	.assign_mask = (assignment_mask),				\
@@ -213,6 +214,18 @@ static int cpcap_regulator_disable(struct regulator_dev *rdev)
 	return error;
 }
 
+static unsigned int cpcap_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case CPCAP_BIT_AUDIO_NORMAL_MODE:
+		return REGULATOR_MODE_NORMAL;
+	case CPCAP_BIT_AUDIO_LOW_PWR:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return -EINVAL;
+	}
+}
+
 static unsigned int cpcap_regulator_get_mode(struct regulator_dev *rdev)
 {
 	int value;
-- 
2.13.2
