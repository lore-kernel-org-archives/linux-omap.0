From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] bus: omap_l3_noc: Correct returning IRQ_HANDLED unconditionally
 in the irq handler
Date: Mon, 10 Nov 2014 09:30:02 -0600
Message-ID: <5460D9FA.3000201@ti.com>
References: <1415595784-5646-1-git-send-email-j-keerthy@ti.com> <1415595784-5646-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52480 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbaKJPaJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2014 10:30:09 -0500
In-Reply-To: <1415595784-5646-3-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org
Cc: afzal@ti.com, tony@atomide.com

On 11/09/2014 11:03 PM, Keerthy wrote:
> Correct returning IRQ_HANDLED unconditionally in the irq handler.
> Return IRQ_NONE for some interrupt which we do not expect to be
> handled in this handler. This prevents kernel stalling with back
> to back spurious interrupts.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Consider providing an appropriate fixes comment here as well?

> ---
>  drivers/bus/omap_l3_noc.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
> index b5eac29..17d8659 100644
> --- a/drivers/bus/omap_l3_noc.c
> +++ b/drivers/bus/omap_l3_noc.c
> @@ -222,10 +222,14 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
>  			}
>  
>  			/* Error found so break the for loop */
> -			break;
> +			return IRQ_HANDLED;
>  		}
>  	}
> -	return IRQ_HANDLED;
> +
> +	dev_err(l3->dev, "L3 %s IRQ not handled!!\n",
> +		inttype ? "debug" : "application");
> +
> +	return IRQ_NONE;
>  }
>  
>  static const struct of_device_id l3_noc_match[] = {
> 


-- 
Regards,
Nishanth Menon
