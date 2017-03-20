From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/4] mfd: cpcap: Fix bad use of IRQ sense register
Date: Mon, 20 Mar 2017 10:47:37 +0000
Message-ID: <20170320104737.fzrjyzbq77xlyl5d@dell>
References: <20170317003633.7361-1-tony@atomide.com>
 <20170317003633.7361-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317003633.7361-5-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 16 Mar 2017, Tony Lindgren wrote:

> The cpcap INTS registers are for getting the value of the line,
> not for configuring the type.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgrne <tony@atomide.com>

Please resubmit with acquired Acks and your name spelt correctly.

Acked-by: Lee Jones <lee.jones@linaro.org>

> ---
>  drivers/mfd/motorola-cpcap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -115,7 +115,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.status_base = CPCAP_REG_INT1,
>  		.ack_base = CPCAP_REG_INT1,
>  		.mask_base = CPCAP_REG_INTM1,
> -		.type_base = CPCAP_REG_INTS1,
>  		.use_ack = true,
>  		.handle_reread = true,
>  		.ack_invert = true,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
