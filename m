From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] musb: Add new fifo table for a OMAP3 errata
Date: Mon, 21 Dec 2009 15:42:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AF94@dbde02.ent.ti.com>
References: <1261387769-20247-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39740 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZLUKMX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 05:12:23 -0500
In-Reply-To: <1261387769-20247-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Gupta, Ajay Kumar wrote:
> 
> We have observed MSC data read corruption when USB LAN device is
> also connected and it's interface is up.
> 
> Silicon team has confirmed an errata where in all the active
> transfers should use FIFO space either in first 8K or next 8K.
> So far we have observed the issue in above use case scenario.
> 
> As a workaround to it, adding a new FIFO config (5) fitting well
> within first 8K which can be used for such use cases.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Long term, do you think the board files should define the
the FIFO configuration table that they want to use (instead of
having different options in musb_core.c)?


For now, this change should be okay (although I don't see a
user now. Or maybe you pass this as a module parameter).

FWIW, this patch is:

Acked-by: Anand Gadiyar <gadiyar@ti.com>

> ---
>  drivers/usb/musb/musb_core.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index bfe08f4..0c8f5ec 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1095,6 +1095,36 @@ static struct fifo_cfg __initdata mode_4_cfg[] = {
>  { .hw_ep_num = 15, .style = FIFO_RXTX, .maxpacket = 1024, },
>  };
>  
> +/* mode 5 - fits in 8KB */
> +static struct fifo_cfg __initdata mode_5_cfg[] = {
> +{ .hw_ep_num =  1, .style = FIFO_TX,   .maxpacket = 512, },
> +{ .hw_ep_num =  1, .style = FIFO_RX,   .maxpacket = 512, },
> +{ .hw_ep_num =  2, .style = FIFO_TX,   .maxpacket = 512, },
> +{ .hw_ep_num =  2, .style = FIFO_RX,   .maxpacket = 512, },
> +{ .hw_ep_num =  3, .style = FIFO_TX,   .maxpacket = 512, },
> +{ .hw_ep_num =  3, .style = FIFO_RX,   .maxpacket = 512, },
> +{ .hw_ep_num =  4, .style = FIFO_TX,   .maxpacket = 512, },
> +{ .hw_ep_num =  4, .style = FIFO_RX,   .maxpacket = 512, },
> +{ .hw_ep_num =  5, .style = FIFO_TX,   .maxpacket = 512, },
> +{ .hw_ep_num =  5, .style = FIFO_RX,   .maxpacket = 512, },
> +{ .hw_ep_num =  6, .style = FIFO_TX,   .maxpacket = 32, },
> +{ .hw_ep_num =  6, .style = FIFO_RX,   .maxpacket = 32, },
> +{ .hw_ep_num =  7, .style = FIFO_TX,   .maxpacket = 32, },
> +{ .hw_ep_num =  7, .style = FIFO_RX,   .maxpacket = 32, },
> +{ .hw_ep_num =  8, .style = FIFO_TX,   .maxpacket = 32, },
> +{ .hw_ep_num =  8, .style = FIFO_RX,   .maxpacket = 32, },
> +{ .hw_ep_num =  9, .style = FIFO_TX,   .maxpacket = 32, },
> +{ .hw_ep_num =  9, .style = FIFO_RX,   .maxpacket = 32, },
> +{ .hw_ep_num = 10, .style = FIFO_TX,   .maxpacket = 32, },
> +{ .hw_ep_num = 10, .style = FIFO_RX,   .maxpacket = 32, },
> +{ .hw_ep_num = 11, .style = FIFO_TX,   .maxpacket = 32, },
> +{ .hw_ep_num = 11, .style = FIFO_RX,   .maxpacket = 32, },
> +{ .hw_ep_num = 12, .style = FIFO_TX,   .maxpacket = 32, },
> +{ .hw_ep_num = 12, .style = FIFO_RX,   .maxpacket = 32, },
> +{ .hw_ep_num = 13, .style = FIFO_RXTX, .maxpacket = 512, },
> +{ .hw_ep_num = 14, .style = FIFO_RXTX, .maxpacket = 1024, },
> +{ .hw_ep_num = 15, .style = FIFO_RXTX, .maxpacket = 1024, },
> +};
>  
>  /*
>   * configure a fifo; for non-shared endpoints, this may be called
> @@ -1210,6 +1240,10 @@ static int __init ep_config_from_table(struct musb *musb)
>  		cfg = mode_4_cfg;
>  		n = ARRAY_SIZE(mode_4_cfg);
>  		break;
> +	case 5:
> +		cfg = mode_5_cfg;
> +		n = ARRAY_SIZE(mode_5_cfg);
> +		break;
>  	}
>  
>  	printk(KERN_DEBUG "%s: setup fifo_mode %d\n",
> -- 
> 1.6.2.4
