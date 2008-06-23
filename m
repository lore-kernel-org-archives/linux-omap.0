From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] i2c: add MODULE_ALIAS to twl4030 drivers
Date: Mon, 23 Jun 2008 14:11:33 +0300
Message-ID: <20080623111132.GP7741@atomide.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-3-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-4-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-5-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.178] ([63.208.196.178]:52836 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752292AbYFWLLI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 07:11:08 -0400
Content-Disposition: inline
In-Reply-To: <1213351443-3336-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080613 13:06]:
> When built as module, it helps udev to probe them.

Pushing today.

Tony


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-core.c            |    1 +
>  drivers/i2c/chips/twl4030-gpio.c            |    1 +
>  drivers/i2c/chips/twl4030-madc.c            |    1 +
>  drivers/i2c/chips/twl4030-poweroff.c        |    1 +
>  drivers/i2c/chips/twl4030-pwrbutton.c       |    1 +
>  drivers/i2c/chips/twl4030-pwrirq.c          |    1 +
>  drivers/i2c/chips/twl4030-usb.c             |    1 +
>  drivers/input/keyboard/omap-twl4030keypad.c |    1 +
>  drivers/rtc/rtc-twl4030.c                   |    1 +
>  9 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
> index 8822653..adc45d4 100644
> --- a/drivers/i2c/chips/twl4030-core.c
> +++ b/drivers/i2c/chips/twl4030-core.c
> @@ -908,6 +908,7 @@ static void __exit twl4030_exit(void)
>  subsys_initcall(twl4030_init);
>  module_exit(twl4030_exit);
>  
> +MODULE_ALIAS("i2c:" DRIVER_NAME);
>  MODULE_AUTHOR("Texas Instruments, Inc.");
>  MODULE_DESCRIPTION("I2C Core interface for TWL4030");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/i2c/chips/twl4030-gpio.c b/drivers/i2c/chips/twl4030-gpio.c
> index a448943..f16a48b 100644
> --- a/drivers/i2c/chips/twl4030-gpio.c
> +++ b/drivers/i2c/chips/twl4030-gpio.c
> @@ -827,6 +827,7 @@ static void __exit gpio_twl4030_exit(void)
>  module_init(gpio_twl4030_init);
>  module_exit(gpio_twl4030_exit);
>  
> +MODULE_ALIAS("i2c:twl4030-gpio");
>  MODULE_AUTHOR("Texas Instruments, Inc.");
>  MODULE_DESCRIPTION("GPIO interface for TWL4030");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/i2c/chips/twl4030-madc.c b/drivers/i2c/chips/twl4030-madc.c
> index f53a3db..72b126b 100644
> --- a/drivers/i2c/chips/twl4030-madc.c
> +++ b/drivers/i2c/chips/twl4030-madc.c
> @@ -448,6 +448,7 @@ static void __exit twl4030_madc_exit(void)
>  module_init(twl4030_madc_init);
>  module_exit(twl4030_madc_exit);
>  
> +MODULE_ALIAS("i2c:twl4030-adc");
>  MODULE_AUTHOR("Nokia Corporation");
>  MODULE_DESCRIPTION("twl4030 ADC driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/i2c/chips/twl4030-poweroff.c b/drivers/i2c/chips/twl4030-poweroff.c
> index 57c7fc7..0ebab0b 100644
> --- a/drivers/i2c/chips/twl4030-poweroff.c
> +++ b/drivers/i2c/chips/twl4030-poweroff.c
> @@ -70,6 +70,7 @@ static void __exit twl4030_poweroff_exit(void)
>  module_init(twl4030_poweroff_init);
>  module_exit(twl4030_poweroff_exit);
>  
> +MODULE_ALIAS("i2c:twl4030-poweroff");
>  MODULE_DESCRIPTION("Triton2 device power off");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Peter De Schrijver");
> diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/i2c/chips/twl4030-pwrbutton.c
> index cbc31aa..09adc67 100644
> --- a/drivers/i2c/chips/twl4030-pwrbutton.c
> +++ b/drivers/i2c/chips/twl4030-pwrbutton.c
> @@ -154,6 +154,7 @@ static void __exit twl4030_pwrbutton_exit(void)
>  module_init(twl4030_pwrbutton_init);
>  module_exit(twl4030_pwrbutton_exit);
>  
> +MODULE_ALIAS("i2c:twl4030-pwrbutton");
>  MODULE_DESCRIPTION("Triton2 Power Button");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Peter De Schrijver");
> diff --git a/drivers/i2c/chips/twl4030-pwrirq.c b/drivers/i2c/chips/twl4030-pwrirq.c
> index 8f1fec6..a4d2e92 100644
> --- a/drivers/i2c/chips/twl4030-pwrirq.c
> +++ b/drivers/i2c/chips/twl4030-pwrirq.c
> @@ -222,5 +222,6 @@ static void __exit twl4030_pwrirq_exit(void)
>  	}
>  }
>  
> +MODULE_ALIAS("i2c:twl4030-pwrirq");
>  subsys_initcall(twl4030_pwrirq_init);
>  module_exit(twl4030_pwrirq_exit);
> diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
> index f546d42..ab335ca 100644
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -770,6 +770,7 @@ static void __exit twl4030_usb_exit(void)
>  subsys_initcall(twl4030_usb_init);
>  module_exit(twl4030_usb_exit);
>  
> +MODULE_ALIAS("i2c:twl4030-usb");
>  MODULE_AUTHOR("Texas Instruments, Inc.");
>  MODULE_DESCRIPTION("TWL4030 USB transceiver driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
> index 0344b4c..94ab43b 100644
> --- a/drivers/input/keyboard/omap-twl4030keypad.c
> +++ b/drivers/input/keyboard/omap-twl4030keypad.c
> @@ -368,6 +368,7 @@ static void __exit omap_kp_exit(void)
>  
>  module_init(omap_kp_init);
>  module_exit(omap_kp_exit);
> +MODULE_ALIAS("platform:omap_twl4030keypad");
>  MODULE_AUTHOR("Texas Instruments");
>  MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
> index ef0e175..e9386ba 100644
> --- a/drivers/rtc/rtc-twl4030.c
> +++ b/drivers/rtc/rtc-twl4030.c
> @@ -647,6 +647,7 @@ static void __exit twl4030_rtc_exit(void)
>  	platform_driver_unregister(&twl4030rtc_driver);
>  }
>  
> +MODULE_ALIAS("platform:twl4030_rtc");
>  MODULE_AUTHOR("Texas Instruments, MontaVista Software");
>  MODULE_LICENSE("GPL");;
>  
> -- 
> 1.5.6.rc1
> 
