From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problem with OHCI on OMAP4430
Date: Tue, 30 Oct 2012 12:04:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210301151270.1363-100000@iolanthe.rowland.org>
References: <CANP3njwd94MQMW2JjB8e73-25YJu-14tz+QOybi8aP=uOPaSZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51445 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754538Ab2J3QEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 12:04:04 -0400
In-Reply-To: <CANP3njwd94MQMW2JjB8e73-25YJu-14tz+QOybi8aP=uOPaSZg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mohan V <mohanvforum@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, keshava_mgowda@ti.com

On Tue, 30 Oct 2012, Mohan V wrote:

> >> >> ------------------------Device not getting detected when connected---------------------------
> >> >>
> >> >> / # [  135.621002] usbhs_wakeup: Enabling clocks
> >> >> [  135.625762] usbhs_runtime_resume:++++++
> >> >> [  135.630371] usbhs_runtime_resume:------
> >> >> [  135.638183] USB IO PAD Wakeup event triggered##################
> >> >> [  135.644958] usbhs_runtime_suspend:++++++
> >> >> [  135.649749] usbhs_runtime_suspend:-----
> >> >
> >> > It appears that ohci_irq() didn't run.  Did
> >> > ohci_finish_controller_resume() get called?
> >> >
> >> This function is not used in ohci-omap3.c and is used only in ohci-omap.c.
> >> Is it necessary to call this function?
> >
> > It is necessary if the driver supports suspend/resume.  As far as I can
> > tell, the ohci-omap3 driver does not have this support (at least, not
> > in the 3.6 kernel) whereas the ohci-omap driver does.
> >
> > What driver produced the "usbhs_runtime_suspend" and
> > "usbhs_runtime_resume" messages above?  (No such messages are present
> > in ohci-omap3.c.)  Apparently that driver _does_ support
> > suspend/resume.
> >
> This driver is USBHS core driver for OMAP EHCI and OHCI
> (drivers/mfd/omap-usb-host.c)

Okay.  I don't understand why the usbhs_runtime_suspend routine ever 
got called.  Since ohci-omap3 never allows the OHCI controller to be 
suspended, the parent platform device should never get suspended 
either.

What do the various files in the /sys/devices/.../ohci-omap3.0/power 
directory show?  What about the corresponding files in the power 
subdirectory of the parent device?

Alan Stern

