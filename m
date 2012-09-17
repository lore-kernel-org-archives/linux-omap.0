From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 5/7] omap sparse irq and local hardware.h cleanup for
 v3.7 merge window
Date: Sun, 16 Sep 2012 20:06:02 -0700
Message-ID: <20120917030602.GA13322@quad.lixom.net>
References: <pull-1347589125-283636>
 <E1TCLVP-0003Cd-Vy@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37811 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab2IQDGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Sep 2012 23:06:07 -0400
Received: by pbbrr13 with SMTP id rr13so8351207pbb.19
        for <linux-omap@vger.kernel.org>; Sun, 16 Sep 2012 20:06:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1TCLVP-0003Cd-Vy@merlin.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 13, 2012 at 07:18:44PM -0700, Tony Lindgren wrote:
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
> 

Pulled into next/cleanup with the tty.git dependency as described.


Thanks!

-Olof

