From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Dramatic lockdep slowdown in 4.14
Date: Sat, 14 Oct 2017 09:26:59 +0200
Message-ID: <20171014072659.f2yr6mhm5ha3eou7@gmail.com>
References: <20171013090333.GA17356@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20171013090333.GA17356@localhost>
Sender: owner-linux-mm@kvack.org
To: Johan Hovold <johan@kernel.org>
Cc: Byungchul Park <byungchul.park@lge.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-mm@kvack.org, kernel-team@lge.com, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


* Johan Hovold <johan@kernel.org> wrote:

> Hi,
> 
> I had noticed that the BeagleBone Black boot time appeared to have
> increased significantly with 4.14 and yesterday I finally had time to
> investigate it.
> 
> Boot time (from "Linux version" to login prompt) had in fact doubled
> since 4.13 where it took 17 seconds (with my current config) compared to
> the 35 seconds I now see with 4.14-rc4.
> 
> I quick bisect pointed to lockdep and specifically the following commit:
> 
> 	28a903f63ec0 ("locking/lockdep: Handle non(or multi)-acquisition
> 	               of a crosslock")
> 
> which I've verified is the commit which doubled the boot time (compared
> to 28a903f63ec0^) (added by lockdep crossrelease series [1]).
> 
> I also verified that simply disabling CONFIG_PROVE_LOCKING on 4.14-rc4
> brought boot time down to about 14 seconds.
> 
> Now since it's lockdep I guess this can't really be considered a
> regression if these changes did improve lockdep correctness, but still,
> this dramatic slow down essentially forces me to disable PROVE_LOCKING
> by default on this system.
> 
> Is this lockdep slowdown expected and desirable?

It's not desirable at all.

Does the patch below fix the regression for you - or does the introduction and 
handling of ->nr_acquire hurt as well?

Thanks,

	Ingo

====================>
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c6401d325b0e..f5b40c1668ea 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1138,8 +1138,8 @@ config PROVE_LOCKING
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
-	select LOCKDEP_CROSSRELEASE
-	select LOCKDEP_COMPLETIONS
+#	select LOCKDEP_CROSSRELEASE
+#	select LOCKDEP_COMPLETIONS
 	select TRACE_IRQFLAGS
 	default n
 	help

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
