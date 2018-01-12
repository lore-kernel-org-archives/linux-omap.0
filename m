From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 13:23:54 +0100
Message-ID: <4913146.sVL6sFxzC8@aspire.rjw.lan>
References: <20180112000037.GA3875@atomide.com> <20180112012019.GA4059@atomide.com> <20180112013257.GB4059@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112013257.GB4059@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday, January 12, 2018 2:32:57 AM CET Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180111 17:20]:
> > Well I tried to measure suspend power consumption and noticed
> > that system suspend fails too hand hangs the network device:
> > 
> > # echo mem > /sys/power/state
> > [   32.577850] PM: suspend entry (deep)
> > [   32.582031] PM: Syncing filesystems ... done.
> > [   32.598083] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > [   32.608398] OOM killer disabled.
> > [   32.611846] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> > [   32.622192] Suspending console(s) (use no_console_suspend to debug)
> > [   32.651123] dpm_run_callback(): mdio_bus_suspend+0x0/0x24 returns 4352
> > [   32.651428] PM: Device 2c000000.ethernet-ffffffff:01 failed to suspend: error 4352

This looks totally bogus.

First, "error" should be a negative number and we print it as int.

Second, error codes are not in this range anyway.

> > [   32.653289] PM: Some devices failed to suspend, or early wake event detected
> > [   32.685455] OOM killer enabled.
> > [   32.688629] Restarting tasks ... done.
> > [   32.695983] PM: suspend exit
> > ash: write error: Bad address
> > 
> > That too works just fine at commit 70286688e5ad.
> 
> Suspend fails at commit e2d7fe89e8ae though, so looks like we
> have two separate issues. I'll try to bisect that separately.

BTW, can you please CC PM bug reports to linux-pm?  That may help sometimes.

Thanks,
Rafael
