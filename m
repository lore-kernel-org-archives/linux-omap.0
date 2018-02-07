From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Wed, 7 Feb 2018 12:19:11 -0600
Message-ID: <ed2d0226-05ac-3d9f-1ca6-1e7063f54d41@ti.com>
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
 <20180207030316.GA7883@khorivan> <20180207133105.GB7883@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180207133105.GB7883@khorivan>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/07/2018 07:31 AM, Ivan Khoronzhuk wrote:
> On Wed, Feb 07, 2018 at 05:03:19AM +0200, Ivan Khoronzhuk wrote:
>> On Tue, Feb 06, 2018 at 07:17:06PM -0600, Grygorii Strashko wrote:
>>> It was discovered that simple program which indefinitely sends 200b UDP
>>> packets and runs on TI AM574x SoC (SMP) under RT Kernel triggers network
>>> watchdog timeout in TI CPSW driver (<6 hours run). The network watchdog
>>> timeout is triggered due to race between cpsw_ndo_start_xmit() and
>>> cpsw_tx_handler() [NAPI]
>>>
>>> cpsw_ndo_start_xmit()
>>> 	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
>>> 		txq = netdev_get_tx_queue(ndev, q_idx);
>>> 		netif_tx_stop_queue(txq);
>>>
>>> ^^ as per [1] barrier has to be used after set_bit() otherwise new value
>>> might not be visible to other cpus
>>> 	}
>>>
>>> cpsw_tx_handler()
>>> 	if (unlikely(netif_tx_queue_stopped(txq)))
>>> 		netif_tx_wake_queue(txq);
>>>
>>> and when it happens ndev TX queue became disabled forever while driver's HW
>>> TX queue is empty.
>> I'm sure it fixes test case somehow but there is some strangeness.
>> (I've thought about this some X months ago):
>> 1. If no free desc, then there is bunch of descs on the queue ready to be sent
>> 2. If one of this desc while this process was missed then next will wake queue,
>> because there is bunch of them on the fly. So, if desc on top of the sent queue
>> missed to enable the queue, then next one more likely will enable it anyway..
>> then how it could happen? The described race is possible only on last
>> descriptor, yes, packets are small the speed is hight, possibility is very small
>> .....but then next situation is also possible:
>> - packets are sent fast
>> - all packets were sent, but no any descriptors are freed now by sw interrupt (NAPI)
>> - when interrupt had started NAPI, the queue was enabled, all other next
>> interrupts are throttled once NAPI not finished it's work yet.
>> - when new packet submitted, no free descs are present yet (NAPI has not freed
>> any yet), but all packets are sent, so no one can awake tx queue, as interrupt
>> will not arise when NAPI is started to free first descriptor interrupts are
>> disabled.....because h/w queue to be sent is empty...
>> - how it can happen as submitting packet and handling packet operations is under
>> channel lock? Not exactly, a period between handling and freeing the descriptor
>> to the pool is not under channel lock, here:
>>
>> 	spin_unlock_irqrestore(&chan->lock, flags);
>> 	if (unlikely(status & CPDMA_DESC_TD_COMPLETE))
>> 		cb_status = -ENOSYS;
>> 	else
>> 		cb_status = status;
>>
>> 	__cpdma_chan_free(chan, desc, outlen, cb_status);
>> 	return status;
>>
>> unlock_ret:
>> 	spin_unlock_irqrestore(&chan->lock, flags);
>> 	return status;
>>
>> And:
>> __cpdma_chan_free(chan, desc, outlen, cb_status);
>> 	-> cpdma_desc_free(pool, desc, 1);
>>
>> As result, queue deadlock as you've described.
>> Just thought, not checked, but theoretically possible.
>> What do you think?

Yep. And if this happens desc_alloc_fail should be >0 while i usually see it 0 when 
watchdog triggers.
I was able to reproduce this situation once, but with bunch of debug code added
which changes timings:

Prerequisite: only one free desc available.
 cpsw_ndo_start_xmit1				cpsw_tx_poll
  prepare and send packet 
  ->Free desc queue is empty at this moment
 if (unlikely(!cpdma_check_free_tx_desc(txch)))
 	netif_tx_stop_queue(txq);
 --- tx queue stopped
						cpdma_chan_process()
							spin_lock_irqsave(&chan->lock, flags);
 							chan->count--
							spin_unlock_irqrestore(&chan->lock, flags)

							cpsw_tx_handler()
							   if (unlikely(netif_tx_queue_stopped(txq)))
								netif_tx_wake_queue(txq);
 --- tx queue is woken up
 cpsw_ndo_start_xmit2
  prepare packet
 ret = cpsw_tx_packet_submit(priv, skb, txch);
 //fail as desc not returned to the pool yet
	if (unlikely(ret != 0)) {
		cpsw_err(priv, tx_err, "desc submit failed\n");
		goto fail;
	}
							cpdma_desc_free()	

fail:
	ndev->stats.tx_dropped++;
	netif_tx_stop_queue(txq);
// oops.

That's why I added double check and barrier in fail path also
 

> 
> Better explanation, for rare race:
> 
> start conditions:
> - all descs are submitted, except last one, and queue is not stopped
> - any desc was returned to the pool yet (but packets can be sent)
> 
>      time
>       ||
>       \/
> 
> submit process				NAPI poll process
> --------------------------------------------------------------------------------
> new packet is scheduled for submission
> stated that no free descs (with locks)
> lock is freed
> 					returned all descs to the pool
> 					and queue is enabled
> 					interrupt enabled, poll exit
> queue is disabled
> submit exit
> 
> Result:
> - all descs are returned to the pool, submission to the queue disabled
> - NAPI cannot wake queue, as all desc were handled already
> 
> According to packet size in 200B
> Data size, bits: 200B * 63desc * 10 = 128000bit roughly
> Time all of them are sent: 128000 / 1Gb = 128us
> 
> That's enough the CPU to be occupied by other process in RT even.
> 

First, in case of RT, it's not a "rare race" as all processing is done in threads
and both xmit and cpsw_tx_poll can be kicked out any time -
in case of xmit right before netif_tx_stop_queue().

It also better reproducible with low speed as xmit drains Free desc pool faster.

Next, on SMP it not only execution race as netif_tx_stop_queue() is just set_bit(), so
new value might not be visible to other cpus and due to netif_tx_queue_stopped(txq) check 
cpsw_tx_handler() might fail to wake up the queue.

By the way, I'm not inventing smth new here - I've checked bunch of net drivers and found
that a lot of them have exactly the same  netif_tx_stop_queue/netif_tx_wake_queue handling.

Do you want me to update description or there are other comments?

-- 
regards,
-grygorii
