From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: pandora: add support for mode devices
Date: Wed, 27 May 2009 13:24:16 -0700
Message-ID: <20090527202415.GD6267@atomide.com>
References: <20090525174517.19679.18805.stgit@localhost> <1243453668-25208-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53414 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbZE0UY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 16:24:26 -0400
Content-Disposition: inline
In-Reply-To: <1243453668-25208-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [090527 12:48]:
> Add support for keypad, GPIO keys and LEDs. Also enable hardware
> debounce feature for GPIO keys.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> This patch was somehow left out, so Tony suggested posting it directly here.

Thanks, I've added this patch to my queue.

Tony
 
>  arch/arm/mach-omap2/board-omap3pandora.c |  149 ++++++++++++++++++++++++++++++
>  1 files changed, 149 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index 2ab2497..e32aa23 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -25,6 +25,9 @@
>  #include <linux/spi/ads7846.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c/twl4030.h>
> +#include <linux/leds.h>
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -36,12 +39,154 @@
>  #include <mach/hardware.h>
>  #include <mach/mcspi.h>
>  #include <mach/usb.h>
> +#include <mach/keypad.h>
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "mmc-twl4030.h"
>  
>  #define OMAP3_PANDORA_TS_GPIO		94
>  
> +/* hardware debounce: (value + 1) * 31us */
> +#define GPIO_DEBOUNCE_TIME		127
> +
> +static struct gpio_led pandora_gpio_leds[] = {
> +	{
> +		.name			= "pandora::sd1",
> +		.default_trigger	= "mmc0",
> +		.gpio			= 128,
> +	}, {
> +		.name			= "pandora::sd2",
> +		.default_trigger	= "mmc1",
> +		.gpio			= 129,
> +	}, {
> +		.name			= "pandora::bluetooth",
> +		.gpio			= 158,
> +	}, {
> +		.name			= "pandora::wifi",
> +		.gpio			= 159,
> +	},
> +};
> +
> +static struct gpio_led_platform_data pandora_gpio_led_data = {
> +	.leds		= pandora_gpio_leds,
> +	.num_leds	= ARRAY_SIZE(pandora_gpio_leds),
> +};
> +
> +static struct platform_device pandora_leds_gpio = {
> +	.name	= "leds-gpio",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &pandora_gpio_led_data,
> +	},
> +};
> +
> +#define GPIO_BUTTON(gpio_num, ev_type, ev_code, act_low, descr)	\
> +{								\
> +	.gpio		= gpio_num,				\
> +	.type		= ev_type,				\
> +	.code		= ev_code,				\
> +	.active_low	= act_low,				\
> +	.desc		= "btn " descr,				\
> +}
> +
> +#define GPIO_BUTTON_LOW(gpio_num, event_code, description)	\
> +	GPIO_BUTTON(gpio_num, EV_KEY, event_code, 1, description)
> +
> +static struct gpio_keys_button pandora_gpio_keys[] = {
> +	GPIO_BUTTON_LOW(110,	KEY_UP,		"up"),
> +	GPIO_BUTTON_LOW(103,	KEY_DOWN,	"down"),
> +	GPIO_BUTTON_LOW(96,	KEY_LEFT,	"left"),
> +	GPIO_BUTTON_LOW(98,	KEY_RIGHT,	"right"),
> +	GPIO_BUTTON_LOW(111,	BTN_A,		"a"),
> +	GPIO_BUTTON_LOW(106,	BTN_B,		"b"),
> +	GPIO_BUTTON_LOW(109,	BTN_X,		"x"),
> +	GPIO_BUTTON_LOW(101,	BTN_Y,		"y"),
> +	GPIO_BUTTON_LOW(102,	BTN_TL,		"l"),
> +	GPIO_BUTTON_LOW(97,	BTN_TL2,	"l2"),
> +	GPIO_BUTTON_LOW(105,	BTN_TR,		"r"),
> +	GPIO_BUTTON_LOW(107,	BTN_TR2,	"r2"),
> +	GPIO_BUTTON_LOW(104,	KEY_LEFTCTRL,	"ctrl"),
> +	GPIO_BUTTON_LOW(99,	KEY_MENU,	"menu"),
> +	GPIO_BUTTON_LOW(176,	KEY_COFFEE,	"hold"),
> +	GPIO_BUTTON(100, EV_KEY, KEY_LEFTALT, 0, "alt"),
> +	GPIO_BUTTON(108, EV_SW, SW_LID, 1, "lid"),
> +};
> +
> +static struct gpio_keys_platform_data pandora_gpio_key_info = {
> +	.buttons	= pandora_gpio_keys,
> +	.nbuttons	= ARRAY_SIZE(pandora_gpio_keys),
> +};
> +
> +static struct platform_device pandora_keys_gpio = {
> +	.name	= "gpio-keys",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &pandora_gpio_key_info,
> +	},
> +};
> +
> +static void __init pandora_keys_gpio_init(void)
> +{
> +	/* set debounce time for GPIO banks 4 and 6 */
> +	omap_set_gpio_debounce_time(32 * 3, GPIO_DEBOUNCE_TIME);
> +	omap_set_gpio_debounce_time(32 * 5, GPIO_DEBOUNCE_TIME);
> +}
> +
> +static int pandora_keypad_map[] = {
> +	/* col, row, code */
> +	KEY(0, 0, KEY_9),
> +	KEY(0, 1, KEY_0),
> +	KEY(0, 2, KEY_BACKSPACE),
> +	KEY(0, 3, KEY_O),
> +	KEY(0, 4, KEY_P),
> +	KEY(0, 5, KEY_K),
> +	KEY(0, 6, KEY_L),
> +	KEY(0, 7, KEY_ENTER),
> +	KEY(1, 0, KEY_8),
> +	KEY(1, 1, KEY_7),
> +	KEY(1, 2, KEY_6),
> +	KEY(1, 3, KEY_5),
> +	KEY(1, 4, KEY_4),
> +	KEY(1, 5, KEY_3),
> +	KEY(1, 6, KEY_2),
> +	KEY(1, 7, KEY_1),
> +	KEY(2, 0, KEY_I),
> +	KEY(2, 1, KEY_U),
> +	KEY(2, 2, KEY_Y),
> +	KEY(2, 3, KEY_T),
> +	KEY(2, 4, KEY_R),
> +	KEY(2, 5, KEY_E),
> +	KEY(2, 6, KEY_W),
> +	KEY(2, 7, KEY_Q),
> +	KEY(3, 0, KEY_J),
> +	KEY(3, 1, KEY_H),
> +	KEY(3, 2, KEY_G),
> +	KEY(3, 3, KEY_F),
> +	KEY(3, 4, KEY_D),
> +	KEY(3, 5, KEY_S),
> +	KEY(3, 6, KEY_A),
> +	KEY(3, 7, KEY_LEFTSHIFT),
> +	KEY(4, 0, KEY_N),
> +	KEY(4, 1, KEY_B),
> +	KEY(4, 2, KEY_V),
> +	KEY(4, 3, KEY_C),
> +	KEY(4, 4, KEY_X),
> +	KEY(4, 5, KEY_Z),
> +	KEY(4, 6, KEY_DOT),
> +	KEY(4, 7, KEY_COMMA),
> +	KEY(5, 0, KEY_M),
> +	KEY(5, 1, KEY_SPACE),
> +	KEY(5, 2, KEY_FN),
> +};
> +
> +static struct twl4030_keypad_data pandora_kp_data = {
> +	.rows		= 8,
> +	.cols		= 6,
> +	.keymap		= pandora_keypad_map,
> +	.keymapsize	= ARRAY_SIZE(pandora_keypad_map),
> +	.rep		= 1,
> +};
> +
>  static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
>  	{
>  		.mmc		= 1,
> @@ -142,6 +287,7 @@ static struct twl4030_platform_data omap3pandora_twldata = {
>  	.usb		= &omap3pandora_usb_data,
>  	.vmmc1		= &pandora_vmmc1,
>  	.vmmc2		= &pandora_vmmc2,
> +	.keypad		= &pandora_kp_data,
>  };
>  
>  static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
> @@ -234,6 +380,8 @@ static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
>  
>  static struct platform_device *omap3pandora_devices[] __initdata = {
>  	&omap3pandora_lcd_device,
> +	&pandora_leds_gpio,
> +	&pandora_keys_gpio,
>  };
>  
>  static void __init omap3pandora_init(void)
> @@ -247,6 +395,7 @@ static void __init omap3pandora_init(void)
>  	spi_register_board_info(omap3pandora_spi_board_info,
>  			ARRAY_SIZE(omap3pandora_spi_board_info));
>  	omap3pandora_ads7846_init();
> +	pandora_keys_gpio_init();
>  	usb_musb_init();
>  }
>  
> -- 
> 1.5.6.3
> 
