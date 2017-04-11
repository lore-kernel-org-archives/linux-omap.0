From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: cpcap: Use ack_invert interrupts
Date: Tue, 11 Apr 2017 10:54:56 +0100
Message-ID: <20170411095456.etcaxk5y4c3b5epx@dell>
References: <20170404031556.5093-1-tony@atomide.com>
 <20170404031556.5093-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404031556.5093-3-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 03 Apr 2017, Tony Lindgren wrote:

> We should use ack_invert as the int_read_and_clear() in the Motorola
> kernel tree does "ireg_val & ~mreg_val" before writing to the mask
> register.
> 
> Fixes: 56e1d40d3bea ("mfd: cpcap: Add minimal support")
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Tested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/motorola-cpcap.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -71,6 +71,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.ack_base = CPCAP_REG_MI1,
>  		.mask_base = CPCAP_REG_MIM1,
>  		.use_ack = true,
> +		.ack_invert = true,
>  	},
>  	{
>  		.name = "cpcap-m2",
> @@ -79,6 +80,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.ack_base = CPCAP_REG_MI2,
>  		.mask_base = CPCAP_REG_MIM2,
>  		.use_ack = true,
> +		.ack_invert = true,
>  	},
>  	{
>  		.name = "cpcap1-4",
> @@ -88,6 +90,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.mask_base = CPCAP_REG_INTM1,
>  		.type_base = CPCAP_REG_INTS1,
>  		.use_ack = true,
> +		.ack_invert = true,
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
