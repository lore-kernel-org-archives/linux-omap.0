From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] OMAPDSS: HDMI: Move duplicate code from
 boardfile to
Date: Fri, 11 Nov 2011 09:20:32 -0800
Message-ID: <20111111172031.GF31337@atomide.com>
References: <1321016900-1714-1-git-send-email-mythripk@ti.com>
 <1321016900-1714-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55373 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753585Ab1KKRUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Nov 2011 12:20:34 -0500
Content-Disposition: inline
In-Reply-To: <1321016900-1714-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

* mythripk@ti.com <mythripk@ti.com> [111111 04:41]:
> From: Mythri P K <mythripk@ti.com>
> 
> Move duplicate HDMI mux_init code from omap4 and panda board file
> to display file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c    |   16 +---------------
>  arch/arm/mach-omap2/board-omap4panda.c |   17 +----------------
>  arch/arm/mach-omap2/display.c          |   23 +++++++++++++++++++++++
>  include/video/omapdss.h                |    2 ++
>  4 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 73b1e99..4a519a3 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -595,20 +595,6 @@ static void __init omap_sfh7741prox_init(void)
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
> @@ -838,9 +824,9 @@ static void omap_4430sdp_display_init(void)
>  		pr_err("%s: Could not get display_sel GPIO\n", __func__);
>  
>  	sdp4430_lcd_init();
> -	sdp4430_hdmi_mux_init();
>  	sdp4430_picodlp_init();
>  	omap_display_init(&sdp4430_dss_data);
> +	omap_hdmi_enable_pads();
>  }

Good to see some removal of the code here :) Maybe call the fuction
omap_hdmi_init() instead? That way you can make it more generic and
pass it some options.

Tony
