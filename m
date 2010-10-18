From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Issue observed with pm_runtime_put_sync
Date: Mon, 18 Oct 2010 14:38:04 -0700
Message-ID: <878w1v9o77.fsf@deeprootsystems.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61359@dbde02.ent.ti.com>
	<87k4lfecwi.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61717@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:43230 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270Ab0JRViH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 17:38:07 -0400
Received: by pxi16 with SMTP id 16so318562pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 18 Oct 2010 14:38:06 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61717@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Mon, 18 Oct 2010 21:30:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>  
> Kevin,
>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Monday, October 18, 2010 9:01 PM
>> To: G, Manjunath Kondaiah
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: Issue observed with pm_runtime_put_sync
>> 
>> Manjunath,
>> 
>> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>> >  
>
> [...]
>
>> > Is this a known issue or issue with pm runtime API usage in 
>> DMA driver?
>> 
>> It's an issue in the runtime PM usage in DMA driver.
>> 
>> Specifically, the _sync versions of the API cannot be used 
>> from interrupt context because they can sleep.
>> 
>> Are the _sync versions really needed at that point?  Without 
>> having the code, I cannot tell, but I susupect that the async 
>> versions could be used there instead.
>> 
>> If not, then the code will need to be reworked so the ISR is 
>> not doing the actual work, but instead is scheduling work to 
>> be done later in process context.
>
> It looks to me this issue is related to DMA client driver since 
> DMA driver only invokes call back function registered during dma channel 
> setup. The control will be passed to DMA client driver. Now it is 
> responsibility of DMA client driver to invoke free_dma(free_dma will
> invoke put_sync) from non interrupt context.

IMO, that is an unnecessary restriction.

There is no reason that I can think of that omap_free_dma() needs to do
a _put_sync().  It should just do a normal (asynchronous) _put(), which
is safe from either process or interrupt context.

> Most of the times, callback will indicate end of data transfer, the
> client driver will release all DMA resources from interrupt context
> itself.

That's fine, and is something the DMA API has supported in the past, and
there's no reason it couldn't continue to support that.

Kevin

