From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sun, 16 Aug 2009 20:10:18 +0300
Message-ID: <20090816171016.GB9923@gandalf>
References: <20090815174352.c2883585.jhnikula@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
 <20090815180701.7710de51.jhnikula@gmail.com>
 <20090815174000.GA13164@nokia.com>
 <20090816104415.e12a5e46.jhnikula@gmail.com>
 <19F8576C6E063C45BE387C64729E739404322AA35B@dbde02.ent.ti.com>
 <20090816131337.GA7634@gandalf>
 <20090816194953.8d96cdb7.jhnikula@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53570 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbZHPRKq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 13:10:46 -0400
Content-Disposition: inline
In-Reply-To: <20090816194953.8d96cdb7.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: me@felipebalbi.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

hi,

On Sun, Aug 16, 2009 at 07:49:53PM +0300, Jarkko Nikula wrote:
> On Sun, 16 Aug 2009 16:13:38 +0300
> Felipe Balbi <me@felipebalbi.com> wrote:
> 
> > > > It didn't help. Only way to get the mainline kernel booting is to revert
> > > > e8e2ff462dd92693f29eb848f42d3eb720390d59 and activate both
> > > > CONFIG_TWL4030_USB and CONFIG_NOP_USB_XCEIV.
> > > 
> > > > By some reason CONFIG_OMAP_LL_DEBUG_UART3=y and CONFIG_DEBUG_LL=y
> > > > don't work in mainline so hard to trace what is make an oops.
> > > 
> > > > I attached my config if you want look at it.
> > > 
> > > You config has both CONFIG_TWL4030_USB and CONFIG_NOP_USB_XCEIV enabled.
> > > Can you try Felipe's patch but enable only CONFIG_TWL4030_USB.
> > > 
> > > http://marc.info/?l=linux-arm-kernel&m=125007992121335&w=2
> > 
> > Oh yeah, good point.
> > 
> As I told before (lines 4-6 in this mail), Felipe's patch to the
> board-omap3beagle.c didn't help. Only way to make 2.6.31-rc6 booting
> was to enable both of those config options + revert.
> 
> > @Jarkko With the patch I sent you on top of mainline, did you make
> > omap3_beagle_defconfig again ?
> > 
> Yep. Actually I re-tested it now with make distclean first. Meaning
> patch from this mail:
> 
> http://marc.info/?l=linux-usb&m=125041334606967&w=2
> 
> No sign of life.
> 
> Now reverting the e8e2ff462dd92693f29eb848f42d3eb720390d59
> 
> No sign of life.
> 
> Adding CONFIG_NOP_USB_XCEIV=y
> 
> Bingo!
> 
> Getting e8e2ff462dd92693f29eb848f42d3eb720390d59 back
> 
> Again, no sign of life.

how about checking whether twl4030_usb is probing fine ?

-- 
balbi
