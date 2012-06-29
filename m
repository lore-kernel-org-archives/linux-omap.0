From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
Date: Fri, 29 Jun 2012 14:38:24 +0000
Message-ID: <201206291438.24828.arnd@arndb.de>
References: <20120629054404.11091.31289.stgit@build.warmcat.com> <201206291345.49878.arnd@arndb.de> <4FEDB5B1.8000703@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56382 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab2F2Oin (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 10:38:43 -0400
In-Reply-To: <4FEDB5B1.8000703@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, patches@linaro.org, rostedt@goodmis.org

On Friday 29 June 2012, Andy Green wrote:
> On 06/29/12 21:45, the mail apparently from Arnd Bergmann included:
> > On Friday 29 June 2012, Tony Lindgren wrote:
> > In case we have a device tree, we should just be using the USB binding
> > to find the specific device node, and add the property there. Then
> > the device driver can use of_get_mac_address() on the usb device itself.
> >
> > I'm not sure what it takes to add the link for the device node in the
> > usb probing code, but my feeling is that it's not too hard.
> >
> > Right now, USB is probed entirely without DT, so the patch is about
> > the best we can do.
> 
> Yes none of this was really hard the problem with more generic approach 
> was getting comprehension and not auto-reject at the other subsystems. 
> To be fair USB is USB and DT is Arm-specific issue.

I don't understand. I'm sure that there are powerpc, x86 or mips systems
with DT that have hardwired USB ports, so it's just a matter of time
until someone forgets to stick an EEPROM on the network port of one of
those.

> >>>> 3. What about mac address in board-generic.c when booting panda with
> >>>>     device tree?
> >>>
> >>> I don't mind adapting it for that case.
> >>
> >> Just to try to think about some alternatives, how about something like
> >> this: This all could be a driver called soft-mac or something that does
> >> what your patches are doing. Except then it would be completely generic
> >> and would be able to take device names and mac addresses from platform
> >> data or from devicetree.
> >
> > That driver would be completely generic to all platforms, but be
> > very specific to finding the mac address of a device, as opposed to
> > other properties.
> >
> > I suspect that if we do that, we will still need a way to bind a
> > device_node to a usb device for the purpose of finding other
> > properties, such as external regulators or clocks that are connected
> > to a hardwired USB device.
> 
> There's no standardized exposure of logical regulators over USB afaik so 
> you won't be able to 'find' them without a VID:PID -bound specific 
> driver that already knew about them.

The point is that as soon as we have implement the standard DT bindings
for USB, we get a way to do this. I would assume that someone has
stumbled over this issue before and just added a hack to their driver
to hardwire some regulator, rather than doing it properly.

> > Normally USB tends to just work because the device is expected to
> > be hot-pluggable anyway. If the USB device is soldered to the
> > board, the hardware designers can take some shortcuts
> 
> Tony's point about modularized host drivers coming in random order seems 
> to be a fair one.  We don't build ehci modular so we don't care about it 
> but from maintainer pov it's a legit issue.

Right, it's definitely ugly. The DT binding would take care of
it because it gives us a way to identify the device, but I think
it also makes sense to have your patches for the common case that
ehci is built-in.

	Arnd
