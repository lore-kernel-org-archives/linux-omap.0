From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 3/7] omap: gpmc: enable irq mode in gpmc
Date: Fri, 17 Dec 2010 16:09:54 -0800
Message-ID: <20101218000954.GX5941@atomide.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
 <1290785677-16005-4-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17298 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab0LRAJ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 19:09:58 -0500
Content-Disposition: inline
In-Reply-To: <1290785677-16005-4-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [101126 07:25]:
> add support the irq mode in GPMC.
> gpmc_init() function move after omap_init_irq() as it has dependecy on irq.
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c        |    1 +
>  arch/arm/mach-omap2/board-3430sdp.c        |    1 +
>  arch/arm/mach-omap2/board-3630sdp.c        |    1 +
>  arch/arm/mach-omap2/board-4430sdp.c        |    2 +
>  arch/arm/mach-omap2/board-am3517evm.c      |    2 +
>  arch/arm/mach-omap2/board-apollon.c        |    1 +
>  arch/arm/mach-omap2/board-cm-t35.c         |    1 +
>  arch/arm/mach-omap2/board-devkit8000.c     |    1 +
>  arch/arm/mach-omap2/board-generic.c        |    2 +
>  arch/arm/mach-omap2/board-h4.c             |    1 +
>  arch/arm/mach-omap2/board-igep0020.c       |    1 +
>  arch/arm/mach-omap2/board-ldp.c            |    1 +
>  arch/arm/mach-omap2/board-n8x0.c           |    2 +
>  arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
>  arch/arm/mach-omap2/board-omap3evm.c       |    2 +
>  arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
>  arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
>  arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
>  arch/arm/mach-omap2/board-omap4panda.c     |    2 +
>  arch/arm/mach-omap2/board-overo.c          |    1 +
>  arch/arm/mach-omap2/board-rx51.c           |    1 +
>  arch/arm/mach-omap2/board-zoom2.c          |    2 +
>  arch/arm/mach-omap2/board-zoom3.c          |    2 +
>  arch/arm/mach-omap2/gpmc.c                 |   39 ++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/io.c                   |    2 -
>  arch/arm/plat-omap/include/plat/gpmc.h     |    4 +++
>  arch/arm/plat-omap/include/plat/irqs.h     |    9 +++++-
>  27 files changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index b527f8d..11c89dc 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -145,6 +145,7 @@ static void __init omap_2430sdp_init_irq(void)
>  	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
>  	omap2_init_common_hw(NULL, NULL);
>  	omap_init_irq();
> +	gpmc_init();
>  	omap_gpio_init();
>  }
>  
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 4e3742c..a040165 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -328,6 +328,7 @@ static void __init omap_3430sdp_init_irq(void)
>  	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
>  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
>  	omap_init_irq();
> +	gpmc_init();
>  	omap_gpio_init();
>  }
...

The gpmc init should be done with subsys_initcall instead.

Tony
