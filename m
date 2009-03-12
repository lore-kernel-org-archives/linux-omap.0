From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Start C-state definitions from base 0
Date: Thu, 12 Mar 2009 14:52:56 -0700
Message-ID: <87ocw64ddz.fsf@deeprootsystems.com>
References: <1236889769-32587-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:36656 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbZCLVxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 17:53:11 -0400
Received: by gxk7 with SMTP id 7so532442gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 14:53:08 -0700 (PDT)
In-Reply-To: <1236889769-32587-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Fri\, 13 Mar 2009 01\:59\:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> From:	Sanjeev Premi <premi@ti.com>
> Subject: [PATCH] Start C-state definitions from base 0
> To:	linux-omap@vger.kernel.org
> Cc:	Sanjeev Premi <premi@ti.com>
> Date:	Fri, 13 Mar 2009 01:59:29 +0530
>
> The current definition of C-states starts from base 1.
> Whereas, the cpuidle driver uses base 0. This patch
> eliminates need for explicit mapping due to different
> base values.

Thanks!

> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 62fbb2e..d7208f3 100644
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
> +	int count = 0;
>  	struct omap3_processor_cx *cx;
>  	struct cpuidle_state *state;
>  	struct cpuidle_device *dev;
> @@ -244,8 +244,8 @@ int omap3_idle_init(void)
>  
>  	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
>  
> -	for (i = 1; i < OMAP3_MAX_STATES; i++) {
> -		cx = &omap3_power_states[i];
> +	for (count = 1; count < OMAP3_MAX_STATES; count++) {
> +		cx = &omap3_power_states[count];
>  		state = &dev->states[count];

If you're going to drop the separation of the iterator and 'count'
then you should drop the 'if (cx->valid) continue' part as well.
Otherwise, states that are not valid at boot time will never be
visible to CPUidle.

This way, all the states, valid or not, are registered with CPUidle,
and the enter hook will sort out the difference.

This change may be more appropriate for for your patch which adds
support for checking the valid field.

Kevin
