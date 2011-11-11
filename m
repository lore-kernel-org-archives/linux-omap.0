From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] OMAPDSS: HDMI: Disable HDMI DDC internal pull up
Date: Fri, 11 Nov 2011 09:22:00 -0800
Message-ID: <20111111172200.GG31337@atomide.com>
References: <1321016900-1714-1-git-send-email-mythripk@ti.com>
 <1321016900-1714-2-git-send-email-mythripk@ti.com>
 <1321016900-1714-3-git-send-email-mythripk@ti.com>
 <1321016900-1714-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56564 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757975Ab1KKRWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Nov 2011 12:22:03 -0500
Content-Disposition: inline
In-Reply-To: <1321016900-1714-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

* mythripk@ti.com <mythripk@ti.com> [111111 04:41]:
> From: Mythri P K <mythripk@ti.com>
> 
> Disables the internal pull resistor for SDA and SCL enabled by
> default as there are expernal pull up's in 4460 and 4430 ES2.3,
> It is done to avoid the EDID read failure.
> 
> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c    |   12 +++++++++++-
>  arch/arm/mach-omap2/board-omap4panda.c |   13 ++++++++++++-
>  arch/arm/mach-omap2/display.c          |   17 ++++++++++++++---
>  include/video/omapdss.h                |    2 +-
>  4 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 4a519a3..91d3742 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -826,7 +826,17 @@ static void omap_4430sdp_display_init(void)
>  	sdp4430_lcd_init();
>  	sdp4430_picodlp_init();
>  	omap_display_init(&sdp4430_dss_data);
> -	omap_hdmi_enable_pads();
> +	/*
> +	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
> +	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
> +	 * internal pull up resistor - This is a change needed in
> +	 * OMAP4460 and OMAP4430 ES2.3 as the external pull up
> +	 * are present. This is needed to avoid EDID read failure.
> +	 */
> +	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))
> +		omap_hdmi_enable_pads(1);
> +	else
> +		omap_hdmi_enable_pads(0);
>  }

If you now have omap_hdmi_init(), then you can just pass it board
specific flags like OMAP_HDMI_EXTERNAL_PULL. The generic init function
will make it easier to move things over to DT also.

Regards,

Tony
