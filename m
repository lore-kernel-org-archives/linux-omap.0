From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 01/14] ARM: OMAP2+: gpmc: platform definitions
Date: Tue, 12 Jun 2012 13:58:15 -0500
Message-ID: <4FD79147.9060501@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <139eb951817b4bee8ea91083b0d572c7421078f0.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37942 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab2FLS6R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 14:58:17 -0400
In-Reply-To: <139eb951817b4bee8ea91083b0d572c7421078f0.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 06/11/2012 09:26 AM, Afzal Mohammed wrote:
> gpmc driver platform definitions
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/gpmc.h |   49 ++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
> index 802fb22..21a8cce 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -139,6 +139,55 @@ struct gpmc_timings {
>  	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>  };
>  
> +/* bool type time settings */
> +struct gpmc_misc_timings {
> +	bool cycle2cyclediffcsen;
> +	bool cycle2cyclesamecsen;
> +	bool we_extra_delay;
> +	bool oe_extra_delay;
> +	bool adv_extra_delay;
> +	bool cs_extra_delay;
> +	bool time_para_granularity;
> +};
> +
> +enum {
> +	has_none,
> +	has_period,
> +	has_clock
> +};
> +
> +struct gpmc_time_ctrl {
> +	int type;
> +	struct gpmc_timings timings;
> +	struct gpmc_misc_timings bool_timings;
> +};

Why not combine misc_timings and the original timings? I don't see why
these need to be kept separate. Even if combined it can still be
backward compatible for legacy boards as they will not specify the misc
timing fields. I am also not convinced we need this type member.

Jon

> +struct gpmc_cs_data {
> +	unsigned		cs;
> +	unsigned long		mem_size;
> +	unsigned long		mem_offset;
> +	bool			have_config;
> +	unsigned		config;
> +	struct gpmc_time_ctrl	time_ctrl;
> +	unsigned		irq_config;
> +};
> +
> +struct gpmc_device_pdata {
> +	char			*name;
> +	int			id;
> +	void			*pdata;
> +	unsigned		pdata_size;
> +	struct resource		*per_res;
> +	unsigned		per_res_cnt;
> +	struct gpmc_cs_data	*cs_data;
> +	unsigned		num_cs;
> +};
> +
> +struct gpmc_pdata {
> +	unsigned			num_device;
> +	struct gpmc_device_pdata	**device_pdata;
> +};
> +
>  struct gpmc_nand_regs {
>  	void __iomem	*gpmc_status;
>  	void __iomem	*gpmc_nand_command;
