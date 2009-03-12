From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] PM: Start C-state definitions from base 0
Date: Thu, 12 Mar 2009 16:18:34 -0700
Message-ID: <87mybq2uut.fsf@deeprootsystems.com>
References: <1236892668-8710-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.248]:15905 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZCLXSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 19:18:41 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1274251agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 16:18:38 -0700 (PDT)
In-Reply-To: <1236892668-8710-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Fri\, 13 Mar 2009 02\:47\:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> The current definition of C-states starts from base 1.
> Whereas, the cpuidle driver uses base 0. This patch
> eliminates need for explicit mapping due to different
> base values.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   23 ++++++++++-------------
>  1 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 62fbb2e..50bf412 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -33,13 +33,13 @@
>  
>  #ifdef CONFIG_CPU_IDLE
>  
> -#define OMAP3_MAX_STATES 7
> -#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */
> -#define OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */
> -#define OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */
> -#define OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */
> -#define OMAP3_STATE_C5 5 /* C5 - MPU OFF + Core RET */
> -#define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core OFF */
> +#define OMAP3_MAX_STATES 6
> +#define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */
> +#define OMAP3_STATE_C2 1 /* C2 - MPU CSWR + Core active */
> +#define OMAP3_STATE_C3 2 /* C3 - MPU OFF + Core active */
> +#define OMAP3_STATE_C4 3 /* C4 - MPU RET + Core RET */
> +#define OMAP3_STATE_C5 4 /* C5 - MPU OFF + Core RET */
> +#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core OFF */
>  
>  struct omap3_processor_cx {
>  	u8 valid;
> @@ -228,7 +228,7 @@ struct cpuidle_driver omap3_idle_driver = {
>   */
>  int omap3_idle_init(void)
>  {
> -	int i, count = 0;
> +	int count;
>  	struct omap3_processor_cx *cx;
>  	struct cpuidle_state *state;
>  	struct cpuidle_device *dev;
> @@ -244,8 +244,8 @@ int omap3_idle_init(void)
>  
>  	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
>  
> -	for (i = 1; i < OMAP3_MAX_STATES; i++) {
> -		cx = &omap3_power_states[i];
> +	for (count = 0; count < OMAP3_MAX_STATES; count++) {
> +		cx = &omap3_power_states[count];
>  		state = &dev->states[count];
>  
>  		if (!cx->valid)

Still not quite right.

The reason for a different loop iterator and 'count' was so that
states that are not 'valid' do not get regsitered with CPUidle.  With
this patch, some of the dev->states[] pointers that get registered
with CPUidle will have bogus values if there are any !valid states
at boot time.

Since you are not fixing the valid state problem in this patch, I
suggest you keep the separate iterator and count, and just start i at
zero instead of 1.

Then, when you fix the valid state problem, you can drop the checking
for valid sates at init time all together, and then use a single
iterator for this loop.

Kevin

> @@ -259,11 +259,8 @@ int omap3_idle_init(void)
>  		if (cx->type == OMAP3_STATE_C1)
>  			dev->safe_state = state;
>  		sprintf(state->name, "C%d", count+1);
> -		count++;
>  	}
>  
> -	if (!count)
> -		return -EINVAL;
>  	dev->state_count = count;
>  
>  	if (cpuidle_register_device(dev)) {
> -- 
> 1.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
