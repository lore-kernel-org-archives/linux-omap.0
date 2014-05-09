From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Fri, 9 May 2014 07:37:49 -0700
Message-ID: <20140509143748.GB17814@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <20140508232006.GG2198@atomide.com>
 <536C8B70.1000306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53690 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755542AbaEIOh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 10:37:57 -0400
Content-Disposition: inline
In-Reply-To: <536C8B70.1000306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 01:02]:
> On 09/05/14 02:20, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [140429 16:53]:
> >> Otherwise we can get often errors like the following and the
> >> display won't come on:
> >>
> >> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> >> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
> >> the output with video overlays disabled
> >>
> >> There are some earlier references to this issue:
> >>
> >> http://www.spinics.net/lists/linux-omap/msg59511.html
> >> http://www.spinics.net/lists/linux-omap/msg59724.html
> >>
> >> It seems that it's safe to set the lower values even for 3630.
> >> If we can confirm that 3630 works with the higher values
> >> reliably we can add further detection.
> > 
> > BTW, I'm also seeing this warning on 3730-evm it may be related:
> > 
> > [    3.523101] ------------[ cut here ]------------
> > [    3.528015] WARNING: CPU: 0 PID: 6 at drivers/video/fbdev/omap2/dss/dss.c:483 dss_set_fck_rate+0x6c/0x8c()
> > [    3.538360] clk rate mismatch: 108000000 != 115200000
> > [    3.543518] Modules linked in:
> 
> Hmm... Can you paste the clk_summary from debugfs? Somehow the clock
> framework calculates the clock rate differently than the dss. Or do we
> have different clock.dts files used for 3730 and 3630?

OK pasted to the other email in this thread.

Tony
