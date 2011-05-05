From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/4] OMAP3: cpuidle: re-organize the C-states data
Date: Thu, 05 May 2011 10:55:52 -0700
Message-ID: <87d3jxghg7.fsf@ti.com>
References: <1304608359-18061-1-git-send-email-j-pihet@ti.com>
	<1304608359-18061-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43292 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755412Ab1EERz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 13:55:56 -0400
Received: by pwi16 with SMTP id 16so1583994pwi.35
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 10:55:54 -0700 (PDT)
In-Reply-To: <1304608359-18061-3-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Thu, 5 May 2011 17:12:37 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Jean,

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> The current implementation defines an internal structure and a
> C-states array. Using those structures is redundant to the
> structs used by the cpuidle framework.
>
> This patch provides a clean-up of the internal struct, removes the
> internal C-states array, stores the data using the existing cpuidle
> per C-state struct and registers the mach specific data to cpuidle
> C-state driver_data (accessed using cpuidle_[gs]et_statedata).
> Also removes unused macros, fields and code and compacts the repeating
> code using an inline helper function.
>
> The result is more compact and more readable code as well as
> reduced data RAM usage.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Some minor comments below...

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |  291 ++++++++++++------------------------
>  1 files changed, 97 insertions(+), 194 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index d7bc31a..816b483 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -36,34 +36,19 @@
>  
>  #ifdef CONFIG_CPU_IDLE
>  
> -#define OMAP3_MAX_STATES 7
> -#define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */
> -#define OMAP3_STATE_C2 1 /* C2 - MPU WFI + Core inactive */
> -#define OMAP3_STATE_C3 2 /* C3 - MPU CSWR + Core inactive */
> -#define OMAP3_STATE_C4 3 /* C4 - MPU OFF + Core iactive */
> -#define OMAP3_STATE_C5 4 /* C5 - MPU RET + Core RET */
> -#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core RET */
> -#define OMAP3_STATE_C7 6 /* C7 - MPU OFF + Core OFF */
> +#define OMAP3_STATE_MIN		0
> +#define OMAP3_STATE_MAX		6 /* Deepest sleep C-state */
> +#define OMAP3_NB_STATES		(OMAP3_STATE_MAX + 1)

How about droping MIN and MAX all together.  Min is always zero, just
use zero in the code.

Then later, 

static struct cpuidle_params cpuidle_params_table[] = {
  	/* C1 */
  	{2 + 2, 5, 1},
        ...
};

#define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table);

This way is less error prone, since when adding/removing states, you
don't also have to manually update NUM_STATES.

> -#define OMAP3_STATE_MAX OMAP3_STATE_C7
> -
> -#define CPUIDLE_FLAG_CHECK_BM	0x10000	/* use omap3_enter_idle_bm() */
> -
> -struct omap3_processor_cx {
> -	u8 valid;
> -	u8 type;
> -	u32 exit_latency;
> +/* Mach specific information to be recorded in the C-state driver_data */
> +struct omap3_idle_statedata {
>  	u32 mpu_state;
>  	u32 core_state;
> -	u32 target_residency;
> -	u32 flags;
> -	const char *desc;
> +	u8 valid;
>  };
> +struct omap3_idle_statedata omap3_idle_data[OMAP3_NB_STATES];
> -struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
> -struct omap3_processor_cx current_cx_state;
> -struct powerdomain *mpu_pd, *core_pd, *per_pd;
> -struct powerdomain *cam_pd;
> +struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>  
>  /*
>   * The latencies/thresholds for various C states have
> @@ -72,7 +57,7 @@ struct powerdomain *cam_pd;
>   * the best power savings) used on boards which do not
>   * pass these details from the board file.
>   */
> -static struct cpuidle_params cpuidle_params_table[] = {
> +static struct cpuidle_params cpuidle_params_table[OMAP3_NB_STATES] = {
>  	/* C1 */
>  	{2 + 2, 5, 1},
>  	/* C2 */
> @@ -121,12 +106,10 @@ static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
>  static int omap3_enter_idle(struct cpuidle_device *dev,
>  			struct cpuidle_state *state)
>  {
> -	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
> +	struct omap3_idle_statedata *cx = cpuidle_get_statedata(state);
>  	struct timespec ts_preidle, ts_postidle, ts_idle;
>  	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
>  
> -	current_cx_state = *cx;
> -
>  	/* Used to keep track of the total time in idle */
>  	getnstimeofday(&ts_preidle);
>  
> @@ -139,7 +122,8 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	if (omap_irq_pending() || need_resched())
>  		goto return_sleep_time;
>  
> -	if (cx->type == OMAP3_STATE_C1) {
> +	/* Deny idle for C1 */
> +	if (state == &dev->states[0]) {
>  		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
>  		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
>  	}
> @@ -147,7 +131,8 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	/* Execute ARM wfi */
>  	omap_sram_idle();
>  
> -	if (cx->type == OMAP3_STATE_C1) {
> +	/* Re-allow idle for C1 */
> +	if (state == &dev->states[0]) {
>  		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
>  		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
>  	}
> @@ -169,15 +154,15 @@ return_sleep_time:
>   *
>   * If the current state is valid, it is returned back to the caller.
>   * Else, this function searches for a lower c-state which is still
> - * valid (as defined in omap3_power_states[]).
> + * valid.
>   */
>  static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
> -						struct cpuidle_state *curr)
> +					      struct cpuidle_state *curr)
>  {
>  	struct cpuidle_state *next = NULL;
> -	struct omap3_processor_cx *cx;
> +	struct omap3_idle_statedata *cx;
>  
> -	cx = (struct omap3_processor_cx *)cpuidle_get_statedata(curr);
> +	cx = cpuidle_get_statedata(curr);
>  
>  	/* Check if current state is valid */
>  	if (cx->valid) {
> @@ -188,7 +173,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
>  		/*
>  		 * Reach the current state starting at highest C-state
>  		 */
> -		for (; idx >= OMAP3_STATE_C1; idx--) {
> +		for (; idx >= OMAP3_STATE_MIN; idx--) {
>  			if (&dev->states[idx] == curr) {
>  				next = &dev->states[idx];
>  				break;
> @@ -205,9 +190,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
>  		 * Start search from the next (lower) state.
>  		 */
>  		idx--;
> -		for (; idx >= OMAP3_STATE_C1; idx--) {
> -			struct omap3_processor_cx *cx;
> -
> +		for (; idx >= OMAP3_STATE_MIN; idx--) {
>  			cx = cpuidle_get_statedata(&dev->states[idx]);
>  			if (cx->valid) {
>  				next = &dev->states[idx];
> @@ -228,9 +211,8 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
>   * @dev: cpuidle device
>   * @state: The target state to be programmed
>   *
> - * Used for C states with CPUIDLE_FLAG_CHECK_BM flag set. This
> - * function checks for any pending activity and then programs the
> - * device to the specified or a safer state.
> + * This function checks for any pending activity and then programs
> + * the device to the specified or a safer state.
>   */
>  static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  			       struct cpuidle_state *state)
> @@ -238,10 +220,10 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  	struct cpuidle_state *new_state = next_valid_state(dev, state);
>  	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
>  	u32 cam_state;
> -	struct omap3_processor_cx *cx;
> +	struct omap3_idle_statedata *cx;
>  	int ret;
>  
> -	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
> +	if (omap3_idle_bm_check()) {
>  		BUG_ON(!dev->safe_state);
>  		new_state = dev->safe_state;
>  		goto select_state;
> @@ -307,8 +289,8 @@ void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
>  {
>  	int i;
>  
> -	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
> -		struct omap3_processor_cx *cx = &omap3_power_states[i];
> +	for (i = OMAP3_STATE_MIN; i < OMAP3_NB_STATES; i++) {
> +		struct omap3_idle_statedata *cx = &omap3_idle_data[i];
>  
>  		if ((cx->mpu_state >= mpu_deepest_state) &&
>  		    (cx->core_state >= core_deepest_state)) {
> @@ -326,9 +308,8 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
>  	if (!cpuidle_board_params)
>  		return;
>  
> -	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
> -		cpuidle_params_table[i].valid =
> -			cpuidle_board_params[i].valid;
> +	for (i = OMAP3_STATE_MIN; i < OMAP3_NB_STATES; i++) {
> +		cpuidle_params_table[i].valid =	cpuidle_board_params[i].valid;
>  		cpuidle_params_table[i].exit_latency =
>  			cpuidle_board_params[i].exit_latency;
>  		cpuidle_params_table[i].target_residency =
> @@ -337,134 +318,30 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
>  	return;
>  }
>  
> -/* omap3_init_power_states - Initialises the OMAP3 specific C states.
> - *
> - * Below is the desciption of each C state.
> - * 	C1 . MPU WFI + Core active
> - *	C2 . MPU WFI + Core inactive
> - *	C3 . MPU CSWR + Core inactive
> - *	C4 . MPU OFF + Core inactive
> - *	C5 . MPU CSWR + Core CSWR
> - *	C6 . MPU OFF + Core CSWR
> - *	C7 . MPU OFF + Core OFF
> - */
> -void omap_init_power_states(void)
> -{
> -	/* C1 . MPU WFI + Core active */
> -	omap3_power_states[OMAP3_STATE_C1].valid =
> -			cpuidle_params_table[OMAP3_STATE_C1].valid;
> -	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
> -	omap3_power_states[OMAP3_STATE_C1].exit_latency =
> -			cpuidle_params_table[OMAP3_STATE_C1].exit_latency;
> -	omap3_power_states[OMAP3_STATE_C1].target_residency =
> -			cpuidle_params_table[OMAP3_STATE_C1].target_residency;
> -	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
> -	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
> -	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
> -	omap3_power_states[OMAP3_STATE_C1].desc = "MPU ON + CORE ON";
> -
> -	/* C2 . MPU WFI + Core inactive */
> -	omap3_power_states[OMAP3_STATE_C2].valid =
> -			cpuidle_params_table[OMAP3_STATE_C2].valid;
> -	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
> -	omap3_power_states[OMAP3_STATE_C2].exit_latency =
> -			cpuidle_params_table[OMAP3_STATE_C2].exit_latency;
> -	omap3_power_states[OMAP3_STATE_C2].target_residency =
> -			cpuidle_params_table[OMAP3_STATE_C2].target_residency;
> -	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
> -	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
> -	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
> -				CPUIDLE_FLAG_CHECK_BM;
> -	omap3_power_states[OMAP3_STATE_C2].desc = "MPU ON + CORE ON";
> -
> -	/* C3 . MPU CSWR + Core inactive */
> -	omap3_power_states[OMAP3_STATE_C3].valid =
> -			cpuidle_params_table[OMAP3_STATE_C3].valid;
> -	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
> -	omap3_power_states[OMAP3_STATE_C3].exit_latency =
> -			cpuidle_params_table[OMAP3_STATE_C3].exit_latency;
> -	omap3_power_states[OMAP3_STATE_C3].target_residency =
> -			cpuidle_params_table[OMAP3_STATE_C3].target_residency;
> -	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
> -	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
> -	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
> -				CPUIDLE_FLAG_CHECK_BM;
> -	omap3_power_states[OMAP3_STATE_C3].desc = "MPU RET + CORE ON";
> -
> -	/* C4 . MPU OFF + Core inactive */
> -	omap3_power_states[OMAP3_STATE_C4].valid =
> -			cpuidle_params_table[OMAP3_STATE_C4].valid;
> -	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
> -	omap3_power_states[OMAP3_STATE_C4].exit_latency =
> -			cpuidle_params_table[OMAP3_STATE_C4].exit_latency;
> -	omap3_power_states[OMAP3_STATE_C4].target_residency =
> -			cpuidle_params_table[OMAP3_STATE_C4].target_residency;
> -	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
> -	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
> -	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
> -				CPUIDLE_FLAG_CHECK_BM;
> -	omap3_power_states[OMAP3_STATE_C4].desc = "MPU OFF + CORE ON";
> -
> -	/* C5 . MPU CSWR + Core CSWR*/
> -	omap3_power_states[OMAP3_STATE_C5].valid =
> -			cpuidle_params_table[OMAP3_STATE_C5].valid;
> -	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
> -	omap3_power_states[OMAP3_STATE_C5].exit_latency =
> -			cpuidle_params_table[OMAP3_STATE_C5].exit_latency;
> -	omap3_power_states[OMAP3_STATE_C5].target_residency =
> -			cpuidle_params_table[OMAP3_STATE_C5].target_residency;
> -	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
> -	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
> -	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
> -				CPUIDLE_FLAG_CHECK_BM;
> -	omap3_power_states[OMAP3_STATE_C5].desc = "MPU RET + CORE RET";
> -
> -	/* C6 . MPU OFF + Core CSWR */
> -	omap3_power_states[OMAP3_STATE_C6].valid =
> -			cpuidle_params_table[OMAP3_STATE_C6].valid;
> -	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
> -	omap3_power_states[OMAP3_STATE_C6].exit_latency =
> -			cpuidle_params_table[OMAP3_STATE_C6].exit_latency;
> -	omap3_power_states[OMAP3_STATE_C6].target_residency =
> -			cpuidle_params_table[OMAP3_STATE_C6].target_residency;
> -	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
> -	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
> -	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
> -				CPUIDLE_FLAG_CHECK_BM;
> -	omap3_power_states[OMAP3_STATE_C6].desc = "MPU OFF + CORE RET";
> -
> -	/* C7 . MPU OFF + Core OFF */
> -	omap3_power_states[OMAP3_STATE_C7].valid =
> -			cpuidle_params_table[OMAP3_STATE_C7].valid;
> -	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
> -	omap3_power_states[OMAP3_STATE_C7].exit_latency =
> -			cpuidle_params_table[OMAP3_STATE_C7].exit_latency;
> -	omap3_power_states[OMAP3_STATE_C7].target_residency =
> -			cpuidle_params_table[OMAP3_STATE_C7].target_residency;
> -	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
> -	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
> -	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
> -				CPUIDLE_FLAG_CHECK_BM;
> -	omap3_power_states[OMAP3_STATE_C7].desc = "MPU OFF + CORE OFF";
> -
> -	/*
> -	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
> -	 * enable OFF mode in a stable form for previous revisions.
> -	 * we disable C7 state as a result.
> -	 */
> -	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
> -		omap3_power_states[OMAP3_STATE_C7].valid = 0;
> -		cpuidle_params_table[OMAP3_STATE_C7].valid = 0;
> -		pr_warn("%s: core off state C7 disabled due to i583\n",
> -				__func__);
> -	}
> -}
> -
>  struct cpuidle_driver omap3_idle_driver = {
>  	.name = 	"omap3_idle",
>  	.owner = 	THIS_MODULE,
>  };
>  
> +/* Fill in the state data from the mach tables and register the driver_data */
> +static inline struct omap3_idle_statedata *fill_in_cstates_data(int idx,

Please prefix internal function helper with '_'.  Also, _data suffix
isn't really needed.  How about simply _fill_state()

> +					const char *descr,
> +					struct cpuidle_state *state)
> +{
> +	struct omap3_idle_statedata *data = &omap3_idle_data[idx];

Minor: please name this 'cx' to be consistent with other usage in this
file.

Also, I think this function should take 'struct cpuidle_device *dev' 
instead of 'struct cpuidle_state', and here it should do

        struct cpuidle_state *state = dev->states[idx]

IOW

static inline 
struct omap3_idle_statedata *_fill_state(struct cpuidle_device *dev, 
					 int idx, const char *desc);

> +	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
> +	state->target_residency	= cpuidle_params_table[idx].target_residency;
> +	state->flags		= CPUIDLE_FLAG_TIME_VALID;
> +	state->enter		= omap3_enter_idle_bm;
> +	data->valid		= cpuidle_params_table[idx].valid;
> +	sprintf(state->name, "C%d", idx + 1);
> +	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
> +	cpuidle_set_statedata(state, data);
> +
> +	return data;
> +}
> +
>  /**
>   * omap3_idle_init - Init routine for OMAP3 idle
>   *
> @@ -473,43 +350,69 @@ struct cpuidle_driver omap3_idle_driver = {
>   */
>  int __init omap3_idle_init(void)
>  {
> -	int i, count = 0;
> -	struct omap3_processor_cx *cx;
>  	struct cpuidle_state *state;
>  	struct cpuidle_device *dev;
> +	struct omap3_idle_statedata *data;

same here, please name this 'cx'

>  	mpu_pd = pwrdm_lookup("mpu_pwrdm");
>  	core_pd = pwrdm_lookup("core_pwrdm");
>  	per_pd = pwrdm_lookup("per_pwrdm");
>  	cam_pd = pwrdm_lookup("cam_pwrdm");
>  
> -	omap_init_power_states();
>  	cpuidle_register_driver(&omap3_idle_driver);
> -
>  	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
>  
> -	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
> -		cx = &omap3_power_states[i];
> -		state = &dev->states[count];
> -
> -		if (!cx->valid)
> -			continue;
> -		cpuidle_set_statedata(state, cx);
> -		state->exit_latency = cx->exit_latency;
> -		state->target_residency = cx->target_residency;
> -		state->flags = cx->flags;
> -		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
> -			omap3_enter_idle_bm : omap3_enter_idle;
> -		if (cx->type == OMAP3_STATE_C1)
> -			dev->safe_state = state;
> -		sprintf(state->name, "C%d", count+1);
> -		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
> -		count++;
> +	/* C1 . MPU WFI + Core active */
> +	state = &dev->states[0];
> +	data = fill_in_cstates_data(0, "MPU ON + CORE ON", state);
> +	state->enter = omap3_enter_idle;
> +	dev->safe_state = state;
> +	data->valid = 1;	/* C1 is always valid */
> +	data->mpu_state = PWRDM_POWER_ON;
> +	data->core_state = PWRDM_POWER_ON;
> +
> +	/* C2 . MPU WFI + Core inactive */
> +	data = fill_in_cstates_data(1, "MPU ON + CORE ON", &dev->states[1]);
> +	data->valid = 1;	/* C2 is always valid */

Why?

> +	data->mpu_state = PWRDM_POWER_ON;
> +	data->core_state = PWRDM_POWER_ON;
> +
> +	/* C3 . MPU CSWR + Core inactive */
> +	data = fill_in_cstates_data(2, "MPU RET + CORE ON", &dev->states[2]);
> +	data->mpu_state = PWRDM_POWER_RET;
> +	data->core_state = PWRDM_POWER_ON;
> +
> +	/* C4 . MPU OFF + Core inactive */
> +	data = fill_in_cstates_data(3, "MPU OFF + CORE ON", &dev->states[3]);
> +	data->mpu_state = PWRDM_POWER_OFF;
> +	data->core_state = PWRDM_POWER_ON;
> +
> +	/* C5 . MPU RET + Core RET */
> +	data = fill_in_cstates_data(4, "MPU RET + CORE RET", &dev->states[4]);
> +	data->mpu_state = PWRDM_POWER_RET;
> +	data->core_state = PWRDM_POWER_RET;
> +
> +	/* C6 . MPU OFF + Core RET */
> +	data = fill_in_cstates_data(5, "MPU OFF + CORE RET", &dev->states[5]);
> +	data->mpu_state = PWRDM_POWER_OFF;
> +	data->core_state = PWRDM_POWER_RET;
> +
> +	/* C7 . MPU OFF + Core OFF */
> +	data = fill_in_cstates_data(6, "MPU OFF + CORE OFF", &dev->states[6]);
> +	/*
> +	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
> +	 * enable OFF mode in a stable form for previous revisions.
> +	 * We disable C7 state as a result.
> +	 */
> +	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
> +		data->valid = 0;
> +		pr_warn("%s: core off state C7 disabled due to i583\n",
> +			__func__);
>  	}
> +	data->mpu_state = PWRDM_POWER_OFF;
> +	data->core_state = PWRDM_POWER_OFF;
>  
> -	if (!count)
> -		return -EINVAL;
> -	dev->state_count = count;
> +	dev->state_count = OMAP3_NB_STATES;
>  
>  	if (enable_off_mode)
>  		omap3_cpuidle_update_states(PWRDM_POWER_OFF, PWRDM_POWER_OFF);

Kevin
