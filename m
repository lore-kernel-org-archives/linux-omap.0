From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv8 06/13] I2C: OMAP: Correct I2C revision for OMAP3
Date: Wed, 20 Jun 2012 07:14:38 -0700
Message-ID: <20120620141437.GN12766@atomide.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-7-git-send-email-shubhrajyoti@ti.com>
 <20120620103235.GD12766@atomide.com>
 <4FE1C9AC.3020104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FE1C9AC.3020104-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> [120620 06:06]:
> On Wednesday 20 June 2012 04:02 PM, Tony Lindgren wrote:
> > * Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> [120618 07:35]:
> >> From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> >>
> >> The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
> >> revision is the same for 3430 and 3530. However, the OMAP3630 device has the
> >> same I2C revision as OMAP4. Correct the revision definition to reflect this.
> >>
> >> This patch is based on work done by Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> >> Changes from his patch
> >> - Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530
> > ...
> >>  /* timeout waiting for the controller to respond */
> >>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> >> @@ -298,7 +298,7 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
> >>  			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
> >>  					   SYSC_AUTOIDLE_MASK);
> >>  
> >> -		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
> >> +		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
> >>  			dev->syscstate = SYSC_AUTOIDLE_MASK;
> >>  			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
> >>  			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
> > Having to patch all over the place for these revision defines leads
> > into unmaintainable code as new SoCs get added.
> >
> > Please instead just check the revision once during init, then set
> > up some feature bits like I2C_OMAP_NEEDS_XYZ_RESET that the runtime
> > code can check.
> Even now at probe
> 
> dev->rev is set by reading the rev register.
> 
> The (macro)name used to identify is only changed.
> 
> Also all the ips need reset the difference is that 2430 has less bits eg only autoidle and reset.
> So a flag needs reset may not be meaningful.
 
Hmm OK so this is a cosmetic/readability fix..

..but your earlier patch now spreads the checking of revision
to the new non-init function omap_i2c_reset.

Why don't you just do this cosmetic/readability rename fix
before your 03/13 patch? Then set the already existing
OMAP_I2C_FLAG_RESET_REGS_POSTIDLE during init for some
revisions and use that instead of the rev check in
omap_i2c_reset?

Tony
 
