From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Mon, 3 Dec 2012 12:09:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1212031154460.1309-100000@iolanthe.rowland.org>
References: <50BC3003.80608@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44094 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754918Ab2LCRJ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Dec 2012 12:09:59 -0500
In-Reply-To: <50BC3003.80608@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Ming Lei <tom.leiming@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>

On Mon, 3 Dec 2012, Andy Green wrote:

> Unless someone NAKs it for sure already (if you're already sure you're 
> going to, please do so to avoid wasting time), I'll issue a try#2 of my 
> code later which demonstrates what I mean.  At least I guess it's useful 
> for comparative purposes.

Before you go writing a whole lot more code, we should discuss the 
basics a bit more clearly.  There are several unsettled issues here:

     1. Should the LAN95xx stuff be associated with the ehci-omap.0's
	driver or with the hub port?  The port would be more flexible,
	offering the ability to turn the power off and on while the
	system is running without affecting anything else.  But the 
	port code is currently in flux, which could cause this new 
	addition to be delayed.

	(On the other hand, since the LAN95xx is the only thing
	connected to the root hub, it could be powered off and on by
	unbinding the ehci-omap.0 device from its driver and rebinding
	it.)

     2. If we do choose the port, do we want to identify it by matching
	against a device name string or by matching a sequence of port
	numbers (in this case, a length-1 sequence)?  The port numbers
	are fixed by the board design, whereas the device name strings
	might  get changed in the future.  On the other hand, the port 
	numbers apply only to USB whereas device names can be used by 
	any subsystem.

     3. Should the matching mechanism go into the device core or into
	the USB port code?  (This is related to the previous question.)

     4. Should this be implemented simply as a regulator (or a pair of
	regulators)?  Or should it be generalized to some sort of PM
	domain thing?  The generic_pm_domain structure defined in
	include/linux/pm_domain.h seems like overkill, but maybe it's
	the most appropriate thing to use.

Until we decide on the answers to these questions, there's no point 
writing detailed patches.

Alan Stern

