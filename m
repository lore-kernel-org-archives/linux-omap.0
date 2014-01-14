From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 4/5] arm: omap3: twl: use the new lookup method with usb
 phy
Date: Tue, 14 Jan 2014 16:38:49 +0200
Message-ID: <20140114143849.GB21169@xps8300>
References: <1386601737-8735-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1386601737-8735-5-git-send-email-heikki.krogerus@linux.intel.com>
 <52AEDE43.8030005@ti.com>
 <20131216144314.GB22944@xps8300>
 <52CBFAC0.9040103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52CBFAC0.9040103@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 07, 2014 at 06:31:52PM +0530, Kishon Vijay Abraham I wrote:
> > In any case, having two device names to deal with does not add any
> > more risk. These associations should always be made in the place where
> > the phy device is created so you will always know it's device name.
> 
> huh.. we should also know the 'controller' device name while defining these
> associations and in some cases the controller device and phy device are created
> in entirely different places.

If you don't want to use the controller device name to do the
matching, we can use the con_id string as well. I believe the lookup
method I use in this set just needs a small change.

Is that OK with you?


> > Normally the platform code creates these associations in the same
> > place it creates the platform devices, so you definitely know what the
> > device names will be.
> > 
> > In this case it's actually created in drivers/mfd/twl-core.c, so I do
> > need to update this and move the lookup table there. We can still
> > deliver the user name as platform data, though I believe it's always
> > "musb". Maybe we could actually skip that and just hard code the name?
> 
> I would rather leave the way it is modelled now.

Do you mean, leave it in the platform code? Why? We would reduce the
platform code by moving it to the mfd driver. Or did I misunderstood
something?

Hope I'm not forgetting something we have talked before my vacation.

Thanks,

-- 
heikki
