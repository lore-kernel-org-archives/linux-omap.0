From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 8/9] usb: gadget: net2280: use generic map/unmap routines
Date: Mon, 19 Dec 2011 10:21:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1112191019580.1746-100000@iolanthe.rowland.org>
References: <1324290632-23758-9-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47229 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752718Ab1LSPVh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 10:21:37 -0500
In-Reply-To: <1324290632-23758-9-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Dahlmann <dahlmann.thomas@arcor.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "open list:DESIGNWARE USB3 D..." <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:AMD GEODE CS5536..." <linux-geode@lists.infradead.org>

On Mon, 19 Dec 2011, Felipe Balbi wrote:

> those routines have everything we need to map/unmap
> USB requests and it's better to use them.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/net2280.c |   19 +++++++++----------
>  1 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
> index cf1f364..59d4794 100644
> --- a/drivers/usb/gadget/net2280.c
> +++ b/drivers/usb/gadget/net2280.c

> @@ -857,10 +853,13 @@ net2280_queue (struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
>  		return -EOPNOTSUPP;
>  
>  	/* set up dma mapping in case the caller didn't */
> -	if (ep->dma && _req->dma == DMA_ADDR_INVALID) {
> -		_req->dma = pci_map_single (dev->pdev, _req->buf, _req->length,
> -			ep->is_in ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
> -		req->mapped = 1;
> +	if (ep->dma) {
> +		int ret;
> +
> +		ret = usb_gadget_map_request(&dev->gadget, &req->req,
> +				ep->is_in);

As mentioned for the goku patch, &req->req can be replaced by _req.

Alan Stern

