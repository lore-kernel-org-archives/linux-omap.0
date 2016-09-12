From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Mon, 12 Sep 2016 07:35:55 -0700
Message-ID: <20160912143554.bx33iibcebvqvlx3@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <20160910132701.776e4d2c@aktux>
 <20160910130749.5qk37gwfidejdqlm@atomide.com>
 <1486773.OWvLIvzMHp@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486773.OWvLIvzMHp@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [160911 02:06]:
> Hi Tony,
> 
> On Saturday 10 Sep 2016 06:07:50 Tony Lindgren wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [160910 04:27]:
> > > On Fri, 9 Sep 2016 16:40:15 -0700 Tony Lindgren wrote:
> > >> * Tony Lindgren <tony@atomide.com> [160909 14:33]:
> > >>> * Andreas Kemnade <andreas@kemnade.info> [160909 14:22]:
> > >>>> We have two independant things:
> > >>>> 1. phy-twl4030-usb (and perhaps others) do not enable
> > >>>> 
> > >>>>   the phy enough to allow charging on pm_runtime_get().
> > >>>>   That is fixed by my phy-related patches.
> > >>> 
> > >>> OK
> > >>> 
> > >>>> 2. phy_power_off/on() in called in an unbalanced way if
> > >>>>    it is called behind musb_platform_enable()/disable()
> > >>>>    as it happens in omap2430.c. Two ways to fix it:
> > >>>>    a) prevent phy_power_off()/on() to be called in
> > >>>>       an unbalanced way in omap240.c
> > >>>>    
> > >>>>    b) prevent musb_platform_enable()
> > >>>> 	      musb_platform_disable() to be called in an
> > >>>> 	      unbalanced way by fixing musb_core.c
> > >>>> 
> > >>>> Fixing 1. is enough on gta04 to fix charging and hide 2. enough to
> > >>>> have gadget working for the most common usecases. (not using
> > >>>> twl4030-charger would not work yet)
> > >>>> But in the longer term 2. has to be fixed too.
> > >>> 
> > >>> Sounds like option 2b here is the real fix.
> > >> 
> > >> And doing full option 2b would be intrusive because of musb_stop
> > >> also calling musb_platform_disable. Here's a suggested fix for
> > >> v4.8-rc cycle.
> > > 
> > > musb_platform_disable() in musb_stop() seems to be balanced.
> > > 
> > > from my list in an earlier mail:
> > > musb_platform_disable() in musb_remove() called upon module removal
> > > 
> > > To my analysis this is odd because musb_stop() is also called indirectly
> > > upon removal.
> > > But topic that can be left for later.
> > 
> > OK will update the patch description. You probaby should attempt
> > to do a patch to make the calls paired as you already know what
> > needs to be done there..
> > 
> > >> Seems to work for me for omap3 torpedo using phy-twl4030-usb,
> > >> omap4 pandaboard es using phy-twl6030-usb and am335x beaglebone
> > >> black using dsps glue. Also PM runtime works on omap3.
> > >> 
> > >> This patch causes a slight merge conlict with Andrea's patches,
> > >> as listed in #1 above, but we should probably merge this first
> > >> as a fix. That is assuming it does not cause side effects to
> > >> Andrea's phy-twl4030-usb charger test case.
> > > 
> > > Hmm, if the patch will gender-change me, then a clear NAK ;-)
> > 
> > Sorry typo there, s/Andrea/Andreas/, no need for other radical
> > changes :)
> > 
> > >> Can you guys please test? If things work I'll resend the
> > >> patch with proper tested-bys and acks.
> > > 
> > > I tested the patch without any other musb/phy-fixes.
> > > No regressions. It fixes Gadget to be usable. Charging seems
> > > not to be totally stable. I will check my phy-patches
> > > on top of that again.
> > > PM runtime probably still desires some work on it.
> > > But I give a clear Ack for merging this one first.
> > 
> > OK good to hear & thanks for testing. Let's see what Laurent
> > says.
> 
> I say
> 
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thank you for the fix.

OK great, will send a proper patch with acks shortly.

Thanks,

Tony
