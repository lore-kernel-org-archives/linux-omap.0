From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC] pwm: omap: Add PWM support using dual-mode timers
Date: Tue, 29 Oct 2013 14:23:18 -0700
Message-ID: <20131029212318.GI15154@atomide.com>
References: <20131024173620.0cbbefcf@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31706 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751044Ab3J2VXX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 17:23:23 -0400
Content-Disposition: inline
In-Reply-To: <20131024173620.0cbbefcf@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org

* NeilBrown <neilb@suse.de> [131023 23:36]:
> 
> I submitted this in December last year.  I got lots of good feedback
> and fixed some things, but it never got accepted.  Not entirely sure
> why, maybe I dropped the ball.
> 
> Anyway, here is again with device-tree support added.
> 
> This is only an RFC and not a real submission for two reasons, both of which
> are really directed as Jon.
> 
> 1/ I have to 
> 
> #include <../arch/arm/plat-omap/include/plat/dmtimer.h>
> 
> which is incredibly ugly.
> Is there any reason this cannot be moved to include/linux/omap-dmtimer.h?

Yes that's what at least dw_apb_timer and sh_timer are doing.
 
> 2/ I found that I need to call
> 
> 	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);
> 
>  when using device-tree.  This is because with devicetree
>  omap_timer_restore_context() is called much more often and it sets the counter
>  register to 0 .. it takes a long time to count up to DM_TIMER_LOAD_MIN from there.
> 
>  Now I don't object to calling omap_dm_timer_write_counter (though it might be nice if
>  omap_dm_timer_set_load wrote the one value to both LOAD_REG and COUNTER_REG).
>  However it seems wrong that I have to call it *after* starting the counter.
>  Currently _write_counter refuses to run if the timer hasn't been started.
> 
>  So Jon: 
>    a/ can we change omap_dm_timer_write_counter to work when the timer isn't
>       running?
>    b/ can we have omap_dm_timer_set_load also set the counter?
> 
> 
> For anyone else generous enough to read my code: is this otherwise acceptable?

Did not look beyond the dmtimer stuff, but let's start by moving dmtimer.c to
live under drivers and move the header, then do the pwm patches.

If there's a bug with the omap_dm_timer_set_load(), then naturally that
should be done separately as a fix before anything.

Regards,

Tony
