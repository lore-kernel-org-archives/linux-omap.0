From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Wed, 07 Feb 2018 21:57:35 -0500 (EST)
Message-ID: <20180207.215735.1518454397358783732.davem@davemloft.net>
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180207011706.13393-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 6 Feb 2018 19:17:06 -0600

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
> 
> Fix this, by adding smp_mb__after_atomic() after netif_tx_stop_queue()
> calls and double check for free TX descriptors after stopping ndev TX queue
> - if there are free TX descriptors wake up ndev TX queue.
> 
> [1] https://www.kernel.org/doc/html/latest/core-api/atomic_ops.html
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied, thanks.
