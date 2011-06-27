From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
Date: Mon, 27 Jun 2011 00:48:57 -0700
Message-ID: <20110627074856.GD23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin> <87wrgca3dr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87wrgca3dr.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110623 09:56]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > There's no need to initialize the dmtimer framework early.
> 
> Actually, there is, because it's being used from the early code.
> 
> The sys_timer.init functions are called before arch_initcalls, so before
> omap_dm_timer_init() is called, you have:
> 
> omap3_timer_init()
>     omap2_gp_clockevent_init()
>         omap_dm_timer_init_one()
>            omap_dm_timer_request_specific()
>                
> 
> Among other things, the spinlock is taken before it has been initialized
> in omap_dm_timer_init() (that's how I noticed this problem), but the
> rest of the init of course hasn't been done either.
> 
> Basically, the problem is that this "early init" code is not only using
> the new macros, but it's also using functions from the "real" driver,
> which is not yet initialized.

Sounds like you did not apply the previous patch to remove the PM hack?

There's no need to call to omap_dm_timer_request_specific here unless
you added back the PM hack.

Regards,

Tony
