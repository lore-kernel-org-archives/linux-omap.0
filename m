From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: Add missing little endian functions" to the regmap tree
Date: Fri, 16 Sep 2016 18:39:49 +0100
Message-ID: <E1bkx77-000407-NA@debutante>
References: <20160915205611.14046-3-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915205611.14046-3-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regmap: Add missing little endian functions

has been applied to the regmap tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

>From 55562449032c43b84f839e2fbb84bf1d351d6603 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 Sep 2016 13:56:11 -0700
Subject: [PATCH] regmap: Add missing little endian functions

This with the longer read and write masks allow supporting more
exotic devices. For example a little endian SPI device:

static const struct regmap_config foo_regmap_config = {
	.reg_bits = 16,
	.reg_stride = 4,
	.val_bits = 16,
	.write_flag_mask = 0x8000,
	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
	.val_format_endian = REGMAP_ENDIAN_LITTLE,
	...
};

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index a6a5236b6c8d..31cfe70e6d53 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -749,6 +749,9 @@ struct regmap *__regmap_init(struct device *dev,
 		case REGMAP_ENDIAN_BIG:
 			map->format.format_reg = regmap_format_16_be;
 			break;
+		case REGMAP_ENDIAN_LITTLE:
+			map->format.format_reg = regmap_format_16_le;
+			break;
 		case REGMAP_ENDIAN_NATIVE:
 			map->format.format_reg = regmap_format_16_native;
 			break;
@@ -768,6 +771,9 @@ struct regmap *__regmap_init(struct device *dev,
 		case REGMAP_ENDIAN_BIG:
 			map->format.format_reg = regmap_format_32_be;
 			break;
+		case REGMAP_ENDIAN_LITTLE:
+			map->format.format_reg = regmap_format_32_le;
+			break;
 		case REGMAP_ENDIAN_NATIVE:
 			map->format.format_reg = regmap_format_32_native;
 			break;
@@ -782,6 +788,9 @@ struct regmap *__regmap_init(struct device *dev,
 		case REGMAP_ENDIAN_BIG:
 			map->format.format_reg = regmap_format_64_be;
 			break;
+		case REGMAP_ENDIAN_LITTLE:
+			map->format.format_reg = regmap_format_64_le;
+			break;
 		case REGMAP_ENDIAN_NATIVE:
 			map->format.format_reg = regmap_format_64_native;
 			break;
-- 
2.8.1
