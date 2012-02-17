From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUG] EHCI build dependencies broken?
Date: Fri, 17 Feb 2012 10:30:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1202171025550.1350-100000@iolanthe.rowland.org>
References: <20120217103746.GN15338@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58612 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751864Ab2BQPae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 10:30:34 -0500
In-Reply-To: <20120217103746.GN15338@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 17 Feb 2012, Russell King - ARM Linux wrote:

> The latest randconfig build for OMAP4430SDP produced this build failure:
> 
> drivers/usb/host/ehci-hcd.c:1382:2: error: #error "missing bus glue for ehci-hcd"
> 
> This appears to be because the OMAP EHCI glue was not selected in the
> configuration, but ehci-hcd was:
> 
> CONFIG_USB_ARCH_HAS_EHCI=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> # CONFIG_USB_EHCI_HCD_OMAP is not set
> # CONFIG_USB_EHCI_MV is not set
> 
> Looking at the Kconfig file, it seems that it's entirely possible to
> select EHCI_HCD without any glue selected.  It's also possible to build
> EHCI with two (or more) bus glues selected - eg, it's possible for
> both these to be selected:
> 
> Kconfig:
> config USB_EHCI_HCD_OMAP
>         bool "EHCI support for OMAP3 and later chips"
>         depends on USB_EHCI_HCD && ARCH_OMAP
> 
> config USB_EHCI_MV
>         bool "EHCI support for Marvell on-chip controller"
>         depends on USB_EHCI_HCD

I'd say the "depends" line for USB_EHCI_MV is broken.  It should allow 
this option only on systems using the Marvell platform.

Of course, that doesn't solve the issue of not having any bus glue
selected at all.  I don't know enough about Kbuild to fix this --
suggestions are welcome.

The same problem exists with OHCI and UHCI too.

Alan Stern

