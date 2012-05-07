From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP] Mark Beagleboard-xM MMC bus as 4-bit
Date: Mon, 7 May 2012 13:31:40 -0700
Message-ID: <20120507203139.GL5088@atomide.com>
References: <1336420577-2578-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28071 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab2EGUbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 16:31:41 -0400
Content-Disposition: inline
In-Reply-To: <1336420577-2578-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org

* Russ Dill <Russ.Dill@ti.com> [120507 13:00]:
> On Beagleboard-xM (all revisions) only MMC1_DAT0-MMC1_DAT3 are wired up.
> Tested on Beagleboard-xM Rev C1 and Beagleboard Rev B4.
> 
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 7be8d65..3b9647a 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -523,6 +523,10 @@ static void __init omap3_beagle_init(void)
>  
>  	if (beagle_config.mmc1_gpio_wp != -EINVAL)
>  		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
> +
> +	/* All xM versions have 4-bit MMC bus */
> +	if (cpu_is_omap3630())
> +		mmc[0].caps &= ~MMC_CAP_8_BIT_DATA;
>  	omap_hsmmc_init(mmc);
>  
>  	omap3_beagle_i2c_init();

This would be better done in omap3_beagle_init_rev as various other
things are already initialized there based on the revision.

Tony
