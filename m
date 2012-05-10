From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/6] twl4030: Various fixes for charing-from-USB
Date: Thu, 10 May 2012 10:45:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205101041350.1831-100000@iolanthe.rowland.org>
References: <20120510123754.6a6d95b9@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120510123754.6a6d95b9@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Peter Chen <peter.chen@freescale.com>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 10 May 2012, NeilBrown wrote:

>  Maybe we need to not suspend the USB OTG interface when the device as a
>  whole enters suspend-to-RAM.  Maybe we need to register a dummy gadget to
>  the bus active while in suspend?
>  Does the gadget have to be responsive while-ever the bus is not suspended?

Yes.

>  Maybe we can arrange for any USB activity to trigger a resume?

Probably not, at least, not fast enough.  The gadget is required to 
respond to USB packets within a few microseconds.  At a minimum, the 
USB device controller would have to remain fully powered.

>  Entering suspend while still charging really should be possible - at least
>  with a dump charger and hopefully from a host port as well.  I'll like to
>  find the best way to achieve that, and any help you can provide would be
>  greatly appreciated.

If the gadget is attached to a dumb charger rather than a host then 
there's no problem.  But otherwise it's not so simple.

Have you read the USB charger class specification?  (I haven't...)

Alan Stern
