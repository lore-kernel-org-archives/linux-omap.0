From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] OMAP3: PM: invoke omap_sram_idle() only when  sleep_while_idle is enabled
Date: Tue, 17 Mar 2009 07:53:03 -0700
Message-ID: <878wn4gq0g.fsf@deeprootsystems.com>
References: <4d34a0a70903170028t1722d565i35ec12b476427ae6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:57865 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbZCQOxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 10:53:09 -0400
Received: by qyk28 with SMTP id 28so84410qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 07:53:07 -0700 (PDT)
In-Reply-To: <4d34a0a70903170028t1722d565i35ec12b476427ae6@mail.gmail.com> (Kim Kyuwon's message of "Tue\, 17 Mar 2009 16\:28\:30 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, q1.kim@samsung.com, Jouni Hogander <jouni.hogander@nokia.com>, kyungmin.park@samsung.com

Kim Kyuwon <chammoru@gmail.com> writes:

> If MPU goes to WFI in the idle thread, execution time becomes a bit
> slow and the JTAG Debugger doesn't work. This patch is needed for
> urgent works(e.g. booting and launching application) and debugging.

Kim,

Do you still need this patch when using the new lower-latency C1-state
patch from Peter which I recently applied to the PM branch?

With that patch, MPU and CORE stay ON, and the clkdomain is not allowed
to idle so that the latency for C1 is on the order of a few usecs.

Kevin

> To enable sleep_while_idle mode, use below setting.
> echo 1 > /sys/power/sleep_while_idle
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    3 +++
>  arch/arm/mach-omap2/pm34xx.c      |    5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index 630108c..1623c2f 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -87,6 +87,9 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	local_irq_disable();
>  	local_fiq_disable();
>
> +	if (!enable_dyn_sleep)
> +		goto return_sleep_time;
> +
>  	if (!enable_off_mode) {
>  		if (mpu_state < PWRDM_POWER_RET)
>  			mpu_state = PWRDM_POWER_RET;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9102cee..402409c 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -484,8 +484,6 @@ static int omap3_fclks_active(void)
>
>  int omap3_can_sleep(void)
>  {
> -	if (!enable_dyn_sleep)
> -		return 0;
>  	if (!omap_uart_can_sleep())
>  		return 0;
>  	if (omap3_fclks_active())
> @@ -545,6 +543,9 @@ static void omap3_pm_idle(void)
>  	local_irq_disable();
>  	local_fiq_disable();
>
> +	if (!enable_dyn_sleep)
> +		goto out;
> +
>  	if (!omap3_can_sleep())
>  		goto out;
>
> -- 
> 1.5.2.5
>
>
> -- 
> Kyuwon
