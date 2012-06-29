From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register
 api
Date: Fri, 29 Jun 2012 07:52:03 -0700
Message-ID: <20120629145203.GJ4202@atomide.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <201206291345.49878.arnd@arndb.de>
 <20120629135559.GH4202@atomide.com>
 <201206291433.06718.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15594 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab2F2OwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 10:52:07 -0400
Content-Disposition: inline
In-Reply-To: <201206291433.06718.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, patches@linaro.org, rostedt@goodmis.org

* Arnd Bergmann <arnd@arndb.de> [120629 07:37]:
> On Friday 29 June 2012, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [120629 06:50]:
> > > On Friday 29 June 2012, Tony Lindgren wrote:
> > > > * Andy Green <andy.green@linaro.org> [120629 03:12]:
> > > > > >2. Is this really how we want to pass the board generated mac addresses
> > > > > >    and other dynamically generated data to the drivers that are device
> > > > > >    tree based?
> > > > > 
> > > > > The issue is that both these busses have an async probe, in the case
> > > > > of USB stack the maintainer was not interested last year in adding
> > > > > platform data.  Maybe it changed but that's my understanding.
> > > > 
> > > > OK, I'd like to hear Arnds comments on the #2 above too as this is
> > > > a more generic issue.
> > > 
> > > In case we have a device tree, we should just be using the USB binding
> > > to find the specific device node, and add the property there. Then
> > > the device driver can use of_get_mac_address() on the usb device itself.
> > 
> > But would you generate the mac address then in the bootloader already?
> 
> Good question. I think we definitely want to have the option of overiding
> the mac address from the boot loader or a predefined device tree blob.
> 
> IMHO the precedence should be
> 
> a) mac-address property from DT if set
> b) hardcoded address from device EEPROM if present
> c) platform-provided address, if supported by platform
> d) random_ether_addr()

And all should be naturally settable with ifconfig too without being
overwritten by the notifier code :)
 
> A lot of devices already provide the mac address in the device tree,
> wherever that comes from. Ideally that would always be possible but
> never necessary.
> 
> > > I'm not sure what it takes to add the link for the device node in the
> > > usb probing code, but my feeling is that it's not too hard.
> > > 
> > > Right now, USB is probed entirely without DT, so the patch is about
> > > the best we can do.
> > 
> > Right, but that still assumes a static mac from the bootloader unless
> > we do a generic driver as below? Or do you have some other ideas?
> 
> The boot loader could theoretically have the same algorithm that Andy's
> patch implements, unless it is configured to something else by the
> user. In many cases, you don't want the boot loader to be that smart,
> but sometimes it is the right solution.

OK that would mean bootloader modifying the .dtb then.
 
> > > Normally USB tends to just work because the device is expected to
> > > be hot-pluggable anyway. If the USB device is soldered to the
> > > board, the hardware designers can take some shortcuts
> > 
> > But that too still depends on the order of loading of the multiple
> > host controller modules. Beagle has both EHCI and musb.

Sorry I meant Panda instead of Beagle here..

> In the device tree, we can uniquely identify the USB hosts, that
> is not a problem here. The problem exists only if you base your
> path on the linux specific name for the devices.
> It's definitely ugly to rely on that, but I think we can actually
> guarantee that it's stable as long as we enforce in the
> Kconfig/Kbuild that the controller that has the ethernet device
> is always built-in on Panda and comes before the other one if
> both are built-in. I would much prefer not to have to rely on
> those things, but I believe it is actually guaranteed at the
> moment for the cases that matter. While you could have both
> controllers as loadable modules and load them in reverse
> order that would also imply that you cannot actually boot from
> the network, so you know that you have a file system on which
> you can set the mac address of the device using udev, before
> you start using networking.

OK. So how about we do the following:

1. Make Andy's notifier part into a generic mac notifier
   driver that can take platform data for the driver name
   mac address pair. Devicetree binding could be added as
   needed.

2. Pass the Panda mac information as platform data to this
   driver for now with a comment on the usb path naming being
   potentially wrong in the loadable modules case.

3. Add devicetree support to the driver once the USB binding
   is available.

That will make my life much easier as then I'm not stuck with
more legacy code to deal with ;) Also writing the driver part
should be trivial as all the code is there already.

Regards,

Tony
