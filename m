From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 14/36] ARM: OMAP2+: gpmc: Allow drivers to reconfigure
 GPMC settings & timings
Date: Fri, 13 Jun 2014 01:04:09 -0700
Message-ID: <20140613080408.GR17845@atomide.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
 <1402477001-31132-15-git-send-email-rogerq@ti.com>
 <20140613072550.GM17845@atomide.com>
 <539AABE5.10907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <539AABE5.10907-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140613 00:46]:
> On 06/13/2014 10:25 AM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140611 01:58]:
> >> Some devices (e.g. TUSB6010, omap-onenand) need to reconfigure the GPMC
> >> timings in order to operate with different peripheral clock frequencies.
> >> Introduce omap_gpmc_retime() to allow them to do that. The driver
> >> needs to pass the chips select number, GPMC settings and Device timings to
> >> omap_gpmc_retime().
> >>
> >> NOTE: Device tree and board code must still pass the most conservative
> >> timings to GPMC so that the device can be probed by the respective driver.
> >> e.g. Onenand must operate in asynchronous mode at bootup. The device driver
> >> can then request for more optimal timings via omap_gpmc_retime().
> > 
> > Hmm but many of the devices are Linux generic like sms91x and 8250 so it's
> > not nice to start stuffing omap bus specific data there.
> 
> Those drivers should never need to use this function. Hopefully they will work with a one time setup where we specify the timings in the DT. This function is primarily for use by omap-onenand and tusb6010, which are both OMAP specific.

Well those were the only ones so far that had to tolerate with L3
speed changes at some point, so others may need it potentially too.
And we could get rid of the omap specific onenand driver at some
point..

But yeah, I'm fine keeping those recalc functions in the device
drivers if it makes things simpler. Just something to consider in
any case.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
