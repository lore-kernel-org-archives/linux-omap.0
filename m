From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 01/28] OMAP3: PM: GPMC context save/restore
Date: Sat, 03 Oct 2009 09:48:52 -0500
Message-ID: <4AC76454.20605@gmail.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com> <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:37143 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbZJCO40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Oct 2009 10:56:26 -0400
Received: by ywh6 with SMTP id 6so1306091ywh.4
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2009 07:55:50 -0700 (PDT)
In-Reply-To: <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Kevin Hilman said the following on 10/01/2009 06:58 PM:
> From: Rajendra Nayak <rnayak@ti.com>
>
> This patch adds the context save restore functions for GPMC
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c             |   93 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/gpmc.h |    3 +
>  2 files changed, 96 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 1587682..86ea936 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -62,10 +62,38 @@
>  #define ENABLE_PREFETCH		(0x1 << 7)
>  #define DMA_MPU_MODE		2
>  
> +/* Structure to save gpmc cs context */
> +struct gpmc_cs_config {
> +	u32 config1;
> +	u32 config2;
> +	u32 config3;
> +	u32 config4;
> +	u32 config5;
> +	u32 config6;
> +	u32 config7;
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
>  static struct resource	gpmc_mem_root;
>  static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
>  static DEFINE_SPINLOCK(gpmc_mem_lock);
>  static unsigned		gpmc_cs_map;
> +static struct omap3_gpmc_regs gpmc_context;
>  
>  static void __iomem *gpmc_base;
>  
> @@ -516,3 +544,68 @@ void __init gpmc_init(void)
>  	gpmc_write_reg(GPMC_SYSCONFIG, l);
>  	gpmc_mem_init();
>  }
> +
> +#ifdef CONFIG_ARCH_OMAP3
>   
apologies if this is a dumb question - why is this under #ifdef -> if
the save save restore structures are not under #ifdef?
> +void omap3_gpmc_save_context()
> +{
> +	int i;
> +	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
> +	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
> +	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
> +	gpmc_context.config = gpmc_read_reg(GPMC_CONFIG);
> +	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> +	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
> +	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
> +	for (i = 0; i < GPMC_CS_NUM; i++) {
> +		gpmc_context.cs_context[i].is_valid =
> +				(gpmc_cs_read_reg(i, GPMC_CS_CONFIG7))
> +							& GPMC_CONFIG7_CSVALID;
> +		if (gpmc_context.cs_context[i].is_valid) {
> +			gpmc_context.cs_context[i].config1 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
> +			gpmc_context.cs_context[i].config2 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
> +			gpmc_context.cs_context[i].config3 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
> +			gpmc_context.cs_context[i].config4 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
> +			gpmc_context.cs_context[i].config5 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
> +			gpmc_context.cs_context[i].config6 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
> +			gpmc_context.cs_context[i].config7 =
> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
> +		}
>   
here is a theoretical bug:
1: GPMC, 1, 2, 3 4 5 configured 6 7 not configured.
2. Save and restore 1: save and restore variables which are static will
contain 1-5 and not 6&7
3. next I disable 2,3
3. save will save 1,4,5 BUT my variable will contain 1,2,3,4,5 ->
restore will rename 2,3 (which I did not intend)..

Regards,
Nishanth Menon
