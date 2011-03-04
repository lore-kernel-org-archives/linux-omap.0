From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAP: DSS2: Add DSS2 support for Overo
Date: Fri, 4 Mar 2011 10:00:48 +0200
Message-ID: <1299225648.2196.25.camel@deskari>
References: <1299195980-17057-1-git-send-email-steve@sakoman.com>
	 <1299195980-17057-3-git-send-email-steve@sakoman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40735 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab1CDIAw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 03:00:52 -0500
In-Reply-To: <1299195980-17057-3-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-03 at 17:46 -0600, Steve Sakoman wrote:
> This patch adds DSS2 support for DVI, S-video, the 480x272 Samsung
> LTE430WQ-F0C panel, and the 320x240 LG.Philips LB035Q02 panel.
> 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  arch/arm/mach-omap2/board-overo.c |  239 +++++++++++++++++++++++++++++++------
>  1 files changed, 202 insertions(+), 37 deletions(-)

<snip>

> +#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
> +	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
> +static struct omap_dss_device overo_lcd35_device = {
> +	.type			= OMAP_DISPLAY_TYPE_DPI,
> +	.name			= "lcd35",
> +	.driver_name		= "lgphilips_lb035q02_panel",
> +	.phy.dpi.data_lines	= 24,
> +	.platform_enable	= overo_panel_enable_lcd,
> +	.platform_disable	= overo_panel_disable_lcd,
> +};
> +#endif
> +
> +static struct omap_dss_device *overo_dss_devices[] = {
> +	&overo_dvi_device,
> +	&overo_tv_device,
> +#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
> +	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
> +	&overo_lcd35_device,
> +#endif
> +	&overo_lcd43_device,

Why check for CONFIG_PANEL_LGPHILIPS_LB035Q02, but not for the lcd43?

And is that even necessary? Of course it would make the kernel very
slightly smaller if you leave some code out, but otherwise does that
help? If you have the device definitions there, but the user doesn't
load the driver, they wouldn't do anything, would they?

For me the ifdefs just make the code harder to read, but I'm not sure if
there's some standard custom to have these.

 Tomi


