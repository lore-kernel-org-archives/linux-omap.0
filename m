From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 1/2] omap: rx51: Use REGULATOR_SUPPLY macro when
 initializing regulator consumers
Date: Tue, 18 May 2010 15:09:00 +0300
Message-ID: <20100518120900.GF11782@besouro.research.nokia.com>
References: <1274180761-14221-1-git-send-email-jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54517 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab0ERMD5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:03:57 -0400
Content-Disposition: inline
In-Reply-To: <1274180761-14221-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>

Moi Jarkko,

On Tue, May 18, 2010 at 01:06:00PM +0200, Jarkko Nikula wrote:
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

I don't have any major objections on this one. I'd just add a patch description though.
Other than that:

Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>


> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   43 ++++++-------------------
>  1 files changed, 11 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 8179d55..ead7ee1 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -272,48 +272,27 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
>  	{}	/* Terminator */
>  };
>  
> -static struct regulator_consumer_supply rx51_vmmc1_supply = {
> -	.supply   = "vmmc",
> -	.dev_name = "mmci-omap-hs.0",
> -};
> +static struct regulator_consumer_supply rx51_vmmc1_supply =
> +	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
>  
> -static struct regulator_consumer_supply rx51_vaux3_supply = {
> -	.supply   = "vmmc",
> -	.dev_name = "mmci-omap-hs.1",
> -};
> +static struct regulator_consumer_supply rx51_vaux3_supply =
> +	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
>  
> -static struct regulator_consumer_supply rx51_vsim_supply = {
> -	.supply   = "vmmc_aux",
> -	.dev_name = "mmci-omap-hs.1",
> -};
> +static struct regulator_consumer_supply rx51_vsim_supply =
> +	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1");
>  
>  static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
>  	/* tlv320aic3x analog supplies */
> -	{
> -		.supply		= "AVDD",
> -		.dev_name	= "2-0018",
> -	},
> -	{
> -		.supply		= "DRVDD",
> -		.dev_name	= "2-0018",
> -	},
> +	REGULATOR_SUPPLY("AVDD", "2-0018"),
> +	REGULATOR_SUPPLY("DRVDD", "2-0018"),
>  	/* Keep vmmc as last item. It is not iterated for newer boards */
> -	{
> -		.supply		= "vmmc",
> -		.dev_name	= "mmci-omap-hs.1",
> -	},
> +	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
>  };
>  
>  static struct regulator_consumer_supply rx51_vio_supplies[] = {
>  	/* tlv320aic3x digital supplies */
> -	{
> -		.supply		= "IOVDD",
> -		.dev_name	= "2-0018"
> -	},
> -	{
> -		.supply		= "DVDD",
> -		.dev_name	= "2-0018"
> -	},
> +	REGULATOR_SUPPLY("IOVDD", "2-0018"),
> +	REGULATOR_SUPPLY("DVDD", "2-0018"),
>  };
>  
>  static struct regulator_init_data rx51_vaux1 = {
> -- 
> 1.7.1
