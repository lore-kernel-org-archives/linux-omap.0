From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP4: hwmod data: add HWMOD_SWSUP_SIDLE
 to dss_hdmi to data
Date: Thu, 21 Jun 2012 09:59:53 +0200
Message-ID: <4FE2D479.5000300@ti.com>
References: <1340233810-1087-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39627 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378Ab2FUIAE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 04:00:04 -0400
In-Reply-To: <1340233810-1087-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>, paul@pwsan.com
Cc: tony@atomide.com, tomi.valkeinen@ti.com, s-guiriec@ti.com, mythripk@ti.com, linux-omap@vger.kernel.org

Hi Ricardo,

Thanks for the update.

On 6/21/2012 1:10 AM, Ricardo Neri wrote:
> As per the OMAP4 documentation, audio over HDMI should be transmitted in
> no-idle mode. This patch adds the HWMOD_SWSUP_SIDLE so that omap_hwmode uses
> no-idle/force-idle settings instead of smart-idle mode.
>
> This is required as the DSS interface clock is used as functional clock
> for the HDMI wrapper audio FIFO. If no-idle mode is not used, audio could
> be choppy, have bad quality or not be audible at all.
>
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>


Paul,
Will you take it as part of your fixes series for 3.5-rc?

Regards,
Benoit

> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 950454a..0cd6ee1 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -865,6 +865,11 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
>   	},
>   	.opt_clks	= dss_hdmi_opt_clks,
>   	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
> +	/*
> +	 * HDMI audio requires to use no-idle mode. Hence,
> +	 * set idle mode by software.
> +	 */
> +	.flags          = HWMOD_SWSUP_SIDLE,
>   };
>
>   /*
>


