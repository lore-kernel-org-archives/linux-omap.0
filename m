From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 14 Jun 2012 02:29:57 -0700
Message-ID: <20120614092957.GE12766@atomide.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27024 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460Ab2FNJaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 05:30:00 -0400
Content-Disposition: inline
In-Reply-To: <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120611 07:21]:
> Configure busturnaround, cycle2cycledelay, waitmonitoringtime,
> clkactivationtime in gpmc_cs_set_timings(). This is done so
> that boards can configure these parameters of gpmc in Kernel
> instead of relying on bootloader.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |    6 ++++++
>  arch/arm/plat-omap/include/plat/gpmc.h |    6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 578fd4c..517953f 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -313,6 +313,12 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>  
>  	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
>  
> +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
> +
> +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
> +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
> +

Thinking about this, the CONFIG1 bits have been set with
gpmc_cs_write_reg because these are part of the static configuration
and do not need to be dynamically calculated as they are tick based.
For example, tusb6010 sets GPMC_CONFIG1_CLKACTIVATIONTIME(1) during init.

Writing these over and over again during DVFS does not make sense, they
should be only initialized once.

Regards,

Tony
