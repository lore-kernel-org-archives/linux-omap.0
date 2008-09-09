From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 01/12] GPMC context save/restore
Date: Tue, 9 Sep 2008 06:56:38 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809090653160.25626@utopia.booyaka.com>
References: <58545.192.168.10.89.1220276182.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46158 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYIIM4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 08:56:39 -0400
In-Reply-To: <58545.192.168.10.89.1220276182.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 1 Sep 2008, Rajendra Nayak wrote:

> This patch adds the context save restore functions for GPMC
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |   66 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/gpmc.h |   29 ++++++++++++++
>  2 files changed, 95 insertions(+)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/gpmc.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/gpmc.c	2008-09-01
> 18:11:29.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/gpmc.c	2008-09-01 18:11:36.000000000 +0530
> @@ -58,6 +58,7 @@ static struct resource	gpmc_mem_root;
>  static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
>  static DEFINE_SPINLOCK(gpmc_mem_lock);
>  static unsigned		gpmc_cs_map;
> +static struct omap3_gpmc_regs gpmc_ctx;
> 
>  static u32 gpmc_base;
> 
> @@ -437,3 +438,68 @@ void __init gpmc_init(void)
> 
>  	gpmc_mem_init();
>  }
> +
> +#ifdef CONFIG_ARCH_OMAP3
> +void omap3_save_gpmc_ctx()
> +{
> +	int i;
> +	gpmc_ctx.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
> +	gpmc_ctx.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
> +	gpmc_ctx.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
> +	gpmc_ctx.config = gpmc_read_reg(GPMC_CONFIG);
> +	gpmc_ctx.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> +	gpmc_ctx.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
> +	gpmc_ctx.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
> +	for (i = 0; i < GPMC_CS_NUM; i++) {
> +		gpmc_ctx.cs_context[i].is_valid =
> +				(gpmc_cs_read_reg(i, GPMC_CS_CONFIG7))
> +								& (1 << 6);

Please use a preprocessor macro in place of (1 << 6).  
"GPMC_CS_CONFIG7_CSVALID" perhaps?


- Paul
