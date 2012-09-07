From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] ARM: OMAP: Clean-up timer posted mode support
Date: Fri, 7 Sep 2012 15:22:24 -0700
Message-ID: <20120907222223.GQ1303@atomide.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
 <1346871872-24413-9-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32983 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751496Ab2IGWW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 18:22:28 -0400
Content-Disposition: inline
In-Reply-To: <1346871872-24413-9-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120905 12:05]:
> The dmtimer functions to read and write the dmtimer registers are currently
> defined as follows ...
> 
> static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
> 						int posted);
> static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
> 						u32 reg, u32 val, int posted);
> 
> The posted variable indicates if the timer is configured to use the posted mode
> when performing register accesses. The posted mode configuration of the dmtimer
> is stored in the omap_dm_timer structure that is also being passed to the above
> functions and therefore we do not need to pass the posted variable separately.
> Therefore, simplify the above functions by removing the posted variable as an
> argument as this is not necessary.

I believe the reason for passing the posted flag was to optimize out some
functions from the timer code as that's being run all the time.

Care to check the assembly before and after this patch for the timer
functions with objdump -d to make sure it does not add tons of bloat
there?

Thanks,

Tony
