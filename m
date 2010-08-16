From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCHv2] omap: rx51: Add bq27200 battery platform data
Date: Mon, 16 Aug 2010 17:01:20 +0300
Message-ID: <4C6944B0.4000202@felipebalbi.com>
References: <201008150112.30128.luke@dashjr.org> <20100816111029.a4c003e0.jhnikula@gmail.com> <201008160857.25075.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56671 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0HPOBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 10:01:36 -0400
In-Reply-To: <201008160857.25075.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Anton Vorontsov <cbou@mail.ru>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>

Hi,

On 08/16/2010 04:57 PM, Luke-Jr wrote:
> Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-
> rx51-peripherals.c
> index 9a5eb87..2c694d4 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -739,6 +739,11 @@ static struct i2c_board_info __initdata 
> rx51_peripherals_i2c_board_info_2[] = {
>  		.platform_data = &rx51_tsl2563_platform_data,
>  	},
>  #endif
> +#if defined(CONFIG_BATTERY_BQ27x00) || defined(CONFIG_BATTERY_BQ27x00_MODULE)
> +	{
> +		I2C_BOARD_INFO("bq27200", 0x55),
> +	},
> +#endif

i don't think the ifdefs are necessary. It won't change much keeping
bq2700 even if it's not enabled.

-- 
balbi
