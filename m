From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP4: mcbsp: Enable FIFO usage
Date: Fri, 16 Dec 2011 09:36:00 -0800
Message-ID: <20111216173600.GB32251@atomide.com>
References: <1323941547-7714-1-git-send-email-peter.ujfalusi@ti.com>
 <1323941547-7714-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55963 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760251Ab1LPRgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 12:36:08 -0500
Content-Disposition: inline
In-Reply-To: <1323941547-7714-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111215 01:01]:
> All McBSP instances on OMAP4 has 128 word long FIFO
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Please merge via ASoC tree:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/mcbsp.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index 292eee3..857860b 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -153,6 +153,9 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
>  		else
>  			/* The FIFO has 128 locations */
>  			pdata->buffer_size = 0x80;
> +	} else if (oh->class->rev == MCBSP_CONFIG_TYPE4) {
> +		/* The FIFO has 128 locations for all instances */
> +		pdata->buffer_size = 0x80;
>  	}
>  
>  	if (oh->class->rev >= MCBSP_CONFIG_TYPE3)
> -- 
> 1.7.8
> 
