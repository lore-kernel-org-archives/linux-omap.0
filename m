From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Date: Tue, 21 Aug 2018 16:21:44 -0700
Message-ID: <20180821232144.GW94926@atomide.com>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2161372.IsD4PDzmmY@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>, Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [691231 23:00]:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the tick has been stopped already, but the governor has not asked to
> stop it (which it can do sometimes), the idle loop should invoke
> tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> of this case properly.
> 
> Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)

This patch seems to fix an issue where boot hangs occasionally
on beagleboard-xm with ARM multi_v7_defconfig as reported by
kernelci.org and Mark Brown earlier at [0].

At least so far no boot hangs for me with this fix, so:

Tested-by: Tony Lindgren <tony@atomide.com>

[0] https://www.spinics.net/lists/linux-mmc/msg50480.html
