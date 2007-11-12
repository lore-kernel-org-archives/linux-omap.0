From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: re-organize duplicated 32k-timer code
Date: Mon, 12 Nov 2007 04:40:31 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711120439280.9164@utopia.booyaka.com>
References: <20071101220915.594218311@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071101220915.594218311@mvista.com>
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

On Thu, 1 Nov 2007, Kevin Hilman wrote:

> On OMAP2/3, the gp-timer code can be used for a 32kHz timer simply by
> setting the source to be the 32k clock instead of sys_clk.
> 
> This patch uses the mach-omap2/timer-gp.c code for 32kHz timer on
> OMAP2, moving the logic into mach-omap2/timer-gp.c, and not using
> plat-omap/timer32k.c which, for OMAP2, is redundant with the timer-gp
> code.
> 
> Also, if CONFIG_OMAP_32K_TIMER is enabled, the gptimer-based
> clocksource is not used.  Instead the default 32k sync counter is used
> as the clocksource (see the clocksource in plat-omap/common.c.)  This
> is important for sleep/suspend so there is a valid counter during
> sleep.  Note that the suspend/sleep code needs fixing to check for
> overflows of this counter.
> 
> NOTE: timer32k.c was left in plat-omap for now so the diff would be
> clearer, but if folks are OK with this, I'll move it into mach-omap1
> and remove the omap2 stuff from it which can now be done much simpler,
> and without redundancy in timer-gp.c.

I like it.  That code reorg for timer32k.c sounds like a great idea too.

- Paul
