From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 16/18] OMAPDSS: DISPC: Configure writeback FIFOs
Date: Wed, 26 Sep 2012 11:01:28 +0530
Message-ID: <50629330.5090902@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>  <1348553993-8083-1-git-send-email-archit@ti.com>  <1348553993-8083-17-git-send-email-archit@ti.com> <1348584652.21717.7.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45357 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab2IZFb0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 01:31:26 -0400
In-Reply-To: <1348584652.21717.7.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 25 September 2012 08:20 PM, Tomi Valkeinen wrote:
> On Tue, 2012-09-25 at 11:49 +0530, Archit Taneja wrote:
>> Extend the DISPC fifo functions to also configure the writeback FIFO thresholds.
>>
>> The most optimal configuration for writeback is to push out data to the
>> interconnect the moment writeback pushes enough pixels in the FIFO to form a
>> burst. This reduces the chance of writeback overflowing it's FIFO.
>
> Hmm, why is this optimal?
>
> The FIFO for WB is the output fifo, right? In mem-to-mem mode the whole
> WB pipeline can stall, so the fifo can't overflow? If so, isn't it
> better to collect more data and flush all that to the memory, instead of
> sending each burst-size piece one by one?

I guess this configuration is optimal for capture mode. Where the input 
side will push out data at the rate of pixel clock, and writeback has to 
collect this data and flush to memory. Writeback can't stall here.

About writeback FIFO overflowing in mem-to-mem mode, I'm not totally 
sure about this. But what you are saying seems valid, writeback would 
stall the input. So it should be safe to accumulate content in the FIFO, 
and push out large number of bursts together.

>
> Then again, if the input side is reading pixels from the memory all the
> time, even if the output fifo helps to keep the output side idle for
> longer periods, it probably doesn't help as the input side keeps the
> memory bus awake.

Maybe if the FIFOs are adjusted such that reading of the pixels from 
input side and writeback flushing out can be done at the same time, then 
we might idle the memory bus more. I don't know if this is possible though.

Archit

