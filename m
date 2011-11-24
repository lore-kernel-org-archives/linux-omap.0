From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Wed, 23 Nov 2011 17:08:55 -0800
Message-ID: <20111124010855.GN31337@atomide.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<1321926047-14211-6-git-send-email-mturquette@linaro.org>
	<20111122154900.GB18954@kroah.com>
	<CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
	<20111122191347.GB4844@kroah.com>
	<20111123165903.GF31337@atomide.com>
	<20111123180651.GB19739@n2100.arm.linux.org.uk>
	<20111123185518.GG31337@atomide.com>
	<20111123224248.GC19739@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111123224248.GC19739-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [111123 14:07]:
> On Wed, Nov 23, 2011 at 10:55:19AM -0800, Tony Lindgren wrote:
> > What else are you aware of that is really needed early for clocks other
> > than clockevent?
> 
> TWD will lose its auto-calibration.  Then there's various clock source
> and clock event implementations.  These all call for the clk API to be
> up and running at init_early time.

If we can't initialize those later on, then it sounds like some clocks
and some parts of the clock fwk code needs to be static.

However, we could still make big chunks of the clock framework into a
regular device driver for allocating non-static clocks, debugfs interface
and so on.

Regards,

Tony
