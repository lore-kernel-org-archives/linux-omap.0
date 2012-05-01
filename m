From: jean.pihet@newoldbits.com
Subject: [PATCH 1/5] ARM: OMAP2+: PM: implement a caching mechanism on the power domains state registers
Date: Tue,  1 May 2012 15:07:39 +0200
Message-ID: <1335877663-32649-2-git-send-email-j-pihet@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46043 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab2EANIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 09:08:11 -0400
Received: by were53 with SMTP id e53so158331wer.19
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 06:08:10 -0700 (PDT)
In-Reply-To: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The OMAP3 PRCM registers accesses are known to be slow. A PRCM read
can take up to 12-14us depending on the OPP.

This patch adds a caching mechanism on the power domains state registers.
When the cache is cold or has been invalidated a register access is
performed, otherwise the register value is retrieved from the registers
cache.
The API is made of read and write functions for fields in the cache, as well
as an invalidate function and helper functions to invalidate parts of the
cache contents (i.e. previous, current power states and all fields in the
cache).

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |  128 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |   45 ++++++++++++-
 2 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 100c422..18e1ffc 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -697,6 +697,134 @@ out:
 }
 
 /**
+ * pwrdm_cache_read - read from the registers cache
+ * @pwrdm: struct powerdomain *
+ * @index: index of the data to be read from the cache
+ * @value: data value to be returned
+ *
+ * Returns 0 if the data is read from the cache.
+ * Returns -ENODATA if the data is not present, -EINVAL if the data is
+ * to be read past the end of the cache.
+ */
+static int pwrdm_cache_read(struct powerdomain *pwrdm, int index, int *value)
+{
+	if (index >= PWRDM_CACHE_SIZE)
+		return -EINVAL;
+
+	if (!(pwrdm->cache_state & (1 << index)))
+		return -ENODATA;
+
+	*value = pwrdm->cache[index];
+	return 0;
+}
+
+/**
+ * pwrdm_cache_write - store data to the registers cache
+ * @pwrdm: struct powerdomain *
+ * @index: index of the data to write to the cache
+ * @value: data value to be stored
+ *
+ * Stores the data in the cache and maintains the internal cache state.
+ *
+ * Returns -EINVAL if the data is to be written past the end of the cache,
+ * 0 otherwise.
+ */
+static int pwrdm_cache_write(struct powerdomain *pwrdm, int index, int value)
+{
+	if (index >= PWRDM_CACHE_SIZE)
+		return -EINVAL;
+
+	pwrdm->cache[index] = value;
+	pwrdm->cache_state |= (1 << index);
+
+	return 0;
+}
+
+/**
+ * pwrdm_invalidate_regs_cache_fields - invalidate fields in the
+ * power domain registers cache
+ * @pwrdm: struct powerdomain *
+ * @mask: cache fields to invalidate, made by OR'ing the
+ * PWRDM_CACHE_* values
+ *
+ * If pwrdm is NULL, invalidate the fields for all power domains,
+ * otherwise invalidate them for the given pwrdm only.
+ *
+ * Invalidates some of the power domain cache fields, thus imposing
+ * an effective re-read from the HW register at the next access.
+ */
+void pwrdm_invalidate_regs_cache_fields(struct powerdomain *pwrdm, int mask)
+{
+	struct powerdomain *temp_pwrdm;
+
+	if (pwrdm) {
+		pwrdm->cache_state &= ~mask;
+	} else {
+		list_for_each_entry(temp_pwrdm, &pwrdm_list, node)
+			temp_pwrdm->cache_state &= ~mask;
+	}
+}
+
+/**
+ * pwrdm_invalidate_regs_cache_fields_prev - invalidate the previous states
+ * in the power domain registers cache
+ * @pwrdm: struct powerdomain *
+ *
+ * If pwrdm is NULL, invalidate the previous states for all power domains,
+ * otherwise invalidate them for the given pwrdm only.
+ *
+ * Invalidates only the previous states of the power domain cache fields,
+ * thus imposing an effective re-read from the HW register at the next access.
+ */
+void pwrdm_invalidate_regs_cache_fields_prev(struct powerdomain *pwrdm)
+{
+	int i;
+
+	pwrdm_invalidate_regs_cache_fields(pwrdm,
+				PWRDM_CACHE_PREV_PWRST |
+				PWRDM_CACHE_PREV_LOGIC_PWRST);
+	for (i = 0; i < PWRDM_MAX_MEM_BANKS; i++)
+		pwrdm_invalidate_regs_cache_fields(pwrdm,
+				PWRDM_CACHE_PREV_MEM_PWRST + i);
+}
+
+/**
+ * pwrdm_invalidate_regs_cache_fields_current - invalidate the current
+ * states in the power domains' registers cache
+ *
+ * If pwrdm is NULL, invalidate the current states for all power domains,
+ * otherwise invalidate them for the given pwrdm only.
+ *
+ * Invalidates only the current states of the power domains cache fields,
+ * thus imposing an effective re-read from the HW register at the next access.
+ */
+void pwrdm_invalidate_regs_cache_fields_current(struct powerdomain *pwrdm)
+{
+	int i;
+
+	pwrdm_invalidate_regs_cache_fields(pwrdm, PWRDM_CACHE_PWRST |
+					   PWRDM_CACHE_LOGIC_RETST);
+	for (i = 0; i < PWRDM_MAX_MEM_BANKS; i++) {
+		pwrdm_invalidate_regs_cache_fields(pwrdm,
+					PWRDM_CACHE_MEM_PWRST + i);
+		pwrdm_invalidate_regs_cache_fields(pwrdm,
+					PWRDM_CACHE_MEM_ONST + i);
+	}
+}
+
+/**
+ * pwrdm_invalidate_regs_cache_all - invalidate all fields in the registers
+ * cache for all power domains
+ *
+ * Invalidates all of the power domain cache fields of all power domains,
+ * thus imposing an effective re-read from the HW register at the next access
+ */
+void pwrdm_invalidate_regs_cache_all(void)
+{
+	pwrdm_invalidate_regs_cache_fields(NULL, PWRDM_CACHE_ALL);
+}
+
+/**
  * pwrdm_set_next_pwrst - set next powerdomain power state
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 63028c0..e5d621c 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -93,6 +93,37 @@
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
 
+/* Power domains state cache fields */
+enum cache_fields {
+	/* current power state */
+	PWRDM_CACHE_PWRST,
+	/* prev power state */
+	PWRDM_CACHE_PREV_PWRST,
+	/* next power state */
+	PWRDM_CACHE_NEXT_PWRST,
+	/* current logic RET state */
+	PWRDM_CACHE_LOGIC_RETST,
+	/* prev logic power state */
+	PWRDM_CACHE_PREV_LOGIC_PWRST,
+	/* next logic RET state */
+	PWRDM_CACHE_NEXT_LOGIC_RETST,
+	/* current mem bank pwrst, up to PWRDM_MAX_MEM_BANKS banks */
+	PWRDM_CACHE_MEM_PWRST,
+	/* previous mem bank pwrst, up to PWRDM_MAX_MEM_BANKS banks */
+	PWRDM_CACHE_PREV_MEM_PWRST	= PWRDM_CACHE_MEM_PWRST +
+					  PWRDM_MAX_MEM_BANKS,
+	/* next mem bank RET state, up to PWRDM_MAX_MEM_BANKS banks */
+	PWRDM_CACHE_NEXT_MEM_RETST	= PWRDM_CACHE_PREV_MEM_PWRST +
+					  PWRDM_MAX_MEM_BANKS,
+	/* mem ON state, up to PWRDM_MAX_MEM_BANKS banks */
+	PWRDM_CACHE_MEM_ONST		= PWRDM_CACHE_NEXT_MEM_RETST +
+					  PWRDM_MAX_MEM_BANKS,
+	/* keep this item at the end of the list */
+	PWRDM_CACHE_SIZE		= PWRDM_CACHE_MEM_ONST +
+					  PWRDM_MAX_MEM_BANKS
+};
+#define PWRDM_CACHE_ALL		-1
+
 struct clockdomain;
 struct powerdomain;
 
@@ -104,14 +135,17 @@ struct powerdomain;
  * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
  * @pwrsts: Possible powerdomain power states
  * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENTION
- * @flags: Powerdomain flags
+ * @flags: Powerdomain capability flags
  * @banks: Number of software-controllable memory banks in this powerdomain
  * @pwrsts_mem_ret: Possible memory bank pwrstates when pwrdm in RETENTION
  * @pwrsts_mem_on: Possible memory bank pwrstates when pwrdm in ON
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
- * @state:
+ * @state: last power state of the pwrdm, used to detect state transitions
+ * @cache: Power domain registers cache contents
+ * @cache_state: State of the power domains cache. Each bit indicates if
+ * the corresponding data field is available from the cache
  * @state_counter:
  * @timer:
  * @state_timer:
@@ -137,6 +171,8 @@ struct powerdomain {
 	struct list_head voltdm_node;
 	struct mutex lock;
 	int state;
+	int cache[PWRDM_CACHE_SIZE];
+	long cache_state;
 	unsigned state_counter[PWRDM_MAX_FUNC_PWRSTS];
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
@@ -233,6 +269,11 @@ int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
 
+void pwrdm_invalidate_regs_cache_fields(struct powerdomain *pwrdm, int mask);
+void pwrdm_invalidate_regs_cache_fields_prev(struct powerdomain *pwrdm);
+void pwrdm_invalidate_regs_cache_fields_current(struct powerdomain *pwrdm);
+void pwrdm_invalidate_regs_cache_all(void);
+
 int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
 int omap2_pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
 int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
-- 
1.7.7.6

