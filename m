From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: nand: reorganize gpmc timing values
Date: Thu, 16 May 2013 08:49:52 -0700
Message-ID: <20130516154952.GT5600@atomide.com>
References: <5170738F.8050305@ti.com>
 <1366325282.4232.6.camel@lovely>
 <51708097.6070102@ti.com>
 <51708131.2040208@ti.com>
 <1366362081.3928.18.camel@mars>
 <1366372957.3928.104.camel@mars>
 <51714E0D.7020304@ti.com>
 <1366383208.3928.144.camel@mars>
 <5171647B.9070108@ti.com>
 <1366388981.3928.158.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16580 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754565Ab3EPPt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 11:49:57 -0400
Content-Disposition: inline
In-Reply-To: <1366388981.3928.158.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Christoph Fritz <chf.fritz@googlemail.com> [130419 09:34]:
> This patch removes omap2_nand_gpmc_retime() which was used to quirk
> some timing values before gpmc_cs_set_timings(). Due to recent changes,
> gpmc_cs_set_timings() has evolved so that there is no more need for a
> retime function.
> 
> To keep the gpmc configuration consistent for legacy board files, this
> patch also adds oe_on and we_on to nand_default_timings[] as they
> would be by the retime function.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

Thanks looks safe to me so applying into omap-for-v3.11/gpmc.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/board-flash.c |    3 +++
>  arch/arm/mach-omap2/gpmc-nand.c   |   40 +------------------------------------
>  2 files changed, 4 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
> index c33adea..fc20a61 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -112,6 +112,9 @@ struct gpmc_timings nand_default_timings[1] = {
>  		.cs_rd_off = 36,
>  		.cs_wr_off = 36,
>  
> +		.we_on = 6,
> +		.oe_on = 6,
> +
>  		.adv_on = 6,
>  		.adv_rd_off = 24,
>  		.adv_wr_off = 36,
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index d9c2719..c8044b0 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -43,44 +43,6 @@ static struct platform_device gpmc_nand_device = {
>  	.resource	= gpmc_nand_resource,
>  };
>  
> -static int omap2_nand_gpmc_retime(
> -				struct omap_nand_platform_data *gpmc_nand_data,
> -				struct gpmc_timings *gpmc_t)
> -{
> -	struct gpmc_timings t;
> -	int err;
> -
> -	memset(&t, 0, sizeof(t));
> -	t.sync_clk = gpmc_t->sync_clk;
> -	t.cs_on = gpmc_t->cs_on;
> -	t.adv_on = gpmc_t->adv_on;
> -
> -	/* Read */
> -	t.adv_rd_off = gpmc_t->adv_rd_off;
> -	t.oe_on  = t.adv_on;
> -	t.access = gpmc_t->access;
> -	t.oe_off = gpmc_t->oe_off;
> -	t.cs_rd_off = gpmc_t->cs_rd_off;
> -	t.rd_cycle = gpmc_t->rd_cycle;
> -
> -	/* Write */
> -	t.adv_wr_off = gpmc_t->adv_wr_off;
> -	t.we_on  = t.oe_on;
> -	if (cpu_is_omap34xx()) {
> -		t.wr_data_mux_bus = gpmc_t->wr_data_mux_bus;
> -		t.wr_access = gpmc_t->wr_access;
> -	}
> -	t.we_off = gpmc_t->we_off;
> -	t.cs_wr_off = gpmc_t->cs_wr_off;
> -	t.wr_cycle = gpmc_t->wr_cycle;
> -
> -	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
> -	if (err)
> -		return err;
> -
> -	return 0;
> -}
> -
>  static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>  {
>  	/* support only OMAP3 class */
> @@ -131,7 +93,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>  				gpmc_get_client_irq(GPMC_IRQ_COUNT_EVENT);
>  
>  	if (gpmc_t) {
> -		err = omap2_nand_gpmc_retime(gpmc_nand_data, gpmc_t);
> +		err = gpmc_cs_set_timings(gpmc_nand_data->cs, gpmc_t);
>  		if (err < 0) {
>  			dev_err(dev, "Unable to set gpmc timings: %d\n", err);
>  			return err;
> -- 
> 1.7.10.4
> 
> 
> 
