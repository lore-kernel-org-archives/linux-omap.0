From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 3/3] dma: cppi41: move -EAGAIN in tear_down
Date: Wed, 02 Oct 2013 11:19:20 +0200
Message-ID: <524BE518.8060008@gmail.com>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com> <1380634271-27588-4-git-send-email-zonque@gmail.com> <20131002082914.GA16680@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:59410 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab3JBJTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 05:19:24 -0400
In-Reply-To: <20131002082914.GA16680@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

Hi Sebastian,

On 02.10.2013 10:29, Sebastian Andrzej Siewior wrote:
> * Daniel Mack | 2013-10-01 15:31:11 [+0200]:

>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>> index 7747bf7..6decf34 100644
>> --- a/drivers/dma/cppi41.c
>> +++ b/drivers/dma/cppi41.c
>> @@ -586,6 +586,9 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
>> 			}
>> 			c->td_seen = 1;
>> 		}
>> +
>> +		if (c->td_retry)
>> +			return -EAGAIN;
> 
> So you return right away since the retry counter should be > 0 here. And
> then you want to get the TDDOWN bit set and retry. Hmmm.
> Let me answer to you 0/3 on this.

Thanks a lot for having a look! As I'm going to be off for a couple of
days now, and only be able to read my mails sporadically, maybe you can
also try the musb suspend functions on your hardware. I'll give you a
quick wrap-up of how my test setup looks like.

On an AM33xx board, I have a host-only (type A) connector with a USB
memory stick plugged in. The relevant config settings are:

CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_OMAP2PLUS is not set
# CONFIG_USB_MUSB_AM35X is not set
CONFIG_USB_MUSB_DSPS=m
# CONFIG_USB_MUSB_UX500 is not set
CONFIG_USB_MUSB_AM335X_CHILD=m
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_TI_CPPI41_DMA=y
CONFIG_TI_CPPI41=y

Once the system is booted up and the USB media is detected, I send the
system to sleep mode with "cat mem >/sys/power/state". After wakeup, I
access the media by mounting and unmounting it once, then send the
system back to sleep.

Repeating the above cycle multiple times will sooner or later make the
warning kick in without the discussed patch. Sometimes it happened on
first try, sometimes it took me up to ~20 cycles to make it happen.

I'd be curious whether you see the same behavior on your board as well,
and whether the fix work for you, too.

For reference, I just pushed my current working tree here:

  https://github.com/zonque/linux/tree/am33xx-3.12


Thanks,
Daniel

