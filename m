From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] mfd: cpcap: Fix bad use of IRQ sense register
Date: Tue, 11 Apr 2017 10:55:07 +0100
Message-ID: <20170411095507.3nfabfqx2rz45uft@dell>
References: <20170404031556.5093-1-tony@atomide.com>
 <20170404031556.5093-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404031556.5093-4-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 03 Apr 2017, Tony Lindgren wrote:

> The cpcap INTS registers are for getting the value of the line,
> not for configuring the type.
> 
> Fixes: 56e1d40d3bea ("mfd: cpcap: Add minimal support")
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Reviewed-By: Sebastian Reichel <sre@kernel.org>
> Tested-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/motorola-cpcap.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -88,7 +88,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.status_base = CPCAP_REG_INT1,
>  		.ack_base = CPCAP_REG_INT1,
>  		.mask_base = CPCAP_REG_INTM1,
> -		.type_base = CPCAP_REG_INTS1,
>  		.use_ack = true,
>  		.ack_invert = true,
>  	},

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
