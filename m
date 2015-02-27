From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 8/8 v4] ARM OMAP2+ GPMC: fix programming/showing reserved timing parameters
Date: Fri, 27 Feb 2015 16:56:55 +0100
Message-ID: <1425052615-29093-9-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

GPMC_CONFIG1_i parameters CLKACTIVATIONTIME and WAITMONITORINGTIME
have reserved values.
Raise an error if calculated timings try to program reserved values.

GPMC_CONFIG1_i ATTACHEDDEVICEPAGELENGTH and DEVICESIZE were already checked
when parsing the DT.

Explicitly comment invalid values on gpmc_cs_show_timings for
-CLKACTIVATIONTIME
-WAITMONITORINGTIME
-DEVICESIZE
-ATTACHEDDEVICEPAGELENGTH

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 68 ++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index d091065..750c655 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -135,7 +135,11 @@
 #define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
 #define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
 #define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
+/** CLKACTIVATIONTIME Max Ticks */
+#define GPMC_CONFIG1_CLKACTIVATIONTIME_MAX 2
 #define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
+/** ATTACHEDDEVICEPAGELENGTH Max Value */
+#define GPMC_CONFIG1_ATTACHEDDEVICEPAGELENGTH_MAX 2
 #define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
 #define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
 #define GPMC_CONFIG1_WAIT_MON_TIME(val) ((val & 3) << 18)
@@ -144,6 +148,8 @@
 #define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
 #define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
+/** DEVICESIZE Max Value */
+#define GPMC_CONFIG1_DEVICESIZE_MAX     1
 #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
 #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
 #define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
@@ -393,6 +399,8 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
  * @reg:     GPMC_CS_CONFIGn register offset.
  * @st_bit:  Start Bit
  * @end_bit: End Bit. Must be >= @st_bit.
+ * @ma:x     Maximum parameter value (before optional @shift).
+ *           If 0, maximum is as high as @st_bit and @end_bit allow.
  * @name:    DTS node name, w/o "gpmc,"
  * @cd:      Clock Domain of timing parameter.
  * @shift:   Parameter value left shifts @shift, which is then printed instead of value.
@@ -400,13 +408,14 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
  *           raw format:  gpmc,name = <value>
  *           tick format: gpmc,name = <value> /&zwj;* x ns -- y ns; x ticks *&zwj;/
  *           Where x ns -- y ns result in the same tick value.
+ *           When @max is exceeded, "invalid" is printed inside comment.
  * @noval:   Parameter values equal to 0 are not printed.
  * @return:  Specified timing parameter (after optional @shift).
  *
  */
 static int get_gpmc_timing_reg(
 	/* timing specifiers */
-	int cs, int reg, int st_bit, int end_bit,
+	int cs, int reg, int st_bit, int end_bit, int max,
 	const char *name, const enum gpmc_clk_domain cd,
 	/* value transform */
 	int shift,
@@ -416,11 +425,15 @@ static int get_gpmc_timing_reg(
 	u32 l;
 	int nr_bits;
 	int mask;
+	bool invalid;
 
 	l = gpmc_cs_read_reg(cs, reg);
 	nr_bits = end_bit - st_bit + 1;
 	mask = (1 << nr_bits) - 1;
 	l = (l >> st_bit) & mask;
+	if (!max)
+		max = mask;
+	invalid = l > max;
 	if (shift)
 		l = (shift << l);
 	if (noval && (l == 0))
@@ -433,11 +446,11 @@ static int get_gpmc_timing_reg(
 		if (l)
 			time_ns_min = gpmc_clk_ticks_to_ns(l - 1, cs, cd) + 1;
 		time_ns = gpmc_clk_ticks_to_ns(l, cs, cd);
-		pr_info("gpmc,%s = <%u> /* %u ns - %u ns; %i ticks */\n",
-		        name, time_ns, time_ns_min, time_ns, l);
+		pr_info("gpmc,%s = <%u> /* %u ns - %u ns; %i ticks%s*/\n",
+		        name, time_ns, time_ns_min, time_ns, l, invalid ? "; invalid " : " ");
 	} else {
 		/* raw format */
-		pr_info("gpmc,%s = <%u>\n", name, l);
+		pr_info("gpmc,%s = <%u>%s\n", name, l, invalid ? " /* invalid */" : "");
 	}
 
 	return l;
@@ -447,15 +460,19 @@ static int get_gpmc_timing_reg(
 	pr_info("cs%i %s: 0x%08x\n", cs, #config, \
 		gpmc_cs_read_reg(cs, config))
 #define GPMC_GET_RAW(reg, st, end, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, 0, 1, 0)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), 0, field, GPMC_CD_FCLK, 0, 1, 0)
+#define GPMC_GET_RAW_MAX(reg, st, end, max, field) \
+	get_gpmc_timing_reg(cs, (reg), (st), (end), (max), field, GPMC_CD_FCLK, 0, 1, 0)
 #define GPMC_GET_RAW_BOOL(reg, st, end, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, 0, 1, 1)
-#define GPMC_GET_RAW_SHIFT(reg, st, end, shift, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, (shift), 1, 1)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), 0, field, GPMC_CD_FCLK, 0, 1, 1)
+#define GPMC_GET_RAW_SHIFT_MAX(reg, st, end, shift, max, field) \
+	get_gpmc_timing_reg(cs, (reg), (st), (end), (max), field, GPMC_CD_FCLK, (shift), 1, 1)
 #define GPMC_GET_TICKS(reg, st, end, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, 0, 0, 0)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), 0, field, GPMC_CD_FCLK, 0, 0, 0)
 #define GPMC_GET_TICKS_CD(reg, st, end, field, cd) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), field, (cd), 0, 0, 0)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), 0, field, (cd), 0, 0, 0)
+#define GPMC_GET_TICKS_CD_MAX(reg, st, end, max, field, cd) \
+	get_gpmc_timing_reg(cs, (reg), (st), (end), (max), field, (cd), 0, 0, 0)
 
 static void gpmc_show_regs(int cs, const char *desc)
 {
@@ -479,11 +496,11 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	pr_info("gpmc cs%i access configuration:\n", cs);
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
-	GPMC_GET_RAW(GPMC_CS_CONFIG1, 12, 13, "device-width");
+	GPMC_GET_RAW_MAX(GPMC_CS_CONFIG1, 12, 13, GPMC_CONFIG1_DEVICESIZE_MAX, "device-width");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 22, 22, "wait-on-read");
-	GPMC_GET_RAW_SHIFT(GPMC_CS_CONFIG1, 23, 24, 4, "burst-length");
+	GPMC_GET_RAW_SHIFT_MAX(GPMC_CS_CONFIG1, 23, 24, 4, GPMC_CONFIG1_ATTACHEDDEVICEPAGELENGTH_MAX, "burst-length");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 27, 27, "sync-write");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 28, 28, "burst-write");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 29, 29, "gpmc,sync-read");
@@ -523,8 +540,8 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 0, 3, "bus-turnaround-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 8, 11, "cycle2cycle-delay-ns");
 
-	GPMC_GET_TICKS_CD(GPMC_CS_CONFIG1, 18, 19, "wait-monitoring-ns", GPMC_CD_CLK);
-	GPMC_GET_TICKS(GPMC_CS_CONFIG1, 25, 26, "clk-activation-ns");
+	GPMC_GET_TICKS_CD_MAX(GPMC_CS_CONFIG1, 18, 19, GPMC_CONFIG1_WAITMONITORINGTIME_MAX, "wait-monitoring-ns", GPMC_CD_CLK);
+	GPMC_GET_TICKS_CD_MAX(GPMC_CS_CONFIG1, 25, 26, GPMC_CONFIG1_CLKACTIVATIONTIME_MAX, "clk-activation-ns", GPMC_CD_FCLK);
 
 	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 16, 19, "wr-data-mux-bus-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 24, 28, "wr-access-ns");
@@ -544,12 +561,14 @@ static inline void gpmc_cs_show_timings(int cs, const char *desc)
  * @reg:     GPMC_CS_CONFIGn register offset.
  * @st_bit:  Start Bit
  * @end_bit: End Bit. Must be >= @st_bit.
+ * @max:     Maximum parameter value.
+ *           If 0, maximum is as high as @st_bit and @end_bit allow.
  * @time:    Timing parameter in ns.
  * @cd:      Timing parameter clock domain.
  * @name:    Timing parameter name.
  * @return:  0 on success, -1 on error.
  */
-static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
+static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit, int max,
 			       int time, enum gpmc_clk_domain cd, const char *name)
 {
 	u32 l;
@@ -562,9 +581,12 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	nr_bits = end_bit - st_bit + 1;
 	mask = (1 << nr_bits) - 1;
 
-	if (ticks > mask) {
+	if (!max)
+		max = mask;
+
+	if (ticks > max) {
 		pr_err("%s: GPMC CS%d: %s %d ns, %d ticks > %d ticks\n",
-		       __func__, cs, name, time, ticks, mask);
+		       __func__, cs, name, time, ticks, max);
 
 		return -1;
 	}
@@ -583,13 +605,13 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	return 0;
 }
 
-#define GPMC_SET_ONE_CD(reg, st, end, field, cd) \
-	if (set_gpmc_timing_reg(cs, (reg), (st), (end), \
-	    t->field, (cd), #field) < 0)                \
+#define GPMC_SET_ONE_CD_MAX(reg, st, end, max, field, cd)  \
+	if (set_gpmc_timing_reg(cs, (reg), (st), (end), (max), \
+	    t->field, (cd), #field) < 0)                       \
 		return -1
 
 #define GPMC_SET_ONE(reg, st, end, field) \
-	GPMC_SET_ONE_CD(reg, st, end, field, GPMC_CD_FCLK)
+	GPMC_SET_ONE_CD_MAX(reg, st, end, 0, field, GPMC_CD_FCLK)
 
 /**
  * gpmc_calc_waitmonitoring_divider - calculate proper GPMCFCLKDIVIDER based on WAITMONITORINGTIME
@@ -717,8 +739,8 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t, const struct gpmc_
 	l |= (div - 1);
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 
-	GPMC_SET_ONE_CD(GPMC_CS_CONFIG1, 18, 19, wait_monitoring, GPMC_CD_CLK);
-	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
+	GPMC_SET_ONE_CD_MAX(GPMC_CS_CONFIG1, 18, 19, GPMC_CONFIG1_WAITMONITORINGTIME_MAX, wait_monitoring, GPMC_CD_CLK);
+	GPMC_SET_ONE_CD_MAX(GPMC_CS_CONFIG1, 25, 26, GPMC_CONFIG1_CLKACTIVATIONTIME_MAX, clk_activation, GPMC_CD_FCLK);
 
 #ifdef DEBUG
 	pr_info("GPMC CS%d CLK period is %lu ns (div %d)\n",
-- 
2.3.0
