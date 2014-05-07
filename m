From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: dwc3: ep0: fix delayed status is queued too early
Date: Wed, 7 May 2014 11:03:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405071050530.1325-100000@iolanthe.rowland.org>
References: <20140507215344.GH19925@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140507215344.GH19925@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Zhuang Jin Can <jin.can.zhuang@intel.com>
Cc: USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, liping.zhou@intel.com, david.a.cohen@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Wed, 7 May 2014, Zhuang Jin Can wrote:

> A delayed status request may be queued before composite framework returns
> USB_GADGET_DELAYED_STATUS, because the thread queueing the request can run
> on a different core in parallel with the control request irq.
> 
> SETUP XferComplete IRQ        		fsg_main_thread
> ----------------------        		---------------
> 	|					|
> spin_lock_irqsave(&dwc->lock)               sleeping
> 	|					|
> 	...					...
> dwc3_ep0_inspect_setup()			|
> 	|					|
> dwc3_ep0_delegate_req() 			|
> 	|					|
> 	...					|
> spin_unlock(&dwc->lock);			|
> 	|					|
> fsg_set_alt()   ======> Signal Wakeup ====>	|
> 	| 					|
> other gadgets->set_alt() 	       handle exception
> 	|					|
> 	|			usb_composite_setup_continue()
> 	|					|
> 	|			spin_lock_irqsave(&dwc->lock)
>   	|			     __dwc3_gadget_ep0_queue()
> 	|				 delay_status is false
> 	|			spin_unlock_irqrestore(&dwc->lock)
> 	|					|
> 	|				     sleeping
> spin_lock(&dwc->lock); 				|
> 	|					|
> delayed_status=true				|
> 	|					|
> 
> 		STATUS XferNotReady IRQ
> 		------------------------
> 			|
> 		dwc3_ep0_xfernotready()
> 			|
> 		   delayed_status is true, return;
> 
> The result is the status packet will never be transferred, and
> delayed_status is not cleared.
> 
> Signed-off-by: Zhuang Jin Can <jin.can.zhuang@intel.com>
> Reported-by: Zhou Liping <liping.zhou@intel.com>

A similar problem can occur in the opposite sense: The thread queuing
the delayed status request might be delayed for so long that another
SETUP packet arrives from the host first.  In that case, the delayed
status request is a response for a stale transfer, so it must not be
sent to the host.

Do dwc3 and composite.c handle this case correctly?

Back in the old g_file_storage driver, I addressed this issue by
keeping a counter of all the setup requests.  When it came time to send
a delayed status response, the response would be sent only if the
counter had not changed from when the original setup request was
received.

As far as I can see, composite.c doesn't do anything like that.

Alan Stern
