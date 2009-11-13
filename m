From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Fri, 13 Nov 2009 00:05:15 -0600
Message-ID: <1258092322-30833-3-git-send-email-nm@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
 <1258092322-30833-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37981 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbZKMGFU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:05:20 -0500
In-Reply-To: <1258092322-30833-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Modifies the initial patch From Sanjeev:
http://patchwork.kernel.org/patch/50998/

NOTE:
The original opp_table introduced by Sanjeev is not needed anymore as
we can use enabled flag to have better granularity in enable/disable
of OPPs.

This introduces the following accessor functions:

freq_to_opp and opp_to_freq: Matching functions to convert OPP to freq
and viceversa.

freq_to_vsel: Converts a frequency to corresponding voltage.

opp_enable: To enable/disable a specific OPP in a OPP table this allows
granular runtime disable/enable of specific OPPs, esp when used in
conjunction with search and mapping functions

get_next_freq: A search function to get next matching frequency. This
could possibly provide the basis for more complex OPP transition algos
of the future.

get_limit_freq: A search function to get the least or maximum
frequency based on search criteria. Allows for independence from
OPP_IDs in the future.

Since the accessor functions hide the details of the table
implementation, the opp table is now moved away from omap3-opp.h to
pm34xx.c. The terminator entry is needed at the start and end of the
table as it is still needed for reverse and forward search as the
length of the table is unknown.

Tests done: Accessor functions standalone tested on a PC host with
dummy OPP table to simulate boundary, invalid and valid conditions,
SDP3430, SDP3630 for system stability.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: SuiLun Lam <s-lam@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap3-opp.h           |   40 +-------
 arch/arm/mach-omap2/pm.c                  |  160 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |   42 ++++++++
 arch/arm/plat-omap/include/plat/omap-pm.h |  109 ++++++++++++++++++++
 4 files changed, 314 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index 42557e1..27e2ca5 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -21,42 +21,8 @@
 #define S83M    83000000
 #define S166M   166000000
 
-static struct omap_opp omap3_mpu_rate_table[] = {
-	{0, 0, 0, 0},
-	/*OPP1*/
-	{true, S125M, VDD1_OPP1, 0x1E},
-	/*OPP2*/
-	{true, S250M, VDD1_OPP2, 0x26},
-	/*OPP3*/
-	{true, S500M, VDD1_OPP3, 0x30},
-	/*OPP4*/
-	{true, S550M, VDD1_OPP4, 0x36},
-	/*OPP5*/
-	{true, S600M, VDD1_OPP5, 0x3C},
-};
-
-static struct omap_opp omap3_l3_rate_table[] = {
-	{0, 0, 0, 0},
-	/*OPP1*/
-	{false, 0, VDD2_OPP1, 0x1E},
-	/*OPP2*/
-	{true, S83M, VDD2_OPP2, 0x24},
-	/*OPP3*/
-	{true, S166M, VDD2_OPP3, 0x2C},
-};
-
-static struct omap_opp omap3_dsp_rate_table[] = {
-	{0, 0, 0, 0},
-	/*OPP1*/
-	{true, S90M, VDD1_OPP1, 0x1E},
-	/*OPP2*/
-	{true, S180M, VDD1_OPP2, 0x26},
-	/*OPP3*/
-	{true, S360M, VDD1_OPP3, 0x30},
-	/*OPP4*/
-	{true, S400M, VDD1_OPP4, 0x36},
-	/*OPP5*/
-	{true, S430M, VDD1_OPP5, 0x3C},
-};
+extern struct omap_opp omap3_mpu_rate_table[];
+extern struct omap_opp omap3_dsp_rate_table[];
+extern struct omap_opp omap3_l3_rate_table[];
 
 #endif
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index f50e93d..b2cd30c 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -33,6 +33,7 @@
 #include <plat/powerdomain.h>
 #include <plat/resource.h>
 #include <plat/omap34xx.h>
+#include <plat/omap-pm.h>
 
 #include "prm-regbits-34xx.h"
 #include "pm.h"
@@ -203,3 +204,162 @@ static int __init omap_pm_init(void)
 	return error;
 }
 late_initcall(omap_pm_init);
+
+int opp_to_freq(unsigned long *freq, const struct omap_opp *opps, u8 opp_id)
+{
+	int i = 1;
+
+	BUG_ON(!freq || !opps);
+
+	/* The first entry is a dummy one, loop till we hit terminator */
+	while (!IS_OPP_TERMINATOR(opps, i)) {
+		if (opps[i].enabled && (opps[i].opp_id == opp_id)) {
+			*freq = opps[i].rate;
+			return 0;
+		}
+		i++;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(opp_to_freq);
+
+int freq_to_vsel(u8 *vsel, const struct omap_opp *opps, unsigned long freq)
+{
+	int i = 1;
+
+	BUG_ON(!vsel || !opps);
+
+	/* The first entry is a dummy one, loop till we hit terminator */
+	while (!IS_OPP_TERMINATOR(opps, i)) {
+		if (opps[i].enabled && (opps[i].rate == freq)) {
+			*vsel = opps[i].vsel;
+			return 0;
+		}
+		i++;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(freq_to_vsel);
+
+int freq_to_opp(u8 *opp_id, const struct omap_opp *opps, unsigned long freq)
+{
+	int i = 1;
+
+	BUG_ON(!opp_id || !opps);
+
+	/* The first entry is a dummy one, loop till we hit terminator */
+	while (!IS_OPP_TERMINATOR(opps, i)) {
+		if (opps[i].enabled && (opps[i].rate == freq)) {
+			*opp_id = opps[i].opp_id;
+			return 0;
+		}
+		i++;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(freq_to_opp);
+
+int opp_enable(struct omap_opp *opps, unsigned long freq, bool enable)
+{
+	int i = 1;
+
+	BUG_ON(!opps);
+
+	/* The first entry is a dummy one, loop till we hit terminator */
+	while (!IS_OPP_TERMINATOR(opps, i)) {
+		if (opps[i].rate == freq) {
+			opps[i].enabled = enable;
+			return 0;
+		}
+		i++;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(opp_enable);
+
+int get_next_freq(unsigned long *freq, const struct omap_opp *opps,
+		bool search_higher, bool search_enabled_only, bool exact_search)
+{
+	int i = 1, inc = 1;
+	bool found = false;
+
+	BUG_ON(!opps || !freq || !(*freq));
+
+	/* The first entry is a dummy one, loop till we hit terminator
+	 * XXX: The following algorithm works only on a presorted
+	 * list of OPPs
+	 */
+	while (!IS_OPP_TERMINATOR(opps, i)) {
+		/* if we found the original freq, then
+		 * case 1: enabled search ONLY, check opp is enabled or not
+		 * case 2: the next available freq if enabled is not searched
+		 */
+		if ((found && search_enabled_only && opps[i].enabled) ||
+		    (found && !search_enabled_only)) {
+			*freq = opps[i].rate;
+			return 0;
+		}
+
+		/* Find the baseline freq first.. */
+		if (!found && ((exact_search && opps[i].rate == *freq) ||
+				(!exact_search && opps[i].rate >= *freq))) {
+			/* found.. next decide direction */
+			inc = search_higher ? 1 : -1;
+			found = true;
+			/* handle an exception case for exact search.. */
+			if (exact_search || !search_higher)
+				i += inc;
+			/* fall thru to search for the right match */
+		} else {
+			i += inc;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(get_next_freq);
+
+int get_limit_freq(unsigned long *freq, const struct omap_opp *opps,
+		bool search_highest, bool search_enabled_only)
+{
+	int i = 1;
+	unsigned long cur_freq_match = search_highest ? 0 : -1;
+	bool found = false;
+
+	BUG_ON(!opps || !freq);
+
+	/* The first entry is a dummy one, loop till we hit terminator
+	 * XXX: The following algorithm works only on a presorted
+	 * list of OPPs
+	 * We could use get_next_freq to search, but that will tend
+	 * to be inefficient
+	 */
+	while (!IS_OPP_TERMINATOR(opps, i)) {
+		/* match condition:
+		 * check if the enabled cases match (only invalid case is:
+		 * search_enabled=1,enabled=0)
+		 * then we look for comparison condition, based on direction
+		 */
+		if (!(search_enabled_only && !opps[i].enabled) &&
+		     ((search_highest && (opps[i].rate > cur_freq_match)) ||
+		     (!search_highest && (opps[i].rate < cur_freq_match)))) {
+			cur_freq_match = opps[i].rate;
+			found = true;
+			/* if we are searching for least, the first match
+			 * is the right one, look no further.
+			 */
+			if (!search_highest)
+				break;
+		}
+		i++;
+	}
+	if (!found)
+		return -EINVAL;
+	*freq = cur_freq_match;
+	return 0;
+}
+EXPORT_SYMBOL(get_limit_freq);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9e471f7..2f17a40 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -51,6 +51,7 @@
 #include "prm.h"
 #include "pm.h"
 #include "sdrc.h"
+#include "omap3-opp.h"
 
 static int regset_save_on_suspend;
 
@@ -99,6 +100,47 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
+struct omap_opp omap3_mpu_rate_table[] = {
+	{0, 0, 0, 0},
+	/*OPP1*/
+	{true, S125M, VDD1_OPP1, 0x1E},
+	/*OPP2*/
+	{true, S250M, VDD1_OPP2, 0x26},
+	/*OPP3*/
+	{true, S500M, VDD1_OPP3, 0x30},
+	/*OPP4*/
+	{true, S550M, VDD1_OPP4, 0x36},
+	/*OPP5*/
+	{true, S600M, VDD1_OPP5, 0x3C},
+	{0, 0, 0, 0},
+};
+
+struct omap_opp omap3_l3_rate_table[] = {
+	{0, 0, 0, 0},
+	/*OPP1*/
+	{false, 0, VDD2_OPP1, 0x1E},
+	/*OPP2*/
+	{true, S83M, VDD2_OPP2, 0x24},
+	/*OPP3*/
+	{true, S166M, VDD2_OPP3, 0x2C},
+	{0, 0, 0, 0},
+};
+
+struct omap_opp omap3_dsp_rate_table[] = {
+	{0, 0, 0, 0},
+	/*OPP1*/
+	{true, S90M, VDD1_OPP1, 0x1E},
+	/*OPP2*/
+	{true, S180M, VDD1_OPP2, 0x26},
+	/*OPP3*/
+	{true, S360M, VDD1_OPP3, 0x30},
+	/*OPP4*/
+	{true, S400M, VDD1_OPP4, 0x36},
+	/*OPP5*/
+	{true, S430M, VDD1_OPP5, 0x3C},
+	{0, 0, 0, 0},
+};
+
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 5dc2048..8316999 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -35,6 +35,10 @@ struct omap_opp {
 	u16 vsel;
 };
 
+/* Identify a OPP terminator */
+#define IS_OPP_TERMINATOR(opps, i) (!(opps)[(i)].enabled &&\
+		((opps)[(i)].rate == 0) && ((opps)[(i)].vsel == 0))
+
 extern struct omap_opp *mpu_opps;
 extern struct omap_opp *dsp_opps;
 extern struct omap_opp *l3_opps;
@@ -324,5 +328,110 @@ unsigned long omap_pm_cpu_get_freq(void);
  */
 int omap_pm_get_dev_context_loss_count(struct device *dev);
 
+/**
+ * freq_to_opp - Get opp_id corresponding to a frequency if enabled
+ * This function can also be used to check if a certain frequency is enabled
+ * in the opp list.
+ *
+ * @opp_id: the ID to return
+ * @opps: the opps table to search through
+ * @freq: the frequency to search for
+ *
+ * returns 0 if *opp_id is populated, else returns EINVAL
+ */
+int freq_to_opp(u8 *opp_id, const struct omap_opp *opps, unsigned long freq);
 
+/**
+ * freq_to_vsel - Get voltage corresponding to a frequency if enabled
+ * This function can also be used to check if a certain frequency is enabled
+ * in the opp list.
+ *
+ * @vsel: voltage corresponding to return
+ * @opps: the opps table to search through
+ * @freq: the frequency to search for
+ *
+ * returns 0 if *vsel is populated, else returns EINVAL
+ */
+int freq_to_vsel(u8 *vsel, const struct omap_opp *opps, unsigned long freq);
+
+/**
+ * opp_to_freq - Get frequency corresponding to an OPP if enabled
+ * This function can also be used to check if a certain opp_id is enabled
+ * in the opp list.
+ *
+ * @freq: return the frequency on this
+ * @opps: the opps table to search through
+ * @opp_id: the ID to search for
+ *
+ * returns 0 if *freq is populated, else returns EINVAL
+ */
+int opp_to_freq(unsigned long *freq, const struct omap_opp *opps, u8 opp_id);
+
+/**
+ * opp_enable - Enable or Disable an OPP in the supported OPPs if available
+ *
+ * @opps: the opps table to search through
+ * @freq: the frequency to search for
+ * @enable: true to enable the OPP, false to disable it
+ *
+ * returns 0 if the OPP is found, else returns EINVAL. if the opp is found
+ * NOTE: Even if it was in the same state as requested, the functions returns 0.
+ */
+int opp_enable(struct omap_opp *opps, unsigned long freq, bool enable);
+
+/**
+ * get_next_freq - search for next matching frequency, given a starting
+ * frequency. This can be combined to create a search logic etc without
+ * knowing OPP IDs.
+ * Example usages:
+ * a) I have an approximate frequency, get enabled opp freq at least freq
+ *	if a match is achieved, result_freq >= requested_freq
+ *   res = get_next_freq(&freq, opps, true, true, false)
+ * b) I have an approximate frequency, get enabled opp freq less than freq
+ *	if a match is achieved, result_freq < requested_freq
+ *   res = get_next_freq(&freq, opps, false, true, false)
+ * c) I have exact OPP freq I want to check -> search for higher enabled
+ *    frequency
+ *   res = get_next_freq(&freq, opps, true, true, true)
+ * d) I have exact OPP freq I want to check -> search for lower enabled
+ *    frequency
+ *   res = get_next_freq(&freq, opps, false, true, true)
+ *
+ * Then we can create all sorts of search combinations -> including searching
+ * for an OPP freq we would like to enable by controlling search_enabled_only
+ *
+ * @freq: Which frequency to start from- should be a valid frequency,
+ *	  even if not enabled.
+ *	  if a match is found, this will contain the matched frequency
+ * @opps: the opp table to search through
+ * @search_higher: should the search go up the list (search for higher freq)
+ *	  if true, searches for next highest freq, else searches for the next
+ *	  lowest frequency
+ * @search_enabled_only: Should the search only for enabled frequencies.
+ *	  if true, searches for only enabled OPP frequencies, else does not
+ *	  care for enabled status of the OPP (useful to enable OPPs)
+ * @exact_search: start search iff start *freq gets an exact match
+ *
+ * If a match is found, returns the matched frequency in *freq and returns 0,
+ * else, returns EINVAL, *freq is unchanged
+ */
+int get_next_freq(unsigned long *freq, const struct omap_opp *opps,
+	bool search_higher, bool search_enabled_only, bool exact_search);
+
+/**
+ * get_limit_freq: Get the max or min frequency for an opp table
+ * we can search for just the enabled opps, or the max or least in
+ * the table
+ *
+ * @freq: returns the max or min opp if a match was found
+ * @opps: opp table to search
+ * @search_highest: search for the highest if true, else search for lowest
+ *	frequency
+ * @search_enabled_only: search only for enabled OPPs
+ *
+ * returns 0 if a match is found and *freq contains the matched frequency
+ * else, returns EINVAL, *freq is unchanged
+ */
+int get_limit_freq(unsigned long *freq, const struct omap_opp *opps,
+		bool search_highest, bool search_enabled_only);
 #endif
-- 
1.6.3.3

