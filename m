From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] ARM: OMAP2+: gpmc-smc91x: Adapt to use gpmc driver
Date: Wed, 13 Jun 2012 05:29:50 -0700
Message-ID: <20120613122950.GR12766@atomide.com>
References: <cover.1339419379.git.afzal@ti.com>
 <0bdbc293fc98613011d37ec59559ba6d475eadf2.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50786 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080Ab2FMM3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 08:29:52 -0400
Content-Disposition: inline
In-Reply-To: <0bdbc293fc98613011d37ec59559ba6d475eadf2.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120611 08:19]:
> --- a/arch/arm/mach-omap2/gpmc-smc91x.c
> +++ b/arch/arm/mach-omap2/gpmc-smc91x.c
> @@ -114,7 +136,13 @@ static int smc91c96_gpmc_retime(void)
>  	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
>  		return 0;
>  
> -	return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
> +	/* gpmc driver interface */
> +	if (gpmc_smc91x_cs_data.mem_size == 0x10) {
> +		gpmc_smc91x_cs_data.time_ctrl.type = has_period;
> +		gpmc_smc91x_cs_data.time_ctrl.timings = t;
> +		return 0;
> +	} else
> +		return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
>  }
>  
>  /*

Here too we just need to care about the mainline kernel users
and convert them to use the new interface. No need to keep
gpmc_cs_set_timings around. The same applies for other similar
patches.

Regards,

Tony
