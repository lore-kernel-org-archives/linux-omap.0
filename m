From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: RE: [PATCH 09/10] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 19:16:02 -0500
Message-ID: <D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34765 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab0FIAQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 20:16:15 -0400
In-Reply-To: <1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Ohad,

In mbox_rx_work() you are removing the lines that enable back the  mbox irq for the RX case, but inside  __mbox_rx_interrupt() this interrupt  is disabled in the case that the kfifo for Rx mailbox gets full. So I think that we need to enable it back as soon as there is space in this kfifo. 

Regards,
Rene


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Thursday, June 03, 2010 1:34 AM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Ohad Ben-Cohen; Kanigeri, Hari; Hiroshi DOYU
> Subject: [PATCH 09/10] omap: mailbox: convert block api to kfifo
> 
> From: Ohad Ben-Cohen <ohad@wizery.com>
> 
> The underlying buffering implementation of mailbox
> is converted from block API to kfifo due to the simplicity
> and speed of kfifo.
> 
> The default size of the kfifo buffer is set to 256 bytes.
> This value is configurable at compile time (via
> CONFIG_OMAP_MBOX_KFIFO_SIZE), and can be changed at
> runtime (via the mbox_kfifo_size module parameter).
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/plat-omap/Kconfig                |    9 ++
>  arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
>  arch/arm/plat-omap/mailbox.c              |  119 +++++++++++++-----------
> -----
>  3 files changed, 64 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 78b49a6..111d39a 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -106,6 +106,15 @@ config OMAP_MBOX_FWK
>  	  Say Y here if you want to use OMAP Mailbox framework support for
>  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
> 
> +config OMAP_MBOX_KFIFO_SIZE
> +	int "Mailbox kfifo default buffer size (bytes)"
> +	depends on OMAP_MBOX_FWK
> +	default 256
> +	help
> +	  Specify the default size of mailbox's kfifo buffers (bytes).
> +	  This can also be changed at runtime (via the mbox_kfifo_size
> +	  module parameter).
> +
>  config OMAP_IOMMU
>  	tristate
> 
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-
> omap/include/plat/mailbox.h
> index 729166b..0c3c4a5 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -5,8 +5,8 @@
> 
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> -#include <linux/blkdev.h>
>  #include <linux/interrupt.h>
> +#include <linux/kfifo.h>
> 
>  typedef u32 mbox_msg_t;
>  struct omap_mbox;
> @@ -42,7 +42,7 @@ struct omap_mbox_ops {
> 
>  struct omap_mbox_queue {
>  	spinlock_t		lock;
> -	struct request_queue	*queue;
> +	struct kfifo		fifo;
>  	struct work_struct	work;
>  	struct tasklet_struct	tasklet;
>  	int	(*callback)(void *);
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 81076b5..ec0e159 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -21,11 +21,14 @@
>   *
>   */
> 
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/kfifo.h>
> +#include <linux/err.h>
> 
>  #include <plat/mailbox.h>
> 
> @@ -37,6 +40,10 @@ static bool rq_full;
>  static int mbox_configured;
>  static DEFINE_MUTEX(mbox_configured_lock);
> 
> +static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
> +module_param(mbox_kfifo_size, uint, S_IRUGO);
> +MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo
> (bytes)");
> +
>  /* Mailbox FIFO handle functions */
>  static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
>  {
> @@ -69,7 +76,7 @@ static inline int is_mbox_irq(struct omap_mbox *mbox,
> omap_mbox_irq_t irq)
>  /*
>   * message sender
>   */
> -static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
> +static int __mbox_poll_for_space(struct omap_mbox *mbox)
>  {
>  	int ret = 0, i = 1000;
> 
> @@ -80,49 +87,50 @@ static int __mbox_msg_send(struct omap_mbox *mbox,
> mbox_msg_t msg)
>  			return -1;
>  		udelay(1);
>  	}
> -	mbox_fifo_write(mbox, msg);
>  	return ret;
>  }
> 
> -
>  int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
>  {
> +	struct omap_mbox_queue *mq = mbox->txq;
> +	int ret = 0, len;
> 
> -	struct request *rq;
> -	struct request_queue *q = mbox->txq->queue;
> +	spin_lock(&mq->lock);
> 
> -	rq = blk_get_request(q, WRITE, GFP_ATOMIC);
> -	if (unlikely(!rq))
> -		return -ENOMEM;
> +	if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
> +	WARN_ON(len != sizeof(msg));
> 
> -	blk_insert_request(q, rq, 0, (void *) msg);
>  	tasklet_schedule(&mbox->txq->tasklet);
> 
> -	return 0;
> +out:
> +	spin_unlock(&mq->lock);
> +	return ret;
>  }
>  EXPORT_SYMBOL(omap_mbox_msg_send);
> 
>  static void mbox_tx_tasklet(unsigned long tx_data)
>  {
> -	int ret;
> -	struct request *rq;
>  	struct omap_mbox *mbox = (struct omap_mbox *)tx_data;
> -	struct request_queue *q = mbox->txq->queue;
> -
> -	while (1) {
> -
> -		rq = blk_fetch_request(q);
> -
> -		if (!rq)
> -			break;
> +	struct omap_mbox_queue *mq = mbox->txq;
> +	mbox_msg_t msg;
> +	int ret;
> 
> -		ret = __mbox_msg_send(mbox, (mbox_msg_t)rq->special);
> -		if (ret) {
> +	while (kfifo_len(&mq->fifo)) {
> +		if (__mbox_poll_for_space(mbox)) {
>  			omap_mbox_enable_irq(mbox, IRQ_TX);
> -			blk_requeue_request(q, rq);
> -			return;
> +			break;
>  		}
> -		blk_end_request_all(rq, 0);
> +
> +		ret = kfifo_out(&mq->fifo, (unsigned char *)&msg,
> +								sizeof(msg));
> +		WARN_ON(ret != sizeof(msg));
> +
> +		mbox_fifo_write(mbox, msg);
>  	}
>  }
> 
> @@ -133,41 +141,21 @@ static void mbox_rx_work(struct work_struct *work)
>  {
>  	struct omap_mbox_queue *mq =
>  			container_of(work, struct omap_mbox_queue, work);
> -	struct omap_mbox *mbox = mq->queue->queuedata;
> -	struct request_queue *q = mbox->rxq->queue;
> -	struct request *rq;
>  	mbox_msg_t msg;
> -	unsigned long flags;
> -
> -	while (1) {
> -		spin_lock_irqsave(q->queue_lock, flags);
> -		rq = blk_fetch_request(q);
> -		if (rq_full) {
> -			omap_mbox_enable_irq(mbox, IRQ_RX);
> -			rq_full = false;
> -		}
> -		spin_unlock_irqrestore(q->queue_lock, flags);
> -		if (!rq)
> -			break;
> +	int len;
> +
> +	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
> +		len = kfifo_out(&mq->fifo, (unsigned char *)&msg,
> sizeof(msg));
> +		WARN_ON(len != sizeof(msg));
> 
> -		msg = (mbox_msg_t)rq->special;
> -		blk_end_request_all(rq, 0);
> -		if (mbox->rxq->callback)
> -			mbox->rxq->callback((void *)msg);
> +		if (mq->callback)
> +			mq->callback((void *)msg);
>  	}
>  }
> 
>  /*
>   * Mailbox interrupt handler
>   */
> -static void mbox_txq_fn(struct request_queue *q)
> -{
> -}
> -
> -static void mbox_rxq_fn(struct request_queue *q)
> -{
> -}
> -
>  static void __mbox_tx_interrupt(struct omap_mbox *mbox)
>  {
>  	omap_mbox_disable_irq(mbox, IRQ_TX);
> @@ -177,13 +165,12 @@ static void __mbox_tx_interrupt(struct omap_mbox
> *mbox)
> 
>  static void __mbox_rx_interrupt(struct omap_mbox *mbox)
>  {
> -	struct request *rq;
> +	struct omap_mbox_queue *mq = mbox->rxq;
>  	mbox_msg_t msg;
> -	struct request_queue *q = mbox->rxq->queue;
> +	int len;
> 
>  	while (!mbox_fifo_empty(mbox)) {
> -		rq = blk_get_request(q, WRITE, GFP_ATOMIC);
> -		if (unlikely(!rq)) {
> +		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
>  			omap_mbox_disable_irq(mbox, IRQ_RX);
>  			rq_full = true;
>  			goto nomem;
> @@ -191,8 +178,9 @@ static void __mbox_rx_interrupt(struct omap_mbox
> *mbox)
> 
>  		msg = mbox_fifo_read(mbox);
> 
> +		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
> +		WARN_ON(len != sizeof(msg));
> 
> -		blk_insert_request(q, rq, 0, (void *)msg);
>  		if (mbox->ops->type == OMAP_MBOX_TYPE1)
>  			break;
>  	}
> @@ -217,11 +205,9 @@ static irqreturn_t mbox_interrupt(int irq, void *p)
>  }
> 
>  static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox *mbox,
> -					request_fn_proc *proc,
>  					void (*work) (struct work_struct *),
>  					void (*tasklet)(unsigned long))
>  {
> -	struct request_queue *q;
>  	struct omap_mbox_queue *mq;
> 
>  	mq = kzalloc(sizeof(struct omap_mbox_queue), GFP_KERNEL);
> @@ -230,11 +216,8 @@ static struct omap_mbox_queue
> *mbox_queue_alloc(struct omap_mbox *mbox,
> 
>  	spin_lock_init(&mq->lock);
> 
> -	q = blk_init_queue(proc, &mq->lock);
> -	if (!q)
> +	if (kfifo_alloc(&mq->fifo, mbox_kfifo_size, GFP_KERNEL))
>  		goto error;
> -	q->queuedata = mbox;
> -	mq->queue = q;
> 
>  	if (work)
>  		INIT_WORK(&mq->work, work);
> @@ -249,7 +232,7 @@ error:
> 
>  static void mbox_queue_free(struct omap_mbox_queue *q)
>  {
> -	blk_cleanup_queue(q->queue);
> +	kfifo_free(&q->fifo);
>  	kfree(q);
>  }
> 
> @@ -279,14 +262,14 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>  		goto fail_request_irq;
>  	}
> 
> -	mq = mbox_queue_alloc(mbox, mbox_txq_fn, NULL, mbox_tx_tasklet);
> +	mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
>  	if (!mq) {
>  		ret = -ENOMEM;
>  		goto fail_alloc_txq;
>  	}
>  	mbox->txq = mq;
> 
> -	mq = mbox_queue_alloc(mbox, mbox_rxq_fn, mbox_rx_work, NULL);
> +	mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
>  	if (!mq) {
>  		ret = -ENOMEM;
>  		goto fail_alloc_rxq;
> @@ -418,6 +401,10 @@ static int __init omap_mbox_init(void)
>  	if (!mboxd)
>  		return -ENOMEM;
> 
> +	/* kfifo size sanity check: alignment and minimal size */
> +	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
> +	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
> sizeof(mbox_msg_t));
> +
>  	return 0;
>  }
>  module_init(omap_mbox_init);
> --
> 1.7.1.rc1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
