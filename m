From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 08/14] ARM: OMAP2+: gpmc: bool type timing helper
Date: Mon, 11 Jun 2012 17:27:45 -0500
Message-ID: <4FD670E1.5070807@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <36a87118922fb714e52d3d27235a35346aaf7b61.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2FKW1t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 18:27:49 -0400
In-Reply-To: <36a87118922fb714e52d3d27235a35346aaf7b61.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 06/11/2012 09:27 AM, Afzal Mohammed wrote:
> Some of the timing configuration like extra delay
> has bool type configurations. Provide a helper so
> that these too can be configured in Kernel.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   55 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index e60076e3..65052f8 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -68,6 +68,13 @@
>  #define GPMC_ECC_CTRL_ECCREG8		0x008
>  #define GPMC_ECC_CTRL_ECCREG9		0x009
>  
> +#define	GPMC_CONFIG2_CSEXTRADELAY		BIT(7)
> +#define	GPMC_CONFIG3_ADVEXTRADELAY		BIT(7)
> +#define	GPMC_CONFIG4_OEEXTRADELAY		BIT(7)
> +#define	GPMC_CONFIG4_WEEXTRADELAY		BIT(23)
> +#define	GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN	BIT(6)
> +#define	GPMC_CONFIG6_CYCLE2CYCLESAMECSEN	BIT(7)
> +
>  #define GPMC_CS0_OFFSET		0x60
>  #define GPMC_CS_SIZE		0x30
>  
> @@ -960,6 +967,54 @@ static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
>  	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
>  }
>  
> +static void gpmc_cs_misc_timings(int cs, const struct gpmc_misc_timings *p)
> +{
> +	u32 l;
> +
> +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +	if (p->time_para_granularity)
> +		l |= GPMC_CONFIG1_TIME_PARA_GRAN;
> +	else
> +		l &= ~GPMC_CONFIG1_TIME_PARA_GRAN;
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
> +
> +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
> +	if (p->cs_extra_delay)
> +		l |= GPMC_CONFIG2_CSEXTRADELAY;
> +	else
> +		l &= ~GPMC_CONFIG2_CSEXTRADELAY;
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, l);
> +
> +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
> +	if (p->adv_extra_delay)
> +		l |= GPMC_CONFIG3_ADVEXTRADELAY;
> +	else
> +		l &= ~GPMC_CONFIG3_ADVEXTRADELAY;
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, l);
> +
> +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
> +	if (p->oe_extra_delay)
> +		l |= GPMC_CONFIG4_OEEXTRADELAY;gpmc_cs_misc_timings
> +	else
> +		l &= ~GPMC_CONFIG4_OEEXTRADELAY;
> +	if (p->we_extra_delay)
> +		l |= GPMC_CONFIG4_WEEXTRADELAY;
> +	else
> +		l &= ~GPMC_CONFIG4_WEEXTRADELAY;
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, l);
> +
> +	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG6);
> +	if (p->cycle2cyclesamecsen)
> +		l |= GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
> +	else
> +		l &= ~GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
> +	if (p->cycle2cyclediffcsen)
> +		l |= GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
> +	else
> +		l &= ~GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
> +	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG6, l);
> +}

How about adding a sub-function like ...

static inline
void _gpmc_cs_misc_timings(int cs, int reg, int flag, int bit)
{
	if (flag)
		gpmc_set_one_timing(cs, reg, bit, bit, 1);
	else
		gpmc_set_one_timing(cs, reg, bit, bit, 0);
}

Or maybe make it into a generic set/clear bit function. Should reduce
overall lines of code.

Cheers
Jon
