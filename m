From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 08 Jun 2010 06:46:32 +0300 (EEST)
Message-ID: <20100608.064632.104051482.Hiroshi.DOYU@nokia.com>
References: <4C0D4004.5060303@ti.com>
	<AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50108 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab0FHDrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 23:47:14 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: fernando.lugo@ti.com
Cc: ohad@wizery.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

From: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 01:14:41 +0200

> 
> 
> Hi,
> 
>> -----Original Message-----
>> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
>> Sent: Monday, June 07, 2010 4:41 PM
>> To: Chitriki Rudramuni, Deepak; Guzman Lugo, Fernando; Ramirez Luna, Omar;
>> Kanigeri, Hari
>> Cc: linux-omap@vger.kernel.org; Hiroshi Doyu
>> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
>> 
>> Hi Deepak,
>> 
>> On Mon, Jun 7, 2010 at 1:52 PM, Deepak Chitriki <deepak.chitriki@ti.com>
>> wrote:
>> > With this patch I observed "inconsistent lock state" warning.
>> 
>> Thanks for the report!
>> 
>> > Kfifo is acccessed in omap_mbox_msg_send() and mbox_tx_tasklet()
>> > functions.In order to protect this critical section we need to protect
>> by
>> > using spin_lock_bh() so that the tasklet cannot preempt
>> > omap_mobx_msg_send().
>> 
>> This is actually not the problem: it's ok if mbox_tx_tasklet preempts
>> omap_mbox_msg_send. In fact, such a use case is even ok if we don't
>> take a spinlock at all: kfifo is designed in a way that if you have
>> only 1 consumer and 1 producer, they can both access kfifo
>> simultaneously without any locking. That's why we don't take the
>> spinlock in the mbox_tx_tasklet. The reason, btw, that we take a
>> spinlock in omap_mbox_msg_send is to allow multiple simultaneous
>> sending contexts (taking a spinlock there ensures serialization of
>> those multiple simultaneous sending contexts).
>> 
>> The problem here lies in the fact (that I've just learnt) that
>> dspbridge also sends mbox messages from a tasklet context
>> (dpc_tasklet). Lockdep identifies that the spinlock is taken in a
>> softirq context (dspbridge's dpc_tasklet) after it was previously
>> taken in a softirq-enabled context. Your proposed fix will solve the
>> lockdep issue here, but:
> 
> I think the best thing to do here is remove the spinlock, if not,
> you are preventing that omap_mbox_msg_send be executed from a
> tasklet or isr context. That maybe in this moment it is not called
> but it could be needed in the future. The caller of
> omap_mbox_msg_send should be take care of that function can not be
> call simultaneously.

What about adding another function, omap_mbox_msg_send_sync()?

I don't want to limit the ability of having multiple senders. The
above would send the message with bypassing tasklet.

