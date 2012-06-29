From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2: Overo: init I2C before MMC to fix MMC
 suspend/resume failure
Date: Fri, 29 Jun 2012 12:03:18 +0530
Message-ID: <4FED4C2E.4030309@ti.com>
References: <1340902892-9542-1-git-send-email-khilman@ti.com> <1340902892-9542-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:60822 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750907Ab2F2GdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 02:33:25 -0400
Received: by obfk16 with SMTP id k16so9453499obf.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 23:33:23 -0700 (PDT)
In-Reply-To: <1340902892-9542-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,
On Thursday 28 June 2012 10:31 PM, Kevin Hilman wrote:
> In order for suspend/resume dependencies to work correctly, I2C has to
> be initialized (more specifically, registered with the driver core)
> before MMC.
Agree.
>   Without this, the MMC driver fails to adjust the VMMC
> regulator (using i2c writes) during the suspend path.
>
> Problem found testing suspend/resume on 3730/OveroSTORM platform.
Not related to your patch.
Was just thinking if
arch/arm/mach-omap2/board-omap3beagle.c
arch/arm/mach-omap2/board-3430sdp.c

should also be patched.

> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/board-overo.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 8fa2fc3..779734d 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -494,8 +494,8 @@ static void __init overo_init(void)
>  
>  	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> -	omap_hsmmc_init(mmc);
>  	overo_i2c_init();
> +	omap_hsmmc_init(mmc);
>  	omap_display_init(&overo_dss_data);
>  	omap_serial_init();
>  	omap_sdrc_init(mt46h32m32lf6_sdrc_params,

