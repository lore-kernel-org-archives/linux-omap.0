From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
Date: Fri, 29 Jun 2012 13:45:49 +0000
Message-ID: <201206291345.49878.arnd@arndb.de>
References: <20120629054404.11091.31289.stgit@build.warmcat.com> <4FED7E6A.4090207@linaro.org> <20120629120325.GD4202@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56955 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab2F2Np5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 09:45:57 -0400
In-Reply-To: <20120629120325.GD4202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, patches@linaro.org, rostedt@goodmis.org

On Friday 29 June 2012, Tony Lindgren wrote:
> * Andy Green <andy.green@linaro.org> [120629 03:12]:
> > >2. Is this really how we want to pass the board generated mac addresses
> > >    and other dynamically generated data to the drivers that are device
> > >    tree based?
> > 
> > The issue is that both these busses have an async probe, in the case
> > of USB stack the maintainer was not interested last year in adding
> > platform data.  Maybe it changed but that's my understanding.
> 
> OK, I'd like to hear Arnds comments on the #2 above too as this is
> a more generic issue.

In case we have a device tree, we should just be using the USB binding
to find the specific device node, and add the property there. Then
the device driver can use of_get_mac_address() on the usb device itself.

I'm not sure what it takes to add the link for the device node in the
usb probing code, but my feeling is that it's not too hard.

Right now, USB is probed entirely without DT, so the patch is about
the best we can do.

> > >3. What about mac address in board-generic.c when booting panda with
> > >    device tree?
> > 
> > I don't mind adapting it for that case.
> 
> Just to try to think about some alternatives, how about something like
> this: This all could be a driver called soft-mac or something that does
> what your patches are doing. Except then it would be completely generic
> and would be able to take device names and mac addresses from platform
> data or from devicetree.

That driver would be completely generic to all platforms, but be
very specific to finding the mac address of a device, as opposed to
other properties.

I suspect that if we do that, we will still need a way to bind a
device_node to a usb device for the purpose of finding other
properties, such as external regulators or clocks that are connected
to a hardwired USB device.

Normally USB tends to just work because the device is expected to
be hot-pluggable anyway. If the USB device is soldered to the
board, the hardware designers can take some shortcuts

	Arnd
