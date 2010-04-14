From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH v2] board-omap3-beagle: add DSS2 support
Date: Wed, 14 Apr 2010 12:07:52 +0000
Message-ID: <4BC5B018.8080102@corscience.de>
References: <1271242535-23929-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53454 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab0DNLI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 07:08:29 -0400
In-Reply-To: <1271242535-23929-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen.kooi@gmail.com>
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>

On 04/14/10 10:55, Koen Kooi wrote:
> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
> 
> Changes since v1:
> 	* removed beagle_panel_enable_tv() and beagle_panel_disable_tv()
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |  130 ++++++++++++++++++++++++-------
>  1 files changed, 103 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 962d377..534316c 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -39,6 +39,7 @@
>  
<snip>
> +
> +static struct platform_device beagle_dss_device = {
> +	.name          = "omapdss",
> +	.id            = -1,
> +	.dev            = {
> +		.platform_data = &beagle_dss_data,
> +	},
> +};
> +
> +static struct regulator_consumer_supply beagle_vdac_supply = {
> +	.supply		= "vdda_dac",
> +	.dev		= &beagle_dss_device.dev,
> +};
Shouldn't we use the REGULATOR_SUPPLY macro?
see commit ed6543243a1c557dbe2005a86f6d
> +
> +static struct regulator_consumer_supply beagle_vdvi_supply = {
> +	.supply		= "vdds_dsi",
> +	.dev		= &beagle_dss_device.dev,
> +};
Here too.

Thomas
