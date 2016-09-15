From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] regma: Add missing little endian functions
Date: Thu, 15 Sep 2016 13:56:11 -0700
Message-ID: <20160915205611.14046-3-tony@atomide.com>
References: <20160915205611.14046-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915205611.14046-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

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
---
 drivers/base/regmap/regmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -772,6 +772,9 @@ struct regmap *__regmap_init(struct device *dev,
 		case REGMAP_ENDIAN_BIG:
 			map->format.format_reg = regmap_format_16_be;
 			break;
+		case REGMAP_ENDIAN_LITTLE:
+			map->format.format_reg = regmap_format_16_le;
+			break;
 		case REGMAP_ENDIAN_NATIVE:
 			map->format.format_reg = regmap_format_16_native;
 			break;
@@ -791,6 +794,9 @@ struct regmap *__regmap_init(struct device *dev,
 		case REGMAP_ENDIAN_BIG:
 			map->format.format_reg = regmap_format_32_be;
 			break;
+		case REGMAP_ENDIAN_LITTLE:
+			map->format.format_reg = regmap_format_32_le;
+			break;
 		case REGMAP_ENDIAN_NATIVE:
 			map->format.format_reg = regmap_format_32_native;
 			break;
@@ -805,6 +811,9 @@ struct regmap *__regmap_init(struct device *dev,
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
2.9.3
