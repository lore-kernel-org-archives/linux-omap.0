From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/9] usb: gadget: add generic map/unmap request utilities
Date: Mon, 19 Dec 2011 10:19:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1112191018320.1746-100000@iolanthe.rowland.org>
References: <1324290632-23758-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47216 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752587Ab1LSPTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 10:19:47 -0500
In-Reply-To: <1324290632-23758-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Dahlmann <dahlmann.thomas@arcor.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "open list:DESIGNWARE USB3 D..." <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:AMD GEODE CS5536..." <linux-geode@lists.infradead.org>

On Mon, 19 Dec 2011, Felipe Balbi wrote:

> such utilities are currently duplicated on all UDC
> drivers basically with the same structure. Let's group
> all implementations into one generic implementation
> and get rid of that duplication.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/udc-core.c |   53 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/gadget.h    |   10 +++++++
>  2 files changed, 63 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc-core.c b/drivers/usb/gadget/udc-core.c
> index 0b0d12c..2031c11 100644
> --- a/drivers/usb/gadget/udc-core.c
> +++ b/drivers/usb/gadget/udc-core.c
> @@ -22,6 +22,7 @@
>  #include <linux/device.h>
>  #include <linux/list.h>
>  #include <linux/err.h>
> +#include <linux/dma-mapping.h>
>  
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> @@ -49,6 +50,58 @@ static DEFINE_MUTEX(udc_lock);
>  
>  /* ------------------------------------------------------------------------- */
>  
> +int usb_gadget_map_request(struct usb_gadget *gadget,
> +		struct usb_request *req, int direction)
> +{
> +	if (req->length == 0)
> +		return 0;
> +
> +	if (req->num_sgs) {
> +		int     mapped;
> +
> +		mapped = dma_map_sg(&gadget->dev, req->sg, req->num_sgs,
> +				direction ? DMA_TO_DEVICE
> +				: DMA_FROM_DEVICE);
> +		if (mapped == 0) {
> +			dev_err(&gadget->dev, "failed to map SGs\n");
> +			return -EFAULT;
> +		}
> +
> +		req->num_mapped_sgs = mapped;
> +	} else {
> +		req->dma = dma_map_single(&gadget->dev, req->buf, req->length,
> +				direction ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +
> +		if (dma_mapping_error(&gadget->dev, req->dma)) {
> +			dev_err(&gadget->dev, "failed to map buffer\n");
> +			return -EFAULT;
> +		}
> +	}
> +
> +	return 0;

You forgot to set req->mapped.

> +}
> +EXPORT_SYMBOL_GPL(usb_gadget_map_request);
> +
> +void usb_gadget_unmap_request(struct usb_gadget *gadget,
> +		struct usb_request *req, int direction)
> +{
> +	if (req->length == 0)
> +		return;
> +
> +	if (req->num_mapped_sgs) {
> +		dma_unmap_sg(&gadget->dev, req->sg, req->num_sgs,
> +				direction ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +
> +		req->num_mapped_sgs = 0;
> +	} else {
> +		dma_unmap_single(&gadget->dev, req->dma, req->length,
> +				direction ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +	}

You forgot to clear req->mapped.

Alan Stern

