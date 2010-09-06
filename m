From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/2] USB: musb-gadget: enable autoclear for OUT transfer
 in both DMA 0 and DMA 1
Date: Mon, 6 Sep 2010 20:27:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03291AE04A@dbde02.ent.ti.com>
References: <1282920723-12459-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0IFO5g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 10:57:36 -0400
In-Reply-To: <1282920723-12459-1-git-send-email-tom.leiming@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "felipe.balbi@nokia.com" <feli>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

tom.leiming@gmail.com wrote:
> 
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch fixes one bugs of OUT transfer in double buffer case:
> 
> -the current code only enable autoclear for dma mode 1, and not
> for dma mode 0
> 
> Without this patch, test #5 of usbtest can't be passed if we
> configure musb as g_zero and use fifo mode 3 to enable double
> buffer mode.
> 
> With this patch and the following patch(fix dma length),
> on my beagle B5, test#5(queued bulk out) may go beyond
> 18Mbyte/s(seems dma mode 0 is quicker in double buffer case)
> if musb is configured as g_zero and fifo mode 3 is taken, follows
> the test command:
> 
>     #./testusb -D DEV_NAME -c 1024 -t 5 -s 32768 -g 8   [1]
> 
> Also I have tested this patch can't make g_ether broken.
> 
> [1],
>     -source of testusb : tools/usb/testusb.c under linux kernel;
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> ---
>  drivers/usb/musb/musb_gadget.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index e0bd1c1..c0dfec4 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -645,9 +645,9 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>  	 */
>  
>  				csr |= MUSB_RXCSR_DMAENAB;
> -#ifdef USE_MODE1
>  				if (!musb_ep->hb_mult)
>  					csr |= MUSB_RXCSR_AUTOCLEAR;

Hi Tom,

Which codebase is this patch meant for?
I don't see the hb_mult in current mainline code?

Are there any patches which this one depends on?

Thanks,
Anand

> +#ifdef USE_MODE1
>  				/* csr |= MUSB_RXCSR_DMAMODE; */
>  
>  				/* this special sequence (enabling and then
