From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3] musb: adding qh in_list and out_list in struct	hw_ep
Date: Mon, 3 Nov 2008 20:22:17 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5E8A786@dbde02.ent.ti.com>
References: <1225357971-10955-1-git-send-email-ajay.gupta@ti.com>,<20081103124645.GL21760@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57380 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbYKCOwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 09:52:36 -0500
In-Reply-To: <20081103124645.GL21760@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, "B, Ravi" <ravibabu@ti.com>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "Abraham, Thomas" <t-abraham@ti.com>

> Currently qh list for control, bulkin and bulkout are
> part of musb structure as musb->control, musb->in_bulk
> and musb->out_bulk.This patch makes it generic across
> hw_ep by removing them from musb and mapping them to
> in_list and out_list of hw_ep structure.
>
> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> Signed-off-by: Swaminathan S <swami.iyer@ti.com>
> Signed-off-by: Thomas Abraham <t-abraham@ti.com>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/musb/musb_core.c |    6 +++---
>  drivers/usb/musb/musb_core.h |    7 ++++---
>  drivers/usb/musb/musb_host.c |   36 ++++++++++++++++++------------------
>  3 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index ebe0828..dbf8861 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1445,6 +1445,9 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
>
>               hw_ep->regs = MUSB_EP_OFFSET(i, 0) + mbase;
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
> +             /* init list of in and out qhs */
> +             INIT_LIST_HEAD(&hw_ep->in_list);
> +             INIT_LIST_HEAD(&hw_ep->out_list);
>               hw_ep->target_regs = MUSB_BUSCTL_OFFSET(i, 0) + mbase;
>               hw_ep->rx_reinit = 1;
>               hw_ep->tx_reinit = 1;
> @@ -1790,9 +1793,6 @@ allocate_instance(struct device *dev,
>       /* usbcore sets dev->driver_data to hcd, and sometimes uses that... */
>
>       musb = hcd_to_musb(hcd);
> -     INIT_LIST_HEAD(&musb->control);
> -     INIT_LIST_HEAD(&musb->in_bulk);
> -     INIT_LIST_HEAD(&musb->out_bulk);
>
>       hcd->uses_new_polling = 1;
>
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index 4972a3b..27cd1e3 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -271,6 +271,10 @@ struct musb_hw_ep {
>       struct musb_qh          *in_qh;
>       struct musb_qh          *out_qh;
>
> +     /* list of rx and tx qhs */
> +     struct list_head        in_list;
> +     struct list_head        out_list;
> +
>       u8                      rx_reinit;
>       u8                      tx_reinit;
>  #endif
> @@ -328,9 +332,6 @@ struct musb {
>        */
>       struct musb_hw_ep       *bulk_ep;
>
> -     struct list_head        control;        /* of musb_qh */
> -     struct list_head        in_bulk;        /* of musb_qh */
> -     struct list_head        out_bulk;       /* of musb_qh */
>       struct musb_qh  *in[16];
>       struct musb_qh  *out[16];
>  #endif
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index b77ca0b..014401c 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -1223,7 +1223,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
>                * transfer, if there's some other (nonperiodic) tx urb
>                * that could use this fifo.  (dma complicates it...)
>                *
> -              * if (bulk && qh->ring.next != &musb->out_bulk), then
> +              * if (bulk && qh->ring.next != &hw_ep->out_list), then
>                * we have a candidate... NAKing is *NOT* an error
>                */
>               musb_ep_select(mbase, epnum);
> @@ -1449,13 +1449,13 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>                        * transfer, if there's some other (nonperiodic) rx urb
>                        * that could use this fifo.  (dma complicates it...)
>                        *
> -                      * if (bulk && qh->ring.next != &musb->in_bulk), then
> +                      * if (bulk && qh->ring.next != &hw_wp->in_list), then
>                        * we have a candidate... NAKing is *NOT* an error
>                        */
>                       DBG(6, "RX end %d NAK timeout\n", epnum);
>                       if (usb_pipebulk(urb->pipe) && qh->mux == 1 &&
> -                             (musb->in_bulk.next->next != &musb->in_bulk) &&
> -                                     bulk_nak_timeout) {
> +                             (hw_ep->in_list.next->next != &hw_ep->in_list)
> +                                      && bulk_nak_timeout) {
>                               musb_bulk_nak_timeout(musb, hw_ep);
>                               return;
>                       }
> @@ -1744,8 +1744,8 @@ static int musb_schedule(
>
>       /* use fixed hardware for control and bulk */
>       if (qh->type == USB_ENDPOINT_XFER_CONTROL) {
> -             head = &musb->control;
>               hw_ep = musb->control_ep;
> +             head = &hw_ep->in_list;

> yeah, this looks odd. It really looks like control can only be done for
> in transfers. At least a comment in the structure would be nice. 

Control needs only one qh list so using in_list. I will add this comments.

> Also,
> do you have any measurement of improvements after this patch ?

I don't have any such data and this is not the intent of the patch also.
This patch is to make better code readability, generalization, and future
expansion such as all interrupt transfer on one endpoint where in_list/out_list
will have qhs for different interrupt devices as it is for bulk today.
