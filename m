From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 2/2] omap: opp: documentation update
Date: Mon, 17 May 2010 15:11:22 -0500
Message-ID: <1274127082-16288-3-git-send-email-nm@ti.com>
References: <1274127082-16288-1-git-send-email-nm@ti.com>
 <1274127082-16288-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0EQULi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 16:11:38 -0400
In-Reply-To: <1274127082-16288-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Tony Lindgren <tony@atomide.com>, Vishwanath BS <vishwanath.bs@ti.com>

move the documentation from header to c, cleanup missing function
documentation for the functions

Signed-off-by: Nishanth Menon <nm@ti.com>

Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>
---
 Documentation/arm/OMAP/omap_pm        |   66 +++++++++++++
 arch/arm/plat-omap/include/plat/opp.h |  143 +----------------------------
 arch/arm/plat-omap/opp.c              |  164 +++++++++++++++++++++++++++++---
 3 files changed, 216 insertions(+), 157 deletions(-)

diff --git a/Documentation/arm/OMAP/omap_pm b/Documentation/arm/OMAP/omap_pm
index 5389440..9376ad4 100644
--- a/Documentation/arm/OMAP/omap_pm
+++ b/Documentation/arm/OMAP/omap_pm
@@ -127,3 +127,69 @@ implementation needs:
 10. (*pdata->cpu_set_freq)(unsigned long f)
 
 11. (*pdata->cpu_get_freq)(void)
+
+OMAP OPP Layer
+==============
+OMAP SOCs have a standard set of tuples consisting of frequency and
+voltage pairs that the device will support per voltage domain. This
+is called Operating Points or OPP. The actual definitions of OMAP
+Operating Points varies over silicon within the same family of
+devices. For a specific domain, you can have a set of
+{frequency, voltage} pairs. As the kernel boots and more information
+is available, a set of these are activated based on the precise
+nature of device the kernel boots up on. It is interesting to
+remember that each IP which belongs to a voltage domain may define
+their own set of OPPs on top of this.
+
+OPP layer of its own depends on silicon specific implementation and
+board specific data to finalize on the final set of OPPs available
+in a system
+
+Initial list initialization:
+---------------------------
+Silicon specific initialization: First the OPP layer needs to be told
+that to initialize the tables for OMAP3, this is done board
+perspective by the call to:
+1. omap3_pm_init_opp_table - this in turn calls opp_init_list for all
+OPP types. This is the generic silicon operating points, however, the
+system may have additional features or customizations required. This
+flexibility is provided by the following apis:
+
+Query functions:
+----------------
+Search for OPPs for various cases:
+2. opp_find_freq_exact - exact search function
+3. opp_find_freq_floor - round_up search function
+4. opp_find_freq_ceil - round_down search function
+
+OPP modifier functions:
+----------------------
+The allows opp layer users to add customized OPPs or change the table
+for any need they may have
+5. opp_add - add a new OPP
+6. opp_enable - enable a disabled OPP
+7. opp_disable - disable an enabled OPP
+
+OPP Data retrieval functions:
+----------------------------
+The following sets of functions are useful for drivers to retrieved
+data stored in opp layer for various functions.
+8. opp_get_voltage - retrieve voltage for an opp
+9. opp_get_freq - get the frequency for an opp
+10. opp_get_opp_count - get number of opps enabled for a domain
+
+Cpufreq table generation:
+------------------------
+11. opp_init_cpufreq_table - this translates the OPP layer's internal
+OPP arrangement into a table understood and operated upon by the
+cpufreq layer.
+
+Deprecated functions:
+--------------------
+To maintain compatibility with out of tree drivers, opp_id is needed.
+OPP IDs are not constant acrross silicon, nor are they constant for a
+given silicon family. The rest of the layers should stop using these
+functions at the earliest. For the out of tree drivers currently,
+This is exposed by the following deprecated functions:
+12. opp_find_by_opp_id - get an OPP for an OPP ID
+13. opp_get_opp_id - get the OPP ID for an OPP
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 7d16a46..9f569e3 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -28,7 +28,6 @@ enum opp_t {
 #error "You need to populate the OPP types for OMAP chip type."
 #endif
 
-
 /**
  * struct omap_opp_def - OMAP OPP Definition
  * @enabled:	True/false - is this OPP enabled/disabled by default
@@ -53,8 +52,8 @@ struct omap_opp_def {
 };
 
 /*
- * Initialization wrapper used to define an OPP
- * to point at the end of a terminator of a list of OPPs,
+ * Initialization wrapper used to define an OPP.
+ * To point at the end of a terminator of a list of OPPs,
  * use OMAP_OPP_DEF(0, 0, 0)
  */
 #define OMAP_OPP_DEF(_enabled, _freq, _uv)	\
@@ -68,165 +67,27 @@ struct omap_opp;
 
 #ifdef CONFIG_CPU_FREQ
 
-/**
- * opp_get_voltage() - Gets the voltage corresponding to an opp
- * @opp:	opp for which voltage has to be returned for
- *
- * Return voltage in micro volt corresponding to the opp, else
- * return 0
- */
 unsigned long opp_get_voltage(const struct omap_opp *opp);
 
-/**
- * opp_get_freq() - Gets the frequency corresponding to an opp
- * @opp:	opp for which frequency has to be returned for
- *
- * Return frequency in hertz corresponding to the opp, else
- * return 0
- */
 unsigned long opp_get_freq(const struct omap_opp *opp);
 
-/**
- * opp_get_opp_count() - Get number of opps enabled in the opp list
- * @num:	returns the number of opps
- * @opp_type:	OPP type we want to count
- *
- * This functions returns the number of opps if there are any OPPs enabled,
- * else returns corresponding error value.
- */
 int opp_get_opp_count(enum opp_t opp_type);
 
-/**
- * opp_find_freq_exact() - search for an exact frequency
- * @opp_type:	OPP type we want to search in.
- * @freq:	frequency to search for
- * @enabled:	enabled/disabled OPP to search for
- *
- * searches for the match in the opp list and returns handle to the matching
- * opp if found, else returns ERR_PTR in case of error and should be handled
- * using IS_ERR.
- *
- * Note enabled is a modifier for the search. if enabled=true, then the match is
- * for exact matching frequency and is enabled. if true, the match is for exact
- * frequency which is disabled.
- */
 struct omap_opp *opp_find_freq_exact(enum opp_t opp_type,
 				     unsigned long freq, bool enabled);
 
-/* XXX This documentation needs fixing */
-
-/**
- * opp_find_freq_floor() - Search for an rounded freq
- * @opp_type:	OPP type we want to search in
- * @freq:	Start frequency
- *
- * Search for the lower *enabled* OPP from a starting freq
- * from a start opp list.
- *
- * Returns *opp and *freq is populated with the next match, else
- * returns NULL opp if found, else returns ERR_PTR in case of error.
- *
- * Example usages:
- *	* find match/next lowest available frequency
- *	freq = 350000;
- *	opp = opp_find_freq_floor(oppl, &freq)))
- *	if (IS_ERR(opp))
- *		pr_err ("unable to find a lower frequency\n");
- *	else
- *		pr_info("match freq = %ld\n", freq);
- *
- *	* print all supported frequencies in descending order *
- *	opp = oppl;
- *	freq = ULONG_MAX;
- *	while (!IS_ERR(opp = opp_find_freq_floor(opp, &freq)) {
- *		pr_info("freq = %ld\n", freq);
- *		freq--; * for next lower match *
- *	}
- *
- * NOTE: if we set freq as ULONG_MAX and search low, we get the
- * highest enabled frequency
- */
 struct omap_opp *opp_find_freq_floor(enum opp_t opp_type, unsigned long *freq);
 
-/* XXX This documentation needs fixing */
-
-/**
- * opp_find_freq_ceil() - Search for an rounded freq
- * @opp_type:	OPP type where we want to search in
- * @freq:	Start frequency
- *
- * Search for the higher *enabled* OPP from a starting freq
- * from a start opp list.
- *
- * Returns *opp and *freq is populated with the next match, else
- * returns NULL opp if found, else returns ERR_PTR in case of error.
- *
- * Example usages:
- *	* find match/next highest available frequency
- *	freq = 350000;
- *	opp = opp_find_freq_ceil(oppl, &freq))
- *	if (IS_ERR(opp))
- *		pr_err ("unable to find a higher frequency\n");
- *	else
- *		pr_info("match freq = %ld\n", freq);
- *
- *	* print all supported frequencies in ascending order *
- *	opp = oppl;
- *	freq = 0;
- *	while (!IS_ERR(opp = opp_find_freq_ceil(opp, &freq)) {
- *		pr_info("freq = %ld\n", freq);
- *		freq++; * for next higher match *
- *	}
- */
 struct omap_opp *opp_find_freq_ceil(enum opp_t opp_type, unsigned long *freq);
 
 
-/**
- * opp_init_list() - Initialize an opp list from the opp definitions
- * @opp_type:	OPP type to initialize this list for.
- * @opp_defs:	Initial opp definitions to create the list.
- *
- * This function creates a list of opp definitions and returns status.
- * This list can be used to further validation/search/modifications. New
- * opp entries can be added to this list by using opp_add().
- *
- * In the case of error, suitable error code is returned.
- */
 int  __init opp_init_list(enum opp_t opp_type,
 			 const struct omap_opp_def *opp_defs);
 
-/**
- * opp_add()  - Add an OPP table from a table definitions
- * @opp_type:	OPP type under which we want to add our new OPP.
- * @opp_def:	omap_opp_def to describe the OPP which we want to add to list.
- *
- * This function adds an opp definition to the opp list and returns status.
- *
- */
 int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def);
 
-/**
- * opp_enable() - Enable a specific OPP
- * @opp:	Pointer to opp
- *
- * Enables a provided opp. If the operation is valid, this returns 0, else the
- * corresponding error value.
- *
- * OPP used here is from the the opp_is_valid/opp_has_freq or other search
- * functions
- */
 int opp_enable(struct omap_opp *opp);
 
-/**
- * opp_disable() - Disable a specific OPP
- * @opp:	Pointer to opp
- *
- * Disables a provided opp. If the operation is valid, this returns 0, else the
- * corresponding error value.
- *
- * OPP used here is from the the opp_is_valid/opp_has_freq or other search
- * functions
- */
 int opp_disable(struct omap_opp *opp);
 
 struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_type,
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 0b61325..01eb0c6 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -24,13 +24,10 @@
  * struct omap_opp - OMAP OPP description structure
  * @enabled:	true/false - marking this OPP as enabled/disabled
  * @rate:	Frequency in hertz
- * @opp_id:	(DEPRECATED) opp identifier
- * @u_volt:     minimum microvolts DC required for this OPP to function
+ * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ * @opp_id:	opp identifier (deprecated)
  *
  * This structure stores the OPP information for a given domain.
- * Due to legacy reasons, this structure is currently exposed and
- * will soon be removed elsewhere and will only be used as a handle
- * from the OPP internal referencing mechanism
  */
 struct omap_opp {
 	bool enabled;
@@ -39,18 +36,19 @@ struct omap_opp {
 	u8 opp_id;
 };
 
-/*
- * This maintains pointers to the start of each OPP array.
- */
-
+/* This maintains pointers to the start of each OPP array. */
 static struct omap_opp *_opp_list[OPP_TYPES_MAX];
-/*
- * DEPRECATED: Meant to detect end of opp array
- * This is meant to help co-exist with current SRF etc
- * TODO: REMOVE!
- */
+
+/* Detect end of opp array */
 #define OPP_TERM(opp) (!(opp)->rate && !(opp)->u_volt && !(opp)->enabled)
 
+/**
+ * opp_get_voltage() - Gets the voltage corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ *
+ * Return voltage in micro volt corresponding to the opp, else
+ * return 0
+ */
 unsigned long opp_get_voltage(const struct omap_opp *opp)
 {
 	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
@@ -60,6 +58,13 @@ unsigned long opp_get_voltage(const struct omap_opp *opp)
 	return opp->u_volt;
 }
 
+/**
+ * opp_get_freq() - Gets the frequency corresponding to an opp
+ * @opp:	opp for which frequency has to be returned for
+ *
+ * Return frequency in hertz corresponding to the opp, else
+ * return 0
+ */
 unsigned long opp_get_freq(const struct omap_opp *opp)
 {
 	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
@@ -71,7 +76,8 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
 
 /**
  * opp_find_by_opp_id - look up OPP by OPP ID (deprecated)
- * @opp_type: OPP type where we want the look up to happen.
+ * @opp_type:	OPP type where we want the look up to happen.
+ * @opp_id:	OPP ID to search for
  *
  * Returns the struct omap_opp pointer corresponding to the given OPP
  * ID @opp_id, or returns NULL on error.
@@ -99,6 +105,12 @@ struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_type,
 	return ERR_PTR(-ENOENT);
 }
 
+/**
+ * opp_get_opp_id() - Provide OPP ID corresponding to an OPP (deprecated)
+ * @opp:	opp for which frequency has to be returned for
+ *
+ * Returns an OPP ID for the OPP required, if error, returns 0
+ */
 u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
 {
 	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
@@ -108,6 +120,13 @@ u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
 	return opp->opp_id;
 }
 
+/**
+ * opp_get_opp_count() - Get number of opps enabled in the opp list
+ * @opp_type:	OPP type we want to count
+ *
+ * This functions returns the number of opps if there are any OPPs enabled,
+ * else returns corresponding error value.
+ */
 int opp_get_opp_count(enum opp_t opp_type)
 {
 	u8 n = 0;
@@ -130,6 +149,20 @@ int opp_get_opp_count(enum opp_t opp_type)
 	return n;
 }
 
+/**
+ * opp_find_freq_exact() - search for an exact frequency
+ * @opp_type:	OPP type we want to search in.
+ * @freq:	frequency to search for
+ * @enabled:	enabled/disabled OPP to search for
+ *
+ * Searches for exact match in the opp list and returns handle to the matching
+ * opp if found, else returns ERR_PTR in case of error and should be handled
+ * using IS_ERR.
+ *
+ * Note enabled is a modifier for the search. if enabled=true, then the match is
+ * for exact matching frequency and is enabled. if false, the match is for exact
+ * frequency which is disabled.
+ */
 struct omap_opp *opp_find_freq_exact(enum opp_t opp_type,
 				     unsigned long freq, bool enabled)
 {
@@ -154,6 +187,33 @@ struct omap_opp *opp_find_freq_exact(enum opp_t opp_type,
 	return OPP_TERM(oppl) ? ERR_PTR(-ENOENT) : oppl;
 }
 
+/**
+ * opp_find_freq_ceil() - Search for an rounded ceil freq
+ * @opp_type:	OPP type where we want to search in
+ * @freq:	Start frequency
+ *
+ * Search for the matching ceil *enabled* OPP from a starting freq
+ * for a domain.
+ *
+ * Returns *opp and *freq is populated with the match, else
+ * returns NULL opp if no match, else returns ERR_PTR in case of error.
+ *
+ * Example usages:
+ *	* find match/next highest available frequency *
+ *	freq = 350000;
+ *	opp = opp_find_freq_ceil(OPP_MPU, &freq))
+ *	if (IS_ERR(opp))
+ *		pr_err("unable to find a higher frequency\n");
+ *	else
+ *		pr_info("match freq = %ld\n", freq);
+ *
+ *	* print all supported frequencies in ascending order *
+ *	freq = 0; * Search for the lowest enabled frequency *
+ *	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq)) {
+ *		pr_info("freq = %ld\n", freq);
+ *		freq++; * for next higher match *
+ *	}
+ */
 struct omap_opp *opp_find_freq_ceil(enum opp_t opp_type, unsigned long *freq)
 {
 	struct omap_opp *oppl;
@@ -183,6 +243,33 @@ struct omap_opp *opp_find_freq_ceil(enum opp_t opp_type, unsigned long *freq)
 	return oppl;
 }
 
+/**
+ * opp_find_freq_floor() - Search for an rounded floor freq
+ * @opp_type:	OPP type we want to search in
+ * @freq:	Start frequency
+ *
+ * Search for the matching floor *enabled* OPP from a starting freq
+ * for a domain.
+ *
+ * Returns *opp and *freq is populated with the next match, else
+ * returns NULL opp if no match, else returns ERR_PTR in case of error.
+ *
+ * Example usages:
+ *	* find match/next lowest available frequency
+ *	freq = 350000;
+ *	opp = opp_find_freq_floor(OPP_MPU, &freq)))
+ *	if (IS_ERR(opp))
+ *		pr_err ("unable to find a lower frequency\n");
+ *	else
+ *		pr_info("match freq = %ld\n", freq);
+ *
+ *	* print all supported frequencies in descending order *
+ *	freq = ULONG_MAX; * search highest enabled frequency *
+ *	while (!IS_ERR(opp = opp_find_freq_floor(OPP_MPU, &freq)) {
+ *		pr_info("freq = %ld\n", freq);
+ *		freq--; * for next lower match *
+ *	}
+ */
 struct omap_opp *opp_find_freq_floor(enum opp_t opp_type, unsigned long *freq)
 {
 	struct omap_opp *prev_opp, *oppl;
@@ -224,6 +311,13 @@ static void omap_opp_populate(struct omap_opp *opp,
 	opp->u_volt = opp_def->u_volt;
 }
 
+/**
+ * opp_add()  - Add an OPP table from a table definitions
+ * @opp_type:	OPP type under which we want to add our new OPP.
+ * @opp_def:	omap_opp_def to describe the OPP which we want to add to list.
+ *
+ * This function adds an opp definition to the opp list and returns status.
+ */
 int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def)
 {
 	struct omap_opp *opp, *oppt, *oppr, *oppl;
@@ -292,6 +386,17 @@ int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def)
 	return 0;
 }
 
+/**
+ * opp_init_list() - Initialize an opp list from the opp definitions
+ * @opp_type:	OPP type to initialize this list for.
+ * @opp_defs:	Initial opp definitions to create the list.
+ *
+ * This function creates a list of opp definitions and returns status.
+ * This list can be used to further validation/search/modifications. New
+ * opp entries can be added to this list by using opp_add().
+ *
+ * In the case of error, suitable error code is returned.
+ */
 int __init opp_init_list(enum opp_t opp_type,
 				 const struct omap_opp_def *opp_defs)
 {
@@ -335,6 +440,16 @@ int __init opp_init_list(enum opp_t opp_type,
 	return 0;
 }
 
+/**
+ * opp_enable() - Enable a specific OPP
+ * @opp:	Pointer to opp
+ *
+ * Enables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
 int opp_enable(struct omap_opp *opp)
 {
 	if (unlikely(!opp || IS_ERR(opp))) {
@@ -345,6 +460,16 @@ int opp_enable(struct omap_opp *opp)
 	return 0;
 }
 
+/**
+ * opp_disable() - Disable a specific OPP
+ * @opp:	Pointer to opp
+ *
+ * Disables a provided opp. If the operation is valid, this returns 0, else the
+ * corresponding error value.
+ *
+ * OPP used here is from the the opp_is_valid/opp_has_freq or other search
+ * functions
+ */
 int opp_disable(struct omap_opp *opp)
 {
 	if (unlikely(!opp || IS_ERR(opp))) {
@@ -355,7 +480,14 @@ int opp_disable(struct omap_opp *opp)
 	return 0;
 }
 
-/* XXX document */
+/**
+ * opp_init_cpufreq_table() - create a cpufreq table for a domain
+ * @opp_type:	OPP type to initialize this list for
+ * @table:	Cpufreq table returned back to caller
+ *
+ * Generate a cpufreq table for a provided domain - this assumes that the
+ * opp list is already initialized and ready for usage
+ */
 void opp_init_cpufreq_table(enum opp_t opp_type,
 			    struct cpufreq_frequency_table **table)
 {
-- 
1.6.3.3

