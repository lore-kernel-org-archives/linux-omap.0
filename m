From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/8] OMAP4 : DSS2 : Add display structure in the board
 file for OMAP4 sdp
Date: Sun, 27 Feb 2011 11:13:24 +0200
Message-ID: <1298798004.1977.3.camel@deskari>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	 <1298643715-21540-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41889 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab1B0JN2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 04:13:28 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1R9DSV1031229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:13:28 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1R9DRis013817
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:13:27 -0600 (CST)
In-Reply-To: <1298643715-21540-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
> Adding  board file changes for display which adds the display structure
> with HDMI as the default driver when the display init is called.
> HDMI GPIO configurations are also done in this file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |   82 +++++++++++++++++++++++++++++++++++
>  1 files changed, 82 insertions(+), 0 deletions(-)

You could move this patch in the end of the set, together with the panda
board patch.

The prefix "OMAP4: DSS2" is not quite right for this, as this is a board
file change. And you should mention HDMI in the subject. Perhaps
something like "OMAP: 4430SDP: Add HDMI support"

> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 07d1b20..334b6fd 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -35,6 +35,7 @@
>  #include <plat/common.h>
>  #include <plat/usb.h>
>  #include <plat/mmc.h>
> +#include <plat/display.h>
>  
>  #include "mux.h"
>  #include "hsmmc.h"
> @@ -47,6 +48,8 @@
>  #define OMAP4SDP_MDM_PWR_EN_GPIO	157
>  #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
>  #define OMAP4_SFH7741_ENABLE_GPIO		188
> +#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
> +#define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
>  
>  static struct gpio_led sdp4430_gpio_leds[] = {
>  	{
> @@ -552,6 +555,84 @@ static void __init omap_sfh7741prox_init(void)
>  	}
>  }
>  
> +static void sdp4430_hdmi_mux_init(void)
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
> +static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
> +{
> +	int status;

r is quite often used as a name for return values.

> +
> +	status = gpio_request_one(HDMI_GPIO_HPD, GPIOF_DIR_OUT,
> +							"hdmi_gpio_hpd");
> +	if (status) {
> +		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_HPD);
> +		return status;
> +	}
> +	status = gpio_request_one(HDMI_GPIO_LS_OE, GPIOF_DIR_OUT,
> +							"hdmi_gpio_ls_oe");
> +	if (status) {
> +		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_LS_OE);
> +		goto error1;
> +	}
> +
> +	/* The value set a pulse */

I still don't understand that comment. It's not even English.

 Tomi


