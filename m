From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 3/5] counter: new TI eQEP driver
Date: Wed, 7 Aug 2019 14:49:08 -0500
Message-ID: <73c4b228-e3d0-ecb0-21b7-6101587481b3@lechnology.com>
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-4-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190807194023.15318-4-david@lechnology.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/7/19 2:40 PM, David Lechner wrote:
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2967d0a9ff91..7eeb310f0cda 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -49,6 +49,18 @@ config STM32_LPTIMER_CNT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called stm32-lptimer-cnt.
>   
> +config TI_EQEP
> +	tristate "TI eQEP counter driver"
> +	depends on (SOC_AM33XX || COMPILE_TEST)
> +	select PWM

oops, missed removing `select PWM`. This line is no longer needed with
patch 1/5.

> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the Texas Instruments Enhanced Quadrature
> +	  Encoder Pulse (eQEP) counter driver.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ti-eqep.
> +
>   config FTM_QUADDEC
>   	tristate "Flex Timer Module Quadrature decoder driver"
>   	depends on HAS_IOMEM && OF
