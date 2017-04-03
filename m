From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] mfd: cpcap: Use ack_invert interrupts
Date: Mon, 3 Apr 2017 11:21:38 +0100
Message-ID: <20170403102138.zmq3t6qt754dmfys@dell>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170322171052.7006-4-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 22 Mar 2017, Tony Lindgren wrote:

> We should use ack_invert as the int_read_and_clear() in the Motorola
> kernel tree does "ireg_val & ~mreg_val" before writing to the mask
> register.
> 
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Lee Jones <lee.jones@linaro.org>
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
> @@ -72,6 +72,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.mask_base = CPCAP_REG_MIM1,
>  		.use_ack = true,
>  		.handle_reread = true,
> +		.ack_invert = true,
>  	},
>  	{
>  		.name = "cpcap-m2",
> @@ -81,6 +82,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.mask_base = CPCAP_REG_MIM2,
>  		.use_ack = true,
>  		.handle_reread = true,
> +		.ack_invert = true,
>  	},
>  	{
>  		.name = "cpcap1-4",
> @@ -91,6 +93,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.type_base = CPCAP_REG_INTS1,
>  		.use_ack = true,
>  		.handle_reread = true,
> +		.ack_invert = true,
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
