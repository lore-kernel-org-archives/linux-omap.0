From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Sun, 11 Sep 2016 12:06:55 +0300
Message-ID: <1486773.OWvLIvzMHp@avalon>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info> <20160910132701.776e4d2c@aktux> <20160910130749.5qk37gwfidejdqlm@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160910130749.5qk37gwfidejdqlm-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Saturday 10 Sep 2016 06:07:50 Tony Lindgren wrote:
> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160910 04:27]:
> > On Fri, 9 Sep 2016 16:40:15 -0700 Tony Lindgren wrote:
> >> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160909 14:33]:
> >>> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160909 14:22]:
> >>>> We have two independant things:
> >>>> 1. phy-twl4030-usb (and perhaps others) do not enable
> >>>> 
> >>>>   the phy enough to allow charging on pm_runtime_get().
> >>>>   That is fixed by my phy-related patches.
> >>> 
> >>> OK
> >>> 
> >>>> 2. phy_power_off/on() in called in an unbalanced way if
> >>>>    it is called behind musb_platform_enable()/disable()
> >>>>    as it happens in omap2430.c. Two ways to fix it:
> >>>>    a) prevent phy_power_off()/on() to be called in
> >>>>       an unbalanced way in omap240.c
> >>>>    
> >>>>    b) prevent musb_platform_enable()
> >>>> 	      musb_platform_disable() to be called in an
> >>>> 	      unbalanced way by fixing musb_core.c
> >>>> 
> >>>> Fixing 1. is enough on gta04 to fix charging and hide 2. enough to
> >>>> have gadget working for the most common usecases. (not using
> >>>> twl4030-charger would not work yet)
> >>>> But in the longer term 2. has to be fixed too.
> >>> 
> >>> Sounds like option 2b here is the real fix.
> >> 
> >> And doing full option 2b would be intrusive because of musb_stop
> >> also calling musb_platform_disable. Here's a suggested fix for
> >> v4.8-rc cycle.
> > 
> > musb_platform_disable() in musb_stop() seems to be balanced.
> > 
> > from my list in an earlier mail:
> > musb_platform_disable() in musb_remove() called upon module removal
> > 
> > To my analysis this is odd because musb_stop() is also called indirectly
> > upon removal.
> > But topic that can be left for later.
> 
> OK will update the patch description. You probaby should attempt
> to do a patch to make the calls paired as you already know what
> needs to be done there..
> 
> >> Seems to work for me for omap3 torpedo using phy-twl4030-usb,
> >> omap4 pandaboard es using phy-twl6030-usb and am335x beaglebone
> >> black using dsps glue. Also PM runtime works on omap3.
> >> 
> >> This patch causes a slight merge conlict with Andrea's patches,
> >> as listed in #1 above, but we should probably merge this first
> >> as a fix. That is assuming it does not cause side effects to
> >> Andrea's phy-twl4030-usb charger test case.
> > 
> > Hmm, if the patch will gender-change me, then a clear NAK ;-)
> 
> Sorry typo there, s/Andrea/Andreas/, no need for other radical
> changes :)
> 
> >> Can you guys please test? If things work I'll resend the
> >> patch with proper tested-bys and acks.
> > 
> > I tested the patch without any other musb/phy-fixes.
> > No regressions. It fixes Gadget to be usable. Charging seems
> > not to be totally stable. I will check my phy-patches
> > on top of that again.
> > PM runtime probably still desires some work on it.
> > But I give a clear Ack for merging this one first.
> 
> OK good to hear & thanks for testing. Let's see what Laurent
> says.

I say

Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Thank you for the fix.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
