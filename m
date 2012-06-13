From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/9] ARM: OMAP2+: gpmc-tusb6010: Adapt to use gpmc
 driver
Date: Wed, 13 Jun 2012 05:27:48 -0700
Message-ID: <20120613122747.GQ12766@atomide.com>
References: <cover.1339419379.git.afzal@ti.com>
 <9c6c6b0298e37b1985a89e2cd99c35504521a1da.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49285 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab2FMM1w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 08:27:52 -0400
Content-Disposition: inline
In-Reply-To: <9c6c6b0298e37b1985a89e2cd99c35504521a1da.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120611 08:19]:
> @@ -106,7 +123,14 @@ static int tusb_set_async_mode(unsigned sysclk_ps, unsigned fclk_ps)
>  	tmp = t.cs_wr_off * 1000 + 7000 /* t_acsn_rdy_z */;
>  	t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
>  
> -	return gpmc_cs_set_timings(async_cs, &t);
> +	/* gpmc driver interface */
> +	if (gpmc_tusb_data.pdata != NULL) {
> +		gpmc_tusb_cs_data[CS_ASYNC_IDX].time_ctrl.type = has_period;
> +		gpmc_tusb_cs_data[CS_ASYNC_IDX].time_ctrl.timings = t;
> +		return 0;
> +	/* old interface */
> +	} else
> +		return gpmc_cs_set_timings(async_cs, &t);
>  }
>  
>  static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
> @@ -174,7 +198,16 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
>  	tmp = t.cs_wr_off * 1000 + 7000 /* t_scsn_rdy_z */;
>  	t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
>  
> -	return gpmc_cs_set_timings(sync_cs, &t);
> +	t.clk_activation = gpmc_ticks_to_ns(1);
> +
> +	/* gpmc driver interface */
> +	if (gpmc_tusb_data.pdata != NULL) {
> +		gpmc_tusb_cs_data[CS_SYNC_IDX].time_ctrl.type = has_period;
> +		gpmc_tusb_cs_data[CS_SYNC_IDX].time_ctrl.timings = t;
> +		return 0;
> +	/* old interface */
> +	} else
> +		return gpmc_cs_set_timings(sync_cs, &t);
>  }

We can drop the old interface for non-mainline cases. In this case
tusb6010 is only used by board-n8x0.c, so it's best to just convert
it all to use the new interface.

Regards,

Tony
