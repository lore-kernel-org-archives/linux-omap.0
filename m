From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 02/18] mailbox: Add an API for flushing the FIFO
Date: Tue, 8 Jan 2013 19:26:51 +0530
Message-ID: <50EC25A3.6070906@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-3-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46013 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755794Ab3AHN4E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 08:56:04 -0500
In-Reply-To: <1356959231-17335-3-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com

On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> On AM33XX, the mailbox module between the MPU and the
> WKUP-M3 co-processor facilitates a one-way communication.
> MPU uses the assigned mailbox sub-module to issue the
> interrupt to the WKUP-M3 co-processor which then goes
> and reads the the IPC data from registers in the control
> module.
>
> WKUP-M3 is in the L4_WKUP and does not have any access to
> the mailbox module. Due to this limitation, the MPU is
> completely responsible for FIFO maintenance and interrupt
> generation. MPU needs to ensure that the FIFO does not
> overflow by reading back the assigned mailbox sub-module.
>
> This patch adds an API in the mailbox code which the MPU
> can use to empty the FIFO by issuing a readback command.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Note: This patch which will be slightly reworked once the mailbox
> driver changes are finalized.
>
Can you expand a bit please ?

>   drivers/mailbox/mailbox-omap2.c |   19 +++++++++++++++++++
>   drivers/mailbox/mailbox.c       |   36 ++++++++++++++++++++++++++++++++++++
>   drivers/mailbox/mailbox.h       |    3 +++
>   include/linux/mailbox.h         |    1 +
>   4 files changed, 59 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
> index 6d61159..c732be1 100644
> --- a/drivers/mailbox/mailbox-omap2.c
> +++ b/drivers/mailbox/mailbox-omap2.c
> @@ -125,6 +125,23 @@ static int omap2_mbox_fifo_full(struct mailbox *mbox)
>   	return mbox_read_reg(fifo->fifo_stat);
>   }
>
> +static int omap2_mbox_fifo_needs_flush(struct mailbox *mbox)
> +{
> +	struct omap_mbox2_priv *p = mbox->priv;
> +	struct omap_mbox2_fifo *fifo = &p->tx_fifo;
> +
> +	return mbox_read_reg(fifo->msg_stat);
> +}
> +
> +static void omap2_mbox_fifo_readback(struct mailbox *mbox,
> +			struct mailbox_msg *msg)
> +{
> +	struct omap_mbox2_priv *p = mbox->priv;
> +	struct omap_mbox2_fifo *fifo = &p->tx_fifo;
> +
> +	msg->header = mbox_read_reg(fifo->msg);
> +}
> +
>   static int ompa2_mbox_poll_for_space(struct mailbox *mbox)
>   {
>   	if (omap2_mbox_fifo_full(mbox))
> @@ -221,6 +238,8 @@ static struct mailbox_ops omap2_mbox_ops = {
>   	.read           = omap2_mbox_fifo_read,
>   	.write          = omap2_mbox_fifo_write,
>   	.empty          = omap2_mbox_fifo_empty,
> +	.fifo_needs_flush	= omap2_mbox_fifo_needs_flush,
> +	.fifo_readback		= omap2_mbox_fifo_readback,
>   	.poll_for_space = ompa2_mbox_poll_for_space,
>   	.enable_irq     = omap2_mbox_enable_irq,
>   	.disable_irq    = omap2_mbox_disable_irq,
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 2f50226..92c9f68 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -57,6 +57,15 @@ static inline int mbox_empty(struct mailbox *mbox)
>   {
>   	return mbox->ops->empty(mbox);
>   }
> +static inline int mbox_fifo_needs_flush(struct mailbox *mbox)
> +{
> +	return mbox->ops->fifo_needs_flush(mbox);
> +}
> +static inline void mbox_fifo_readback(struct mailbox *mbox,
> +				struct mailbox_msg *msg)
> +{
> +	mbox->ops->fifo_readback(mbox, msg);
> +}
>
>   /* Mailbox IRQ handle functions */
>   static inline void ack_mbox_irq(struct mailbox *mbox, mailbox_irq_t irq)
> @@ -110,6 +119,33 @@ out:
>   }
>   EXPORT_SYMBOL(mailbox_msg_send);
>
> +/*
s/*/**
> + * Flush the Rx FIFO by reading back the messages
> + * Since the normal expectation is that the Rx will do the
> + * reading, add a debug message to indicate if we really flush
> + *
> + * Returns the no. of messages read back
> + */
Just look at the kernel doc style for above

Rest looks fine.

Regards
Santosh
