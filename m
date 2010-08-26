From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/10] [PM-WIP-MMC] omap4 hsmmc: Fix the init if  CONFIG_MMC_OMAP_HS is not set
Date: Thu, 26 Aug 2010 16:24:28 -0700
Message-ID: <87mxs9ufdf.fsf@deeprootsystems.com>
References: <16186.10.24.255.18.1282335083.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61449 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0HZXYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:24:34 -0400
Received: by gyd8 with SMTP id 8so888888gyd.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:24:32 -0700 (PDT)
In-Reply-To: <16186.10.24.255.18.1282335083.squirrel@dbdmail.itg.ti.com>
	(kishore kadiyala's message of "Sat, 21 Aug 2010 01:41:23 +0530
	(IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, adrian.hunter@nokia.com, akpm@linux-foundation.org, madhu.cr@ti.com

"kishore kadiyala" <kishore.kadiyala@ti.com> writes:

> From: Benoit Cousson <b-cousson@ti.com
> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

This is another fix that should go upstream independently of the rest of
the series.

In fact, this should probably be fixed in 2.6.36-rc.

Kevin

> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 9447644..3a0dafd 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -235,8 +235,13 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>
>  static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
>  {
> -	struct omap_mmc_platform_data *pdata = dev->platform_data;
> +	struct omap_mmc_platform_data *pdata;
> +
> +	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
> +	if (!dev)
> +		return;
>
> +	pdata = dev->platform_data;
>  	pdata->init =	omap4_twl6030_hsmmc_late_init;
>  }
