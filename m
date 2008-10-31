From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 2/3] musb: adding qh in_list and out_list in struct hw_ep
Date: Fri, 31 Oct 2008 11:44:28 +0800
Message-ID: <386072610810302044s480e9f7qeae02c1c22700d06@mail.gmail.com>
References: <1225357971-10955-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:37499 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbYJaDo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 23:44:29 -0400
In-Reply-To: <1225357971-10955-1-git-send-email-ajay.gupta@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, david-b@pacbell.net, me@felipebalbi.com, felipe.balbi@nokia.com, Ravi Babu <ravibabu@ti.com>, Swaminathan S <swami.iyer@ti.com>, Thomas Abraham <t-abraham@ti.com>

On Thu, Oct 30, 2008 at 5:12 PM, Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
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
>                hw_ep->regs = MUSB_EP_OFFSET(i, 0) + mbase;
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
> +               /* init list of in and out qhs */
> +               INIT_LIST_HEAD(&hw_ep->in_list);
> +               INIT_LIST_HEAD(&hw_ep->out_list);
>                hw_ep->target_regs = MUSB_BUSCTL_OFFSET(i, 0) + mbase;
>                hw_ep->rx_reinit = 1;
>                hw_ep->tx_reinit = 1;
> @@ -1790,9 +1793,6 @@ allocate_instance(struct device *dev,
>        /* usbcore sets dev->driver_data to hcd, and sometimes uses that... */
>
>        musb = hcd_to_musb(hcd);
> -       INIT_LIST_HEAD(&musb->control);
> -       INIT_LIST_HEAD(&musb->in_bulk);
> -       INIT_LIST_HEAD(&musb->out_bulk);
>
>        hcd->uses_new_polling = 1;
>
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index 4972a3b..27cd1e3 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -271,6 +271,10 @@ struct musb_hw_ep {
>        struct musb_qh          *in_qh;
>        struct musb_qh          *out_qh;
>
> +       /* list of rx and tx qhs */
> +       struct list_head        in_list;
> +       struct list_head        out_list;
> +
>        u8                      rx_reinit;
>        u8                      tx_reinit;
>  #endif
> @@ -328,9 +332,6 @@ struct musb {
>         */
>        struct musb_hw_ep       *bulk_ep;
>
> -       struct list_head        control;        /* of musb_qh */
> -       struct list_head        in_bulk;        /* of musb_qh */
> -       struct list_head        out_bulk;       /* of musb_qh */
>        struct musb_qh  *in[16];
>        struct musb_qh  *out[16];
>  #endif
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index b77ca0b..014401c 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -1223,7 +1223,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
>                 * transfer, if there's some other (nonperiodic) tx urb
>                 * that could use this fifo.  (dma complicates it...)
>                 *
> -                * if (bulk && qh->ring.next != &musb->out_bulk), then
> +                * if (bulk && qh->ring.next != &hw_ep->out_list), then
>                 * we have a candidate... NAKing is *NOT* an error
>                 */
>                musb_ep_select(mbase, epnum);
> @@ -1449,13 +1449,13 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>                         * transfer, if there's some other (nonperiodic) rx urb
>                         * that could use this fifo.  (dma complicates it...)
>                         *
> -                        * if (bulk && qh->ring.next != &musb->in_bulk), then
> +                        * if (bulk && qh->ring.next != &hw_wp->in_list), then
>                         * we have a candidate... NAKing is *NOT* an error
>                         */
>                        DBG(6, "RX end %d NAK timeout\n", epnum);
>                        if (usb_pipebulk(urb->pipe) && qh->mux == 1 &&
> -                               (musb->in_bulk.next->next != &musb->in_bulk) &&
> -                                       bulk_nak_timeout) {
> +                               (hw_ep->in_list.next->next != &hw_ep->in_list)
> +                                        && bulk_nak_timeout) {
>                                musb_bulk_nak_timeout(musb, hw_ep);
>                                return;
>                        }
> @@ -1744,8 +1744,8 @@ static int musb_schedule(
>
>        /* use fixed hardware for control and bulk */
>        if (qh->type == USB_ENDPOINT_XFER_CONTROL) {
> -               head = &musb->control;
>                hw_ep = musb->control_ep;
> +               head = &hw_ep->in_list;

So we only support control in transfer and no hope for control out here?

Thanks
-Bryan
