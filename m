From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Wed, 16 Feb 2011 08:44:26 +0200
Message-ID: <1297838666.2031.8.camel@deskari>
References: <1297691206.2951.8.camel@deskari>
	 <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
	 <1297692039.2951.10.camel@deskari>
	 <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34115 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab1BPGoa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 01:44:30 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1G6iTdU020670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:44:29 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1G6iTFw006736
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:44:29 -0600 (CST)
In-Reply-To: <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-02-14 at 08:02 -0600, Balbi, Felipe wrote:
> On Mon, Feb 14, 2011 at 04:00:39PM +0200, Tomi Valkeinen wrote:
> > On Mon, 2011-02-14 at 07:48 -0600, Balbi, Felipe wrote:
> > > On Mon, Feb 14, 2011 at 03:46:46PM +0200, Tomi Valkeinen wrote:
> > > > Hi,
> > > > 
> > > > I've been trying to get USB ethernet gadget driver working so that I can
> > > > use NFS root to boot my board (overo or beagle).
> > > > 
> > > > With 2.6.37 I did get it work, but only after I enabled host mode and
> > > > set the driver mode to OTG. With just USB peripheral mode it didn't seem
> > > > to work.
> > > > 
> > > > With 2.6.38-rc4 I don't seem to get it working at all, not matter what
> > > > config options I have tried.
> > > > 
> > > > And when I say "not working" I mean I don't get any output about USB
> > > > when the kernel is waiting for the rootfs. Not even if I unplug and plug
> > > > the USB cable. And the PC's kernel messages don't show anything when the
> > > > board's kernel boots up.
> > > > 
> > > > I've attached the configs I have tried.
> > > 
> > > try this patch:
> > > 
> > > commit d5f42190e7cf11b20face63ee96f26c7d2067b63
> > > Author: Ming Lei <tom.leiming@gmail.com>
> > > Date:   Wed Jan 5 22:03:21 2011 +0800
> > > 
> > >     arm: omap4: panda: remove usb_nop_xceiv_register(v1)
> > >     
> > >     Panda uses both twl6030 otg phy(vbus, id) and internal
> > >     phy(data lines, DP/DM), so removes usb_nop_xceiv_register to make
> > >     twl6030 otg driver working since current otg code only supports
> > >     one global transceiver. Otherwise, musb doesn't work without
> > >     the remove.
> > 
> > I don't use Panda (yet, damn fedex...), but Overo or Beagle.
> 
> ah, ok. So it's another problem. I don't have beagle, but I have an old
> overo here. Will try tomorrow to see what's going on. Thanks for the
> report.

Did you get a chance to try this? Or any suggestions what I could try? I
could of course try to bisect it, but that's quite laborious as I have
to store the kernel into an mmc to be able to use it.

 Tomi


