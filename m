From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2: Make OMAP2PLUS select OMAP_DM_TIMER
Date: Fri, 24 Dec 2010 09:39:13 -0800
Message-ID: <20101224173912.GV7771@atomide.com>
References: <1293158889-9708-1-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26796 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab0LXRjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Dec 2010 12:39:18 -0500
Content-Disposition: inline
In-Reply-To: <1293158889-9708-1-git-send-email-bgamari.foss@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ben Gamari <bgamari.foss@gmail.com> [101223 18:48]:
> It appears that arch/arm/mach-omap2/timer-gp.o is needed by OMAP2PLUS.
> Since timer-gp.o has direct dependencies on omap_dm_timer_*, it seems
> correct for the architecture to depend upon OMAP_DM_TIMER, otherwise
> unsuspecting integrators will be faced with a whole bunch of linker
> errors at the end of their kernel build:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap2_gp_timer_set_mode':
> /home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:84: undefined reference to `omap_dm_timer_stop'
> /home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:88: undefined reference to `omap_dm_timer_get_fclk'
> /home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:90: undefined reference to `omap_dm_timer_set_load_start'
> ...

One more thing.. Can you please reply with your
Signed-off-by: line so this can be applied?

Thanks

Tony
