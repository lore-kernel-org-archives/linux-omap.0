From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/3] musb: NAK timeout scheme on bulk reserved ep
Date: Mon, 3 Nov 2008 20:16:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5E8A785@dbde02.ent.ti.com>
References: <1225357942-10920-1-git-send-email-ajay.gupta@ti.com>,<20081103124435.GK21760@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60256 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798AbYKCOrG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 09:47:06 -0500
In-Reply-To: <20081103124435.GK21760@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, "B, Ravi" <ravibabu@ti.com>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "Abraham, Thomas" <t-abraham@ti.com>

> On Thu, Oct 30, 2008 at 02:42:22PM +0530, Ajay Kumar Gupta wrote:
> Fixes endpoint starvation issue when more than one bulk qhs
> are multiplexed on reserved bulk endpoint.NAK timeout interval
> is set for such qhs and next qh is scheduled when NAK timeout
> occurs.
> This scheme doesn't work for devices which are connected to a
> high to full speed tree as there is no NAK timeout interrupt
> at musb controller from such devices.
> A module parameter 'bulk_nak_timeout' is added so that this feature
> can be disabled if not required.

> then if the user sets the parameter wrongly, it would break
> communication, right ?

This parameter is enabled by default and would not affect any communication.
If user wants, he can disable it while inserting musb module otherwise this
feature will be enabled and work properly.
If this is disabled then we will not write NAK timeout value in interval register
and thus this feature will be off.


> unless you can come up with a way to figure out if bulk_nak_timeout
> could be set automatically, let's drop this patch.
Bulk nak timeout values are written in interval register whenever more than one
qhs are on reserved bulk ep. It is automatic.

> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> Signed-off-by: Swaminathan S <swami.iyer@ti.com>
> Signed-off-by: Thomas Abraham <t-abraham@ti.com>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
> These patches have been created against latest omap git and Felipe's
> musb .28 patch series at,
> http://marc.info/?l=linux-usb&m=122528597116718&w=2
>
>  drivers/usb/musb/musb_host.c |   70 ++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 30b5685..b77ca0b 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -100,6 +100,10 @@
>   * of transfers between endpoints, or anything clever.
>   */
>
> +static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep);

> please, reorganize the code so we don't need this prototype here.
 Ok fine, will do it.

> +static int bulk_nak_timeout = 1;
> +module_param(bulk_nak_timeout, bool, 0);
> +MODULE_PARM_DESC(bulk_nak_timeout, "enable/disable use of bulk nak timeout");
>
>  static void musb_ep_program(struct musb *musb, u8 epnum,
>                       struct urb *urb, unsigned int nOut,
> @@ -1449,10 +1453,15 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>                        * we have a candidate... NAKing is *NOT* an error
>                        */
>                       DBG(6, "RX end %d NAK timeout\n", epnum);
> +                     if (usb_pipebulk(urb->pipe) && qh->mux == 1 &&
> +                             (musb->in_bulk.next->next != &musb->in_bulk) &&
> +                                     bulk_nak_timeout) {
> +                             musb_bulk_nak_timeout(musb, hw_ep);
> +                             return;
> +                     }
>                       musb_ep_select(mbase, epnum);
> -                     musb_writew(epio, MUSB_RXCSR,
> -                                     MUSB_RXCSR_H_WZC_BITS
> -                                     | MUSB_RXCSR_H_REQPKT);
> +                     rx_csr &= ~MUSB_RXCSR_DATAERROR;
> +                     musb_writew(epio, MUSB_RXCSR, rx_csr);
>
>                       goto finish;
>               } else {
> @@ -1802,6 +1811,9 @@ static int musb_schedule(
>
>       idle = 1;
>       qh->mux = 0;
> +     /* disable NAK scheme when bulk is not multiplexed */
> +     if (is_in && qh->type == USB_ENDPOINT_XFER_BULK && bulk_nak_timeout)
> +             qh->intv_reg = 0;
>       hw_ep = musb->endpoints + best_end;
>       if (is_in)
>               musb->in[best_end] = qh;
> @@ -1912,6 +1924,17 @@ static int musb_urb_enqueue(
>       case USB_ENDPOINT_XFER_ISOC:
>               /* iso always uses log encoding */
>               break;
> +     case USB_ENDPOINT_XFER_BULK:
> +             /* Enable bulk NAK time out scheme when bulk requests are
> +              * multiplxed.This scheme doen't work in high speed to full
> +              * speed scenario as NAK interrupts are not coming from a
> +              * full speed device connected to a high speed device.
> +              */
> +             if (usb_pipein(urb->pipe) && bulk_nak_timeout) {
> +                     interval = 8;
> +                     break;
> +             }
> +             /* FALLTHROUGH */
>       default:
>               /* REVISIT we actually want to use NAK limits, hinting to the
>                * transfer scheduling logic to try some other qh, e.g. try
> @@ -2265,6 +2288,47 @@ static int musb_bus_resume(struct usb_hcd *hcd)
>       return 0;
>  }
>
> +static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep)
> +{
> +     struct dma_channel      *dma;
> +     struct urb      *urb;
> +     void __iomem    *mbase = musb->mregs;
> +     void __iomem    *epio = ep->regs;
> +     struct musb_qh  *cur_qh, *next_qh;
> +     u16     rx_csr;
> +
> +     musb_ep_select(mbase, ep->epnum);
> +     dma = is_dma_capable() ? ep->rx_channel : NULL;
> +
> +     /* clear nak timeout bit */
> +     rx_csr = musb_readw(epio, MUSB_RXCSR);
> +     rx_csr &= ~MUSB_RXCSR_DATAERROR;
> +     musb_writew(epio, MUSB_RXCSR, rx_csr);
> +
> +     cur_qh = first_qh(&musb->in_bulk);
> +     if (cur_qh) {
> +             urb = next_urb(cur_qh);
> +             if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
> +                     dma->status = MUSB_DMA_STATUS_CORE_ABORT;
> +                     musb->dma_controller->channel_abort(dma);
> +                     urb->actual_length += dma->actual_len;
> +                     dma->actual_len = 0L;
> +             }
> +             musb_save_toggle(ep, 1, urb);
> +
> +             /* delete cur_qh and add to tail to musb->in_bulk */
> +             list_del(&cur_qh->ring);
> +             list_add_tail(&cur_qh->ring, &musb->in_bulk);
> +
> +             /* get the next qh from musb->in_bulk */
> +             next_qh = first_qh(&musb->in_bulk);
> +
> +             /* set rx_reinit and schedule the next qh */
> +             ep->rx_reinit = 1;
> +             musb_start_urb(musb, 1, next_qh);
> +     }
> +}
> +
>  const struct hc_driver musb_hc_driver = {
>       .description            = "musb-hcd",
>       .product_desc           = "MUSB HDRC host driver",
> --
> 1.5.6

--
balbi

