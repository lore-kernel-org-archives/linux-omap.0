From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP: RX-51: Drop I2C-1 speed to 2200
Date: Fri, 9 Oct 2009 09:15:34 -0500
Message-ID: <4ACF4586.2010905@ti.com>
References: <1255088564-7861-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760876AbZJIOQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 10:16:16 -0400
In-Reply-To: <1255088564-7861-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aaro Koskinen had written, on 10/09/2009 06:42 AM, the following:
> The I2C-1 bus frequency on RX-51 should be 2.2 MHz.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index c1af532..2b0eb1b 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -444,7 +444,7 @@ static int __init rx51_i2c_init(void)
>  		rx51_twldata.vaux3 = &rx51_vaux3_cam;
>  		rx51_twldata.vmmc2 = &rx51_vmmc2;
>  	}
> -	omap_register_i2c_bus(1, 2600, rx51_peripherals_i2c_board_info_1,
> +	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
why?

-- 
Regards,
Nishanth Menon
