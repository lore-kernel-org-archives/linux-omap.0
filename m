From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/10] omap2+: Use dmtimer macros for clockevent
Date: Mon, 27 Jun 2011 00:39:24 -0700
Message-ID: <20110627073923.GC23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092339.357.10396.stgit@kaulin> <87r56ka341.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87r56ka341.fsf@ti.com>
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

* Kevin Hilman <khilman@ti.com> [110623 10:02]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > This patch makes timer-gp.c to use only a subset of dmtimer
> > functions without the need to initialize dmtimer code early.
> >
> > Also note that now with the inline functions, timer_set_next_event
> > becomes more efficient in the lines of assembly code.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> 
> In order for this to work, *all* the dmtimer functions need to be
> converted.  Some still call the real driver, which may not yet be
> initialized (as pointed out for [7/10]...

Well omap_dm_timer_init_one is a static omap2plus specific
implementation that can then be then passed as a function pointer
to the dmtimer device driver in later patches.
 
> >  	gptimer = omap_dm_timer_request_specific(gptimer_id);
> 
> Here remains a call to the real driver, which is not yet initialized
> when called from sys_timer.init.

There's no need for omap_dm_timer_request_specific after the later
patches. It gets removed in the PM_DEBUG sysfs interface removal patch.

Tony
