From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/5] OMAP3: cpuidle: re-organize the C-states data
Date: Fri, 29 Apr 2011 16:54:16 +0530
Message-ID: <4DBA9FE0.2030802@ti.com>
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com> <1304069186-3086-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:33366 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751310Ab1D2LYr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 07:24:47 -0400
Received: by gxk8 with SMTP id 8so1559159gxk.37
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 04:24:45 -0700 (PDT)
In-Reply-To: <1304069186-3086-4-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

Jean,

On 4/29/2011 2:56 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
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
> code using common macros.
>
> The result is more compact and more readable code as well as
> reduced data RAM usage.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/cpuidle34xx.c |  286 +++++++++++++------------------------
>   1 files changed, 97 insertions(+), 189 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index d7bc31a..f84315c 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -36,34 +36,25 @@
>
>   #ifdef CONFIG_CPU_IDLE
>
> -#define OMAP3_MAX_STATES 7
> -#define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */
> -#define OMAP3_STATE_C2 1 /* C2 - MPU WFI + Core inactive */
> -#define OMAP3_STATE_C3 2 /* C3 - MPU CSWR + Core inactive */
> -#define OMAP3_STATE_C4 3 /* C4 - MPU OFF + Core iactive */
> -#define OMAP3_STATE_C5 4 /* C5 - MPU RET + Core RET */
> -#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core RET */
> -#define OMAP3_STATE_C7 6 /* C7 - MPU OFF + Core OFF */
> -
> -#define OMAP3_STATE_MAX OMAP3_STATE_C7
> -
> -#define CPUIDLE_FLAG_CHECK_BM	0x10000	/* use omap3_enter_idle_bm() */
> -
> -struct omap3_processor_cx {
> -	u8 valid;
> -	u8 type;
> -	u32 exit_latency;
> +#define OMAP3_STATE_C1		0 /* C1 - MPU WFI + Core active */
> +#define OMAP3_STATE_C2		1 /* C2 - MPU WFI + Core inactive */
> +#define OMAP3_STATE_C3		2 /* C3 - MPU CSWR + Core inactive */
> +#define OMAP3_STATE_C4		3 /* C4 - MPU OFF + Core inactive */
> +#define OMAP3_STATE_C5		4 /* C5 - MPU RET + Core RET */
> +#define OMAP3_STATE_C6		5 /* C6 - MPU OFF + Core RET */
> +#define OMAP3_STATE_C7		6 /* C7 - MPU OFF + Core OFF */
> +#define OMAP3_STATE_MAX		OMAP3_STATE_C7
> +#define OMAP3_MAX_STATES	7
> +
> +/* Mach specific information to be recorded in the C-state driver_data */
> +struct omap3_idle_statedata {
>   	u32 mpu_state;
>   	u32 core_state;
> -	u32 target_residency;
> -	u32 flags;
> -	const char *desc;
> +	u8 valid;
>   };
> +struct omap3_idle_statedata omap3_idle_data[OMAP3_MAX_STATES];
>
> -struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
> -struct omap3_processor_cx current_cx_state;
> -struct powerdomain *mpu_pd, *core_pd, *per_pd;
> -struct powerdomain *cam_pd;
> +struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>
>   /*
>    * The latencies/thresholds for various C states have
> @@ -72,7 +63,7 @@ struct powerdomain *cam_pd;
>    * the best power savings) used on boards which do not
>    * pass these details from the board file.
>    */
> -static struct cpuidle_params cpuidle_params_table[] = {
> +static struct cpuidle_params cpuidle_params_table[OMAP3_MAX_STATES] = {

Nice cleanup. Using idle per device C-state struct is much cleaner
than the those static arrays.

[...]

>
> +/* Fill in the state data from the mach tables and register the driver_data */
> +#define FILL_IN_STATE(idx, descr)					\
> +do {									\
> +	state				=&dev->states[count];		\
> +	params				=&cpuidle_params_table[idx];	\
> +	data				=&omap3_idle_data[idx];	\
> +	state->exit_latency		= params->exit_latency;		\
> +	state->target_residency		= params->target_residency;	\
> +	state->flags			= CPUIDLE_FLAG_TIME_VALID;	\
> +	state->enter			= omap3_enter_idle_bm;		\
> +	sprintf(state->name, "C%d", count + 1);				\
> +	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);			\
> +	data->valid			= params->valid;		\
> +	cpuidle_set_statedata(state, data);				\
> +	count++;							\
> +} while (0);
> +
I like this macro as well. It avoids un-necessary lines on the C-state
initialization code.

Good work.

Regards
Santosh

