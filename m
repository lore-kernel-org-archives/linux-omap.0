From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Thu, 8 Feb 2018 10:04:31 -0600
Message-ID: <e1ef5d15-91f9-c4ad-9a85-cc360a0b425a@ti.com>
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
 <20180207.215735.1518454397358783732.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180207.215735.1518454397358783732.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 02/07/2018 08:57 PM, David Miller wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Tue, 6 Feb 2018 19:17:06 -0600
> 
>> It was discovered that simple program which indefinitely sends 200b UDP
>> packets and runs on TI AM574x SoC (SMP) under RT Kernel triggers network
>> watchdog timeout in TI CPSW driver (<6 hours run). The network watchdog
>> timeout is triggered due to race between cpsw_ndo_start_xmit() and
>> cpsw_tx_handler() [NAPI]
>>
>> cpsw_ndo_start_xmit()
>> 	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
>> 		txq = netdev_get_tx_queue(ndev, q_idx);
>> 		netif_tx_stop_queue(txq);
>>
>> ^^ as per [1] barier has to be used after set_bit() otherwise new value
>> might not be visible to other cpus
>> 	}
>>
>> cpsw_tx_handler()
>> 	if (unlikely(netif_tx_queue_stopped(txq)))
>> 		netif_tx_wake_queue(txq);
>>
>> and when it happens ndev TX queue became disabled forever while driver's HW
>> TX queue is empty.
>>
>> Fix this, by adding smp_mb__after_atomic() after netif_tx_stop_queue()
>> calls and double check for free TX descriptors after stopping ndev TX queue
>> - if there are free TX descriptors wake up ndev TX queue.
>>
>> [1] https://www.kernel.org/doc/html/latest/core-api/atomic_ops.html
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Applied, thanks.
> 

Thank you David.

Could this be marked as stable material 4.9+?

-- 
regards,
-grygorii
