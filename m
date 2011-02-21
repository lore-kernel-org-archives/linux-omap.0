From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP2,3: DSS2: Report -EBUSY when to many registered isr
Date: Mon, 21 Feb 2011 11:28:29 +0200
Message-ID: <1298280509.4931.36.camel@deskari>
References: <1295585610-24179-1-git-send-email-btucker@mpcdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60182 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186Ab1BUJ2d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 04:28:33 -0500
In-Reply-To: <1295585610-24179-1-git-send-email-btucker@mpcdata.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Tucker <btucker@mpcdata.com>
Cc: linux-omap@vger.kernel.org, Ben Tucker <btucker@mpc-data.co.uk>

Hi,

On Fri, 2011-01-21 at 04:53 +0000, Ben Tucker wrote:
> From: Ben Tucker <btucker@mpc-data.co.uk>
> 
> This patch fixes a problem with map_dispc_register_isr() where it
> fails to return -EBUSY if it has no more space for registrations.

Looks correct, but a couple of things:
- Missing signed-off
- Indentation is wrong
- Don't use { } when there's just one line in the if block

Please fix those, or alternatively I can fix the bug myself and add you
as reported-by.

 Tomi


> 
> ---
> drivers/video/omap2/dss/dispc.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index e0e8275..f566177 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -2579,6 +2579,10 @@ int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
>  		break;
>  	}
>  
> +    if (ret) {
> +        goto err;
> +    }
> +
>  	_omap_dispc_set_irqs();
>  
>  	spin_unlock_irqrestore(&dispc.irq_lock, flags);


