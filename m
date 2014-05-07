From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: dwc3: ep0: fix delayed status is queued too early
Date: Wed, 7 May 2014 12:59:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405071252550.1325-100000@iolanthe.rowland.org>
References: <20140508043902.GI19925@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42670 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751638AbaEGQ7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 12:59:08 -0400
In-Reply-To: <20140508043902.GI19925@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zhuang Jin Can <jin.can.zhuang@intel.com>
Cc: Felipe Balbi <balbi@ti.com>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, liping.zhou@intel.com, david.a.cohen@linux.intel.com

On Thu, 8 May 2014, Zhuang Jin Can wrote:

> > A similar problem can occur in the opposite sense: The thread queuing
> > the delayed status request might be delayed for so long that another
> > SETUP packet arrives from the host first.  In that case, the delayed
> > status request is a response for a stale transfer, so it must not be
> > sent to the host.
> > 
> > Do dwc3 and composite.c handle this case correctly?
> > 
> So the situation you describe is that we get the STATUS XferNotReady
> event, but gadget queues a status request when control transfer already
> failed.

When the host already timed out the control transfer and started a new 
one.  Here's what I'm talking about:

	Host sends a Set-Configuration request.

	The UDC driver calls the gadget driver's setup function.

	The setup function returns DELAYED_STATUS.

	After a few seconds, the host gets tired of waiting and
	sends a Get-Descriptor request

	The gadget driver finally submits the delayed request response
	to the Set-Configuration request.  But it is now too late,
	because the host expects a response to the Get-Descriptor 
	request.

>  dwc3 can't move to SETUP phase until the status request arrives,
> so any SETUP transaction from host will fail. If status request
> eventually arrives, it already missed the first control transfer, and
> I don't know how the controller will behave. If we still can get a
> STATUS XferComplete event without actually transfer anything on the
> bus, then we can move back to SETUP PHASE which will remove the stale
> delayed status request and start the new SETUP transaction. But I think
> in this situation, the host should already lose it patience and start
> to reset the bus.

My point is that the UDC driver can't handle this.  Therefore the
gadget driver has to prevent this from happening.

That means composite.c has to avoid sending delayed status responses if 
a new SETUP packet has been received already.

> Per my understanding, it's impossible for dwc3 to send a stale STATUS
> request for a new SETUP transaction. 

dwc3 won't know that the status response is stale.  It will think the 
response was meant for the new transfer, not the old one.

Alan Stern

