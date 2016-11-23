From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: twl: Remove unused fields from struct twlreg_info
Date: Wed, 23 Nov 2016 21:13:20 +0800
Message-ID: <20161123131321.12413-1-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-omap@vger.kernel.org

The min_mV, max_mV and flags fields are not used, so remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl-regulator.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index d572b8a..6c9ec84 100644
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
2.9.3
