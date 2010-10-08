From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Fri, 8 Oct 2010 12:20:21 -0500
Message-ID: <4CAF52D5.9040007@ti.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>	<201010070940.14208.laurent.pinchart@ideasonboard.com>	<4CADFCEB.4030008@ti.com>	<AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>	<4CAE1CA1.4050006@ti.com> <AANLkTikRWdw8NQinHmco6dp+XtEr5mr_7H8OBU6+FcB0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58401 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757884Ab0JHRUt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 13:20:49 -0400
In-Reply-To: <AANLkTikRWdw8NQinHmco6dp+XtEr5mr_7H8OBU6+FcB0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Russell King <linux@arm.linux.org.uk>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/8/2010 3:18 AM, Felipe Contreras wrote:
> On Thu, Oct 7, 2010 at 10:16 PM, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>> On 10/7/2010 1:22 PM, Felipe Contreras wrote:
>> ...
>>>
>>> Note that the "shared memory" described in the document you share has
>>> nothing to do with the SHM pool. AFAIK that memory is used for other
>>> things, like MMU PTEs, and storing the base image and socket-nodes,
>>> thus it needs to be contiguous.
>>
>> hmmm, no. it is the same memory. i.e.: we propagate the current opp through
>> the shared memory so the dsp can read it if it went to sleep, with the
>> proper offset you can read that variable starting from the mempool base
>> address.
>
> The document mentions "shared memory" for buffer passing, normal
> memory is used for that, scattered, even user-space memory, not the
> SHM contiguous area.

"streaming" (meaning dsp stream) buffers are passed through the SHM 
(check page 9). The regular "big" buffers are passed through old DMM 
(page 14) which is exactly as you describe it; but that SHM portion is 
referring to stream buffers.

>
>>> I don't see any problem flushing the SHM area when needed, which
>>> probably has performance implications when mmaping/unmapping buffers,
>>> at which point you need to flush bigger memory areas anyway, so that's
>>> not an issue.
>>
>> well, you would have to flush when loading the base image, or allocating a
>> socket node, but also minor flushes for opp propagation, SHM messages to
>> DSP, chnl params, those are the ones I can quickly think of.
>
> All those happen when you send buffers to the DSP, and when you do
> that you need to flush the buffer memory area, which is a much heavier
> operation. Except maybe the opp propagation, but that would require at
> most one page to be flushed, not a big deal I think, besides, it would
> be better if that specific area is handled differently than the rest
> of the SHM, so that we can allocate it with dma_alloc_coherent().

Yes, on top of the regular buffer flush, you need to flush the specific 
parts of the shared memory that the dsp is going to read, meaning: you 
send a buffer to the dsp, then send the MBX interrupt, to let it know 
there is a SHM message, DSP is going to read that SHM message from the 
SHM memory.

You also need to invalidate if the dsp is going to write, so the next 
time you read there is no mismatch in the data, meaning: DSP sends a SHM 
message to slot 1, but you already read slot 1 from a previous 
transaction so contents might be still in cache, so you need to 
invalidate that memory and read again the new SHM message.

Now to know when to read/write you need to have 2 flags per operation, 
one to know if you have new messages and other to know if you are 
reading/writing any message (all in SHM), which are there right now for 
this specific case; but if flushing the SHM, now you will need flags for 
knowing if the first two have been already flushed... and then 2 for 
these two... and so on. So in the end a better locking mechanism would 
be needed for both ARM and DSP which is not based on memory which may or 
may not have the latest contents (going the cacheable route).

As I have been saying, we can try this changes in the ARM tidspbridge 
because we _freely_ see what is going on, but in the DSP we can't.

Regards,

Omar


