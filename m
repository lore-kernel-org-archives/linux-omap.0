From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/2] USB: musb-gadget: fix bulk IN infinite hangs in
 double buffer case
Date: Fri, 27 Aug 2010 19:10:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CB42@dbde02.ent.ti.com>
References: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45047 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301Ab0H0Nks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 09:40:48 -0400
In-Reply-To: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "felipe.balbi@nokia.com" <feli>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

tom.leiming@gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch fixes one infinite hang of bulk IN transfer in double buffer
> case, the hang can be observed easily by test #6 of usbtest if musb is
> configured as g_zero and fifo mode 3 is taken to enable double fifo.
> 
> In fact, the patch only removes the check for non-empty fifo before
> loading data from new request into fifo since the check is 
> not correct:
> 
> 	-in double buffer case, fifo may accommodate more than one packet,
> 	even though it has contained one packet already and is non-empty
> 
> 	-since last DMA is completed before calling musb_g_tx, it is sure
> 	that fifo may accommodate at least one packet
> 
> Without applying the patch, new requst enqueued from .complte may not
> have a chance to be loaded into fifo, then will never be completed and
> cause infinite hangs.
> 
> With the patch, on my beagle B5, test#6(queued bulk in) can be passed and
> test result may go beyond 33Mbyte/s if musb is configured as g_zero and
> fifo mode 3 is taken, follows the test command:
> 
> 	#testusb -D DEV_NAME -c 1024 -t 6 -s 32768 -g 8   [1]
> 
> [1],
>     -source of testusb : tools/usb/testusb.c under linux kernel;
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 

For OMAPs,
Acked-by: Anand Gadiyar <gadiyar@ti.com>

I sent out this patch a while ago [1]. I've tested it on
OMAP3 and OMAP4 silicon.

It does look like a logic bug to me, but I'd like the Blackfin
and Davinci guys to take a look at the code as well.

- Anand

[1] <http://marc.info/?l=linux-usb&m=127055442703499&w=2>

> ---
>  drivers/usb/musb/musb_gadget.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 550b397..e0bd1c1 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -506,18 +506,6 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			/* ... or if not, then complete it. */
>  			musb_g_giveback(musb_ep, request, 0);
>  
> -			/*
> -			 * Kickstart next transfer if appropriate;
> -			 * the packet that just completed might not
> -			 * be transmitted for hours or days.
> -			 * REVISIT for double buffering...
> -			 * FIXME revisit for stalls too...
> -			 */
> -			musb_ep_select(mbase, epnum);
> -			csr = musb_readw(epio, MUSB_TXCSR);
> -			if (csr & MUSB_TXCSR_FIFONOTEMPTY)
> -				return;
> -
>  			request = musb_ep->desc ? next_request(musb_ep) : NULL;
>  			if (!request) {
>  				DBG(4, "%s idle now\n",
> -- 
> 1.6.2.5
> 
> 