From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3630 PM: Update C state latencies
Date: Fri, 17 Sep 2010 08:09:26 -0700
Message-ID: <87hbho1k61.fsf@deeprootsystems.com>
References: <1284732790-13440-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38830 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab0IQPJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 11:09:29 -0400
Received: by mail-yx0-f174.google.com with SMTP id 4so763700yxp.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 08:09:29 -0700 (PDT)
In-Reply-To: <1284732790-13440-1-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 17 Sep 2010 19:43:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Nicole Chalhoub <n-chalhoub@ti.com>, Vincent Bour <v-bour@ti.com>, Benoit Cousson <b-cousson@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> This patch has changes to update the C state latencies for OMAP3630
> and removes the useless C-States, keeping only the optimized ones with 
> their corresponding measured latencies.

Technically, this patch doesn't remove them, it disables them.

Also, these C-states are 3630 specific, and not Zoom3 specific, yet here
they are added only to the Zoom3 board file.   Please add these in a way
that makes them available for all 3630-based platforms.

> Only 4 C-states are kept instead of 7 C-States:
>   * 	C1 . MPU WFI clock gated + Core autogating
>   *	C3 . MPU CSWR + Core inactive
>   *	C5 . MPU CSWR + Core CSWR
>   *	C7 . MPU OFF + Core OFF
>  A new C-State C1 is created which is the same as the existing C1 but clocks 
>  gated. It will be the default state. When calling the safe state, the clocks
>  gating is denied as it was the case previously. With these changes, gain is 
>  in power consumption is observed on some use cases.

This needs a little better description in the changelog, and comments in
the code.

Does this mean that C1 has to "modes"?   By default, C1 will gate clocks
but if the safe_state is chosen, clock gating is prevented?  

If so, it is a little confusing.  Why not call the clock-active state C1
and the clock-gated state C2?

> Thanks to Nicole Chaloub<n-chalhoub@ti.com> and Vincent Bour <v-bour@ti.com>
> for their investigation.

The results from the excellent study by Nicole & Vincent should be posted
on omappedia.org someplace and a reference to it should be included in
this changelog.

> Tested on ZOOM3 board using latest pm branch.

This doesn't apply to latest pm branch.  There are changes queued for
2.6.37 which affect CPUidle, so this needs to be rebased and re-tested
with those changes.

Was it tested with off-mode also?  It wasn't caused by this patch,
but it looks like there's a bug in the way we update C-states when
off-mode is enabled.

Now that we have a set of C-states where many are flagged as disabled,
omap3_cpuidle_update_states() needs to be fixed as well.

Currently, when enable_off_mode is set, it blindly sets the valid flag
for all C-states, even ones that were disabled on init.  This should
be fixed in a separate patch as a pre-requiste to this one.

> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Nicole Chalhoub <n-chalhoub@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom3.c |   19 +++++++++++++++++++
>  arch/arm/mach-omap2/cpuidle34xx.c |    9 ++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
> index 03411b2..c47b2a3 100644
> --- a/arch/arm/mach-omap2/board-zoom3.c
> +++ b/arch/arm/mach-omap2/board-zoom3.c
> @@ -25,10 +25,28 @@
>  #include "mux.h"
>  #include "sdram-hynix-h8mbx00u0mer-0em.h"
>  #include "smartreflex-class3.h"
> +#include "pm.h"
>  
>  static struct omap_board_config_kernel zoom_config[] __initdata = {
>  };
>  
> +static struct cpuidle_params omap3_cpuidle_params_table[] = {
> +	/* C1 */
> +	{1, 74, 78, 152},
> +	/* C2 */
> +	{0, 165, 90, 255},
> +	/* C3 */
> +	{1, 163, 180, 345},
> +	/* C4 */
> +	{0, 2852, 605, 3457},
> +	/* C5 */
> +	{1, 800, 366, 2120},
> +	/* C6 */
> +	{0, 4080, 801, 4881},
> +	/* C7 */
> +	{1, 4300, 8794, 159000},
> +};
> +
>  static struct mtd_partition zoom_nand_partitions[] = {
>  	/* All the partition sizes are listed in terms of NAND block size */
>  	{
> @@ -74,6 +92,7 @@ static void __init omap_zoom_init_irq(void)
>  {
>  	omap_board_config = zoom_config;
>  	omap_board_config_size = ARRAY_SIZE(zoom_config);
> +	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
>  	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
>  			h8mbx00u0mer0em_sdrc_params);
>  	omap_init_irq();
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 3d3d035..2bbfc43 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -136,7 +136,8 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	if (omap_irq_pending() || need_resched())
>  		goto return_sleep_time;
>  
> -	if (cx->type == OMAP3_STATE_C1) {
> +	/* deny idle only if we are entering safe state */
> +	if (dev->last_state != state) {

This condition isn't just true for the safe state.  It's also true
if CPUidle has chosen a state that isn't currently valid (e.g. an
off-mode state that is currently disabled because off-mode is disabled.

IOW, this check should be more explicitly checking for the safe state.

That being said, I think it greatly help readability if there were
separate states here rather than have a single C1 that has a
clock-active and a clock-gated modes.

>  		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
>  		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
>  	}
> @@ -144,7 +145,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	/* Execute ARM wfi */
>  	omap_sram_idle();
>  
> -	if (cx->type == OMAP3_STATE_C1) {
> +	if (dev->last_state != state) {
>  		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
>  		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
>  	}
> @@ -233,14 +234,16 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  			       struct cpuidle_state *state)
>  {
>  	struct cpuidle_state *new_state = next_valid_state(dev, state);
> +	int t;
>  
>  	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
>  		BUG_ON(!dev->safe_state);
>  		new_state = dev->safe_state;
>  	}
>  
> +	t = omap3_enter_idle(dev, new_state);
>  	dev->last_state = new_state;
> -	return omap3_enter_idle(dev, new_state);
> +	return t;

I don't see the point of this change.

>  }
>  
>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);

Kevin
