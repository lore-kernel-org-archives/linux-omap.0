From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Mon, 8 Apr 2013 14:46:24 -0700
Message-ID: <20130408214624.GZ10155@atomide.com>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24945 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965221Ab3DHVq3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 17:46:29 -0400
Content-Disposition: inline
In-Reply-To: <1363214006-10662-2-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: peter.ujfalusi@ti.com, thierry.reding@avionic-design.de, acourbot@nvidia.com, linux-omap@vger.kernel.org

* Andrew Chew <achew@nvidia.com> [130313 15:37]:
> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> ---
> Changed the device name of the backlight regulator supply to "pwm-backlight",
> per Peter's comment.
> 
> Changed the name of the regulator to "backlight-enable", per Thierry's
> suggestion.

Thanks applying into omap-for-v3.10/board. Note that I'm not taking the
second one, that should be resent to the related driver maintainers.
You can get that list by running scripts/get_maintainer.pl against it.

Regards,

Tony
 
>  arch/arm/mach-omap2/board-4430sdp.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 35f3ad0..a01a39a 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -291,6 +291,10 @@ static struct platform_device sdp4430_leds_pwm = {
>  	},
>  };
>  
> +/* Dummy regulator for pwm-backlight driver */
> +static struct regulator_consumer_supply backlight_supply =
> +	REGULATOR_SUPPLY("enable", "pwm-backlight");
> +
>  static struct platform_pwm_backlight_data sdp4430_backlight_data = {
>  	.max_brightness = 127,
>  	.dft_brightness = 127,
> @@ -718,6 +722,8 @@ static void __init omap_4430sdp_init(void)
>  
>  	omap4_i2c_init();
>  	omap_sfh7741prox_init();
> +	regulator_register_always_on(-1, "backlight-enable",
> +				     &backlight_supply, 1, 0);
>  	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
