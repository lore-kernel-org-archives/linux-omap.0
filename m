From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: cpcap: Add OF mode mapping" to the regulator tree
Date: Mon, 10 Jul 2017 19:42:26 +0100
Message-ID: <E1dUdda-0000JE-Ah@debutante>
References: <20170710143341.25543-3-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710143341.25543-3-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: cpcap: Add OF mode mapping

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8c02843cb0f9f2c8857d9228ec56ce931e957f62 Mon Sep 17 00:00:00 2001
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Date: Mon, 10 Jul 2017 16:33:40 +0200
Subject: [PATCH] regulator: cpcap: Add OF mode mapping

Add device tree mode mapping capabilities to the cpcap driver.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
