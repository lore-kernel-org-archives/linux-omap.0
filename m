From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on transfer completion
Date: Wed, 20 Jul 2016 08:26:03 +0200
Message-ID: <877fcg25c4.fsf@belgarion.home>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
	<20160714124242.7579-3-peter.ujfalusi@ti.com>
	<20160718103409.GH5783@n2100.arm.linux.org.uk>
	<923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com> (Peter Ujfalusi's
	message of "Tue, 19 Jul 2016 15:35:18 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, vinod.koul@intel.com, linux-kernel@vger.kernel.org, tony@atomide.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> On 07/18/16 13:34, Russell King - ARM Linux wrote:
>> On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
>>> Before looking for the next descriptor to start, complete the just finished
>>> cookie.
>> 
>> This change will reduce performance as we no longer have an overlap
>> between the next request starting to be dealt with in the hardware
>> vs the previous request being completed.
>
> vchan_cookie_complete() will only mark the cookie completed, adds the vd to
> the desc_completed list (it was deleted from desc_issued list when it was
> started by omap_dma_start_desc) and schedule the tasklet to deal with the real
> completion later.
> Marking the just finished descriptor/cookie done first then looking for
> possible descriptors in the queue to start feels like a better sequence.
>
> After a quick grep in the kernel source: only omap-dma.c was starting the next
> transfer before marking the current completed descriptor/cookie done.

Euh actually I think it's done in other drivers as well :
 - Documentation/dmaengine/pxa_dma.txt (chapter "Transfers hot-chaining)
 - drivers/dma/pxa_dma.c
   => look for pxad_try_hotchain() and it's impact on pxad_chan_handler() which
   will mark the completion while the next transfer is already pumped by the
   hardware.

Speaking of which, from a purely design point of view, as long as you think
beforehand what is your sequence, ie. what is the sequence of your link
chaining, completion handling, etc ..., both marking before or after next tx
start should be fine IMHO.

So in your quest for the "better sequence" the pxa driver's one might give you
some perspective :)

Cheers.

-- 
Robert
