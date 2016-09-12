From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 2/3] mfd: tps65217: Add power button as subdevice
Date: Mon, 12 Sep 2016 14:57:56 +0100
Message-ID: <20160912135756.GE9789@dell>
References: <20160909084204.26226-1-m.niestroj@grinn-global.com>
 <20160909084204.26226-3-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160909084204.26226-3-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 09 Sep 2016, Marcin Niestroj wrote:

> Add tps65217 power buttor subdevice with assigned IRQ resources.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> Depends on patch 1 in series
> 
> Changes v1 -> v6: none
> 
>  drivers/mfd/tps65217.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 41b5d59..57c8741 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -38,6 +38,10 @@ static struct resource charger_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
>  };
>  
> +static struct resource pb_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
> +};
> +
>  struct tps65217_irq {
>  	int mask;
>  	int interrupt;
> @@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] = {
>  		.resources = charger_resources,
>  		.of_compatible = "ti,tps65217-charger",
>  	},
> +	{
> +		.name = "tps65217-pwrbutton",
> +		.num_resources = ARRAY_SIZE(pb_resources),
> +		.resources = pb_resources,
> +		.of_compatible = "ti,tps65217-pwrbutton",
> +	},
>  };
>  
>  static irqreturn_t tps65217_irq_thread(int irq, void *data)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
