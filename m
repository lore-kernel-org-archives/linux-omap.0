From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC] pwm: omap: Add PWM support using dual-mode timers
Date: Fri, 13 Dec 2013 09:41:49 -0800
Message-ID: <20131213174149.GH28184@atomide.com>
References: <20131024173620.0cbbefcf@notabene.brown>
 <20131029212318.GI15154@atomide.com>
 <20131212125929.GL11524@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131212125929.GL11524@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Thierry Reding <thierry.reding@gmail.com> [131212 05:02]:
> On Tue, Oct 29, 2013 at 02:23:18PM -0700, Tony Lindgren wrote:
> > * NeilBrown <neilb@suse.de> [131023 23:36]:
> > > 
> > > I submitted this in December last year.  I got lots of good feedback
> > > and fixed some things, but it never got accepted.  Not entirely sure
> > > why, maybe I dropped the ball.
> > > 
> > > Anyway, here is again with device-tree support added.
> > > 
> > > This is only an RFC and not a real submission for two reasons, both of which
> > > are really directed as Jon.
> > > 
> > > 1/ I have to 
> > > 
> > > #include <../arch/arm/plat-omap/include/plat/dmtimer.h>
> > > 
> > > which is incredibly ugly.
> > > Is there any reason this cannot be moved to include/linux/omap-dmtimer.h?
> > 
> > Yes that's what at least dw_apb_timer and sh_timer are doing.
> >  
> > > 2/ I found that I need to call
> > > 
> > > 	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);
> > > 
> > >  when using device-tree.  This is because with devicetree
> > >  omap_timer_restore_context() is called much more often and it sets the counter
> > >  register to 0 .. it takes a long time to count up to DM_TIMER_LOAD_MIN from there.
> > > 
> > >  Now I don't object to calling omap_dm_timer_write_counter (though it might be nice if
> > >  omap_dm_timer_set_load wrote the one value to both LOAD_REG and COUNTER_REG).
> > >  However it seems wrong that I have to call it *after* starting the counter.
> > >  Currently _write_counter refuses to run if the timer hasn't been started.
> > > 
> > >  So Jon: 
> > >    a/ can we change omap_dm_timer_write_counter to work when the timer isn't
> > >       running?
> > >    b/ can we have omap_dm_timer_set_load also set the counter?
> > > 
> > > 
> > > For anyone else generous enough to read my code: is this otherwise acceptable?
> > 
> > Did not look beyond the dmtimer stuff, but let's start by moving dmtimer.c to
> > live under drivers and move the header, then do the pwm patches.
> 
> Why does the driver have to move? There is certainly some precedent for
> having arch-specific code in arch/ but expose the public API via some
> header in include/linux. Sometimes there's just no proper place for the
> driver elsewhere, so rather than moving it somewhere more or less random
> keeping it in arch/arm/plat-omap is just as good.

There's actually been some developments regarding the dmtimer usage after
these comments, see below.

Basically we don't want to export custom functions as we've seen what kind
of mess exporting custom interfaces makes. See the current state of omap
DMA for example.

We've figured out a way to access the timers by doing a request_irq()
on a timer, then do a clk_set_rate() to select the timer source clock.

And then we need only about five custom functions to program the timer,
which can be eventually replaced with some Linux generic hardware timer
framework.

For more info, see the discussion in thread "[PATCH 6/8] devicetree: doc:
Document ti,timer-parent property".

Regards,

Tony
