From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/8] MFD: twl4030-audio: Rename platform data
Date: Wed, 1 Jun 2011 05:07:54 -0700
Message-ID: <20110601120754.GC11352@atomide.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
 <1306927051-8937-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1306927051-8937-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110601 04:14]:
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -463,11 +463,11 @@ static struct regulator_init_data sdp3430_vpll2 = {
>  	.consumer_supplies	= sdp3430_vpll2_supplies,
>  };
>  
> -static struct twl4030_codec_audio_data sdp3430_audio;
> +static struct twl4030_codec_data sdp3430_codec;
>  
> -static struct twl4030_codec_data sdp3430_codec = {
> +static struct twl4030_audio_data sdp3430_audio = {
>  	.audio_mclk = 26000000,
> -	.audio = &sdp3430_audio,
> +	.codec = &sdp3430_codec,
>  };
>  
>  static struct twl4030_platform_data sdp3430_twldata = {
> @@ -480,7 +480,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
>  	.madc		= &sdp3430_madc_data,
>  	.keypad		= &sdp3430_kp_data,
>  	.usb		= &sdp3430_usb_data,
> -	.codec		= &sdp3430_codec,
> +	.audio		= &sdp3430_audio,
>  
>  	.vaux1		= &sdp3430_vaux1,
>  	.vaux2		= &sdp3430_vaux2,
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -337,11 +337,11 @@ static struct twl4030_usb_data devkit8000_usb_data = {
>  	.usb_mode	= T2_USB_MODE_ULPI,
>  };
>  
> -static struct twl4030_codec_audio_data devkit8000_audio_data;
> +static struct twl4030_codec_data devkit8000_codec_data;
>  
> -static struct twl4030_codec_data devkit8000_codec_data = {
> +static struct twl4030_audio_data devkit8000_audio_data = {
>  	.audio_mclk = 26000000,
> -	.audio = &devkit8000_audio_data,
> +	.codec = &devkit8000_codec_data,
>  };
>  
>  static struct twl4030_platform_data devkit8000_twldata = {
> @@ -351,7 +351,7 @@ static struct twl4030_platform_data devkit8000_twldata = {
>  	/* platform_data for children goes here */
>  	.usb		= &devkit8000_usb_data,
>  	.gpio		= &devkit8000_gpio_data,
> -	.codec		= &devkit8000_codec_data,
> +	.audio		= &devkit8000_audio_data,
>  	.vmmc1		= &devkit8000_vmmc1,
>  	.vdac		= &devkit8000_vdac,
>  	.vpll1		= &devkit8000_vpll1,
...

Can you please take a look at creating arch/arm/mach-omap2/i2c-twl.c or
something in common-board-devices.c to get rid of the cut and paste
duplication in every board-*.c file?

Maybe you could have a generic twl_init function that allows overriding
things like keypad with board specific configuration?

Regards,

Tony
