From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 5/7] omap sparse irq and local hardware.h cleanup
 for v3.7 merge window
Date: Fri, 14 Sep 2012 10:55:33 -0700
Message-ID: <20120914175533.GG4521@atomide.com>
References: <pull-1347590052-683636>
 <E1TCLkq-0006f8-Qp@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16214 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759724Ab2INRzi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 13:55:38 -0400
Content-Disposition: inline
In-Reply-To: <E1TCLkq-0006f8-Qp@merlin.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120914 08:28]:
> The following changes since commit a1e01703bacbadd22eb4aaca0bbba59bcba7d3b3:
> 
>   Merge tags 'omap-devel-gpmc-fixed-for-v3.7' and 'cleanup-omap-tags-for-v3.7' into cleanup-sparseirq (2012-09-12 18:05:19 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-sparseirq-for-v3.7
> 
> for you to fetch changes up to 68cb700c59fae6cd539c9dc1e9f2584f671935a0:
> 
>   ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)
> 
> ----------------------------------------------------------------
> This branch contains changes needed to make omap2+
> work properly with sparse IRQ. It also removes
> dependencies to mach/hardware.h. These help moving
> things towards ARM single zImage support.
> 
> This branch is based on a commit in tty-next
> branch with omap-devel-gpmc-fixed-for-v3.7 and
> cleanup-omap-tags-for-v3.7 merged in to keep things
> compiling and sort out some merge conflicts.

This will need some manual merging with what's in
testing/platform-data, so please let me know if
you need help with that. But basically it's mostly:

remove #include <plat/board.h> for both mach-omap1 & mach-omap2
remove #include <mach/hardware.h> for mach-omap2
remove #include <mach/irqs.h> for mach-omap2

Regards,

Tony
