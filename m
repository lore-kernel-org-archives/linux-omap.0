From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Wed, 30 Sep 2015 16:49:53 +0200
Message-ID: <6944324.e1oo8C9xbx@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com> <20150930141338.GC31865@saruman.tx.rr.com> <3705422.OMk7ysE7Jn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3705422.OMk7ysE7Jn@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 30 September 2015 16:42:21 Arnd Bergmann wrote:
> 
> TEGRA folks: the tegra_read_persistent_clock() implementation apparently
> predates the Tegra RTC driver and I wonder if they actually do the
> right thing in combination. Could it be that the wall time forwards
> twice as fast as it should during resume when the RTC driver is loaded?
> Could it be that we can simply remove  tegra_read_persistent_clock()
> and the register_persistent_clock() infrastructure?
> 

I found the 'sleeptime_injected' variable now, which takes care of
forwarding the clock by the correct amount.

I also found the CLOCK_SOURCE_SUSPEND_NONSTOP flag next to it, which
should let us use the counter32k driver to provide the correct
time during suspend without the omap_read_persistent_clock() function.
We should be able to just delete that code.

If we decide to also delete the tegra_read_persistent_clock()
function, we can remove the registration too.

	Arnd
