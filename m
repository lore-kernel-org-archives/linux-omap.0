From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] OMAP3: cm-t35: enable ds2786 battery gas gauge
Date: Thu, 22 Apr 2010 10:32:13 +0300
Message-ID: <4BCFFB7D.8030509@compulab.co.il>
References: <1271919966-12366-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:49926 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab0DVHdR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 03:33:17 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1O4quS-0006uy-UD
	for linux-omap@vger.kernel.org; Thu, 22 Apr 2010 02:33:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id EFA749A028A
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 10:33:15 +0300 (IDT)
In-Reply-To: <1271919966-12366-1-git-send-email-mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Yulia Vilensky <vilensky@compulab.co.il>, Mike Rapoport <mike@compulab.co.il>

Please discard. Sorry for the noise.


Mike Rapoport wrote:
> From: Yulia Vilensky <vilensky@compulab.co.il>
> 
> This patch depends on ds2786 patch [1], but it does not break anything
> even without the ds2786 battery support.
> 
> [1] http://lkml.org/lkml/2010/4/22/48
> 
> --
> Signed-off-by: Yulia Vilensky <vilensky@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 2de4f79..c28e7bb 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -687,10 +687,23 @@ static struct i2c_board_info __initdata cm_t35_i2c_boardinfo[] = {
>  	},
>  };
>  
> +#define DS2786_RSNS    18 /* Constant sense resistor value */
> +
> +static int cm_t35_ds2786_rsns_val = DS2786_RSNS;
> +
> +static struct i2c_board_info __initdata cm_t35_i2c3_boardinfo[] = {
> +	{
> +		I2C_BOARD_INFO("ds2786", 0x36),
> +		.platform_data = &cm_t35_ds2786_rsns_val,
> +	},
> +};
> +
>  static void __init cm_t35_init_i2c(void)
>  {
>  	omap_register_i2c_bus(1, 2600, cm_t35_i2c_boardinfo,
>  			      ARRAY_SIZE(cm_t35_i2c_boardinfo));
> +	omap_register_i2c_bus(3, 400, cm_t35_i2c3_boardinfo,
> +			      ARRAY_SIZE(cm_t35_i2c3_boardinfo));
>  }
>  
>  static struct omap_board_config_kernel cm_t35_config[] __initdata = {


-- 
Sincerely yours,
Mike.
