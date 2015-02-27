From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 4/8 v4] ARM OMAP2+ GPMC: change get_gpmc_timing_reg output for DTS
Date: Fri, 27 Feb 2015 16:56:51 +0100
Message-ID: <1425052615-29093-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

DTS output was formatted to require additional work when copy-pasting into DTS.
Nano-second timings were replaced with interval of values that produce the same
number of clock ticks.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index dbb6753..432e638 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -337,32 +337,50 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
 }
 
 #ifdef DEBUG
+/**
+ * get_gpmc_timing_reg - read a timing parameter and print DTS settings for it.
+ * @cs:      Chip Select Region
+ * @reg:     GPMC_CS_CONFIGn register offset.
+ * @st_bit:  Start Bit
+ * @end_bit: End Bit. Must be >= @st_bit.
+ * @name:    DTS node name, w/o "gpmc,"
+ * @raw:     Raw Format Option.
+ *           raw format:  gpmc,name = <value>
+ *           tick format: gpmc,name = <value> /&zwj;* x ns -- y ns; x ticks *&zwj;/
+ *           Where x ns -- y ns result in the same tick value.
+ * @noval:   Parameter values equal to 0 are not printed.
+ * @shift:   Parameter value left shifts @shift, which is then printed instead of value.
+ * @return:  Specified timing parameter (after optional @shift).
+ *
+ */
 static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			       bool raw, bool noval, int shift,
 			       const char *name)
 {
 	u32 l;
-	int nr_bits, max_value, mask;
+	int nr_bits;
+	int mask;
 
 	l = gpmc_cs_read_reg(cs, reg);
 	nr_bits = end_bit - st_bit + 1;
-	max_value = (1 << nr_bits) - 1;
-	mask = max_value << st_bit;
-	l = (l & mask) >> st_bit;
+	mask = (1 << nr_bits) - 1;
+	l = (l >> st_bit) & mask;
 	if (shift)
 		l = (shift << l);
 	if (noval && (l == 0))
 		return 0;
 	if (!raw) {
-		unsigned int time_ns_min, time_ns, time_ns_max;
+		/* DTS tick format for timings in ns */
+		unsigned int time_ns;
+		unsigned int time_ns_min = 0;
 
-		time_ns_min = gpmc_ticks_to_ns(l ? l - 1 : 0);
+		if (l)
+			time_ns_min = gpmc_ticks_to_ns(l - 1) + 1;
 		time_ns = gpmc_ticks_to_ns(l);
-		time_ns_max = gpmc_ticks_to_ns(l + 1 > max_value ?
-					       max_value : l + 1);
-		pr_info("gpmc,%s = <%u> (%u - %u ns, %i ticks)\n",
-			name, time_ns, time_ns_min, time_ns_max, l);
+		pr_info("gpmc,%s = <%u> /* %u ns - %u ns; %i ticks */\n",
+		        name, time_ns, time_ns_min, time_ns, l);
 	} else {
+		/* raw format */
 		pr_info("gpmc,%s = <%u>\n", name, l);
 	}
 
-- 
2.3.0
