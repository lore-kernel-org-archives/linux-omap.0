From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: cpcap: Fix interrupt to use level interrupt
Date: Tue, 11 Apr 2017 10:54:45 +0100
Message-ID: <20170411095445.egoderehaiwovj5b@dell>
References: <20170404031556.5093-1-tony@atomide.com>
 <20170404031556.5093-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404031556.5093-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 03 Apr 2017, Tony Lindgren wrote:

> I made a mistake assuming the device tree configuration for interrupt
> triggering was somehow passed to the SPI device but it's not.
> 
> In the Motorola Linux kernel tree CPCAP PMIC is configured as a rising
> edge triggered interrupt, but then then it's interrupt handler keeps
> looping until the GPIO line goes down. So the CPCAP interrupt is clearly
> a level interrupt and not an edge interrupt.
> 
> Earlier when I tried to configure it as level interrupt using the
> device tree, I did not account that the triggering only gets passed
> to the SPI core and it also needs to be specified in the CPCAP driver
> when we do devm_regmap_add_irq_chip().
> 
> Fixes: 56e1d40d3bea ("mfd: cpcap: Add minimal support")
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/motorola-cpcap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -126,7 +126,7 @@ static int cpcap_init_irq_chip(struct cpcap_ddata *cpcap, int irq_chip,
>  
>  	ret = devm_regmap_add_irq_chip(&cpcap->spi->dev, cpcap->regmap,
>  				       cpcap->spi->irq,
> -				       IRQF_TRIGGER_RISING |
> +				       irq_get_trigger_type(cpcap->spi->irq) |
>  				       IRQF_SHARED, -1,
>  				       chip, &cpcap->irqdata[irq_chip]);
>  	if (ret) {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
