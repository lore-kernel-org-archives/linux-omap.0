From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [TMP][PATCH 5/5] OMAP3EVM: Test gpmc-nand
Date: Mon, 26 Mar 2012 12:51:50 -0500
Message-ID: <4F70ACB6.5070208@ti.com>
References: <1332484630-22181-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932903Ab2CZRvx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Mar 2012 13:51:53 -0400
In-Reply-To: <1332484630-22181-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 3/23/2012 1:37, Afzal Mohammed wrote:

[snip]

>   static void __init omap3_evm_init(void)
>   {
> +	struct omap_nand_platform_data *nand_data;
> +
>   	omap3_evm_get_revision();
>
>   	if (cpu_is_omap3630())
> @@ -684,6 +747,25 @@ static void __init omap3_evm_init(void)
>   	omap3evm_init_smsc911x();
>   	omap3_evm_display_init();
>   	omap3_evm_wl12xx_init();
> +	/* NAND */
> +	nand_data = omap_nand_init(omap3_evm_nand_partitions,
> +			ARRAY_SIZE(omap3_evm_nand_partitions),
> +			0, NAND_BUSWIDTH_16, nand_default_timings);
> +	if (nand_data == NULL) {
> +		pr_err("omap_nand_init() failed\n");
> +		return;
> +	}
> +
> +	gpmc_data.device_pdata = gpmc_nand_init(nand_data);
> +	if (gpmc_data.device_pdata == NULL) {
> +		pr_err("gpmc_nand_init() failed\n");
> +		return;
> +	}
> +
> +	gpmc_data.num_device++;
> +	gpmc_data.fclk_rate = gpmc_get_fclk_period();
> +
> +	platform_device_register(&gpmc_device);
>   }

I see this is marked as a temp patch, but this is actually needed to 
register the device. Actually, we would need to do this for all boards, 
right?

Rather than registering the device here, may be we should add a function 
in arch/arm/mach-omap2/devices.c called "omap_gpmc_init()" that is 
called from all of the boards files passing the pdata structure. Then 
the omap_gmpc_init() function should use omap_device_build() API to 
register the device. If you look at arch/arm/mach-omap2/devices.c you 
can look at omap4_keyboard_init() as an example. Let me know if this is 
clear.

Cheers
Jon
