From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap: revert "i2c: omap: switch to threaded IRQ support")
Date: Fri, 19 Oct 2012 16:28:16 -0700
Message-ID: <87a9vijb3j.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
	<CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
	<20121016133356.GG21801@arwen.pp.htv.fi>
	<87ipaanljt.fsf_-_@deeprootsystems.com>
	<20121017140002.GI11394@arwen.pp.htv.fi>
	<20121017143534.GJ11394@arwen.pp.htv.fi>
	<87txtsitpt.fsf@deeprootsystems.com>
	<20121018055136.GF11137@arwen.pp.htv.fi>
	<1350655227.2768.11.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350655227.2768.11.camel@twins> (Peter Zijlstra's message of
	"Fri, 19 Oct 2012 16:00:27 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> writes:

> On Thu, 2012-10-18 at 08:51 +0300, Felipe Balbi wrote:
>> > So the primary question remains: is RT runtime supposed to include the
>> > time spent suspended?  I suspect not. 
>> 
>> you might be right there, though we need Thomas or Peter to answer :-s 
>
> re, sorry both tglx and I have been traveling, he still is, I'm trying
> to play catch-up :-)

No worries, thanks for the help.

> Anyway, yeah I'm somewhat surprised the clock is 'running' when the
> machine isn't. From what I could gather, this is !x86 hardware, right?
>
> x86 explicitly makes sure our clocks are 'stopped' during suspend, see
> commit cd7240c0b900eb6d690ccee088a6c9b46dae815a.
>
> Can you do something similar for ARM? A quick look at
> arch/arm/kernel/sched_clock.c shows there's already suspend/resume
> hooks, do they do the wrong thing?

No, they do the right thing, but only if they're asked by the
SoC-specific code that registers a sched_clock.  Changing the SoC
specific code to use the 'needs_suspend' API gets things working
perfectly.

Thanks,

Kevin
