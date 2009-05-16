From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2/3: Change omapfb to use clkdev for
	dispc and rfbi
Date: Sat, 16 May 2009 11:02:44 -0700
Message-ID: <20090516180243.GN19742@atomide.com>
References: <20090514174100.12080.9736.stgit@localhost> <20090514174959.12080.64417.stgit@localhost> <20090514210312.9fa02bb3.krzysztof.h1@poczta.fm> <20090514202805.GQ5593@atomide.com> <20090516090621.GC15328@n2100.arm.linux.org.uk> <20090516152543.GK19742@atomide.com> <20090516162228.GA25657@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52370 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757174AbZEPSC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 14:02:59 -0400
Content-Disposition: inline
In-Reply-To: <20090516162228.GA25657@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090516 09:22]:
> On Sat, May 16, 2009 at 08:25:43AM -0700, Tony Lindgren wrote:
> > The code does not work for omap3 without this patch because of the
> > different clock names. It only works for 24xx. And because of the
> > different source clocks, it's pointless trying to fix it in any
> > other way for -rc series.
> 
> If that's the case, leave it in please.

OK, thanks. I'll add it back and send an updated pull request too.

Regards,

Tony
