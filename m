From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 3/4] OMAP4: DSS: Adding a picodlp in OMAP4430 SDP
 board file
Date: Thu, 12 May 2011 16:26:32 +0300
Message-ID: <1305206792.2062.48.camel@deskari>
References: <1305033947-4521-1-git-send-email-mayur@ti.com>
	 <1305033947-4521-4-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:32981 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755929Ab1ELN0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 09:26:39 -0400
Received: by mail-ew0-f49.google.com with SMTP id 3so508500ewy.8
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:26:37 -0700 (PDT)
In-Reply-To: <1305033947-4521-4-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org, Mythri P K <mythripk@ti.com>

On Tue, 2011-05-10 at 18:55 +0530, Mayuresh Janorkar wrote:
> An on-board projector named picodlp is available for OMAP4430 SDP.
> 
> Entry for this picodlp as a panel is being added in dss_devices array
> to the board file.
> It needs 4 GPIO pins for interfacing with host processor
> and these are defined and two of them are configured in board file.
> Two GPIOs power_on and display_select are configured here.
> picodlp also needs an i2c client over i2c controller-2 at address 0x1b.
> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
> Changes since v3:
> 	All GPIOs are requested here and assigned to init value.
> 
> Changes since v2:
> 	 Changed GPIO names to power_on, emu_done and pwrgood
> 
>  arch/arm/mach-omap2/board-4430sdp.c |   59 +++++++++++++++++++++++++++++++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 570e83f..7078037
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -38,6 +38,7 @@
>  #include <plat/omap4-keypad.h>
>  #include <plat/display.h>
>  #include <plat/nokia-dsi-panel.h>
> +#include <plat/panel-picodlp.h>
>  
>  #include "mux.h"
>  #include "hsmmc.h"
> @@ -52,6 +53,8 @@
>  #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
>  #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
>  #define LCD_BL_GPIO		27	/* LCD Backlight GPIO */
> +#define OMAP4_DLP_POWER_ON_GPIO		40
> +#define OMAP4_DLP_DISPLAY_SELECT_GPIO	59
>  /* PWM2 and TOGGLE3 register offsets */
>  #define LED_PWM2ON		0x03
>  #define LED_PWM2OFF		0x04
> @@ -812,9 +815,64 @@ static struct omap_dss_device sdp4430_hdmi_device = {
>  	.channel = OMAP_DSS_CHANNEL_DIGIT,
>  };
>  
> +static struct picodlp_panel_data sdp4430_picodlp_pdata = {
> +	.picodlp_adapter_id	= 2,
> +	.emu_done_gpio		= 44,
> +	.pwrgood_gpio		= 45,
> +};

It's better to define all the gpio numbers with defines, like you do for
the power_on and display_select gpios. And use the defines in the gpios
array below.

> +
> +static void sdp4430_picodlp_init(void)
> +{
> +	int status;
> +	struct gpio picodlp_gpios[] = {
> +		{OMAP4_DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
> +			"DLP POWER ON"},
> +		{OMAP4_DLP_DISPLAY_SELECT_GPIO, GPIOF_OUT_INIT_LOW,
> +			"DLP DISPLAY SELECT"},
> +		{sdp4430_picodlp_pdata.emu_done_gpio, GPIOF_IN,
> +			"DLP EMU DONE"},
> +		{sdp4430_picodlp_pdata.pwrgood_gpio, GPIOF_OUT_INIT_LOW,
> +			"DLP PWRGOOD"},
> +	};
> +
> +	status = gpio_request_array(picodlp_gpios, ARRAY_SIZE(picodlp_gpios));
> +	if (status)
> +		pr_err("Cannot request OMAP4_DLP_GPIOs, error %d\n", status);
> +
> +	gpio_set_value(OMAP4_DLP_DISPLAY_SELECT_GPIO, 0);
> +	gpio_set_value(OMAP4_DLP_POWER_ON_GPIO, 0);
> +	gpio_set_value(sdp4430_picodlp_pdata.pwrgood_gpio, 1);

gpio_request_array already sets the gpio values as defined in the gpios
array.

Why do you set pwrgood to 1?

 Tomi


