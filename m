From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 8/9] OMAP4: omap4panda: Enable audio support
Date: Thu, 22 Dec 2011 09:32:16 -0800
Message-ID: <20111222173216.GJ24444@atomide.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
 <1324571902-16918-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41700 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753226Ab1LVRcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 12:32:24 -0500
Content-Disposition: inline
In-Reply-To: <1324571902-16918-9-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

> @@ -548,6 +588,19 @@ void omap4_panda_display_init(void)
>  	omap_display_init(&omap4_panda_dss_data);
>  }
>  
> +static void omap4_panda_audio_init(void)
> +{
> +	if (cpu_is_omap4430()) {
> +		/* PandaBoard 4430 */
> +		panda_abe_audio_data.card_name = "PandaBoard";
> +		/* Audio in is connected to HSMIC */
> +		panda_abe_audio_data.has_hsmic = 1;
> +	} else {
> +		/* PandaBoard ES */
> +		panda_abe_audio_data.card_name = "PandaBoardES";
> +	}
> +}
> +

Please move the cpu_is_omap4430() check from audio_init to..

>  static void __init omap4_panda_init(void)
>  {
>  	int package = OMAP_PACKAGE_CBS;
> @@ -560,6 +613,7 @@ static void __init omap4_panda_init(void)
>  		pr_err("error setting wl12xx data\n");
>  
>  	omap4_panda_i2c_init();
> +	omap4_panda_audio_init();
>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>  	platform_device_register(&omap_vwlan_device);
>  	board_serial_init();

..omap4_panda_init() instead and set some flag that other
devices can use too so we don't have cpu_is_omap tests
for each init function. I'd assume that will be needed for
other devices too, but that's just a guess of course :)

Tony
