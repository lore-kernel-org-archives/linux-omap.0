From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v2] OMAP3EVM: ehci: Fix EHCI support
Date: Wed, 24 Aug 2011 17:23:04 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC007BC0@dbde02.ent.ti.com>
References: <1314174902-12797-1-git-send-email-bdefaria@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570Ab1HXLxY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 07:53:24 -0400
In-Reply-To: <1314174902-12797-1-git-send-email-bdefaria@adeneo-embedded.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan DE FARIA <bdefaria@adeneo-embedded.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,
> Set the VAUX2 regulator supply to 1.8V for the HSUSB host interface.
> Gpio 2 of the TPS65950 has to be set to zero in order to enable the
> HSUBS2 clock.

TPS65950 GPIO2 is not to enable HSUSB2 clock but to enable chip u131
On omap3evm (rev-G) which latches USB, camera and audio lines.

> 
> Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index c452b3f..13a2b71 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -377,6 +377,10 @@ static int omap3evm_twl_gpio_setup(struct device
> *dev,
>  	if (r)
>  		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
> 
> +	/* gpio + 2 == HSUSB2 Clock Enable */
> +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> +		gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW,
> "EN_HSUSB2_CLK");
> +

Did you test EHCI port with this change ?

Ajay
>  	/* gpio + 7 == DVI Enable */
>  	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
[...]
rm-kernel
