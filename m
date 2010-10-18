From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: Issue observed with pm_runtime_put_sync
Date: Mon, 18 Oct 2010 21:30:43 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61717@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBC61359@dbde02.ent.ti.com>
 <87k4lfecwi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36026 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756848Ab0JRQAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 12:00:50 -0400
In-Reply-To: <87k4lfecwi.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 
Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Monday, October 18, 2010 9:01 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Issue observed with pm_runtime_put_sync
> 
> Manjunath,
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> >  

[...]

> > Is this a known issue or issue with pm runtime API usage in 
> DMA driver?
> 
> It's an issue in the runtime PM usage in DMA driver.
> 
> Specifically, the _sync versions of the API cannot be used 
> from interrupt context because they can sleep.
> 
> Are the _sync versions really needed at that point?  Without 
> having the code, I cannot tell, but I susupect that the async 
> versions could be used there instead.
> 
> If not, then the code will need to be reworked so the ISR is 
> not doing the actual work, but instead is scheduling work to 
> be done later in process context.

It looks to me this issue is related to DMA client driver since 
DMA driver only invokes call back function registered during dma channel 
setup. The control will be passed to DMA client driver. Now it is 
responsibility of DMA client driver to invoke free_dma(free_dma will
invoke put_sync) from non interrupt context.

Most of the times, callback will indicate end of data transfer, the
client driver will release all DMA resources from interrupt context
itself.

-Manjunath


