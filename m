From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
Date: Wed, 20 Jun 2012 16:05:44 +0400
Message-ID: <4FE1BC98.7050607@mvista.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com> <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56450 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab2FTMG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 08:06:26 -0400
Received: by lbbgm6 with SMTP id gm6so521045lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 05:06:25 -0700 (PDT)
In-Reply-To: <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, hvaibhav@ti.com, linux-arm-kernel@lists.infradead.org, ajay.gupta@ti.com

Hello.

On 20-06-2012 13:14, Zumeng Chen wrote:

> This was chosen by following the trace on the schematic from component U131
> and U134 to the CPEN pin on the USB3320 device.

> TWL4030.GPIO2-...->(T2_GPIO2_3V3)U131-..>nUSB2_EN-..>U134-..>EXP_nUSB2_1V8
> which starts EHCI tranceiver USB3320.

> This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.

> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
> ---
>   arch/arm/mach-omap2/board-omap3evm.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 1bfbe42..02d8047 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -360,6 +360,15 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
>
>   	platform_device_register(&leds_gpio);
>
> +	/* Enable VBUS switch by setting TWL4030.GPIO2DIR as output
> +	 * for starting USB tranceiver
> +	 */
> +	if (get_omap3_evm_rev()>= OMAP3EVM_BOARD_GEN_2) {
> +		u8 val;

    Empty line after declaration block wouldn't hurt...

> +		twl_i2c_read_u8(TWL4030_MODULE_GPIO,&val, REG_GPIODATADIR1);
> +		val |= 0x04; /* TWL4030.GPIO2DIR BIT at GPIODATADIR1(0x9B) */
> +		twl_i2c_write_u8(TWL4030_MODULE_GPIO, val, REG_GPIODATADIR1);
> +	}
>   	return 0;
>   }

WBR, Sergei
