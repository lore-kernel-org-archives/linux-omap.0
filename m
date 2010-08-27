From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 2/2] USB: musb-gadget: fix OUT transfer in double buffer
 case
Date: Fri, 27 Aug 2010 19:17:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB4B@dbde02.ent.ti.com>
References: <1282909068-2968-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45359 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371Ab0H0NsT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 09:48:19 -0400
In-Reply-To: <1282909068-2968-1-git-send-email-tom.leiming@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "felipe.balbi@nokia.com" <feli>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

tom.leiming@gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch fixes two bugs of OUT transfer in double buffer case:
> 
> 	-USE_MODE1 should be enabled except for ANOMALY_05000456 case, or
> 	else may cause infinite hang and data error bug in double buffer
> 

Double buffering should still work with or without mode1 DMA.
I'm not sure using Mode1 DMA is the fix for enabling double buffering.

> 	-DMA length should not go beyond the availabe space of request buffer
> 
> Without this patch, test #5 of usbtest can't be passed if we configure musb as
> g_zero and use fifo mode 3 to enable double buffer mode.
> 
> With this patch, on my beagle B5, test#5(queued bulk out) may go beyond 14Mbyte/s
> if musb is configured as g_zero and fifo mode 3 is taken, follows the test command:
> 
> 	#./testusb -D DEV_NAME -c 1024 -t 5 -s 32768 -g 8   [1]
> 
> [1],
>     -source of testusb : tools/usb/testusb.c under linux kernel;
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

The DMA length part is a good fix. However, I'm not so sure I like the
combining of the MODE1 RX change here.

With current code, only g_zero and g_file_storage work well with
Mode1 DMA RX. g_ether used to break (have not tested recently with mode1).
Did you test g_ether with your patch?

We know that at least on OMAPs, MODE1 DMA RX works reliably with patches
Felipe submitted last December. These have not been resubmitted and we're
waiting on that.

- Anand


> 
> ---
>  drivers/usb/musb/musb_dma.h    |    2 ++
>  drivers/usb/musb/musb_gadget.c |    5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
> index 916065b..dff91ce 100644
> --- a/drivers/usb/musb/musb_dma.h
> +++ b/drivers/usb/musb/musb_dma.h
> @@ -89,6 +89,8 @@ struct musb_hw_ep;
>  # if !ANOMALY_05000456
>  #  define USE_MODE1
>  # endif
> +#else
> +#  define USE_MODE1
>  #endif
>  
>  /*
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index e0bd1c1..f1c44b9 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -662,10 +662,11 @@ static void rxstate(struct musb *musb, 
> struct musb_request *req)
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