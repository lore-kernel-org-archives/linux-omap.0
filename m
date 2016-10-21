From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Fri, 21 Oct 2016 00:17:23 -0700
Message-ID: <20161021071722.2cetd2mt23t245ao@atomide.com>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161020193612.GA29736-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161020 12:37]:
> On Thu, Oct 20, 2016 at 05:35:24AM -0700, Tony Lindgren wrote:
> > I don't think I've seen that error..
> 
> Comment in code reads: 'FIXME this is another "SHOULD NEVER HAPPEN"'

Seems like it does though..

> > There are few patches that we seem to need for v4.7 and v4.8 stable.
> > At least these two fixes that should be merged for v4.9 should be
> > in:
> > 
> > [PATCH 0/2] Fixes for two more musb regressions
> > 
> > Then two patches for phy-twl4030-usb.c:
> > 
> > b78ea84a7d45 ("phy-twl4030-usb: initialize charging-related stuff via
> > pm_runtime")
> > 78489c7c48d4 ("phy-twl4030-usb: better handle musb_mailbox() failure")
> > 
> > Are you using the twl4030 phy or something else? Also, care to try
> 
> twl4030.
> 
> > with v4.9-rc + [PATCH 0/2] Fixes for two more musb regressions?
> 
> Compiled recent Linus' git tree with those two patches on top of it.
> It doesn't work either, but I found that when I unplug hub from musb
> during bootup and connect is again after musb gets initialized, it works
> normally. Well, almost... It does survive only few reconnects, then
> ends with:

OK interesting, care to check if things work normally with the fixes
mentioned and without the hub? Maybe that's the difference here
compared to my setup.
...

> [  186.457519] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_wait_bcon (90, <VBusValid), retry #3, port1 0008010c
> 
> And that's the end, since now it does not react on hub plug/unplug.
> 
> Also all that VBUS_ERROR conditions are strange as hub is powered separately
> and power lines from phy are not used.

Hmm yeah. I'd like to be able to reproduce this. Can you email me
your .config (again)? You have things in host mode with a powered
hub plus few devices with no USB gadgets configured?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
