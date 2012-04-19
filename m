From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP3: cm-t35: add support for power off
Date: Thu, 19 Apr 2012 13:40:59 +0300
Message-ID: <4F8FEBBB.70509@compulab.co.il>
References: <1332928278-6582-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49714
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752692Ab2DSKlK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 06:41:10 -0400
In-Reply-To: <1332928278-6582-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

ping!

Tony, can this please, go into 3.5?

On 03/28/12 11:51, Igor Grinberg wrote:
> Enable the power off feature of the TPS65930 on-board PMIC.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 8770be1..46275c6 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -499,6 +499,10 @@ static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
>  	.setup          = cm_t35_twl_gpio_setup,
>  };
>  
> +static struct twl4030_power_data cm_t35_power_data = {
> +	.use_poweroff	= true,
> +};
> +
>  static struct twl4030_platform_data cm_t35_twldata = {
>  	/* platform_data for children goes here */
>  	.keypad		= &cm_t35_kp_data,
> @@ -506,6 +510,7 @@ static struct twl4030_platform_data cm_t35_twldata = {
>  	.vmmc1		= &cm_t35_vmmc1,
>  	.vsim		= &cm_t35_vsim,
>  	.vio		= &cm_t35_vio,
> +	.power		= &cm_t35_power_data,
>  };
>  
>  static void __init cm_t35_init_i2c(void)

-- 
Regards,
Igor.
