From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] clocksource: Allow toggling between runtime and persistent
 clocksource for idle
Date: Mon, 6 Jul 2015 19:34:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507061931570.3916@nanos>
References: <1436166725-18353-1-git-send-email-tony@atomide.com> <CALAqxLXUWE8HmVW+i=qjdFnGOfrVNM+vRgEdtpp2HS6pzxAKEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALAqxLXUWE8HmVW+i=qjdFnGOfrVNM+vRgEdtpp2HS6pzxAKEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 6 Jul 2015, John Stultz wrote:
> On Mon, Jul 6, 2015 at 12:12 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Some persistent clocksources can be on a slow external bus. For shorter
> > latencies for RT use, let's allow toggling the clocksource during idle
> > between a faster non-persistent runtime clocksource and a slower persistent
> > clocksource.
> 
> So yea, as Thomas mentioned, this will cause problems for timekeeping
> accuracy, since we end up resetting the ntp state when we change
> clocksource (additionally you gain a bit of error each time you switch
> clocksources). So you'll most likely see trouble w/ ntpd steering the
> clock.
> 
> I'm not sure its quite clear in the description as to the need here.
> Could you expand a bit as to the rational for why?  I assume it has to
> do with you have a high-res clocksource that is good for fine-grained
> clock_gettime() calls, but wraps quickly, making it poor for long idle
> times. So you're trying to swap to a less fine grained clocksource
> that won't wrap so fast?
> 
> The persistent-clock-like name muddies things further, since the
> persistent-clock is used for suspend, while it looks like this is just
> for idle times.

Though that are idle states where the cpu is powered off so the fast
clock source is powered off as well....

We all know how well that works from the x86/TSC horror. It's just the
same thing again with a different arch prefix.

Thanks,

	tglx
