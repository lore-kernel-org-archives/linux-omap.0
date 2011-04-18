From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Mon, 18 Apr 2011 10:00:11 +0300
Message-ID: <1303110011.2062.7.camel@deskari>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	 <BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
	 <20110416130929.GL4423@n2100.arm.linux.org.uk>
	 <20110418064838.GE12272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41234 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752602Ab1DRHAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 03:00:21 -0400
Received: by ewy6 with SMTP id 6so1689482ewy.24
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 00:00:15 -0700 (PDT)
In-Reply-To: <20110418064838.GE12272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2011-04-18 at 09:48 +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110416 16:06]:
> > On Sat, Apr 16, 2011 at 09:01:26PM +0800, Haojian Zhuang wrote:
> > > On Fri, Apr 15, 2011 at 9:06 PM, Russell King - ARM Linux
> > > >
> > > > This uses the physical address, and unlike Davinci's dma address usage,
> > > > it always wants to have the physical address, and will always return
> > > > the corresponding physical address when passed that pointer.
> > > >
> > > > OMAP could probably do with some more work to make the omapfb and other
> > > > allocations use the sram allocator, rather than hooking in before the
> > > > sram allocator is initialized - and then further cleanups so that we
> > > > have an initialization function which just does
> 
> I think we can just remove the omapfb SRAM support for now as it should
> be optional. That will then leave out that dependency and can be added
> back once we have a common framework in place.
> 
> Tomi do you see any problems with that?

I agree. Only OMAP2 has enough SRAM to possibly have a framebuffer
there, and even on OMAP2 the SRAM size is so small that it works only
for rather small displays. I'm not aware of anyone using omapfb's SRAM
support.

The SRAM support also makes our video ram allocator and omapfb more
complex, without much benefit, so I'm more than happy to remove it
totally. Additionally, I believe there is work going on with memory
allocators that omapfb could also use, and migrating to any new mem
allocator will no doubt be much easier if we just handle normal RAM.

So, I can make a patch that removes the SRAM support from omapfb, and
queue it up for the next merge window.

 Tomi


