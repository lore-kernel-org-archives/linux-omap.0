From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [PATCH] OMAP: timekeeping: time should not stop during suspend
Date: Mon, 28 Sep 2009 10:02:08 +0200
Message-ID: <200909281002.08841.jpihet@mvista.com>
References: <1253835348-12640-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:39165 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbZI1IDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 04:03:11 -0400
In-Reply-To: <1253835348-12640-1-git-send-email-khilman@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Kevin,

On Friday 25 September 2009 01:35:48 Kevin Hilman wrote:
> During suspend, the kernel timekeeping subsystem is shut down.  Before
> suspend and upon resume, it uses a weak function
> read_persistent_clock() to determine the amount of time that elapsed
> during suspend.
>
> This function was not implemented on OMAP, so from the timekeeping
> subsystem perspective (and thus userspace as well) it appeared that no
> time elapsed during suspend.
>
> This patch uses the 32k sync timer as a the persistent clock the 32k
> sync timer value converted to seconds.
>
> NOTE: This does *NOT* handle wrapping of the 32k sync timer, so
>       wrapping of the 32k sync timer during suspend may cause
>       problems.  Also, there are not interrupts when the 32k sync
>       timer wraps, so something else has to be done.
I think we should read the 32k timer value before entering the sleep and 
reading it again at resume time. Doing so up to one overflow could be 
handled, which means a maximum sleep period of 36.4 hours.

Now the time wrap problem imposes the system to wake-up before 36.4 hours. We 
have a few options:
1) always use the wake-up timer with a wake-up time < 36.4 hours
2) rely on the user space to set the wake-up timer correctly, depending on the 
applications needs.

I am for option 1.

Any thoughts?

Regards,
Jean

>
> Reported-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Tested on OMAP3 using PM branch.
> If no issues, I will queue for 2.6.32-rc fixes
>
>  arch/arm/plat-omap/common.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index b3f70e6..3e4325b 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -178,6 +178,21 @@ unsigned long long sched_clock(void)
>  	return ret;
>  }
>
> +/**
> + * read_persistent_clock -  Return time in seconds from the persistent
> clock. + */
> +unsigned long read_persistent_clock(void)
> +{
> +	unsigned long long ret;
> +	cycle_t cycles;
> +
> +	cycles = clocksource_32k.read(&clocksource_32k);
> +	ret = (cycles * clocksource_32k.mult_orig) >> clocksource_32k.shift;
> +	do_div(ret, NSEC_PER_SEC);
> +
> +	return (unsigned long)ret;
> +}
> +
>  static int __init omap_init_clocksource_32k(void)
>  {
>  	static char err[] __initdata = KERN_ERR


