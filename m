From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 21:35:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211222130340.8245-100000@netrider.rowland.org>
References: <20121122201549.GA24320@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58615 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754407Ab2KWCfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 21:35:07 -0500
In-Reply-To: <20121122201549.GA24320@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, 22 Nov 2012, Felipe Balbi wrote:

> > The latter, more or less.  For example, maybe we can tell usbcore
> > somehow that regulator X is in control of a device attached to host
> > controller Y (not sure how we would express X and Y though).  Then when
> > usb_add_hcd() sees that the host controller being added is Y, it will
> > know to turn on regulator X.  Similarly for usb_remove_hcd().
> 
> that'd look very nice indeed. Perhaps we could even take care of such
> details for the roothub, even. Maybe some systems might show up where
> roothub need external regulators provided by e.g. PMIC ?!?

As far as I can see, that ought to work provided the controller's 
platform driver is careful not to access the controller hardware before 
calling usb_add_hcd().

And maybe the same sort of scheme could be used for clocks, although I 
don't know how to do it in a generic way that will work on all 
platforms.

Alan Stern

