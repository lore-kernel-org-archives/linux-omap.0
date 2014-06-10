From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] irqchip: gic: always mask interrupts during suspend
Date: Tue, 10 Jun 2014 16:48:26 -0700
Message-ID: <20140610234826.GK3599@ld-irv-0074>
References: <1402442098-21093-1-git-send-email-computersforpeace@gmail.com>
 <alpine.DEB.2.10.1406110129270.5170@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1406110129270.5170@nanos>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 11, 2014 at 01:34:39AM +0200, Thomas Gleixner wrote:
> On Tue, 10 Jun 2014, Brian Norris wrote:
> > Other random thought: it seems like any irqchip driver which does lazy IRQ
> > masking ought to use IRQCHIP_MASK_ON_SUSPEND. So maybe the IRQ core should just
> > do something like:
> > 
> > 	if (!chip->irq_disable)
> > 		chip->flags |= IRQCHIP_MASK_ON_SUSPEND;
> 
> No. Lazy irq disable and the suspend logic are different beasts.

OK, fair enough. Drop that random thought then. It's not in the patch
content anyway.

> That's up to the platform to decide this. Just for the record: there
> is a world outside of ARM...

OK. But GIC is ARM-specific, so we can still constrain this patch and
related topics to the world of ARM.

> But that brings me to a different question:
> 
>     Why are you not putting that customization into the device tree
>     instead of trying to add this to some random arch/arm/mach-foo
>     files?

I'm not adding customization to arch/arm/mach-foo files. I'm trying to
remove it.

This property could be added to device tree, if there was really a valid
use case for a GIC which leaves its interrupts unmasked for suspend. My
question in this patch is essentially: does such a use case exist?

Brian
