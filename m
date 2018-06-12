From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for
 serio device
Date: Tue, 12 Jun 2018 15:23:56 -0700
Message-ID: <20180612222356.GD38773@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Janusz,

On Sat, Jun 09, 2018 at 04:02:15PM +0200, Janusz Krzysztofik wrote:
> GPIO lookup table for ams-delta-serio device was introduced by commit
> 0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
> Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
> lookup table" was not accepted by subystem maintainer who requested
> conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
> pin with IRQ resource, replacement of GPIO pin providing keyboard power
> with a regulator and removal of remaining GPIO pins from the driver as
> not handled by it.
> 
> Let's start with removal of no the longer needed GPIO lookup table from
> the board init file.
> 
> Series created and tested on top of next-20180608 tag from linux-next
> tree.

This all is really nice (modulo a couple of questions), thank you for
implementing this. How do you want to merge this? Through OMAP tree or
input?

> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 80f54cb54276..18e0ff437b27 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -504,20 +504,6 @@ static struct platform_device cx20442_codec_device = {
>  	.id     = -1,
>  };
>  
> -static struct gpiod_lookup_table ams_delta_serio_gpio_table = {
> -	.table = {
> -		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
> -			    "data", 0),
> -		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_CLK,
> -			    "clock", 0),
> -		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR,
> -			    "power", 0),
> -		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT,
> -			    "dataout", 0),
> -		{ },
> -	},
> -};
> -
>  static struct platform_device *ams_delta_devices[] __initdata = {
>  	&latch1_gpio_device,
>  	&latch2_gpio_device,
> @@ -534,7 +520,6 @@ static struct platform_device *late_devices[] __initdata = {
>  
>  static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
>  	&ams_delta_audio_gpio_table,
> -	&ams_delta_serio_gpio_table,
>  };
>  
>  static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
> @@ -580,10 +565,6 @@ static void __init ams_delta_init(void)
>  	 */
>  	ams_delta_audio_gpio_table.dev_id =
>  			dev_name(&ams_delta_audio_device.dev);
> -	/*
> -	 * No device name is assigned to GPIO lookup table for serio device
> -	 * as long as serio driver is not converted to platform device driver.
> -	 */
>  
>  	gpiod_add_lookup_tables(ams_delta_gpio_tables,
>  				ARRAY_SIZE(ams_delta_gpio_tables));
> -- 
> 2.16.1
> 

-- 
Dmitry
