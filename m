From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 05:52:03 -0800
Message-ID: <20180112135203.GA4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180112013257.GB4059@atomide.com>
 <4913146.sVL6sFxzC8@aspire.rjw.lan>
 <4745593.FguGN2uIkX@aspire.rjw.lan>
 <e7a673e1-b28d-f84e-c6c1-c5b896e92aeb@metafoo.de>
 <20180112131623.GA29734@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112131623.GA29734@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux PM <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andrew Lunn <andrew@lunn.ch> [180112 13:16]:
> On Fri, Jan 12, 2018 at 02:01:14PM +0100, Lars-Peter Clausen wrote:
> > On 01/12/2018 01:30 PM, Rafael J. Wysocki wrote:
> > > On Friday, January 12, 2018 1:23:54 PM CET Rafael J. Wysocki wrote:
> > >> On Friday, January 12, 2018 2:32:57 AM CET Tony Lindgren wrote:
> > >>> * Tony Lindgren <tony@atomide.com> [180111 17:20]:
> > >>>> Well I tried to measure suspend power consumption and noticed
> > >>>> that system suspend fails too hand hangs the network device:
> > >>>>
> > >>>> # echo mem > /sys/power/state
> > >>>> [   32.577850] PM: suspend entry (deep)
> > >>>> [   32.582031] PM: Syncing filesystems ... done.
> > >>>> [   32.598083] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > >>>> [   32.608398] OOM killer disabled.
> > >>>> [   32.611846] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> > >>>> [   32.622192] Suspending console(s) (use no_console_suspend to debug)
> > >>>> [   32.651123] dpm_run_callback(): mdio_bus_suspend+0x0/0x24 returns 4352
> > >>>> [   32.651428] PM: Device 2c000000.ethernet-ffffffff:01 failed to suspend: error 4352
> > >>
> > >> This looks totally bogus.
> > >>
> > >> First, "error" should be a negative number and we print it as int.
> > >>
> > >> Second, error codes are not in this range anyway.
> > >>
> > >>>> [   32.653289] PM: Some devices failed to suspend, or early wake event detected
> > >>>> [   32.685455] OOM killer enabled.
> > >>>> [   32.688629] Restarting tasks ... done.
> > >>>> [   32.695983] PM: suspend exit
> > >>>> ash: write error: Bad address
> > >>>>
> > >>>> That too works just fine at commit 70286688e5ad.
> > >>>
> > >>> Suspend fails at commit e2d7fe89e8ae though, so looks like we
> > >>> have two separate issues. I'll try to bisect that separately.
> > > 
> > > I guess what may happen is that something started to return positive numbers
> > > which confuse things all over when passed along by its callers as error codes.
> > 
> > 
> > I guess it this: https://patchwork.kernel.org/patch/10151763/
> 
> Hi Tony, 
> 
> Please try:
> 
> https://patchwork.ozlabs.org/patch/859297/
> 
> Hopefully we will get this into net-next soon.

Thanks that fixes the suspend error. And I was able to confirm
that the suspend power consumption is OK.

That still leaves the mystery of the runtime idle power consumption
being much higher with commit e130bc1d00a4.

Regards,

Tony
