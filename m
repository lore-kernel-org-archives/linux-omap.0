From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/9] usb: hcd: Introduce usb_start/stop_hcd()
Date: Thu, 19 Mar 2015 10:17:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503191012440.1135-100000@iolanthe.rowland.org>
References: <550AB538.7090806@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57076 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752892AbbCSORr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 10:17:47 -0400
In-Reply-To: <550AB538.7090806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, 19 Mar 2015, Roger Quadros wrote:

> > It would be a lot simpler to unbind the host controller driver
> > completely when switching to device mode and rebind it when switching
> > back.  I guess that is the sort of heavy-duty approach you want to
> > avoid, but it may be the only practical way forward.
> 
> So you mean directly calling usb_add/remove_hcd() from the OTG core?

Well, actually I meant calling device_release_driver() and
driver_probe_device().  But usb_add/remove_hcd() might work just about
as well, although I think some of the HCDs may still require a little
rewriting.  Peter Chen says it works for Chipidea.

> I don't see any issues with that other than it being a heavy-duty operation
> like you said and hope that it doesn't violate the OTG spec timing.

The timing is a tough issue.  I'm not sure what we can do about it, 
though.

> Looking at Figure 5-3: "HNP Sequence of Events (FS)" of the OTG 2.0 spec
> we have about 150ms (X10) to switch from B-Device detected A connect (b_wait_acon state)
> to driving bus reset (b_host state). I don't think this should be an issue in modern SoCs
> but I'm not very sure.
> 
> In any case I can migrate to the add/remove hcd approach to simplify things.

Good luck.

Alan Stern

