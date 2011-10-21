From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: HDMI: Move duplicate code from boardfile
 to
Date: Fri, 21 Oct 2011 14:12:41 +0300
Message-ID: <1319195561.2870.75.camel@deskari>
References: <1319189211-10991-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46043 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754460Ab1JULMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Oct 2011 07:12:47 -0400
Received: by mail-bw0-f50.google.com with SMTP id q10so5607880bka.23
        for <linux-omap@vger.kernel.org>; Fri, 21 Oct 2011 04:12:44 -0700 (PDT)
In-Reply-To: <1319189211-10991-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Fri, 2011-10-21 at 14:56 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Move duplicate HDMI mux_init code from omap4 and panda board file
> to display file.

The subject is again broken.

> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c    |   15 ---------------
>  arch/arm/mach-omap2/board-omap4panda.c |   16 ----------------
>  arch/arm/mach-omap2/display.c          |   25 +++++++++++++++++++++++++
>  3 files changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 6d16306..4fcdf38 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -601,20 +601,6 @@ static void __init omap_sfh7741prox_init(void)
>  			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
>  }
>  
> -static void sdp4430_hdmi_mux_init(void)
> -{
> -	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
> -	omap_mux_init_signal("hdmi_hpd",
> -			OMAP_PIN_INPUT_PULLUP);
> -	omap_mux_init_signal("hdmi_cec",
> -			OMAP_PIN_INPUT_PULLUP);
> -	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
> -	omap_mux_init_signal("hdmi_ddc_scl",
> -			OMAP_PIN_INPUT_PULLUP);
> -	omap_mux_init_signal("hdmi_ddc_sda",
> -			OMAP_PIN_INPUT_PULLUP);
> -}
> -
>  static struct gpio sdp4430_hdmi_gpios[] = {
>  	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_hpd"   },
>  	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
> @@ -844,7 +830,6 @@ static void omap_4430sdp_display_init(void)
>  		pr_err("%s: Could not get display_sel GPIO\n", __func__);
>  
>  	sdp4430_lcd_init();
> -	sdp4430_hdmi_mux_init();
>  	sdp4430_picodlp_init();
>  	omap_display_init(&sdp4430_dss_data);
>  }
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index a38ed273..bb5fca2 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -484,21 +484,6 @@ int __init omap4_panda_dvi_init(void)
>  	return r;
>  }
>  
> -
> -static void omap4_panda_hdmi_mux_init(void)
> -{
> -	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
> -	omap_mux_init_signal("hdmi_hpd",
> -			OMAP_PIN_INPUT_PULLUP);
> -	omap_mux_init_signal("hdmi_cec",
> -			OMAP_PIN_INPUT_PULLUP);
> -	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
> -	omap_mux_init_signal("hdmi_ddc_scl",
> -			OMAP_PIN_INPUT_PULLUP);
> -	omap_mux_init_signal("hdmi_ddc_sda",
> -			OMAP_PIN_INPUT_PULLUP);
> -}
> -
>  static struct gpio panda_hdmi_gpios[] = {
>  	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_hpd"   },
>  	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
> @@ -550,7 +535,6 @@ void omap4_panda_display_init(void)
>  	if (r)
>  		pr_err("error initializing panda DVI\n");
>  
> -	omap4_panda_hdmi_mux_init();
>  	omap_display_init(&omap4_panda_dss_data);
>  }
>  
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 94a96ce..f6590b9 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -28,6 +28,7 @@
>  #include <plat/omap-pm.h>
>  #include <plat/common.h>
>  
> +#include "mux.h"
>  #include "control.h"
>  #include "display.h"
>  
> @@ -103,6 +104,20 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
>  	{ "dss_hdmi", "omapdss_hdmi", -1 },
>  };
>  
> +static void omap4_hdmi_mux_pads(void)
> +{
> +	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
> +	omap_mux_init_signal("hdmi_hpd",
> +			OMAP_PIN_INPUT_PULLUP);
> +	omap_mux_init_signal("hdmi_cec",
> +			OMAP_PIN_INPUT_PULLUP);
> +	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
> +	omap_mux_init_signal("hdmi_ddc_scl",
> +			OMAP_PIN_INPUT_PULLUP);
> +	omap_mux_init_signal("hdmi_ddc_sda",
> +			OMAP_PIN_INPUT_PULLUP);
> +}
> +
>  static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
>  {
>  	u32 enable_mask, enable_shift;
> @@ -136,6 +151,14 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
>  	return 0;
>  }
>  
> +static int omap_hdmi_enable_pads(void)
> +{
> +	if (cpu_is_omap44xx())
> +		omap4_hdmi_mux_pads();
> +
> +	return 0;
> +}
> +
>  static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
>  {
>  	if (cpu_is_omap44xx())
> @@ -172,6 +195,8 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
>  		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
>  	}
>  
> +	omap_hdmi_enable_pads();

Now this would be done for all boards, even those without HDMI. I don't
think that's right, as the HDMI pins can probably be used for something
else.

Should there be similar system than for DSI, so an enable and disable
function for the pads, called from the hdmi driver?

However, for DSI we need to change the pins during runtime, so that's
why the functions for DSI are required. If the HDMI configuration is
more static, and needs to be done only once at boot time, perhaps the
display_init function could go through the displays from the board_data,
and if there's an HDMI display defined, do the muxing.

So is there ever need to change the hdmi pins after they have been
configured? I guess the pins could be changed to safe mode when not in
use, preserving some power, but I don't know if that difference is
noticeable.

 Tomi


