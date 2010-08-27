From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 2/2] USB: musb-gadget: fix DMA length for OUT transfer
Date: Fri, 27 Aug 2010 20:26:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB89@dbde02.ent.ti.com>
References: <1282920752-12490-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58464 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab0H0O4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:56:52 -0400
In-Reply-To: <1282920752-12490-1-git-send-email-tom.leiming@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "felipe.balbi@nokia.com" <feli>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

tom.leiming@gmail.com wrote:
> 
> From: Ming Lei <tom.leiming@gmail.com>
> 
> DMA length should not go beyond the availabe space of request buffer,
> so fix it.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

There's a small typo in the description.

But for the patch itself,

Acked-by: Anand Gadiyar <gadiyar@ti.com>

> ---
>  drivers/usb/musb/musb_gadget.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index c0dfec4..e898228 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -662,10 +662,11 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>  				if (request->actual < request->length) {
>  					int transfer_size = 0;
>  #ifdef USE_MODE1
> -					transfer_size = min(request->length,
> +					transfer_size = min(request->length - request->actual,
>  							channel->max_len);
>  #else
> -					transfer_size = len;
> +					transfer_size = min(request->length - request->actual,
> +							len);
>  #endif
>  					if (transfer_size <= musb_ep->packet_sz)
>  						musb_ep->dma->desired_mode = 0;
> -- 
> 1.6.2.5
> 
> 