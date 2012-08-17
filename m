From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Fri, 17 Aug 2012 06:07:24 -0700
Message-ID: <20120817130723.GZ11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18097 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab2HQNHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 09:07:32 -0400
Content-Disposition: inline
In-Reply-To: <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
> the FIFO for the audio stack.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index ebc801e..6e046e1 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -151,7 +151,10 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
>  	if (id == 4 && oh->class->rev == MCBSP_CONFIG_TYPE4)
>  		pdata->mux_signal = omap4_mcbsp4_mux_rx_clk;
>  
> -	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
> +	if (oh->class->rev == MCBSP_CONFIG_TYPE2) {
> +		/* The FIFO has 128 locations */
> +		pdata->buffer_size = 0x80;
> +	} else if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
>  		if (id == 2)
>  			/* The FIFO has 1024 + 256 locations */
>  			pdata->buffer_size = 0x500;

Is this the case also for 2420? I thought some only had a FIFO at
one port?

Tony
