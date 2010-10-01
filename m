From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Fri, 1 Oct 2010 02:47:10 -0500
Message-ID: <4CA591FE.7030201@ti.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com> <1285915146-18511-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60115 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295Ab0JAIVR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 04:21:17 -0400
In-Reply-To: <1285915146-18511-2-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Peter Ujfalusi had written, on 10/01/2010 01:39 AM, the following:
[...]
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index ec7eddf..7115884 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1000,7 +1000,7 @@ void omap_start_dma(int lch)
>  	 * This will always fail on ES1.0
>  	 */
>  	if (cpu_is_omap24xx())
> -		l |= OMAP_DMA_CCR_EN;
in code comment for errata helps over time I guess.. could be my pet peeve.
> +		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;

same comment -> would be nice to have erratas under a errata variable to 
help track them all..
[...]
-- 
Regards,
Nishanth Menon
