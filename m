From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: McBSP: tx_irq_completion used in rx_irq_handler
Date: Thu, 9 Sep 2010 09:24:22 +0300
Message-ID: <20100909092422.79840f3e.jhnikula@gmail.com>
References: <1283966941.3677.178.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55171 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab0IIGXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 02:23:35 -0400
Received: by eyb6 with SMTP id 6so615632eyb.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 23:23:34 -0700 (PDT)
In-Reply-To: <1283966941.3677.178.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Scott Ellis <scott@jumpnowtek.com>
Cc: linux-omap@vger.kernel.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-arm-kernel@lists.infradead.org

On Wed, 08 Sep 2010 13:29:01 -0400
Scott Ellis <scott@jumpnowtek.com> wrote:

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
> @@ -156,7 +156,7 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
>  		/* Writing zero to RSYNC_ERR clears the IRQ */
>  		MCBSP_WRITE(mcbsp_rx, SPCR1, MCBSP_READ_CACHE(mcbsp_rx, SPCR1));
>  	} else {
> -		complete(&mcbsp_rx->tx_irq_completion);
> +		complete(&mcbsp_rx->rx_irq_completion);
>  	}
>  
It looks so.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
