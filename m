From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl: Remove unused fields from struct twlreg_info" to the regulator tree
Date: Wed, 23 Nov 2016 16:31:39 +0000
Message-ID: <E1c9aSR-0006dZ-8h@debutante>
References: <20161123131321.12413-1-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161123131321.12413-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl: Remove unused fields from struct twlreg_info

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

>From 15cc95c442859e8b26b59234569d926c246e45f1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 23 Nov 2016 21:13:20 +0800
Subject: [PATCH] regulator: twl: Remove unused fields from struct twlreg_info

The min_mV, max_mV and flags fields are not used, so remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index d572b8a583e4..6c9ec84121bd 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -48,12 +48,6 @@ struct twlreg_info {
 	/* State REMAP default configuration */
 	u8			remap;
 
-	/* chip constraints on regulator behavior */
-	u16			min_mV;
-	u16			max_mV;
-
-	u8			flags;
-
 	/* used by regulator core */
 	struct regulator_desc	desc;
 
@@ -497,7 +491,6 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
-	.min_mV = mVolts, \
 	.remap = remap_conf, \
 	.desc = { \
 		.name = #label, \
-- 
2.10.2
