From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] regulator: pbias-regulator: constify regulator_ops structure
Date: Sat, 28 Jan 2017 20:25:21 +0530
Message-ID: <1485615321-30623-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Declare regulator_ops structure as const as it is only stored in the ops
field of a regulator_desc structure. This field is of type const, so
regulator_ops structures having this property can be made const too.

File size before: drivers/regulator/pbias-regulator.o
   text	   data	    bss	    dec	    hex	filename
   2545	    624	      0	   3169	    c61 regulator/pbias-regulator.o

File size after: drivers/regulator/pbias-regulator.o
   text	   data	    bss	    dec	    hex	filename
   2801	    368	      0	   3169	    c61 regulator/pbias-regulator.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/regulator/pbias-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index f9d74d6..0cb76ba 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -54,7 +54,7 @@ struct pbias_of_data {
 	3000000
 };
 
-static struct regulator_ops pbias_regulator_voltage_ops = {
+static const struct regulator_ops pbias_regulator_voltage_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-- 
1.9.1
