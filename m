From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Wed, 7 Feb 2018 05:03:19 +0200
Message-ID: <20180207030316.GA7883@khorivan>
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180207011706.13393-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 06, 2018 at 07:17:06PM -0600, Grygorii Strashko wrote:
> It was discovered that simple program which indefinitely sends 200b UDP
> packets and runs on TI AM574x SoC (SMP) under RT Kernel triggers network
> watchdog timeout in TI CPSW driver (<6 hours run). The network watchdog
> timeout is triggered due to race between cpsw_ndo_start_xmit() and
> cpsw_tx_handler() [NAPI]
> 
> cpsw_ndo_start_xmit()
> 	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
> 		txq = netdev_get_tx_queue(ndev, q_idx);
> 		netif_tx_stop_queue(txq);
> 
> ^^ as per [1] barier has to be used after set_bit() otherwise new value
> might not be visible to other cpus
> 	}
> 
> cpsw_tx_handler()
> 	if (unlikely(netif_tx_queue_stopped(txq)))
> 		netif_tx_wake_queue(txq);
> 
> and when it happens ndev TX queue became disabled forever while driver's HW
> TX queue is empty.
I'm sure it fixes test case somehow but there is some strangeness.
(I've thought about this some X months ago):
1. If no free desc, then there is bunch of descs on the queue ready to be sent
2. If one of this desc while this process was missed then next will wake queue,
because there is bunch of them on the fly. So, if desc on top of the sent queue
missed to enable the queue, then next one more likely will enable it anyway..
then how it could happen? The described race is possible only on last
descriptor, yes, packets are small the speed is hight, possibility is very small
.....but then next situation is also possible:
- packets are sent fast
- all packets were sent, but no any descriptors are freed now by sw interrupt (NAPI)
- when interrupt had started NAPI, the queue was enabled, all other next 
interrupts are throttled once NAPI not finished it's work yet.
- when new packet submitted, no free descs are present yet (NAPI has not freed
any yet), but all packets are sent, so no one can awake tx queue, as interrupt 
will not arise when NAPI is started to free first descriptor interrupts are 
disabled.....because h/w queue to be sent is empty...
- how it can happen as submitting packet and handling packet operations is under 
channel lock? Not exactly, a period between handling and freeing the descriptor
to the pool is not under channel lock, here:

	spin_unlock_irqrestore(&chan->lock, flags);
	if (unlikely(status & CPDMA_DESC_TD_COMPLETE))
		cb_status = -ENOSYS;
	else
		cb_status = status;

	__cpdma_chan_free(chan, desc, outlen, cb_status);
	return status;

unlock_ret:
	spin_unlock_irqrestore(&chan->lock, flags);
	return status;

And:
__cpdma_chan_free(chan, desc, outlen, cb_status);
	-> cpdma_desc_free(pool, desc, 1);

As result, queue deadlock as you've described.
Just thought, not checked, but theoretically possible.
What do you think?

> 
> Fix this, by adding smp_mb__after_atomic() after netif_tx_stop_queue()
> calls and double check for free TX descriptors after stopping ndev TX queue
> - if there are free TX descriptors wake up ndev TX queue.
> 
> [1] https://www.kernel.org/doc/html/latest/core-api/atomic_ops.html
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 10d7cbe..3805b13 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -1638,6 +1638,7 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
>  		q_idx = q_idx % cpsw->tx_ch_num;
>  
>  	txch = cpsw->txv[q_idx].ch;
> +	txq = netdev_get_tx_queue(ndev, q_idx);
>  	ret = cpsw_tx_packet_submit(priv, skb, txch);
>  	if (unlikely(ret != 0)) {
>  		cpsw_err(priv, tx_err, "desc submit failed\n");
> @@ -1648,15 +1649,26 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
>  	 * tell the kernel to stop sending us tx frames.
>  	 */
>  	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
> -		txq = netdev_get_tx_queue(ndev, q_idx);
>  		netif_tx_stop_queue(txq);
> +
> +		/* Barrier, so that stop_queue visible to other cpus */
> +		smp_mb__after_atomic();
> +
> +		if (cpdma_check_free_tx_desc(txch))
> +			netif_tx_wake_queue(txq);
>  	}
>  
>  	return NETDEV_TX_OK;
>  fail:
>  	ndev->stats.tx_dropped++;
> -	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
>  	netif_tx_stop_queue(txq);
> +
> +	/* Barrier, so that stop_queue visible to other cpus */
> +	smp_mb__after_atomic();
> +
> +	if (cpdma_check_free_tx_desc(txch))
> +		netif_tx_wake_queue(txq);
> +
>  	return NETDEV_TX_BUSY;
>  }
>  
> -- 
> 2.10.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,
Ivan Khoronzhuk
