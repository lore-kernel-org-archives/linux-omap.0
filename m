From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH] OMAP: PM: DMA: Enable runtime pm
Date: Tue, 25 Jan 2011 10:13:59 +0530
Message-ID: <20110125044359.GA29117@m-desktop>
References: <1295860819-20142-1-git-send-email-manjugk@ti.com>
 <87d3nm7zb0.fsf@ti.com>
 <20110124235205.GA6351@manju-desktop>
 <871v414yna.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48688 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752475Ab1AYEpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 23:45:06 -0500
Received: by yxl31 with SMTP id 31so1802446yxl.0
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 20:45:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <871v414yna.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, Jan 24, 2011 at 04:26:01PM -0800, Kevin Hilman wrote:
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Kevin,
> >
> > On Mon, Jan 24, 2011 at 01:43:31PM -0800, Kevin Hilman wrote:
> >> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> >> 
> >> > From: Manjunath G Kondaiah <manjugk@ti.com>
> >> >
> >> > Enable runtime pm and use pm_runtime_get_sync and pm_runtime_put
> >> > for OMAP DMA driver.
> >> >
> >> > Since DMA driver callback will happen from interrupt context and
> >> > DMA client driver will release all DMA resources from interrupt
> >> > context itself, pm_runtime_put_sync() cannot be used in DMA driver.
> >> > Instead, pm_runtime_put() is used which is asynchronous call and
> >> > gets executed in work queue.
> >> 
> >> It's fine that the asynchronous version of put is uses (it's actually
> >> preferred.)  However, the description is confusing here.  You talk about
> >> driver callbacks here but in the patch, your calling _put() from
> >> omap_dma_free(), not from the callback.
> >
> > All dma client drivers are calling omap_dma_free from callback
> > context. 
> 
> Maybe so, but that's not a requirement of the API.  I have a DMA test
> driver that doesn't do that.
> 
> It's also legitimate (and IMO, expected) for a client driver to, for
> example do a omap_dma_request() on module load and omap_free_dma() on
> module unload and only use omap_start_dma() + callbacks for xfers.
> It would be nice (and IMO, expected) that the channels would go idle
> between xfers (using the autosuspend feature for timeouts.)

I can use autosuspend feature which can handle if there is no free_dma and also
if there is no callback registered by the client.

> 
> > I can update this info in patch description if it is useful.
> >
> >> 
> >> You're also calling _get() from the request.  That means, as long as the
> >> DMA channel is allocated, it will be active.   
> >> 
> >> Wouldn't it be better to do the 'get' when the channel is started
> >
> > No. omap_dma_request will call omap_clear_dma which in turn access all channel
> > specific registers for writing zeros.
> 
> Of course, you always have to do get/put around any device access.
> 
> >> and the 'put' when the callback has finished, possibly using the
> >
> > after omap_free_dma, none of the dma registers are accessed hence it is safe to
> > use _put immediately after free_dma.
> 
> Right, but my point above is: what if the user does not call free_dma?
> What if the client will be using the channel again sometime in the
> future, but will be idle.   What I would expect is that the channel
> could go idle until another xfer is initiated rather than waiting for
> the channel to be freed.
ok.
> 
> > Also, dma driver is not aware of callback completion status since it will be
> > executed in client driver.
> 
> Why not?  DMA driver knows when the callback returns.

You are right. We can get this info from DMA interrupt handler.

-Manjunath
[...]
