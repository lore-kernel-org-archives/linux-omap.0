From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 08 Jun 2010 06:55:58 +0300 (EEST)
Message-ID: <20100608.065558.189709308.Hiroshi.DOYU@nokia.com>
References: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<4C0D807E.2080607@ti.com>
	<AANLkTilRzAZbwEbc-52BfjntH83upmJZvAFE8fldRaXL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29422 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab0FHD6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 23:58:36 -0400
In-Reply-To: <AANLkTilRzAZbwEbc-52BfjntH83upmJZvAFE8fldRaXL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, felipe.contreras@nokia.com
Cc: deepak.chitriki@ti.com, fernando.lugo@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 05:11:50 +0200

> Hi Deepak,
> 
> On Mon, Jun 7, 2010 at 6:27 PM, Deepak Chitriki <deepak.chitriki@ti.com> wrote:
>>> Ohad Ben-Cohen wrote:
>>> Somewhat relevant note about mailbox performance: omap_mbox_msg_send
>>> often (i.e. when the kfifo is empty) can just send the message
>>> directly, without triggering the tasklet to do that. Applying such a
>>> change will substantially improve the mailbox performance, and will
>>> make the shift to workqueues even more reasonable. I've got a patch
>>> for that, I'll post it soon.
>>>
>>
>> tasklet is run in atomic context,so I wonder how mailbox performance will
>> increase if you switch from tasklet to workqueue?
> 
> In general moving from tasklet to workqueues will probably increase
> some scheduling latencies.
> 
> Nevertheless, if we'll send mailbox messages directly whenever
> possible, without triggering any deferred context, we'll be improving
> mailbox performance on average, because most of the time we will get
> rid of the scheduling latencies entirely.

I think that this depends on the situation.

1) too many messages are coming, buffering and tasklet works
   efficiently at onece, for good throughput.
2) too few messages, the latency won't be a problem? Or some PM case
   may be concerned.

I guess that most of the case, we just care about the throughput of
encoding and decoding, but I am afraid that data themselves are sent
via shared memory and the traffic of mailbox message may not be so
big. I'd like to see the actual data for practical usecases.

Does TI have some typical test pattern to measure throughput? Or Felipe?
