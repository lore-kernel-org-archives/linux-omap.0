From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/8] OMAP4: PM: TEMP: Prevent l3init from idling/force
 sleep
Date: Thu, 23 Jun 2011 09:04:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106230819540.12954@utopia.booyaka.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com> <1307616853-28395-2-git-send-email-rnayak@ti.com> <1307616853-28395-3-git-send-email-rnayak@ti.com> <1307616853-28395-4-git-send-email-rnayak@ti.com> <1307616853-28395-5-git-send-email-rnayak@ti.com>
 <1307616853-28395-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43419 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758007Ab1FWPEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 11:04:21 -0400
In-Reply-To: <1307616853-28395-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On Thu, 9 Jun 2011, Rajendra Nayak wrote:

> Since MMC driver is yet to be adapted to
> runtime PM and still uses direct clock
> calls to enable/disable module, its needed
> that the clockdomain (for MMC) is always kept force
> enabled since the next few patches move
> the clockdomain handling from clock framework
> to hwmod framework and break MMC.
> 
> This will certainlly gate any CORE low power
> transitions.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
> index a607ec1..ff38764 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -493,7 +493,7 @@ static struct clockdomain l3_init_44xx_clkdm = {
>  	.dep_bit	  = OMAP4430_L3INIT_STATDEP_SHIFT,
>  	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
>  	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		  = CLKDM_CAN_FORCE_WAKEUP,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  };

Since this is basically a hack to work around limitations of the current 
MMC driver, if we accept something like this, I think it should come with 
a big warning message and comment.  Something like this in 
omap44xx_clockdomains_init():

	/*
	 * XXX The OMAP L3 interconnect hardware is able to enter
	 * hardware-supervised idle.  But because the OMAP HSMMC
	 * driver still hasn't been converted to use runtime PM, if
	 * the L3 is allowed to enter hwsup idle, the kernel will
	 * crash.  Once the MMC driver is fixed (which patches have
	 * been posted to do, with subject line "OMAP: HSMMC: cleanup
	 * and runtime pm") the change to the l3_init_44xx_clkdm
	 * flags should be dropped.  It limits the low-power state that
	 * the chip can enter.
	 */
	pr_warn("WARNING: OMAP4 low power states artificially limited, due 
to unconverted HSMMC driver\n");


- Paul
