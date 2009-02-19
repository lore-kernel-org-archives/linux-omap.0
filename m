From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB on OMAP3530
Date: Thu, 19 Feb 2009 18:09:45 +0200
Message-ID: <20090219160945.GA32564@gandalf>
References: <E1LaALp-0003gl-KO@amazonia.comcast.net> <5A47E75E594F054BAF48C5E4FC4B92AB02F565649D@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35451 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbZBSQJy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 11:09:54 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F565649D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "rick@efn.org" <rick@efn.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 19, 2009 at 08:37:39PM +0530, Gadiyar, Anand wrote:
> >   Thanks very much for the help.
> > 
> > > so Rick, you need to load a gadget driver for musb to work, g_ether or
> > > g_zero are the simplest ones.
> > 
> >   But don't I already have the g_zero enabled via:
> > 
> > CONFIG_USB_GADGET_MUSB_HDRC=y
> > 
> >   But lets assume that, for the time being, I'm only interested in USB Host.
> > 
> >   I had combed the mailing list looking for ISP1505 support and
> > happened across this:
> > 
> > > There's one problem here. If this is similar to isp1704, it doesn't have
> > > a control interface. And the only way to talk to the transceiver is via
> > > ULPI. I have patches that add musb_ulpi_read/write functions using the
> > > musb ulpi wrapper.
> > 
> >   The ISP1704 is very similar to the ISP1505, neither one has a
> > control interface (like I2C), only straight ULPI.  Does this mean that
> > there is no "out of the box" support for straight ULPI in 2.6.29?  If
> > so, what would I need to do to support it?
> > 
> >   Rick
> > 
> > 
> 
> The ISP1505 is supposed to be pretty-much plug and play. MUSB should
> in theory work directly - no configuration required.
> 
> The OMAP3 EVM boards also run a similar configuration. Maybe someone
> with that board can tell you if MUSB in the current kernel works out
> of the box.

I have a board with isp1704, I only have to talk to it when I wanna e.g.
ask it to detect if we have a charger attached to usb port.

> Looking closer at your config options, you have CONFIG_USB_MUSB_OTG
> which means you need a gadget driver loaded before you can use MUSB.
> But, you also have CONFIG_USB_ETH=y, which means your gadget driver
> is also built-in. So you won't need to insmod the module.

Then it should be working. Do you attach micro/mini-A connector to usb
port ? What happens in that case ? how about

echo 5 > /sys/modules/musb_hdrc/parameters/musb_debug

Does it give you any messages when you attach cable ? Send us dmesg
output with musb_debug set to 5.

-- 
balbi
