From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Mon, 14 Feb 2011 16:02:16 +0200
Message-ID: <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
References: <1297691206.2951.8.camel@deskari>
 <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
 <1297692039.2951.10.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34452 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754839Ab1BNOCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 09:02:22 -0500
Received: by bwz10 with SMTP id 10so5737325bwz.24
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 06:02:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297692039.2951.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 14, 2011 at 04:00:39PM +0200, Tomi Valkeinen wrote:
> On Mon, 2011-02-14 at 07:48 -0600, Balbi, Felipe wrote:
> > On Mon, Feb 14, 2011 at 03:46:46PM +0200, Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > I've been trying to get USB ethernet gadget driver working so that I can
> > > use NFS root to boot my board (overo or beagle).
> > > 
> > > With 2.6.37 I did get it work, but only after I enabled host mode and
> > > set the driver mode to OTG. With just USB peripheral mode it didn't seem
> > > to work.
> > > 
> > > With 2.6.38-rc4 I don't seem to get it working at all, not matter what
> > > config options I have tried.
> > > 
> > > And when I say "not working" I mean I don't get any output about USB
> > > when the kernel is waiting for the rootfs. Not even if I unplug and plug
> > > the USB cable. And the PC's kernel messages don't show anything when the
> > > board's kernel boots up.
> > > 
> > > I've attached the configs I have tried.
> > 
> > try this patch:
> > 
> > commit d5f42190e7cf11b20face63ee96f26c7d2067b63
> > Author: Ming Lei <tom.leiming@gmail.com>
> > Date:   Wed Jan 5 22:03:21 2011 +0800
> > 
> >     arm: omap4: panda: remove usb_nop_xceiv_register(v1)
> >     
> >     Panda uses both twl6030 otg phy(vbus, id) and internal
> >     phy(data lines, DP/DM), so removes usb_nop_xceiv_register to make
> >     twl6030 otg driver working since current otg code only supports
> >     one global transceiver. Otherwise, musb doesn't work without
> >     the remove.
> 
> I don't use Panda (yet, damn fedex...), but Overo or Beagle.

ah, ok. So it's another problem. I don't have beagle, but I have an old
overo here. Will try tomorrow to see what's going on. Thanks for the
report.

-- 
balbi
