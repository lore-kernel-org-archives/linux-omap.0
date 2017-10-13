From: Johan Hovold <johan@kernel.org>
Subject: Dramatic lockdep slowdown in 4.14
Date: Fri, 13 Oct 2017 11:03:33 +0200
Message-ID: <20171013090333.GA17356@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Byungchul Park <byungchul.park@lge.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-mm@kvack.org, kernel-team@lge.com, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

I had noticed that the BeagleBone Black boot time appeared to have
increased significantly with 4.14 and yesterday I finally had time to
investigate it.

Boot time (from "Linux version" to login prompt) had in fact doubled
since 4.13 where it took 17 seconds (with my current config) compared to
the 35 seconds I now see with 4.14-rc4.

I quick bisect pointed to lockdep and specifically the following commit:

	28a903f63ec0 ("locking/lockdep: Handle non(or multi)-acquisition
	               of a crosslock")

which I've verified is the commit which doubled the boot time (compared
to 28a903f63ec0^) (added by lockdep crossrelease series [1]).

I also verified that simply disabling CONFIG_PROVE_LOCKING on 4.14-rc4
brought boot time down to about 14 seconds.

Now since it's lockdep I guess this can't really be considered a
regression if these changes did improve lockdep correctness, but still,
this dramatic slow down essentially forces me to disable PROVE_LOCKING
by default on this system.

Is this lockdep slowdown expected and desirable?

Johan

[1] https://lkml.kernel.org/r/1502089981-21272-1-git-send-email-byungchul.park@lge.com
