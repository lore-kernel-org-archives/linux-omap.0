From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] omap clean-up for v4.2
Date: Fri, 22 May 2015 16:38:47 +0200
Message-ID: <2834055.EyDA6uXtOP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59884 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809AbbEVOjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 10:39:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 20 May 2015 15:36:04 Tony Lindgren wrote:
> Clean-up for omaps for v4.2 merge window:
> 
> Drop more omap3 legacy board-*.c files for v4.2. This time we're
> dropping the board files for beagle, overo and cm-t35.
> 
> The reason for dropping these now rather than later is that now
> we can simply revert the patches in case of unexpected issues as
> we are not dropping any platform data at this point.
> 
> This leaves us with only the following board-*.c files:
> 
> BOARD                   REASON NEEDED
> board-ldp.c             Still used in RMKs boot test system
> board-omap3logic.c      Getting a .dts file for v4.2
> board-omap3pandora.c    Got a .dts file for v4.1
> board-rx51-*.c          Needs /proc/atags support for user space
> 
> I'm hoping we can drop the remaining board-*.c for v4.3 merge
> window, then keep the platform data around for one more merge
> window in case of reverting needed, then drop the platform data
> too for v4.4 if no issues needing reverting are found.

Sounds good. 

Pulled into next/cleanup, thanks!

	Arnd
