From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] mailbox/omap: adapt to the new mailbox framework
Date: Thu, 27 Nov 2014 13:02:49 +0530
Message-ID: <CAJe_Zhc7-PZn01C+fNhQ1WZrYcXxiw6eP5xhXVgxACQrM=W2Pg@mail.gmail.com>
References: <1415055950-64090-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415055950-64090-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 4 November 2014 at 04:35, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> The OMAP mailbox driver and its existing clients (remoteproc
> for OMAP4+) are adapted to use the generic mailbox framework.
>
> The main changes for the adaptation are:
>   - The tasklet used for Tx is replaced with the state machine from
>     the generic mailbox framework. The workqueue used for processing
>     the received messages stays intact for minimizing the effects on
>     the OMAP mailbox clients.
>   - The existing exported client API, omap_mbox_get, omap_mbox_put and
>     omap_mbox_send_msg are deleted, as the framework provides equivalent
>     functionality. A OMAP-specific omap_mbox_request_channel is added
>     though to support non-DT way of requesting mailboxes.
>   - The OMAP mailbox driver is integrated with the mailbox framework
>     through the proper implementations of mbox_chan_ops, except for
>     .last_tx_done and .peek_data. The OMAP mailbox driver does not need
>     these ops, as it is completely interrupt driven.
>   - The OMAP mailbox driver uses a custom of_xlate controller ops that
>     allows phandles for the pargs specifier instead of indexing to avoid
>     any channel registration order dependencies.
>   - The new framework does not support multiple clients operating on a
>     single channel, so the reference counting logic is simplified.
>   - The remoteproc driver (current client) is adapted to use the new API.
>     The notifier callbacks used within this client is replaced with the
>     regular callbacks from the newer framework.
>   - The exported OMAP mailbox API are limited to omap_mbox_save_ctx,
>     omap_mbox_restore_ctx, omap_mbox_enable_irq & omap_mbox_disable_irq,
>     with the signature modified to take in the new mbox_chan handle instead
>     of the OMAP specific omap_mbox handle. The first 2 will be removed when
>     the OMAP mailbox driver is adapted to runtime_pm. The other exported
>     API omap_mbox_request_channel will be removed once existing legacy
>     users are converted to DT.
>
> Cc: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> ---
> v3->v4: No code changes, switched the example to use the DSP node instead of
> WkupM3 in the bindings document & minor commit description changes. Other than
> that, this is a repost of the driver adaptation patch [1] from the OMAP Mailbox
> framework adaptation series [2]. This patch is intended for the 3.19 merge window,
> all the dependent patches in [2] are merged as of 3.18-rc2. The DTS patch in [2]
> will be posted separately.
>
> [1] http://marc.info/?l=linux-omap&m=141038453917790&w=2
> [2] http://marc.info/?l=linux-omap&m=141038447817775&w=2
>
>  .../devicetree/bindings/mailbox/omap-mailbox.txt   |  23 ++
>  drivers/mailbox/omap-mailbox.c                     | 346 ++++++++++++---------
>  drivers/remoteproc/omap_remoteproc.c               |  51 +--
>  include/linux/omap-mailbox.h                       |  16 +-
>  4 files changed, 256 insertions(+), 180 deletions(-)
>
Applied to mailbox-devel, Thanks
-Jassi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
