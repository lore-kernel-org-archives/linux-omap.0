From: Tony Lindgren <tony@atomide.com>
Subject: Re: [2.6.29-rc5][PATCH 1/1] ARM: OMAP: BEAGLE: Remove dead code
	for CONFIG_I2C2_OMAP_BEAGLE
Date: Tue, 24 Feb 2009 13:46:10 -0800
Message-ID: <20090224214610.GP26205@atomide.com>
References: <1235321248-5844-1-git-send-email-jarkko.nikula@nokia.com> <1235321248-5844-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61354 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723AbZBXVqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 16:46:14 -0500
Content-Disposition: inline
In-Reply-To: <1235321248-5844-2-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

* Jarkko Nikula <jhnikula@gmail.com> [090222 08:44]:
> There is no CONFIG_I2C2_OMAP_BEAGLE in mainline and it is under removal
> in linux-omap also so remove this dead code now.

Thanks, adding to omap3-upstream queue.

Tony

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index e39cd2c..e3c8628 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -175,9 +175,6 @@ static int __init omap3_beagle_i2c_init(void)
>  {
>  	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
>  			ARRAY_SIZE(beagle_i2c_boardinfo));
> -#ifdef CONFIG_I2C2_OMAP_BEAGLE
> -	omap_register_i2c_bus(2, 400, NULL, 0);
> -#endif
>  	/* Bus 3 is attached to the DVI port where devices like the pico DLP
>  	 * projector don't work reliably with 400kHz */
>  	omap_register_i2c_bus(3, 100, NULL, 0);
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
