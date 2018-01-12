From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Thu, 11 Jan 2018 17:32:57 -0800
Message-ID: <20180112013257.GB4059@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112012019.GA4059@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180111 17:20]:
> Well I tried to measure suspend power consumption and noticed
> that system suspend fails too hand hangs the network device:
> 
> # echo mem > /sys/power/state
> [   32.577850] PM: suspend entry (deep)
> [   32.582031] PM: Syncing filesystems ... done.
> [   32.598083] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [   32.608398] OOM killer disabled.
> [   32.611846] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   32.622192] Suspending console(s) (use no_console_suspend to debug)
> [   32.651123] dpm_run_callback(): mdio_bus_suspend+0x0/0x24 returns 4352
> [   32.651428] PM: Device 2c000000.ethernet-ffffffff:01 failed to suspend: error 4352
> [   32.653289] PM: Some devices failed to suspend, or early wake event detected
> [   32.685455] OOM killer enabled.
> [   32.688629] Restarting tasks ... done.
> [   32.695983] PM: suspend exit
> ash: write error: Bad address
> 
> That too works just fine at commit 70286688e5ad.

Suspend fails at commit e2d7fe89e8ae though, so looks like we
have two separate issues. I'll try to bisect that separately.

Regards,

Tony
