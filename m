From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: AM43xx hwmod: Add RTC hwmod for
 AM43xx
Date: Fri, 6 Mar 2015 04:26:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503060425590.5613@utopia.booyaka.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com> <1425561211-31003-3-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44230 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbbCFE0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 23:26:13 -0500
In-Reply-To: <1425561211-31003-3-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>

On Thu, 5 Mar 2015, Dave Gerlach wrote:

> RTC hwmod is needed for proper operation of PM features like
> rtcwake and rtc-only mode so reuse the am33xx rtc hwmod.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> index 8eb8592..9070535 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> @@ -889,6 +889,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>  	&am43xx_l4_ls__dss,
>  	&am43xx_l4_ls__dss_dispc,
>  	&am43xx_l4_ls__dss_rfbi,
> +	&am33xx_l4_wkup__rtc,
>  	NULL,
>  };

Thanks, queued for v4.1.


- Paul
