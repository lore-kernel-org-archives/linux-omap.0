From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot
 in DT only mode
Date: Mon, 25 Nov 2013 17:28:52 -0800
Message-ID: <20131126012851.GC26766@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <20131126010922.GA21580@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15923 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab3KZB2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 20:28:54 -0500
Content-Disposition: inline
In-Reply-To: <20131126010922.GA21580@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [131125 17:10]:
> On Mon, Nov 25, 2013 at 04:14:15PM -0800, Tony Lindgren wrote:
> > 
> > We can finally make mach-omap2 to boot in device tree only mode for v3.14.
...
> > 
> > Tony Lindgren (12):
> >   ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
> >     DT only for booting
> 
> looks like this patch didn't make it to the list, maybe it's too large ?

Yeah looks like patches 1 and 11 were too bloated. I just posted dietx
versions of those as a reply to this thread that don't yet remove the
legacy board-*.c files and mux*.c files.

Regards,

Tony
