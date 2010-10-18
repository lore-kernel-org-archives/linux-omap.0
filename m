From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: Issue observed with pm_runtime_put_sync
Date: Tue, 19 Oct 2010 00:14:39 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61769@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61359@dbde02.ent.ti.com>
 <87k4lfecwi.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61717@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D1704FA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605Ab0JRSoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 14:44:46 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D1704FA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Monday, October 18, 2010 9:42 PM
> To: G, Manjunath Kondaiah; Kevin Hilman
> Cc: linux-omap@vger.kernel.org
> Subject: RE: Issue observed with pm_runtime_put_sync
> 
> Manju,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
> > Sent: Monday, October 18, 2010 9:31 PM
> > To: Kevin Hilman
> > Cc: linux-omap@vger.kernel.org
> > Subject: RE: Issue observed with pm_runtime_put_sync
> > 
> > 
> > Kevin,
> > 
> > > -----Original Message-----
> > > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > > Sent: Monday, October 18, 2010 9:01 PM
> > > To: G, Manjunath Kondaiah
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: Issue observed with pm_runtime_put_sync
> > >
> > > Manjunath,
> > >
> > > "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> > > >
> > 
> > [...]
> > 
> > > > Is this a known issue or issue with pm runtime API usage in
> > > DMA driver?
> > >
> > > It's an issue in the runtime PM usage in DMA driver.
> > >
> > > Specifically, the _sync versions of the API cannot be used
> > > from interrupt context because they can sleep.
> > >
> > > Are the _sync versions really needed at that point?  Without
> > > having the code, I cannot tell, but I susupect that the async
> > > versions could be used there instead.
> > >
> > > If not, then the code will need to be reworked so the ISR is
> > > not doing the actual work, but instead is scheduling work to
> > > be done later in process context.
> > 
> > It looks to me this issue is related to DMA client driver since
> > DMA driver only invokes call back function registered 
> during dma channel
> > setup. The control will be passed to DMA client driver. Now it is
> > responsibility of DMA client driver to invoke free_dma(free_dma will
> > invoke put_sync) from non interrupt context.
> > 
> > Most of the times, callback will indicate end of data transfer, the
> > client driver will release all DMA resources from interrupt context
> > itself.
> > 
> Why are you doing put_sync/get_sync per channel alloc/free. DMA has 
> a single clock and not each for per channel. The driver should release
> DMA clocks when all channels are free and acquire it on the 
> first channel
> request.
> 
> We did discuss this sometime back on the LO, right ?

In this case, we might have to check all the 32 channels status(free or
used) for every free_dma call.
 
I was thinking to use dev->power.usage_count field for each get_sysnc and put_sync.

We can have additional logic in free_dma if get_sync/put_sync is overhead.
 
> 
> This may not solve your problem but just wanted to understand this.

Yes. We need to align on this part. Waitning for kevin's comment on this issue.

-Manjunath 