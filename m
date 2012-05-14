From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 19:06:25 +0200
Message-ID: <4FB13B91.7020007@ti.com>
References: <1336996151.2333.3.camel@deskari> <20120514121527.GF22242@arwen.pp.htv.fi> <1336998251.2333.17.camel@deskari> <20120514122920.GK22242@arwen.pp.htv.fi> <20120514124757.GL22242@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40591 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab2ENRG1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 13:06:27 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4EH6QQY010986
	for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 12:06:26 -0500
Received: from DFLE71.ent.ti.com (dfle71.ent.ti.com [128.247.5.62])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4EH6Q7M008942
	for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 12:06:26 -0500
In-Reply-To: <20120514124757.GL22242@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On 5/14/2012 2:47 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, May 14, 2012 at 03:29:21PM +0300, Felipe Balbi wrote:
>> On Mon, May 14, 2012 at 03:24:11PM +0300, Tomi Valkeinen wrote:
>>> On Mon, 2012-05-14 at 15:15 +0300, Felipe Balbi wrote:
>>>
>>>> looks like MUSB is probing before transceiver driver... could it be ?
>>>> Can you check transceiver has actually probed ? I guess panda's using
>>>> twl6030-usb.c
>>>
>>> Ah. Perhaps it's then about this?
>>>
>>> [    0.352905] Skipping twl internal clock init and using bootloader value (unknown osc rate)
>>> [    0.354034] twl 1-0048: PIH (irq 39) chaining IRQs 352..372
>>> [    0.356079] VUSB: 3300 mV normal standby
>>> [    0.358123] genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 356
>>> [    0.358215] twl6030_usb twl6030_usb: can't get IRQ 356, err -22
>>> [    0.358398] twl6030_usb: probe of twl6030_usb failed with error -22
>>
>> sounds about right. Now, why can't it get the IRQ... Benoit, is this
>> related to your sparse irq/irq_domain changes ?
>
> Looks like twl6030-irq still missed conversion to threaded IRQ. It still
> has that ugly ass kthread to handle the IRQs. Oh well, yet another
> broken OMAP driver...

Well, yeah, I did not clean all that mess.

That being said, we did have some issue recently as well, but due to the 
increase of IRQ number and the fact the NR_IRQS is still used since 
SPARSE_IRQ migration is not completed.

At least we saw similar issue with OMAP5.

Maybe increasing NR_IRQS will fix that, but in this case, it looks like 
the IRQ might already been used by someone else.
This is probably because something is still using the hard coded IRQ 
BASE number from the irqs.h define.

I was planning to get rid of them to highlight the broken driver / board 
that might still used them. But this is on my TODO list :-(

Regards,
Benoit
