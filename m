From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: tx_irq_completion used in rx_irq_handler
Date: Fri, 10 Sep 2010 08:30:21 +0300
Message-ID: <201009100830.21767.peter.ujfalusi@nokia.com>
References: <1283966941.3677.178.camel@quad>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43873 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0IJFbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 01:31:03 -0400
In-Reply-To: <1283966941.3677.178.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Scott Ellis <scott@jumpnowtek.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wednesday 08 September 2010 20:29:01 ext Scott Ellis wrote:
> Looks like a typo from commit d6d834b010.
> 
> Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index e31496e..0c8612f 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -156,7 +156,7 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq,
> void *dev_id) /* Writing zero to RSYNC_ERR clears the IRQ */
>  		MCBSP_WRITE(mcbsp_rx, SPCR1, MCBSP_READ_CACHE(mcbsp_rx, SPCR1));
>  	} else {
> -		complete(&mcbsp_rx->tx_irq_completion);
> +		complete(&mcbsp_rx->rx_irq_completion);
>  	}
> 
>  	return IRQ_HANDLED;

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
