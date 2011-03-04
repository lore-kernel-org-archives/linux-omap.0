From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual
 hwmods
Date: Fri, 4 Mar 2011 09:42:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103040941390.10981@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <4D651998.3040002@ti.com> <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com> <4D6B845A.9000900@ti.com> <20110302175422.GY20560@atomide.com> <4D6F7723.5040001@ti.com> <4D70FC5B.9040701@ti.com>
 <20110304161933.GV20560@atomide.com> <4D7115BF.7000009@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56984 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355Ab1CDQmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 11:42:22 -0500
In-Reply-To: <4D7115BF.7000009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Fri, 4 Mar 2011, Cousson, Benoit wrote:

> >From aa22c44486c12c388eb96e9fe9b1476267856006 Mon Sep 17 00:00:00 2001
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Fri, 4 Mar 2011 16:01:43 +0100
> Subject: [PATCH 1/2] Revert "OMAP4: hwmod data: Prevent timer1 to be reset and idle during init"
> 
> The following commit: 38698be:
> OMAP2+: clockevent: set up GPTIMER clockevent hwmod right before timer init
> 
> Fixed properly the issue with early init for the timer1
> 
> So reverts commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6 that is now
> generated a warning at boot time.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7dbcdf7..7b72316 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -4005,7 +4005,6 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
>  static struct omap_hwmod omap44xx_timer1_hwmod = {
>  	.name		= "timer1",
>  	.class		= &omap44xx_timer_1ms_hwmod_class,
> -	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>  	.mpu_irqs	= omap44xx_timer1_irqs,
>  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
>  	.main_clk	= "timer1_fck",
> -- 
> 1.7.0.4
> 


- Paul
