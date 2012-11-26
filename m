From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Mon, 26 Nov 2012 11:27:28 -0800
Message-ID: <20121126192728.GA24510@kroah.com>
References: <20121126123427.18106.4112.stgit@build.warmcat.com>
 <20121126124534.18106.44137.stgit@build.warmcat.com>
 <20121126192206.GB11239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58408 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab2KZT1a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 14:27:30 -0500
Content-Disposition: inline
In-Reply-To: <20121126192206.GB11239@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: stern@rowland.harvard.edu, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On Mon, Nov 26, 2012 at 11:22:06AM -0800, Greg KH wrote:
> On Mon, Nov 26, 2012 at 12:45:34PM +0000, Andy Green wrote:
> > This adds a small optional API into drivers/base which deals with generating,
> > matching and registration of wildcard device paths.
> > 
> > >From a struct device * you can generate a string like
> > 
> >  /platform/usbhs_omap/ehci-omap.0/usb1/1-1
> > 
> > which enapsulates the path of the device's connection to the board.
> > 
> > These can be used to match up other assets, for example struct regulators,
> > that have been registed elsewhere with a device instance that is probed
> > asynchronously from the other board assets.
> > 
> > If your device is on a bus, as it probably is, the device path will feature
> > redundant bus indexes that do not contain information about the connectivity.
> 
> Huh?  A bus "index" does show the connectivity, well, one type of
> connectivity, but perhaps it's not the one _you_ happen to want at the
> moment.  Which is fine, but I don't see why you want to try to figure
> this out using the device path in the first place, surely you have some
> other way that the hardware can describe itself to the kernel as to
> where it needs to be hooked up to?
> 
> > For example if more than one driver can generate devices on the same bus,
> > then the ordering of device probing will change the path, despite the
> > connectivity remains the same.
> 
> That's an expected thing, I don't see the issue here.
> 
> > For that reason, to get a deterministic path for matching, wildcards are
> > allowed.  If your target device has the path
> 
> Wait, no, why would you want a deterministic path and have that
> hard-coded into the kernel here?  You can't rely on that any more than
> userspace can, so let's not start making the mistake that lots of
> userspace programmers originally did when they started using sysfs
> please.  We have learned from our past mistakes.
> 
> >  /platform/usbhs_omap/ehci-omap.0/usb1/1-1

Oh, and further proof of this, there are patches floating around to drop
the "platform" name from the sys/drivers/ tree, so your driver just
broke if that goes through, showing you really don't want to be
hard-coding sysfs paths in any type of logic.

greg k-h
