From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Mon, 05 Oct 2015 13:03:52 +0200
Message-ID: <9068678.D8T0aRhgnK@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com> <560DAFC5.50003@linaro.org> <20151005105554.GV23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151005105554.GV23801-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 05 October 2015 03:55:55 Tony Lindgren wrote:
> * Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [151001 15:16]:
> > On 09/30/2015 04:49 PM, Arnd Bergmann wrote:
> > >On Wednesday 30 September 2015 16:42:21 Arnd Bergmann wrote:
> > >>
> > >>TEGRA folks: the tegra_read_persistent_clock() implementation apparently
> > >>predates the Tegra RTC driver and I wonder if they actually do the
> > >>right thing in combination. Could it be that the wall time forwards
> > >>twice as fast as it should during resume when the RTC driver is loaded?
> > >>Could it be that we can simply remove  tegra_read_persistent_clock()
> > >>and the register_persistent_clock() infrastructure?
> > >>
> > >
> > >I found the 'sleeptime_injected' variable now, which takes care of
> > >forwarding the clock by the correct amount.
> > >
> > >I also found the CLOCK_SOURCE_SUSPEND_NONSTOP flag next to it, which
> > >should let us use the counter32k driver to provide the correct
> > >time during suspend without the omap_read_persistent_clock() function.
> > >We should be able to just delete that code.
> > >
> > >If we decide to also delete the tegra_read_persistent_clock()
> > >function, we can remove the registration too.
> > 
> > 
> > +1
> 
> We could maybe have read_persistent_clock() just check for the
> CLOCK_SOURCE_SUSPEND_NONSTOP flag?

timekeeping_resume() already ignores the persistent clock values if
the clocksource has this set. Do you mean we should additionally
not call the read_persistent_clock() function at all to safe a
few cycles reading that value?

How expensive is the function?

	Arnd
