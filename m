From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Sat, 10 Sep 2016 13:27:01 +0200
Message-ID: <20160910132701.776e4d2c@aktux>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
        <1946895.vi37Pmm05X@avalon>
        <20160909200803.4cngkfhgkki4e7o3@atomide.com>
        <1538976.gm2HNISj8k@avalon>
        <20160909205103.sqonsprxbb7i6zth@atomide.com>
        <20160909232206.70ee2558@aktux>
        <20160909213341.m2tmrvws5ffomnho@atomide.com>
        <20160909234014.pvu3wp2z45rzbbk5@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909234014.pvu3wp2z45rzbbk5@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 9 Sep 2016 16:40:15 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [160909 14:33]:
> > * Andreas Kemnade <andreas@kemnade.info> [160909 14:22]:
> > > We have two independant things:
> > > 1. phy-twl4030-usb (and perhaps others) do not enable
> > >   the phy enough to allow charging on pm_runtime_get().
> > >   That is fixed by my phy-related patches.
> > 
> > OK
> >
> > > 2. phy_power_off/on() in called in an unbalanced way if
> > >    it is called behind musb_platform_enable()/disable()
> > >    as it happens in omap2430.c. Two ways to fix it:
> > >    a) prevent phy_power_off()/on() to be called in
> > >       an unbalanced way in omap240.c
> > >    b) prevent musb_platform_enable()
> > > 	      musb_platform_disable() to be called in an
> > > 	      unbalanced way by fixing musb_core.c
> > > 
> > > Fixing 1. is enough on gta04 to fix charging and hide 2. enough to
> > > have gadget working for the most common usecases. (not using
> > > twl4030-charger would not work yet)
> > > But in the longer term 2. has to be fixed too.
> > 
> > Sounds like option 2b here is the real fix.
> 
> And doing full option 2b would be intrusive because of musb_stop
> also calling musb_platform_disable. Here's a suggested fix for
> v4.8-rc cycle.
> 
musb_platform_disable() in musb_stop() seems to be balanced.

from my list in an earlier mail:
musb_platform_disable() in musb_remove() called upon module removal

To my analysis this is odd because musb_stop() is also called indirectly
upon removal.
But topic that can be left for later.

> Seems to work for me for omap3 torpedo using phy-twl4030-usb,
> omap4 pandaboard es using phy-twl6030-usb and am335x beaglebone
> black using dsps glue. Also PM runtime works on omap3.
> 
> This patch causes a slight merge conlict with Andrea's patches,
> as listed in #1 above, but we should probably merge this first
> as a fix. That is assuming it does not cause side effects to
> Andrea's phy-twl4030-usb charger test case.
> 
Hmm, if the patch will gender-change me, then a clear NAK ;-)

> Can you guys please test? If things work I'll resend the
> patch with proper tested-bys and acks.
> 
I tested the patch without any other musb/phy-fixes.
No regressions. It fixes Gadget to be usable. Charging seems
not to be totally stable. I will check my phy-patches
on top of that again. 
PM runtime probably still desires some work on it.
But I give a clear Ack for merging this one first.

Regards,
Andreas Kemnade

> Regards,
> 
> Tony
> 
> 8< --------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 9 Sep 2016 15:04:53 -0700
> Subject: [PATCH] usb: musb: Fix unbalanced platform_disable
> 
> Commit a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> for 2430 glue layer") moved PHY enable/disable calls to happen from
> omap2430_musb_enable/disable(). That broke enumeration for several
> devices as PM runtime in the PHY will never enable it.
> 
> The root cause of the problem is unpaired calls from musb_core.c to
> musb_platform_enable/disable in musb_core.c as reported by
> Andreas Kemnade <andreas@kemnade.info>.
> 
> As musb_platform_enable/disable are being called from various
> functions, let's not attempt to make them paiered immediately. This
> would require fixing also musb_stop as it currently calls
> musb_platform_disable.
> 
> Instead, let's first fix the regression in a minimal way by removing
> the initial call to musb_platform_disable.
> 
> AFAIK the initial musb_platform_disable call has always been just an
> attempted workaround for the 2430 glue layer announcing itself too
> early before the gadgets are configured. And that issue finally
> got fixed with commit a118df07f5b1 ("usb: musb: Don't set d+ high
> before enable for 2430 glue layer").
> 
> We now also need to fix the twl4030-phy accordingly making it's
> PM runtime call only needed in twl4030_phy_power_on and have it
> autosuspend. The cable state will keep the phy active when connected.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Reported-by: Andreas Kemnade <andreas@kemnade.info>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> for 2430 glue layer")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -447,8 +447,6 @@ static int twl4030_phy_power_off(struct phy *phy)
>  	struct twl4030_usb *twl = phy_get_drvdata(phy);
>  
>  	dev_dbg(twl->dev, "%s\n", __func__);
> -	pm_runtime_mark_last_busy(twl->dev);
> -	pm_runtime_put_autosuspend(twl->dev);
>  
>  	return 0;
>  }
> @@ -465,6 +463,8 @@ static int twl4030_phy_power_on(struct phy *phy)
>  		twl4030_i2c_access(twl, 0);
>  	twl->linkstat = MUSB_UNKNOWN;
>  	schedule_delayed_work(&twl->id_workaround_work, HZ);
> +	pm_runtime_mark_last_busy(twl->dev);
> +	pm_runtime_put_autosuspend(twl->dev);
>  
>  	return 0;
>  }
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2142,7 +2142,6 @@ musb_init_controller(struct device *dev, int
> nIrq, void __iomem *ctrl) }
>  
>  	/* be sure interrupts are disabled before connecting ISR */
> -	musb_platform_disable(musb);
>  	musb_generic_disable(musb);
>  
>  	/* Init IRQ workqueue before request_irq */
> 
> 
