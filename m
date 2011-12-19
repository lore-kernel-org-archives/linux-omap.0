From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 9/9] usb: gadget: goku: use generic map/unmap routines
Date: Mon, 19 Dec 2011 17:02:51 +0400
Message-ID: <4EEF35FB.9090707@mvista.com>
References: <1324290632-23758-1-git-send-email-balbi@ti.com> <1324290632-23758-10-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1324290632-23758-10-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Greg Kroah-Hartman (supporter:USB SUBSYSTEM ,commit_signer:28/50=56%)" <gregkh-l3A5Bk7waGM@public.gmane.org>, "Thomas Dahlmann (supporter:AMD GEODE CS5536...)" <dahlmann.thomas-KvP5wT2u2U0@public.gmane.org>, "Kuninori Morimoto (commit_signer:43/50=86%)" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:AMD GEODE CS5536..." <linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 19-12-2011 14:30, Felipe Balbi wrote:

> those routines have everything we need to map/unmap
> USB requests and it's better to use them.

> Signed-off-by: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/gadget/goku_udc.c |   17 +++++++----------
>   1 files changed, 7 insertions(+), 10 deletions(-)

> diff --git a/drivers/usb/gadget/goku_udc.c b/drivers/usb/gadget/goku_udc.c
> index 5af70fcc..bc47735 100644
> --- a/drivers/usb/gadget/goku_udc.c
> +++ b/drivers/usb/gadget/goku_udc.c
[...]
> @@ -736,10 +732,11 @@ goku_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
>   		return -EBUSY;
>
>   	/* set up dma mapping in case the caller didn't */
> -	if (ep->dma&&  _req->dma == DMA_ADDR_INVALID) {
> -		_req->dma = pci_map_single(dev->pdev, _req->buf, _req->length,
> -			ep->is_in ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
> -		req->mapped = 1;
> +	if (ep->dma) {
> +		status = usb_gadget_map_request(&dev->gadget, &req->req,

    Not '&_req->req'?

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
