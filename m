From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH v2 06/13] usb: hcd: Add hcd add/remove functions
 for OTG use
Date: Fri, 17 Apr 2015 10:03:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504170958440.1319-100000@iolanthe.rowland.org>
References: <5530B46F.6010400@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5530B46F.6010400@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Peter Chen <peter.chen@freescale.com>, gregkh@linuxfoundation.org, balbi@ti.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 17 Apr 2015, Roger Quadros wrote:

> On 17/04/15 05:18, Peter Chen wrote:
> > On Tue, Apr 14, 2015 at 01:41:53PM +0300, Roger Quadros wrote:
> >> The existing usb_add/remove_hcd() functionality
> >> remains unchanged for non-OTG devices. For OTG
> >> devices they only register the HCD with the OTG core.
> >>
> >> Introduce _usb_add/remove_hcd() for use by OTG core.
> >> These functions actually add/remove the HCD.
> > 
> > Would you please explain why additional _usb_add/remove_hcd are needed?
> 
> It is to differentiate if the add/remove_hcd was called by the
> HCD drivers or by the OTG core as we want to behave a bit differently
> in both cases.
> When called by HCD drivers, we want to defer the add/remove if it is an
> OTG device. When called by OTG core, we don't want to defer the add/remove.

I don't understand this.  Why do you want to defer the add/remove if 
the device is OTG?  Don't host controller drivers expect these things 
to execute synchronously?

For example, what happens if you rmmod the HCD?  If the remove call
gets deferred, then when it finally runs it will try to call back into
HCD code that has already been unloaded from memory!

> HCD drivers use usb_add/remove_hcd()
> OTG core uses _usb_add/remove_hcd()

How about a more explicit naming scheme?

	HC drivers use usb_add/remove_hcd()
	OTG core uses usb_otg_add/remove_hcd()

Alan Stern
