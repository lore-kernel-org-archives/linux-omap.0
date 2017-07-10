From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: cpcap: Fix standby mode" to the regulator tree
Date: Mon, 10 Jul 2017 19:42:29 +0100
Message-ID: <E1dUddd-0000KE-BF@debutante>
References: <20170710143341.25543-2-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710143341.25543-2-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: cpcap: Fix standby mode

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

>From 4ebb9d7f901027e1740f69829cf10af0193e8e17 Mon Sep 17 00:00:00 2001
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Date: Mon, 10 Jul 2017 16:33:39 +0200
Subject: [PATCH] regulator: cpcap: Fix standby mode

The original patch from Tony uses standby mode bit inverted, which is
not correct. This fixes all instances in the driver code for get & set
mode. This did not yet make problems, since mode has not been changed
by any mainline driver so far.

Fixes: 0ad4c07edd41 ("regulator: cpcap: Add basic regulator support")
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/cpcap-regulator.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index cc98aceed1c1..ce1cab320f6f 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -77,6 +77,8 @@
 #define CPCAP_BIT_VAUDIO_MODE0		BIT(1)
 #define CPCAP_BIT_V_AUDIO_EN		BIT(0)
 
+#define CPCAP_BIT_AUDIO_NORMAL_MODE	0x00
+
 /*
  * Off mode configuration bit. Used currently only by SW5 on omap4. There's
  * the following comment in Motorola Linux kernel tree for it:
@@ -217,7 +219,7 @@ static unsigned int cpcap_regulator_get_mode(struct regulator_dev *rdev)
 
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &value);
 
-	if (!(value & CPCAP_BIT_AUDIO_LOW_PWR))
+	if (value & CPCAP_BIT_AUDIO_LOW_PWR)
 		return REGULATOR_MODE_STANDBY;
 
 	return REGULATOR_MODE_NORMAL;
@@ -230,10 +232,10 @@ static int cpcap_regulator_set_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
-		value = CPCAP_BIT_AUDIO_LOW_PWR;
+		value = CPCAP_BIT_AUDIO_NORMAL_MODE;
 		break;
 	case REGULATOR_MODE_STANDBY:
-		value = 0;
+		value = CPCAP_BIT_AUDIO_LOW_PWR;
 		break;
 	default:
 		return -EINVAL;
-- 
2.13.2
