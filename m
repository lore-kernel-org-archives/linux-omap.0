From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/15] OMAP: Beagle: Enable DSS2 for Beagle board
Date: Wed, 5 Aug 2009 17:43:01 +0300
Message-ID: <20090805144300.GN7374@atomide.com>
References: <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-12-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-13-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-14-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-15-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53543 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933724AbZHEOnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:43:07 -0400
Content-Disposition: inline
In-Reply-To: <1249481741-14008-15-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  arch/arm/configs/omap3_beagle_defconfig |   26 ++++++-
>  arch/arm/mach-omap2/board-omap3beagle.c |  119 ++++++++++++++++++++++++-------
>  2 files changed, 116 insertions(+), 29 deletions(-)
> 

<snip snip>

> +static struct omap_dss_device beagle_dvi_device = {
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.name = "dvi",
> +	.driver_name = "generic_panel",
> +	.phy.dpi.data_lines = 24,
> +	.reset_gpio = 170,
> +	.platform_enable = beagle_enable_dvi,
> +	.platform_disable = beagle_disable_dvi,
> +};
...

Just nitpicking about the data tabbing in general, other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
