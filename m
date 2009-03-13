From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3] PM: Start C-state definitions from base 0
Date: Fri, 13 Mar 2009 15:15:43 -0700
Message-ID: <87y6v9ul0w.fsf@deeprootsystems.com>
References: <1236960265-19734-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:37346 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613AbZCMWPt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 18:15:49 -0400
Received: by rv-out-0506.google.com with SMTP id g37so583114rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2009 15:15:46 -0700 (PDT)
In-Reply-To: <1236960265-19734-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Fri\, 13 Mar 2009 21\:34\:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> The current definition of C-states starts from base 1.
> Whereas, the cpuidle driver uses base 0. This patch
> eliminates need for explicit mapping (add/ sbutract)
> due to different base values.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 62fbb2e..04119e4 100644
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
> @@ -244,7 +244,7 @@ int omap3_idle_init(void)
>  
>  	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
>  
> -	for (i = 1; i < OMAP3_MAX_STATES; i++) {
> +	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
>  		cx = &omap3_power_states[i];
>  		state = &dev->states[count];
>  

Thanks, pushing to PM branch after slight fixup in order to apply
after Peter's new C-state patch.

Kevin
