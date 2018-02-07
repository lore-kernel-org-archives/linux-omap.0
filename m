From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
Date: Thu, 8 Feb 2018 01:07:05 +0200
Message-ID: <20180207230704.GA3489@khorivan>
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
 <20180207030316.GA7883@khorivan>
 <20180207133105.GB7883@khorivan>
 <ed2d0226-05ac-3d9f-1ca6-1e7063f54d41@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ed2d0226-05ac-3d9f-1ca6-1e7063f54d41@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 07, 2018 at 12:19:11PM -0600, Grygorii Strashko wrote:
>On 02/07/2018 07:31 AM, Ivan Khoronzhuk wrote:
>> On Wed, Feb 07, 2018 at 05:03:19AM +0200, Ivan Khoronzhuk wrote:
>>> On Tue, Feb 06, 2018 at 07:17:06PM -0600, Grygorii Strashko wrote:
>>>> It was discovered that simple program which indefinitely sends 200b UDP
>>>> packets and runs on TI AM574x SoC (SMP) under RT Kernel triggers network
>>>> watchdog timeout in TI CPSW driver (<6 hours run). The network watchdog
>>>> timeout is triggered due to race between cpsw_ndo_start_xmit() and
>>>> cpsw_tx_handler() [NAPI]
>>>>
>>>> cpsw_ndo_start_xmit()
>>>> 	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
>>>> 		txq = netdev_get_tx_queue(ndev, q_idx);
>>>> 		netif_tx_stop_queue(txq);
>>>>
>>>> ^^ as per [1] barrier has to be used after set_bit() otherwise new value
>>>> might not be visible to other cpus
>>>> 	}
>>>>
>>>> cpsw_tx_handler()
>>>> 	if (unlikely(netif_tx_queue_stopped(txq)))
>>>> 		netif_tx_wake_queue(txq);
>>>>
>>>> and when it happens ndev TX queue became disabled forever while driver's HW
>>>> TX queue is empty.
>>> I'm sure it fixes test case somehow but there is some strangeness.
>>> (I've thought about this some X months ago):
>>> 1. If no free desc, then there is bunch of descs on the queue ready to be sent
>>> 2. If one of this desc while this process was missed then next will wake queue,
>>> because there is bunch of them on the fly. So, if desc on top of the sent queue
>>> missed to enable the queue, then next one more likely will enable it anyway..
>>> then how it could happen? The described race is possible only on last
>>> descriptor, yes, packets are small the speed is hight, possibility is very small
>>> .....but then next situation is also possible:
>>> - packets are sent fast
>>> - all packets were sent, but no any descriptors are freed now by sw interrupt (NAPI)
>>> - when interrupt had started NAPI, the queue was enabled, all other next
>>> interrupts are throttled once NAPI not finished it's work yet.
>>> - when new packet submitted, no free descs are present yet (NAPI has not freed
>>> any yet), but all packets are sent, so no one can awake tx queue, as interrupt
>>> will not arise when NAPI is started to free first descriptor interrupts are
>>> disabled.....because h/w queue to be sent is empty...
>>> - how it can happen as submitting packet and handling packet operations is under
>>> channel lock? Not exactly, a period between handling and freeing the descriptor
>>> to the pool is not under channel lock, here:
>>>
>>> 	spin_unlock_irqrestore(&chan->lock, flags);
>>> 	if (unlikely(status & CPDMA_DESC_TD_COMPLETE))
>>> 		cb_status = -ENOSYS;
>>> 	else
>>> 		cb_status = status;
>>>
>>> 	__cpdma_chan_free(chan, desc, outlen, cb_status);
>>> 	return status;
>>>
>>> unlock_ret:
>>> 	spin_unlock_irqrestore(&chan->lock, flags);
>>> 	return status;
>>>
>>> And:
>>> __cpdma_chan_free(chan, desc, outlen, cb_status);
>>> 	-> cpdma_desc_free(pool, desc, 1);
>>>
>>> As result, queue deadlock as you've described.
>>> Just thought, not checked, but theoretically possible.
>>> What do you think?
>
>Yep. And if this happens desc_alloc_fail should be >0 while i usually see it 0 when
>watchdog triggers.
It has to be 0 for situation I trying to describe.
See below re example for keeping all in one place

>I was able to reproduce this situation once, but with bunch of debug code added
>which changes timings:
I also unintentionally observed it several times but usually was thinking
that it was connected with my other experiments. It was with am572x.
But now seems it actually can happen with plane sources. And maybe here not
only 1 fix is needed, that's my concern.

>
>Prerequisite: only one free desc available.
> cpsw_ndo_start_xmit1				cpsw_tx_poll
>  prepare and send packet
>  ->Free desc queue is empty at this moment
> if (unlikely(!cpdma_check_free_tx_desc(txch)))
> 	netif_tx_stop_queue(txq);
> --- tx queue stopped
>						cpdma_chan_process()
>							spin_lock_irqsave(&chan->lock, flags);
> 							chan->count--
>							spin_unlock_irqrestore(&chan->lock, flags)
>
>							cpsw_tx_handler()
>							   if (unlikely(netif_tx_queue_stopped(txq)))
>								netif_tx_wake_queue(txq);
> --- tx queue is woken up
> cpsw_ndo_start_xmit2
>  prepare packet
> ret = cpsw_tx_packet_submit(priv, skb, txch);
> //fail as desc not returned to the pool yet
>	if (unlikely(ret != 0)) {
>		cpsw_err(priv, tx_err, "desc submit failed\n");
>		goto fail;
>	}
>							cpdma_desc_free()	
>
>fail:
>	ndev->stats.tx_dropped++;
>	netif_tx_stop_queue(txq);
>// oops.
>
>That's why I added double check and barrier in fail path also
Seems to be reasonable. It happens along with printing "desc submit failed\n",
so can be coughs easily. Did you observe it? I have no objection, but
implementation prompts that smth wrong in order and locking and rather covers
one usecase than solves issue itself, parts of what could be came out later.
Did you considered case with checking number of descs before submitting,
leaving say 1 desc for later submit, and submit then, and all this under
channel lock, or doing all this stuff in cpsw_submit under channel lock and 
using some analog of cpdma_submit with return codes and w/o lock. Then likely
stop/wake/check queue also can be under channel lock and probably no need in
smp_mb__after_atomic() then, no sure.

>
>
>>
>> Better explanation, for rare race:
>>
>> start conditions:
>> - all descs are submitted, except last one, and queue is not stopped
>> - any desc was returned to the pool yet (but packets can be sent)
>>
>>      time
>>       ||
>>       \/
>>
>> submit process				NAPI poll process
>> --------------------------------------------------------------------------------
>> new packet is scheduled for submission
>> stated that no free descs (with locks)
>> lock is freed
>> 					returned all descs to the pool
>> 					and queue is enabled
>> 					interrupt enabled, poll exit
>> queue is disabled
>> submit exit
>>
>> Result:
>> - all descs are returned to the pool, submission to the queue disabled
>> - NAPI cannot wake queue, as all desc were handled already
>>
>> According to packet size in 200B
>> Data size, bits: 200B * 63desc * 10 = 128000bit roughly
>> Time all of them are sent: 128000 / 1Gb = 128us
>>
>> That's enough the CPU to be occupied by other process in RT even.
>>
>
>First, in case of RT, it's not a "rare race" as all processing is done in threads
>and both xmit and cpsw_tx_poll can be kicked out any time -
>in case of xmit right before netif_tx_stop_queue().
sure, processing is done always in threads, but it happens frequently
with your good test case :).

>
>It also better reproducible with low speed as xmit drains Free desc pool faster.
Low speed of interface? Strange. Seems you have good test case. Could be
useful to check version with correct channel locking.

>
>Next, on SMP it not only execution race as netif_tx_stop_queue() is just set_bit(), so
>new value might not be visible to other cpus and due to netif_tx_queue_stopped(txq) check
>cpsw_tx_handler() might fail to wake up the queue.
I have nothing against smp_mb__after_atomic(), just want to show that issue can
have different sources not only caused by not "atomicity" of bitwise operation,
critical section is a little wider here.

>
>By the way, I'm not inventing smth new here - I've checked bunch of net drivers and found
>that a lot of them have exactly the same  netif_tx_stop_queue/netif_tx_wake_queue handling.
Let it be, if it covers all potential races, not sure if can cover all cases for
cpsw.

>
>Do you want me to update description or there are other comments?
Seems here some misunderstanding, above description are not for your fix, above
description is for alternative reason why queue deadlock can happen, actually
here can be two cases, your and one more. Let me rewrite it a little:

Prerequisite: only one free desc available.

cpsw_ndo_start_xmit				cpsw_tx_poll
--------------------------------------------------------------------------------
prepare and send packet
->Free desc queue is empty at this moment
if (unlikely(!cpdma_check_free_tx_desc(txch)))
--- tx queue is not stopped yet, but decision to stop is made

						->All packets were sent to the network at this moment
						for() {
						   cpdma_chan_process()
							spin_lock_irqsave(&chan->lock, flags);
 							chan->count--
							spin_unlock_irqrestore(&chan->lock, flags)

							cpsw_tx_handler()
							   if (unlikely(netif_tx_queue_stopped(txq)))
								netif_tx_wake_queue(txq);
						}
						->Returned all descs to the pool
						->handled all channels
						->cpsw_tx_poll exit

netif_tx_stop_queue(txq);
--- tx queue is disabled

Result:
- desc_alloc_fail = 0 (your main criteria)
- queue is disabled
- no one is going to wake queue
- watchdog is scheduled

>Do you want me to update description or there are other comments?
You can leave this patch as is, description is enough, if upper is not your
case...basically you've extended critical area and double checked pool,
masking other possible issue and removed only race for "tx_queue_stopped()"
flag check between CPUs. By a big account, it can never happen, but criteria of
check can cover not one source of issue and can mask others. If no lock or no
need in it, then memory barrier is only choice, as obviously, it has to be
added for existing code.

>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
