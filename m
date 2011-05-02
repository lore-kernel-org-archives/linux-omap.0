From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/4] omap: musb: introduce default baord config
Date: Mon, 2 May 2011 17:25:34 +0300
Message-ID: <20110502142533.GJ2529@legolas.emea.dhcp.ti.com>
References: <cover.1303682352.git.mike@compulab.co.il>
 <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il>
 <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru>
 <20110428141818.GE19709@n2100.arm.linux.org.uk>
 <9B236748-29D6-4129-AFCD-5D223CE18ECD@linuxhacker.ru>
 <20110428162820.GF19709@n2100.arm.linux.org.uk>
 <9D42099B-0C25-4407-88B2-2574E9233B2A@linuxhacker.ru>
 <20110502142051.GC2092@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43880 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759640Ab1EBOZm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 10:25:42 -0400
Received: by fxm6 with SMTP id 6so6211129fxm.39
        for <linux-omap@vger.kernel.org>; Mon, 02 May 2011 07:25:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110502142051.GC2092@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Oleg Drokin <green@linuxhacker.ru>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

On Mon, May 02, 2011 at 07:20:52AM -0700, Tony Lindgren wrote:
> * Oleg Drokin <green@linuxhacker.ru> [110428 09:33]:
> > Hello!
> > On Apr 28, 2011, at 12:28 PM, Russell King - ARM Linux wrote:
> > > mm, it looks to me like we're ending up with two layers on top of
> > > each other, both trying to provide some kind of generic board interface.
> > > 
> > > I think they should be squashed together.  And that:
> > > 
> > > static struct musb_hdrc_platform_data musb_plat = {
> > > #ifdef CONFIG_USB_MUSB_OTG
> > >        .mode           = MUSB_OTG,
> > > #elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> > >        .mode           = MUSB_HOST,
> > > #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> > >        .mode           = MUSB_PERIPHERAL,
> > > #endif
> > > 
> > > in usb-musb.c needs the same treatment as I mentioned in the previous
> > > message if it really is board specific.  If not, I see no reason why
> > > the above can't go into the musb driver itself.
> > 
> > In the end it's chip dependent. And the musb can work in all three modes.
> > Of course the board dictates if the power is supplied to the bus in host
> > mode and such, but even that could be worked around as nokia 9x0 saga for
> > USB host shows.
> > So to me it looks like something totally in realm of musb driver itself.
> > Nothing bad happens if you configure your MUSB as say OTG while in fact only
> > peripheral mode was implemented, it continues to work as it did.
> > Of course enabling HOST mode may not magically make things work, but
> > I suspect this could be addressed from Kconfig itself instead.
> > 
> > Now I totally expect musb maintainer to jump in and explain
> > how many misconceptions I have ;)
> 
> As far as I remember MUSB always relies on the OTG hardware to enable
> the host mode.. So I don't even know if the driver is usable with
> host only configuration. And for the peripheral mode, it should be

yes, it is :-)

> possible to have OTG enabled, for cert testing some strings need
> to be changed in that case for peripheral only configuration.
> 
> I think Felipe already has some patches to remove the various Kconfig
> options for musb?  In any case, the musb configuration should be a
> runtime configuration passed in the platform data or cmdline.

Yeah, I'm planning to get rid of all the ifdeferry and always compile it
with HOST and Peripheral support. It's only few extra tens of bytes
anyway. Still, I doubt I can get that done for this merge window, I
already have pending the debugging rework.

-- 
balbi
