From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2/3: Change omapfb to use clkdev for
	dispc and rfbi
Date: Sat, 16 May 2009 08:25:43 -0700
Message-ID: <20090516152543.GK19742@atomide.com>
References: <20090514174100.12080.9736.stgit@localhost> <20090514174959.12080.64417.stgit@localhost> <20090514210312.9fa02bb3.krzysztof.h1@poczta.fm> <20090514202805.GQ5593@atomide.com> <20090516090621.GC15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57424 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbZEPPZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 11:25:59 -0400
Content-Disposition: inline
In-Reply-To: <20090516090621.GC15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090516 02:06]:
> On Thu, May 14, 2009 at 01:28:06PM -0700, Tony Lindgren wrote:
> > commit 27db33cfadd3c47c9499def6e71aaf5d2fd51e60
> > Author: Tony Lindgren <tony@atomide.com>
> > Date:   Tue May 12 11:20:03 2009 -0700
> > 
> >     ARM: OMAP2/3: Change omapfb to use clkdev for dispc and rfbi, v2
> >     
> >     This makes the framebuffer work on omap3.
> >     
> >     Also fix the clk_get usage for checkpatch.pl
> >     "ERROR: do not use assignment in if condition".
> >     
> >     Cc: Imre Deak <imre.deak@nokia.com>
> >     Cc: linux-fbdev-devel@lists.sourceforge.net
> >     Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> >     Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This isn't a bug fix - the current code works, although checkpatch will
> complain about the assignment in the if condition.
> 
> The rest of the patch is just a conversion from the old way of doing
> things to the new way, and I don't think is -rc material.

The code does not work for omap3 without this patch because of the
different clock names. It only works for 24xx. And because of the
different source clocks, it's pointless trying to fix it in any
other way for -rc series.

Dropping anyways from the omap-fixes series, we can wait a bit
longer.

Tony
