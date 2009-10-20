From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 2/2] OMAP3: PM: Configure CPUidle latencies/thresholds from board file
Date: Tue, 20 Oct 2009 08:46:59 -0700
Message-ID: <877huqoyoc.fsf@deeprootsystems.com>
References: <1255697935-3521-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:63626 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbZJTPrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 11:47:14 -0400
Received: by pzk26 with SMTP id 26so4178234pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 08:47:19 -0700 (PDT)
In-Reply-To: <1255697935-3521-1-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Fri\, 16 Oct 2009 18\:28\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> The CPUidle C state latencies and thresholds are dependent
> on various board specific details.
> This patch makes it possible to configure these values from the
> respective board files.
>
> omap3_pm_init_cpuidle() can now be optionally called from board
> files to pass board specific cpuidle parameters.
> If the board files do not use this function to pass the params
> default values are used which might cause higher consumption
> dur to wrong state selection by the governor.
>
> This patch only updates the 3430sdp board files to use
> omap3_pm_init_cpuidle().
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, pulling v3 into PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/board-3430sdp.c |   19 ++++++
>  arch/arm/mach-omap2/cpuidle34xx.c   |  105 ++++++++++++++++++++++++++++-------
>  arch/arm/mach-omap2/pm.h            |    8 +++
>  3 files changed, 111 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 0f1975c..d2b2f8f 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -73,6 +73,24 @@ static struct prm_setup_vc omap3_setuptime_table = {
>  	.vdd1_off = 0x00,
>  };
>  
> +/* FIXME: These values need to be updated based on more profiling on 3430sdp*/
> +static struct cpuidle_params omap3_cpuidle_params_table[] = {
> +	/* C1 */
> +	{2, 2, 5},
> +	/* C2 */
> +	{10, 10, 30},
> +	/* C3 */
> +	{50, 50, 300},
> +	/* C4 */
> +	{1500, 1800, 4000},
> +	/* C5 */
> +	{2500, 7500, 12000},
> +	/* C6 */
> +	{3000, 8500, 15000},
> +	/* C7 */
> +	{10000, 30000, 300000},
> +};
> +
>  static int board_keymap[] = {
>  	KEY(0, 0, KEY_LEFT),
>  	KEY(0, 1, KEY_RIGHT),
> @@ -203,6 +221,7 @@ static void __init omap_3430sdp_init_irq(void)
>  	omap_board_config = sdp3430_config;
>  	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
>  	omap3_pm_init_vc(&omap3_setuptime_table);
> +	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
>  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
>  			     omap3_dsp_rate_table, omap3_l3_rate_table);
>  	omap_init_irq();
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index c44a942..f1ae474 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -60,6 +60,30 @@ struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
>  struct omap3_processor_cx current_cx_state;
>  struct powerdomain *mpu_pd, *core_pd, *per_pd;
>  
> +/*
> + * The latencies/thresholds for various C states have
> + * to be configured from the respective board files.
> + * These are some default values (which might not provide
> + * the best power savings) used on boards which do not
> + * pass these details from the board file.
> + */
> +static struct cpuidle_params cpuidle_params_table[] = {
> +	/* C1 */
> +	{2, 2, 5},
> +	/* C2 */
> +	{10, 10, 30},
> +	/* C3 */
> +	{50, 50, 300},
> +	/* C4 */
> +	{1500, 1800, 4000},
> +	/* C5 */
> +	{2500, 7500, 12000},
> +	/* C6 */
> +	{3000, 8500, 15000},
> +	/* C7 */
> +	{10000, 30000, 300000},
> +};
> +
>  static int omap3_idle_bm_check(void)
>  {
>  	if (!omap3_can_sleep())
> @@ -165,6 +189,24 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  
>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>  
> +void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
> +{
> +	int i;
> +
> +	if (!cpuidle_board_params)
> +		return;
> +
> +	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
> +		cpuidle_params_table[i].sleep_latency =
> +			cpuidle_board_params[i].sleep_latency;
> +		cpuidle_params_table[i].wake_latency =
> +			cpuidle_board_params[i].wake_latency;
> +		cpuidle_params_table[i].threshold =
> +			cpuidle_board_params[i].threshold;
> +	}
> +	return;
> +}
> +
>  /* omap3_init_power_states - Initialises the OMAP3 specific C states.
>   *
>   * Below is the desciption of each C state.
> @@ -181,9 +223,12 @@ void omap_init_power_states(void)
>  	/* C1 . MPU WFI + Core active */
>  	omap3_power_states[OMAP3_STATE_C1].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
> -	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 2;
> -	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 2;
> -	omap3_power_states[OMAP3_STATE_C1].threshold = 5;
> +	omap3_power_states[OMAP3_STATE_C1].sleep_latency =
> +			cpuidle_params_table[OMAP3_STATE_C1].sleep_latency;
> +	omap3_power_states[OMAP3_STATE_C1].wakeup_latency =
> +			cpuidle_params_table[OMAP3_STATE_C1].wake_latency;
> +	omap3_power_states[OMAP3_STATE_C1].threshold =
> +			cpuidle_params_table[OMAP3_STATE_C1].threshold;
>  	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
>  	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
>  	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
> @@ -191,9 +236,12 @@ void omap_init_power_states(void)
>  	/* C2 . MPU WFI + Core inactive */
>  	omap3_power_states[OMAP3_STATE_C2].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
> -	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 10;
> -	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 10;
> -	omap3_power_states[OMAP3_STATE_C2].threshold = 30;
> +	omap3_power_states[OMAP3_STATE_C2].sleep_latency =
> +			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;
> +	omap3_power_states[OMAP3_STATE_C2].wakeup_latency =
> +			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;
> +	omap3_power_states[OMAP3_STATE_C2].threshold =
> +			cpuidle_params_table[OMAP3_STATE_C2].threshold;
>  	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
>  	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
>  	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
> @@ -201,9 +249,12 @@ void omap_init_power_states(void)
>  	/* C3 . MPU CSWR + Core inactive */
>  	omap3_power_states[OMAP3_STATE_C3].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
> -	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 50;
> -	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 50;
> -	omap3_power_states[OMAP3_STATE_C3].threshold = 300;
> +	omap3_power_states[OMAP3_STATE_C3].sleep_latency =
> +			cpuidle_params_table[OMAP3_STATE_C3].sleep_latency;
> +	omap3_power_states[OMAP3_STATE_C3].wakeup_latency =
> +			cpuidle_params_table[OMAP3_STATE_C3].wake_latency;
> +	omap3_power_states[OMAP3_STATE_C3].threshold =
> +			cpuidle_params_table[OMAP3_STATE_C3].threshold;
>  	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
>  	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
>  	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
> @@ -212,9 +263,12 @@ void omap_init_power_states(void)
>  	/* C4 . MPU OFF + Core inactive */
>  	omap3_power_states[OMAP3_STATE_C4].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
> -	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 1500;
> -	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 1800;
> -	omap3_power_states[OMAP3_STATE_C4].threshold = 4000;
> +	omap3_power_states[OMAP3_STATE_C4].sleep_latency =
> +			cpuidle_params_table[OMAP3_STATE_C4].sleep_latency;
> +	omap3_power_states[OMAP3_STATE_C4].wakeup_latency =
> +			cpuidle_params_table[OMAP3_STATE_C4].wake_latency;
> +	omap3_power_states[OMAP3_STATE_C4].threshold =
> +			cpuidle_params_table[OMAP3_STATE_C4].threshold;
>  	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
>  	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
>  	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
> @@ -223,9 +277,12 @@ void omap_init_power_states(void)
>  	/* C5 . MPU CSWR + Core CSWR*/
>  	omap3_power_states[OMAP3_STATE_C5].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
> -	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 2500;
> -	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 7500;
> -	omap3_power_states[OMAP3_STATE_C5].threshold = 12000;
> +	omap3_power_states[OMAP3_STATE_C5].sleep_latency =
> +			cpuidle_params_table[OMAP3_STATE_C5].sleep_latency;
> +	omap3_power_states[OMAP3_STATE_C5].wakeup_latency =
> +			cpuidle_params_table[OMAP3_STATE_C5].wake_latency;
> +	omap3_power_states[OMAP3_STATE_C5].threshold =
> +			cpuidle_params_table[OMAP3_STATE_C5].threshold;
>  	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
>  	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
>  	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
> @@ -234,9 +291,12 @@ void omap_init_power_states(void)
>  	/* C6 . MPU OFF + Core CSWR */
>  	omap3_power_states[OMAP3_STATE_C6].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
> -	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 3000;
> -	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 8500;
> -	omap3_power_states[OMAP3_STATE_C6].threshold = 15000;
> +	omap3_power_states[OMAP3_STATE_C6].sleep_latency =
> +			cpuidle_params_table[OMAP3_STATE_C6].sleep_latency;
> +	omap3_power_states[OMAP3_STATE_C6].wakeup_latency =
> +			cpuidle_params_table[OMAP3_STATE_C6].wake_latency;
> +	omap3_power_states[OMAP3_STATE_C6].threshold =
> +			cpuidle_params_table[OMAP3_STATE_C6].threshold;
>  	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
>  	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
>  	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
> @@ -245,9 +305,12 @@ void omap_init_power_states(void)
>  	/* C7 . MPU OFF + Core OFF */
>  	omap3_power_states[OMAP3_STATE_C7].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
> -	omap3_power_states[OMAP3_STATE_C7].sleep_latency = 10000;
> -	omap3_power_states[OMAP3_STATE_C7].wakeup_latency = 30000;
> -	omap3_power_states[OMAP3_STATE_C7].threshold = 300000;
> +	omap3_power_states[OMAP3_STATE_C7].sleep_latency =
> +			cpuidle_params_table[OMAP3_STATE_C7].sleep_latency;
> +	omap3_power_states[OMAP3_STATE_C7].wakeup_latency =
> +			cpuidle_params_table[OMAP3_STATE_C7].wake_latency;
> +	omap3_power_states[OMAP3_STATE_C7].threshold =
> +			cpuidle_params_table[OMAP3_STATE_C7].threshold;
>  	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
>  	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
>  	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index ca673c5..0b814ab 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -41,7 +41,15 @@ struct prm_setup_vc {
>  	u16 vdd1_ret;
>  	u16 vdd1_off;
>  };
> +
> +struct cpuidle_params {
> +	u32 sleep_latency;
> +	u32 wake_latency;
> +	u32 threshold;
> +};
> +
>  extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
> +extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
>  
>  extern int resource_set_opp_level(int res, u32 target_level, int flags);
>  extern int resource_access_opp_lock(int res, int delta);
> -- 
> 1.5.4.7
