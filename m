From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: revert "i2c: omap: switch to threaded IRQ
 support"
Date: Mon, 15 Oct 2012 15:05:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210151452470.15973@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com> <20121015071657.GA22818@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121015071657.GA22818-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

On Mon, 15 Oct 2012, Felipe Balbi wrote:

> On Mon, Oct 15, 2012 at 01:51:08AM +0000, Paul Walmsley wrote:
> > 
> > Commit 3b2f8f82dad7d1f79cdc8fc05bd1c94baf109bde ("i2c: omap: switch to
> > threaded IRQ support") causes communication with I2C devices to fail
> > after system suspend/resume on all OMAP3 devices:
> > 
> > ...
> > [   40.228576] PM: noirq resume of devices complete after 3.723 msecs
> > [   40.233184] PM: early resume of devices complete after 3.173 msecs
> > [   40.242736] [sched_delayed] sched: RT throttling activated
> > [   41.235046] omap_i2c omap_i2c.1: controller timed out
> 
> instead of just reverting the patch, I'd rather try to figure out why
> controller times out in that situation.
> 
> It should make no difference if you're running an IRQ thread or not.
> 
> Do you have any extra debugging information which might help figuring
> out what the issue really is ?

As mentioned, the problem can be easily reproduced on OMAP3 is test by 
running

"echo mem > /sys/power/state"

in userspace when rootfs is on MMC.  Then wake up out of suspend, for 
example, by hitting ENTER on the serial console.

This needs to be part of the testing before any OMAP patches are posted to 
the lists -- if for no other reason than because Android kernels enter and 
exit system suspend frequently as part of their standard usage model.

> If the thread is actually at fault, then we need to add IRQF_NO_THREAD
> to the IRQ flags, otherwise same issue will appear if we boot with
> "threadirqs" kernel parameter.

...

> but it fails because I2C times out and I'd like to understand why,
> before just reverting the patch.

It doesn't matter to me how it's fixed as long as it's fixed quickly 
during the early 3.7-rcs.  


- Paul
