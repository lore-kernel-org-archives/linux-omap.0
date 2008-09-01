From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [PATCH 01/12] GPMC context save/restore
Date: Mon, 01 Sep 2008 17:14:56 +0300
Message-ID: <48BBF8E0.9050200@nokia.com>
References: <58545.192.168.10.89.1220276182.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53384 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYIAOMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 10:12:00 -0400
In-Reply-To: <58545.192.168.10.89.1220276182.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak wrote:
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

Is there a "void" missing i.e. void omap3_save_gpmc_ctx(void)

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
> +		if (gpmc_ctx.cs_context[i].is_valid) {
> +			gpmc_ctx.cs_context[i].gpmc_config1 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
> +			gpmc_ctx.cs_context[i].gpmc_config2 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
> +			gpmc_ctx.cs_context[i].gpmc_config3 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
> +			gpmc_ctx.cs_context[i].gpmc_config4 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
> +			gpmc_ctx.cs_context[i].gpmc_config5 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
> +			gpmc_ctx.cs_context[i].gpmc_config6 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
> +			gpmc_ctx.cs_context[i].gpmc_config7 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
> +		}
> +	}
> +}
> +
> +void omap3_restore_gpmc_ctx()

Ditto

> +{
> +	int i;
> +	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_ctx.sysconfig);
> +	gpmc_write_reg(GPMC_IRQENABLE, gpmc_ctx.irqenable);
> +	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_ctx.timeout_ctrl);
> +	gpmc_write_reg(GPMC_CONFIG, gpmc_ctx.config);
> +	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, gpmc_ctx.prefetch_config1);
> +	gpmc_write_reg(GPMC_PREFETCH_CONFIG2, gpmc_ctx.prefetch_config2);
> +	gpmc_write_reg(GPMC_PREFETCH_CONTROL, gpmc_ctx.prefetch_control);
> +	for (i = 0; i < GPMC_CS_NUM; i++) {
> +		if (gpmc_ctx.cs_context[i].is_valid) {
> +			gpmc_cs_write_reg(i, GPMC_CS_CONFIG1,
> +					gpmc_ctx.cs_context[i].gpmc_config1);
> +			gpmc_cs_write_reg(i, GPMC_CS_CONFIG2,
> +					gpmc_ctx.cs_context[i].gpmc_config2);
> +			gpmc_cs_write_reg(i, GPMC_CS_CONFIG3,
> +					gpmc_ctx.cs_context[i].gpmc_config3);
> +			gpmc_cs_write_reg(i, GPMC_CS_CONFIG4,
> +					gpmc_ctx.cs_context[i].gpmc_config4);
> +			gpmc_cs_write_reg(i, GPMC_CS_CONFIG5,
> +					gpmc_ctx.cs_context[i].gpmc_config5);
> +			gpmc_cs_write_reg(i, GPMC_CS_CONFIG6,
> +					gpmc_ctx.cs_context[i].gpmc_config6);
> +			gpmc_cs_write_reg(i, GPMC_CS_CONFIG7,
> +					gpmc_ctx.cs_context[i].gpmc_config7);
> +		}
> +	}
> +}
> +#endif /* CONFIG_ARCH_OMAP3 */
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/gpmc.h	2008-09-01
> 18:11:29.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h	2008-09-01
> 18:11:36.000000000 +0530
> @@ -90,6 +90,33 @@ struct gpmc_timings {
>  	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>  };
> 
> +/* Structure to save gpmc cs context */
> +struct gpmc_cs_config {
> +	u32 gpmc_config1;
> +	u32 gpmc_config2;
> +	u32 gpmc_config3;
> +	u32 gpmc_config4;
> +	u32 gpmc_config5;
> +	u32 gpmc_config6;
> +	u32 gpmc_config7;
> +	int is_valid;
> +};
> +
> +/*
> + * Structure to save/restore gpmc context
> + * to support core off on OMAP3
> + */
> +struct omap3_gpmc_regs {
> +	u32 sysconfig;
> +	u32 irqenable;
> +	u32 timeout_ctrl;
> +	u32 config;
> +	u32 prefetch_config1;
> +	u32 prefetch_config2;
> +	u32 prefetch_control;
> +	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
> +};
> +
>  extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
>  extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
>  extern unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns);
> @@ -103,6 +130,8 @@ extern int gpmc_cs_request(int cs, unsig
>  extern void gpmc_cs_free(int cs);
>  extern int gpmc_cs_set_reserved(int cs, int reserved);
>  extern int gpmc_cs_reserved(int cs);
> +extern void omap3_save_gpmc_ctx(void);
> +extern void omap3_restore_gpmc_ctx(void);
>  extern void __init gpmc_init(void);
> 
>  #endif
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

