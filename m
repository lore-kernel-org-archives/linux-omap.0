From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: hrtimers/dyntick support for OMAP2 GP-timers
Date: Wed, 16 May 2007 10:47:13 -0700
Message-ID: <20070516174712.GH20297@atomide.com>
References: <20070511003036.203942772@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070511003036.203942772@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070510 17:32]:
> This patch converts the GP-timer layer to use the
> clocksource/clockevent interface provided by the new GENERIC_TIME and
> GENERIC_CLOCKEVENT layers.
> 
> Doing so enables use of the new hrtimers and dynticks features on
> OMAP2.
> 
> A quick test of hrtimers using Thomas Gleixner's cyclictest on a
> 2430SDP shows min/avg/max userspace latencies of 38/50/850 usec.
> 
> A quick test of dyntick using /proc/timer_stats on an idle system
> shows an avg. of ~5 events/sec over a 10 second period.

Pushing today.

Tony
