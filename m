From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] V4 regmap: Apply optional delay in multi_reg_write/register_patch
Date: Tue, 14 Jul 2015 15:45:52 +0100
Message-ID: <1436885152-19850-2-git-send-email-nariman@opensource.wolfsonmicro.com>
References: <1436885152-19850-1-git-send-email-nariman@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436885152-19850-1-git-send-email-nariman@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: nariman@opensource.wolfsonmicro.com, gregkh@linuxfoundation.org, airlied@linux.ie, dmitry.torokhov@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, tony@atomide.com, lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, support.opensource@diasemi.com, bardliao@realtek.com, oder_chiou@realtek.com, laurent.pinchart+renesas@ideasonboard.com, lars@metafoo.de, dmurphy@ti.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com
List-Id: linux-omap@vger.kernel.org

We treat a delay in a sequence the same way we treat a page change as
they are logically similar in that you can coalesce all write before
a delay (in the same way you can coalesce all writes before a page
change is needed)

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
---
 drivers/base/regmap/regmap.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0a849ee..a67473c2 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/rbtree.h>
 #include <linux/sched.h>
+#include <linux/delay.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -47,6 +48,17 @@ static int _regmap_bus_reg_write(void *context, unsigned int reg,
 static int _regmap_bus_raw_write(void *context, unsigned int reg,
 				 unsigned int val);
 
+static void regmap_sequence_delay(unsigned int delay_us)
+{
+	/* For small delays it isn't worth setting up the hrtimers
+	 * so fall back on udelay
+	 */
+	if (delay_us < 10)
+		udelay(delay_us);
+	else
+		usleep_range(delay_us, delay_us * 2);
+}
+
 bool regmap_reg_in_ranges(unsigned int reg,
 			  const struct regmap_range *ranges,
 			  unsigned int nranges)
@@ -1819,10 +1831,12 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
 	int i, n;
 	struct reg_sequence *base;
 	unsigned int this_page = 0;
+	unsigned int page_change = 0;
 	/*
 	 * the set of registers are not neccessarily in order, but
 	 * since the order of write must be preserved this algorithm
-	 * chops the set each time the page changes
+	 * chops the set each time the page changes. This also applies
+	 * if there is a delay required at any point in the sequence.
 	 */
 	base = regs;
 	for (i = 0, n = 0; i < num_regs; i++, n++) {
@@ -1838,16 +1852,48 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
 				this_page = win_page;
 			if (win_page != this_page) {
 				this_page = win_page;
+				page_change = 1;
+			}
+		}
+
+		/* If we have both a page change and a delay make sure to
+		 * write the regs and apply the delay before we change the
+		 * page.
+		 */
+
+		if (page_change || regs[i].delay_us) {
+
+				/* For situations where the first write requires
+				 * a delay we need to make sure we don't call
+				 * raw_multi_reg_write with n=0
+				 * This can't occur with page breaks as we
+				 * never write on the first iteration
+				 */
+				if (regs[i].delay_us && i == 0)
+					n = 1;
+
 				ret = _regmap_raw_multi_reg_write(map, base, n);
 				if (ret != 0)
 					return ret;
+
+				if (regs[i].delay_us)
+					regmap_sequence_delay(regs[i].delay_us);
+
 				base += n;
 				n = 0;
-			}
-			ret = _regmap_select_page(map, &base[n].reg, range, 1);
-			if (ret != 0)
-				return ret;
+
+				if (page_change) {
+					ret = _regmap_select_page(map,
+								  &base[n].reg,
+								  range, 1);
+					if (ret != 0)
+						return ret;
+
+					page_change = 0;
+				}
+
 		}
+
 	}
 	if (n > 0)
 		return _regmap_raw_multi_reg_write(map, base, n);
@@ -1866,6 +1912,9 @@ static int _regmap_multi_reg_write(struct regmap *map,
 			ret = _regmap_write(map, regs[i].reg, regs[i].def);
 			if (ret != 0)
 				return ret;
+
+			if (regs[i].delay_us)
+				regmap_sequence_delay(regs[i].delay_us);
 		}
 		return 0;
 	}
@@ -1905,8 +1954,12 @@ static int _regmap_multi_reg_write(struct regmap *map,
 	for (i = 0; i < num_regs; i++) {
 		unsigned int reg = regs[i].reg;
 		struct regmap_range_node *range;
+
+		/* Coalesce all the writes between a page break or a delay
+		 * in a sequence
+		 */
 		range = _regmap_range_lookup(map, reg);
-		if (range) {
+		if (range || regs[i].delay_us) {
 			size_t len = sizeof(struct reg_sequence)*num_regs;
 			struct reg_sequence *base = kmemdup(regs, len,
 							   GFP_KERNEL);
-- 
2.1.4
