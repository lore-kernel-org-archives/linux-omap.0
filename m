From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/10] OMAP clockdomain/powerdomain: improve documentation
Date: Tue, 05 Jan 2010 15:55:04 -0700
Message-ID: <20100105225503.16474.12093.stgit@localhost.localdomain>
References: <20100105225217.16474.44114.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49863 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab0AEW6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 17:58:24 -0500
In-Reply-To: <20100105225217.16474.44114.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch only affects documentation; no functional changes are
included.

Clean up comments in the current clockdomain, powerdomain code and
header files.  This mostly involves conversion to kerneldoc format,
although some clarifications are also included.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   65 ++++++-----
 arch/arm/mach-omap2/powerdomain.c             |  149 +++++++++++++------------
 arch/arm/plat-omap/include/plat/clockdomain.h |   87 +++++++--------
 arch/arm/plat-omap/include/plat/powerdomain.h |   40 +++----
 4 files changed, 167 insertions(+), 174 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index f44d9ea..2f68c10 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -351,10 +351,10 @@ static void _init_sleepdep_usecount(struct clockdomain *clkdm)
  * @init_autodeps: optional pointer to an array of autodeps to register
  *
  * Set up internal state.  If a pointer to an array of clockdomains
- * was supplied, loop through the list of clockdomains, register all
- * that are available on the current platform. Similarly, if a pointer
- * to an array of clockdomain autodependencies was provided, register
- * those.  No return value.
+ * @clkdms was supplied, loop through the list of clockdomains,
+ * register all that are available on the current platform. Similarly,
+ * if a pointer to an array of clockdomain autodependencies
+ * @init_autodeps was provided, register those.  No return value.
  */
 void clkdm_init(struct clockdomain **clkdms,
 		struct clkdm_autodep *init_autodeps)
@@ -386,8 +386,8 @@ void clkdm_init(struct clockdomain **clkdms,
  * clkdm_lookup - look up a clockdomain by name, return a pointer
  * @name: name of clockdomain
  *
- * Find a registered clockdomain by its name.  Returns a pointer to the
- * struct clockdomain if found, or NULL otherwise.
+ * Find a registered clockdomain by its name @name.  Returns a pointer
+ * to the struct clockdomain if found, or NULL otherwise.
  */
 struct clockdomain *clkdm_lookup(const char *name)
 {
@@ -412,8 +412,8 @@ struct clockdomain *clkdm_lookup(const char *name)
  * clkdm_for_each - call function on each registered clockdomain
  * @fn: callback function *
  *
- * Call the supplied function for each registered clockdomain.
- * The callback function can return anything but 0 to bail
+ * Call the supplied function @fn for each registered clockdomain.
+ * The callback function @fn can return anything but 0 to bail
  * out early from the iterator.  The callback function is called with
  * the clkdm_mutex held, so no clockdomain structure manipulation
  * functions should be called from the callback, although hardware
@@ -446,7 +446,7 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
  * @clkdm: struct clockdomain *
  *
  * Return a pointer to the struct powerdomain that the specified clockdomain
- * 'clkdm' exists in, or returns NULL if clkdm argument is NULL.
+ * @clkdm exists in, or returns NULL if @clkdm is NULL.
  */
 struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm)
 {
@@ -759,10 +759,10 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 
 /**
  * omap2_clkdm_clktrctrl_read - read the clkdm's current state transition mode
- * @clk: struct clk * of a clockdomain
+ * @clkdm: struct clkdm * of a clockdomain
  *
- * Return the clockdomain's current state transition mode from the
- * corresponding domain OMAP2_CM_CLKSTCTRL register.	Returns -EINVAL if clk
+ * Return the clockdomain @clkdm current state transition mode from the
+ * corresponding domain CM_CLKSTCTRL register.	Returns -EINVAL if @clkdm
  * is NULL or the current mode upon success.
  */
 static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
@@ -784,7 +784,7 @@ static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
  * @clkdm: struct clockdomain *
  *
  * Instruct the CM to force a sleep transition on the specified
- * clockdomain 'clkdm'.  Returns -EINVAL if clk is NULL or if
+ * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if
  * clockdomain does not support software-initiated sleep; 0 upon
  * success.
  */
@@ -828,7 +828,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
  * @clkdm: struct clockdomain *
  *
  * Instruct the CM to force a wakeup transition on the specified
- * clockdomain 'clkdm'.  Returns -EINVAL if clkdm is NULL or if the
+ * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if the
  * clockdomain does not support software-controlled wakeup; 0 upon
  * success.
  */
@@ -871,7 +871,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
  * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
  * @clkdm: struct clockdomain *
  *
- * Allow the hardware to automatically switch the clockdomain into
+ * Allow the hardware to automatically switch the clockdomain @clkdm into
  * active or idle states, as needed by downstream clocks.  If the
  * clockdomain has any downstream clocks enabled in the clock
  * framework, wkdep/sleepdep autodependencies are added; this is so
@@ -904,8 +904,8 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
  * @clkdm: struct clockdomain *
  *
  * Prevent the hardware from automatically switching the clockdomain
- * into inactive or idle states.  If the clockdomain has downstream
- * clocks enabled in the clock framework, wkdep/sleepdep
+ * @clkdm into inactive or idle states.  If the clockdomain has
+ * downstream clocks enabled in the clock framework, wkdep/sleepdep
  * autodependencies are removed.  No return value.
  */
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
@@ -936,14 +936,14 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
  * @clkdm: struct clockdomain *
  * @clk: struct clk * of the enabled downstream clock
  *
- * Increment the usecount of this clockdomain 'clkdm' and ensure that
- * it is awake.  Intended to be called by clk_enable() code.  If the
- * clockdomain is in software-supervised idle mode, force the
- * clockdomain to wake.  If the clockdomain is in hardware-supervised
- * idle mode, add clkdm-pwrdm autodependencies, to ensure that devices
- * in the clockdomain can be read from/written to by on-chip processors.
- * Returns -EINVAL if passed null pointers; returns 0 upon success or
- * if the clockdomain is in hwsup idle mode.
+ * Increment the usecount of the clockdomain @clkdm and ensure that it
+ * is awake before @clk is enabled.  Intended to be called by
+ * clk_enable() code.  If the clockdomain is in software-supervised
+ * idle mode, force the clockdomain to wake.  If the clockdomain is in
+ * hardware-supervised idle mode, add clkdm-pwrdm autodependencies, to
+ * ensure that devices in the clockdomain can be read from/written to
+ * by on-chip processors.  Returns -EINVAL if passed null pointers;
+ * returns 0 upon success or if the clockdomain is in hwsup idle mode.
  */
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 {
@@ -988,13 +988,14 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
  * @clkdm: struct clockdomain *
  * @clk: struct clk * of the disabled downstream clock
  *
- * Decrement the usecount of this clockdomain 'clkdm'. Intended to be
- * called by clk_disable() code.  If the usecount goes to 0, put the
- * clockdomain to sleep (software-supervised mode) or remove the
- * clkdm-pwrdm autodependencies (hardware-supervised mode).  Returns
- * -EINVAL if passed null pointers; -ERANGE if the clkdm usecount
- * underflows and debugging is enabled; or returns 0 upon success or
- * if the clockdomain is in hwsup idle mode.
+ * Decrement the usecount of this clockdomain @clkdm when @clk is
+ * disabled.  Intended to be called by clk_disable() code.  If the
+ * clockdomain usecount goes to 0, put the clockdomain to sleep
+ * (software-supervised mode) or remove the clkdm autodependencies
+ * (hardware-supervised mode).  Returns -EINVAL if passed null
+ * pointers; -ERANGE if the @clkdm usecount underflows and debugging
+ * is enabled; or returns 0 upon success or if the clockdomain is in
+ * hwsup idle mode.
  */
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 {
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9d4b8f5..dc03289 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -185,11 +185,13 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 
 /**
  * pwrdm_init - set up the powerdomain layer
+ * @pwrdm_list: array of struct powerdomain pointers to register
  *
- * Loop through the list of powerdomains, registering all that are
- * available on the current CPU. If pwrdm_list is supplied and not
- * null, all of the referenced powerdomains will be registered.  No
- * return value.
+ * Loop through the array of powerdomains @pwrdm_list, registering all
+ * that are available on the current CPU. If pwrdm_list is supplied
+ * and not null, all of the referenced powerdomains will be
+ * registered.  No return value.  XXX pwrdm_list is not really a
+ * "list"; it is an array.  Rename appropriately.
  */
 void pwrdm_init(struct powerdomain **pwrdm_list)
 {
@@ -217,8 +219,8 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
  * pwrdm_lookup - look up a powerdomain by name, return a pointer
  * @name: name of powerdomain
  *
- * Find a registered powerdomain by its name.  Returns a pointer to the
- * struct powerdomain if found, or NULL otherwise.
+ * Find a registered powerdomain by its name @name.  Returns a pointer
+ * to the struct powerdomain if found, or NULL otherwise.
  */
 struct powerdomain *pwrdm_lookup(const char *name)
 {
@@ -236,11 +238,11 @@ struct powerdomain *pwrdm_lookup(const char *name)
  * pwrdm_for_each - call function on each registered clockdomain
  * @fn: callback function *
  *
- * Call the supplied function for each registered powerdomain.  The
- * callback function can return anything but 0 to bail out early from
- * the iterator.  Returns the last return value of the callback function, which
- * should be 0 for success or anything else to indicate failure; or -EINVAL if
- * the function pointer is null.
+ * Call the supplied function @fn for each registered powerdomain.
+ * The callback function @fn can return anything but 0 to bail out
+ * early from the iterator.  Returns the last return value of the
+ * callback function, which should be 0 for success or anything else
+ * to indicate failure; or -EINVAL if the function pointer is null.
  */
 int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
 		   void *user)
@@ -265,7 +267,7 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
  * @pwrdm: struct powerdomain * to add the clockdomain to
  * @clkdm: struct clockdomain * to associate with a powerdomain
  *
- * Associate the clockdomain 'clkdm' with a powerdomain 'pwrdm'.  This
+ * Associate the clockdomain @clkdm with a powerdomain @pwrdm.  This
  * enables the use of pwrdm_for_each_clkdm().  Returns -EINVAL if
  * presented with invalid pointers; -ENOMEM if memory could not be allocated;
  * or 0 upon success.
@@ -313,10 +315,10 @@ pac_exit:
  * @pwrdm: struct powerdomain * to add the clockdomain to
  * @clkdm: struct clockdomain * to associate with a powerdomain
  *
- * Dissociate the clockdomain 'clkdm' from the powerdomain
- * 'pwrdm'. Returns -EINVAL if presented with invalid pointers;
- * -ENOENT if the clkdm was not associated with the powerdomain, or 0
- * upon success.
+ * Dissociate the clockdomain @clkdm from the powerdomain
+ * @pwrdm. Returns -EINVAL if presented with invalid pointers; -ENOENT
+ * if @clkdm was not associated with the powerdomain, or 0 upon
+ * success.
  */
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
 {
@@ -353,8 +355,8 @@ pdc_exit:
  * @pwrdm: struct powerdomain * to iterate over
  * @fn: callback function *
  *
- * Call the supplied function for each clockdomain in the powerdomain
- * 'pwrdm'.  The callback function can return anything but 0 to bail
+ * Call the supplied function @fn for each clockdomain in the powerdomain
+ * @pwrdm.  The callback function can return anything but 0 to bail
  * out early from the iterator.  Returns -EINVAL if presented with
  * invalid pointers; or passes along the last return value of the
  * callback function, which should be 0 for success or anything else
@@ -380,7 +382,7 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
  * pwrdm_get_mem_bank_count - get number of memory banks in this powerdomain
  * @pwrdm: struct powerdomain *
  *
- * Return the number of controllable memory banks in powerdomain pwrdm,
+ * Return the number of controllable memory banks in powerdomain @pwrdm,
  * starting with 1.  Returns -EINVAL if the powerdomain pointer is null.
  */
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
@@ -396,7 +398,7 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
  *
- * Set the powerdomain pwrdm's next power state to pwrst.  The powerdomain
+ * Set the powerdomain @pwrdm's next power state to @pwrst.  The powerdomain
  * may not enter this state immediately if the preconditions for this state
  * have not been satisfied.  Returns -EINVAL if the powerdomain pointer is
  * null or if the power state is invalid for the powerdomin, or returns 0
@@ -424,7 +426,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
  * pwrdm_read_next_pwrst - get next powerdomain power state
  * @pwrdm: struct powerdomain * to get power state
  *
- * Return the powerdomain pwrdm's next power state.  Returns -EINVAL
+ * Return the powerdomain @pwrdm's next power state.  Returns -EINVAL
  * if the powerdomain pointer is null or returns the next power state
  * upon success.
  */
@@ -441,7 +443,7 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
  * pwrdm_read_pwrst - get current powerdomain power state
  * @pwrdm: struct powerdomain * to get power state
  *
- * Return the powerdomain pwrdm's current power state.	Returns -EINVAL
+ * Return the powerdomain @pwrdm's current power state.	Returns -EINVAL
  * if the powerdomain pointer is null or returns the current power state
  * upon success.
  */
@@ -458,7 +460,7 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
  * pwrdm_read_prev_pwrst - get previous powerdomain power state
  * @pwrdm: struct powerdomain * to get previous power state
  *
- * Return the powerdomain pwrdm's previous power state.  Returns -EINVAL
+ * Return the powerdomain @pwrdm's previous power state.  Returns -EINVAL
  * if the powerdomain pointer is null or returns the previous power state
  * upon success.
  */
@@ -476,11 +478,11 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
  *
- * Set the next power state that the logic portion of the powerdomain
- * pwrdm will enter when the powerdomain enters retention.  This will
- * be either RETENTION or OFF, if supported.  Returns -EINVAL if the
- * powerdomain pointer is null or the target power state is not not
- * supported, or returns 0 upon success.
+ * Set the next power state @pwrst that the logic portion of the
+ * powerdomain @pwrdm will enter when the powerdomain enters retention.
+ * This will be either RETENTION or OFF, if supported.  Returns
+ * -EINVAL if the powerdomain pointer is null or the target power
+ * state is not not supported, or returns 0 upon success.
  */
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
@@ -512,13 +514,14 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
  * @bank: memory bank number to set (0-3)
  * @pwrst: one of the PWRDM_POWER_* macros
  *
- * Set the next power state that memory bank x of the powerdomain
- * pwrdm will enter when the powerdomain enters the ON state.  Bank
- * will be a number from 0 to 3, and represents different types of
- * memory, depending on the powerdomain.  Returns -EINVAL if the
- * powerdomain pointer is null or the target power state is not not
- * supported for this memory bank, -EEXIST if the target memory bank
- * does not exist or is not controllable, or returns 0 upon success.
+ * Set the next power state @pwrst that memory bank @bank of the
+ * powerdomain @pwrdm will enter when the powerdomain enters the ON
+ * state.  @bank will be a number from 0 to 3, and represents different
+ * types of memory, depending on the powerdomain.  Returns -EINVAL if
+ * the powerdomain pointer is null or the target power state is not
+ * not supported for this memory bank, -EEXIST if the target memory
+ * bank does not exist or is not controllable, or returns 0 upon
+ * success.
  */
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 {
@@ -575,14 +578,15 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  * @bank: memory bank number to set (0-3)
  * @pwrst: one of the PWRDM_POWER_* macros
  *
- * Set the next power state that memory bank x of the powerdomain
- * pwrdm will enter when the powerdomain enters the RETENTION state.
- * Bank will be a number from 0 to 3, and represents different types
- * of memory, depending on the powerdomain.  pwrst will be either
- * RETENTION or OFF, if supported. Returns -EINVAL if the powerdomain
- * pointer is null or the target power state is not not supported for
- * this memory bank, -EEXIST if the target memory bank does not exist
- * or is not controllable, or returns 0 upon success.
+ * Set the next power state @pwrst that memory bank @bank of the
+ * powerdomain @pwrdm will enter when the powerdomain enters the
+ * RETENTION state.  Bank will be a number from 0 to 3, and represents
+ * different types of memory, depending on the powerdomain.  @pwrst
+ * will be either RETENTION or OFF, if supported.  Returns -EINVAL if
+ * the powerdomain pointer is null or the target power state is not
+ * not supported for this memory bank, -EEXIST if the target memory
+ * bank does not exist or is not controllable, or returns 0 upon
+ * success.
  */
 int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 {
@@ -637,10 +641,10 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  * pwrdm_read_logic_pwrst - get current powerdomain logic retention power state
  * @pwrdm: struct powerdomain * to get current logic retention power state
  *
- * Return the current power state that the logic portion of
- * powerdomain pwrdm will enter
- * Returns -EINVAL if the powerdomain pointer is null or returns the
- * current logic retention power state upon success.
+ * Return the power state that the logic portion of powerdomain @pwrdm
+ * will enter when the powerdomain enters retention.  Returns -EINVAL
+ * if the powerdomain pointer is null or returns the logic retention
+ * power state upon success.
  */
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
@@ -655,9 +659,9 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
  * pwrdm_read_prev_logic_pwrst - get previous powerdomain logic power state
  * @pwrdm: struct powerdomain * to get previous logic power state
  *
- * Return the powerdomain pwrdm's logic power state.  Returns -EINVAL
- * if the powerdomain pointer is null or returns the previous logic
- * power state upon success.
+ * Return the powerdomain @pwrdm's previous logic power state.  Returns
+ * -EINVAL if the powerdomain pointer is null or returns the previous
+ * logic power state upon success.
  */
 int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 {
@@ -679,8 +683,8 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
  * @pwrdm: struct powerdomain * to get current memory bank power state
  * @bank: memory bank number (0-3)
  *
- * Return the powerdomain pwrdm's current memory power state for bank
- * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
+ * Return the powerdomain @pwrdm's current memory power state for bank
+ * @bank.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
  * the target memory bank does not exist or is not controllable, or
  * returns the current memory power state upon success.
  */
@@ -733,10 +737,11 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
  * @pwrdm: struct powerdomain * to get previous memory bank power state
  * @bank: memory bank number (0-3)
  *
- * Return the powerdomain pwrdm's previous memory power state for bank
- * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
- * the target memory bank does not exist or is not controllable, or
- * returns the previous memory power state upon success.
+ * Return the powerdomain @pwrdm's previous memory power state for
+ * bank @bank.  Returns -EINVAL if the powerdomain pointer is null,
+ * -EEXIST if the target memory bank does not exist or is not
+ * controllable, or returns the previous memory power state upon
+ * success.
  */
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
@@ -783,10 +788,10 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
  * pwrdm_clear_all_prev_pwrst - clear previous powerstate register for a pwrdm
  * @pwrdm: struct powerdomain * to clear
  *
- * Clear the powerdomain's previous power state register.  Clears the
- * entire register, including logic and memory bank previous power states.
- * Returns -EINVAL if the powerdomain pointer is null, or returns 0 upon
- * success.
+ * Clear the powerdomain's previous power state register @pwrdm.
+ * Clears the entire register, including logic and memory bank
+ * previous power states.  Returns -EINVAL if the powerdomain pointer
+ * is null, or returns 0 upon success.
  */
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 {
@@ -811,11 +816,11 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
  * @pwrdm: struct powerdomain *
  *
  * Enable automatic context save-and-restore upon power state change
- * for some devices in a powerdomain.  Warning: this only affects a
- * subset of devices in a powerdomain; check the TRM closely.  Returns
- * -EINVAL if the powerdomain pointer is null or if the powerdomain
- * does not support automatic save-and-restore, or returns 0 upon
- * success.
+ * for some devices in the powerdomain @pwrdm.  Warning: this only
+ * affects a subset of devices in a powerdomain; check the TRM
+ * closely.  Returns -EINVAL if the powerdomain pointer is null or if
+ * the powerdomain does not support automatic save-and-restore, or
+ * returns 0 upon success.
  */
 int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 {
@@ -839,11 +844,11 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
  * @pwrdm: struct powerdomain *
  *
  * Disable automatic context save-and-restore upon power state change
- * for some devices in a powerdomain.  Warning: this only affects a
- * subset of devices in a powerdomain; check the TRM closely.  Returns
- * -EINVAL if the powerdomain pointer is null or if the powerdomain
- * does not support automatic save-and-restore, or returns 0 upon
- * success.
+ * for some devices in the powerdomain @pwrdm.  Warning: this only
+ * affects a subset of devices in a powerdomain; check the TRM
+ * closely.  Returns -EINVAL if the powerdomain pointer is null or if
+ * the powerdomain does not support automatic save-and-restore, or
+ * returns 0 upon success.
  */
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 {
@@ -866,7 +871,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
  * pwrdm_has_hdwr_sar - test whether powerdomain supports hardware SAR
  * @pwrdm: struct powerdomain *
  *
- * Returns 1 if powerdomain 'pwrdm' supports hardware save-and-restore
+ * Returns 1 if powerdomain @pwrdm supports hardware save-and-restore
  * for some devices, or 0 if it does not.
  */
 bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
@@ -878,7 +883,7 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
  * pwrdm_wait_transition - wait for powerdomain power transition to finish
  * @pwrdm: struct powerdomain * to wait for
  *
- * If the powerdomain pwrdm is in the process of a state transition,
+ * If the powerdomain @pwrdm is in the process of a state transition,
  * spin until it completes the power transition, or until an iteration
  * bailout value is reached. Returns -EINVAL if the powerdomain
  * pointer is null, -EAGAIN if the bailout value was reached, or
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index 45b5deb..683fdf0 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -40,86 +40,77 @@
 #define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP		0x2
 #define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
 
-/*
- * struct clkdm_autodep - a clockdomain that should have wkdeps
- * and sleepdeps added when a clockdomain should stay active in hwsup mode;
- * and conversely, removed when the clockdomain should be allowed to go
- * inactive in hwsup mode.
+/**
+ * struct clkdm_autodep - clkdm deps to add when entering/exiting hwsup mode
+ * @clkdm: clockdomain to add wkdep+sleepdep on - set name member only
+ * @omap_chip: OMAP chip types that this autodep is valid on
+ *
+ * A clockdomain that should have wkdeps and sleepdeps added when a
+ * clockdomain should stay active in hwsup mode; and conversely,
+ * removed when the clockdomain should be allowed to go inactive in
+ * hwsup mode.
+ *
+ * Autodeps are deprecated and should be removed after
+ * omap_hwmod-based fine-grained module idle control is added.
  */
 struct clkdm_autodep {
-
 	union {
-		/* Name of the clockdomain to add a wkdep/sleepdep on */
 		const char *name;
-
-		/* Clockdomain pointer (looked up at clkdm_init() time) */
 		struct clockdomain *ptr;
 	} clkdm;
-
-	/* OMAP chip types that this clockdomain dep is valid on */
 	const struct omap_chip_id omap_chip;
-
 };
 
-/* Encodes dependencies between clockdomains - statically defined */
+/**
+ * struct clkdm_dep - encode dependencies between clockdomains
+ * @clkdm_name: clockdomain name
+ * @clkdm: pointer to the struct clockdomain of @clkdm_name
+ * @omap_chip: OMAP chip types that this dependency is valid on
+ * @wkdep_usecount: Number of wakeup dependencies causing this clkdm to wake
+ * @sleepdep_usecount: Number of sleep dependencies that could prevent clkdm from idle
+ *
+ * Statically defined.  @clkdm is resolved from @clkdm_name at runtime and
+ * should not be pre-initialized.
+ *
+ * XXX Should also include hardware (fixed) dependencies.
+ */
 struct clkdm_dep {
-
-	/* Clockdomain name */
 	const char *clkdm_name;
-
-	/* Clockdomain pointer - resolved by the clockdomain code */
 	struct clockdomain *clkdm;
-
-	/* Number of wakeup dependencies causing this clkdm to wake  */
 	atomic_t wkdep_usecount;
-
-	/* Number of sleep dependencies that could prevent clkdm from idle */
 	atomic_t sleepdep_usecount;
-
-	/* Flags to mark OMAP chip restrictions, etc. */
 	const struct omap_chip_id omap_chip;
-
 };
 
+/**
+ * struct clockdomain - OMAP clockdomain
+ * @name: clockdomain name
+ * @pwrdm: powerdomain containing this clockdomain
+ * @clktrctrl_reg: CLKSTCTRL reg for the given clock domain
+ * @clktrctrl_mask: CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg
+ * @flags: Clockdomain capability flags
+ * @dep_bit: Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit
+ * @wkdep_srcs: Clockdomains that can be told to wake this powerdomain up
+ * @sleepdep_srcs: Clockdomains that can be told to keep this clkdm from inact
+ * @omap_chip: OMAP chip types that this clockdomain is valid on
+ * @usecount: Usecount tracking
+ * @node: list_head to link all clockdomains together
+ */
 struct clockdomain {
-
-	/* Clockdomain name */
 	const char *name;
-
 	union {
-		/* Powerdomain enclosing this clockdomain */
 		const char *name;
-
-		/* Powerdomain pointer assigned at clkdm_register() */
 		struct powerdomain *ptr;
 	} pwrdm;
-
-	/* CLKSTCTRL reg for the given clock domain*/
 	void __iomem *clkstctrl_reg;
-
-	/* CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg */
 	const u16 clktrctrl_mask;
-
-	/* Clockdomain capability flags */
 	const u8 flags;
-
-	/* Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit */
 	const u8 dep_bit;
-
-	/* Clockdomains that can be told to wake this powerdomain up */
 	struct clkdm_dep *wkdep_srcs;
-
-	/* Clockdomains that can be told to keep this clkdm from inactivity */
 	struct clkdm_dep *sleepdep_srcs;
-
-	/* OMAP chip types that this clockdomain is valid on */
 	const struct omap_chip_id omap_chip;
-
-	/* Usecount tracking */
 	atomic_t usecount;
-
 	struct list_head node;
-
 };
 
 void clkdm_init(struct clockdomain **clkdms, struct clkdm_autodep *autodeps);
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 87e13f8..e15c7e9 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -68,40 +68,36 @@
 struct clockdomain;
 struct powerdomain;
 
+/**
+ * struct powerdomain - OMAP powerdomain
+ * @name: Powerdomain name
+ * @omap_chip: represents the OMAP chip types containing this pwrdm
+ * @prcm_offs: the address offset from CM_BASE/PRM_BASE
+ * @pwrsts: Possible powerdomain power states
+ * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENTION
+ * @flags: Powerdomain flags
+ * @banks: Number of software-controllable memory banks in this powerdomain
+ * @pwrsts_mem_ret: Possible memory bank pwrstates when pwrdm in RETENTION
+ * @pwrsts_mem_on: Possible memory bank pwrstates when pwrdm in ON
+ * @pwrdm_clkdms: Clockdomains in this powerdomain
+ * @node: list_head linking all powerdomains
+ * @state:
+ * @state_counter:
+ * @timer:
+ * @state_timer:
+ */
 struct powerdomain {
-
-	/* Powerdomain name */
 	const char *name;
-
-	/* Used to represent the OMAP chip types containing this pwrdm */
 	const struct omap_chip_id omap_chip;
-
-	/* the address offset from CM_BASE/PRM_BASE */
 	const s16 prcm_offs;
-
-	/* Possible powerdomain power states */
 	const u8 pwrsts;
-
-	/* Possible logic power states when pwrdm in RETENTION */
 	const u8 pwrsts_logic_ret;
-
-	/* Powerdomain flags */
 	const u8 flags;
-
-	/* Number of software-controllable memory banks in this powerdomain */
 	const u8 banks;
-
-	/* Possible memory bank pwrstates when pwrdm in RETENTION */
 	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
-
-	/* Possible memory bank pwrstates when pwrdm is ON */
 	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
-
-	/* Clockdomains in this powerdomain */
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
-
 	struct list_head node;
-
 	int state;
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
 


