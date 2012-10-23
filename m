From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
	revert "i2c: omap: switch to threaded IRQ support")
Date: Tue, 23 Oct 2012 10:19:49 +0100
Message-ID: <20121023091949.GD28061@n2100.arm.linux.org.uk>
References: <20121016133356.GG21801@arwen.pp.htv.fi> <87ipaanljt.fsf_-_@deeprootsystems.com> <20121017140002.GI11394@arwen.pp.htv.fi> <20121017143534.GJ11394@arwen.pp.htv.fi> <87txtsitpt.fsf@deeprootsystems.com> <20121018055136.GF11137@arwen.pp.htv.fi> <1350655227.2768.11.camel@twins> <87391ahvao.fsf@deeprootsystems.com> <1350899541.2768.82.camel@twins> <87ehkqihdh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ehkqihdh.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 22, 2012 at 09:47:06AM -0700, Kevin Hilman wrote:
> Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> writes:
> 
> > On Fri, 2012-10-19 at 16:54 -0700, Kevin Hilman wrote:
> >
> >> So I did the same thing for my ARM SoC, and it definitley stops the RT
> >> throttling.  
> >> 
> >> However, it has the undesriable (IMO) side effect of making timed printk
> >> output rather unhelpful for debugging suspend/resume since printk time
> >> stays constant throughout suspend/resume no matter how long you
> >> sleep. :(
> >> 
> >> So does that mean we have to choose between useful printk times during
> >> suspend/resume or functioning IRQ threads during suspend/resume ?
> >
> > Urgh.. this was not something I considered. This being primarily the
> > sched_clock infrastructure and such.
> >
> > So what exactly is the problem with the suspend resume thing (its not
> > something I've ever debugged), is all you need a clean break between pre
> > and post suspend, or do you need the actual time the machine was gone?
> 
> I think it's more a question of what people are used to.  I think folks
> used to debugging suspend/resume (at least on ARM) are used to having
> the printk timestamps reflect the amount of time the machine was gone.
> 
> With a sched_clock() that counts during suspend, that feature doesn't
> work anymore.  I'm not sure that this feature is a deal breaker, but it
> has been convenient.

IMHO, this isn't a deal breaker, it's nothing more than cosmetic issue.
The big hint about the sched_clock() behaviour is partly in the name,
and the behaviour you get from the scheduler if you don't give it what
it wants.  The scheduler sets the requirements for sched_clock(), not
printk, so if we have to fix sched_clock() to get correct behaviour
from the scheduler, that's what we have to do irrespective of cosmetic
printk issues.

And there are many other ways to measure time off in suspend... we have
at least three other functions which return time, and which will return
updated time after a resume event.
