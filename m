From: Tony Lindgren <tony@atomide.com>
Subject: Re: Linux-next as of 20110222 broken on OMAP4
Date: Tue, 22 Feb 2011 11:13:44 -0800
Message-ID: <20110222191343.GP15225@atomide.com>
References: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
 <4D63B160.3010103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14437 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285Ab1BVTN4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 14:13:56 -0500
Content-Disposition: inline
In-Reply-To: <4D63B160.3010103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Cousson, Benoit <b-cousson@ti.com> [110222 04:50]:
> Hi Anand,
> 
> On 2/22/2011 10:49 AM, Gadiyar, Anand wrote:
> > Looks like linux-next as of today is broken on at least OMAP4.
> > 
> > Turning on earlyprintk, I get a crash in omap_init_mcspi. Disabling
> > CONFIG_SPI_OMAP24XX gets me as far as the following lines from my
> > bootup log, but I haven't attempted to debug further.
> > 
> > If there are any patches out there to fix this, let me know.
> > Else I will debug this sometime tomorrow.
> 
> Yes, it was discussed with Tony and temporarily fixed yesterday.
> 
> The SPI fix is is already in omap-for-linus, and the timer1 temp fix is below.
> We need to find a better way to handle timer now that they are initialized pretty soon.

I applied the fix below with Paul's ack from the other thread.
So linux-next should be working again on omap4 when it gets rebuilt.

Regards,

Tony
 
> ---
> From 9a8dc4fdab03d00d556d05ad8b64c547493ad84d Mon Sep 17 00:00:00 2001
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Tue, 22 Feb 2011 10:36:27 +0100
> Subject: [PATCH] OMAP4: hwmod data: Prevent timer1 to be reset and idle during init
> 
> Since the timer1 is now started before the hwmod_init, we cannot
> reset it and idle it anymore.
> 
> Add the appropriate flags to prevent the hwmod framework to do that.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 182aa79..79a8601 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3989,6 +3989,7 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
>  static struct omap_hwmod omap44xx_timer1_hwmod = {
>  	.name		= "timer1",
>  	.class		= &omap44xx_timer_1ms_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>  	.mpu_irqs	= omap44xx_timer1_irqs,
>  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
>  	.main_clk	= "timer1_fck",
> -- 
> 1.7.0.4
