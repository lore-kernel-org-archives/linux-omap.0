From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP4 coupled CPUidle support for v3.6
Date: Thu, 26 Jul 2012 14:37:47 -0700
Message-ID: <87394enqz8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34361 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752288Ab2GZVhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 17:37:48 -0400
Received: by pbcwz7 with SMTP id wz7so4002301pbc.2
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 14:37:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, ccross@android.com, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Arnd, Olof,

I know it is late, but I'm really hoping this can still make it for
v3.6, so consider this a [GIT PLEA].  ;)

OMAP4 coupled CPUidle support has been well tested and was ready for the
v3.5 merge window, but there were some complaints from Linus in the pull
request from Len (unrelated to CPUidle) that caused the core support to
be left out of v3.5, so I didn't submit the OMAP stuff either.

Since then, there has been some confusion about maintainership of core
CPUidle code, including an additional cpuidle-next tree from Linaro
leading to confusion/delay about how/where to merge the OMAP support.

All of that is sorted out now, and Len has just sent his pull request[1]
to Linus including the core CPUidle changes to support coupled CPUidle,
so the path is now paved for the OMAP support.

Also, in mainline, CPUidle doesn't properly work on OMAP4 without
coupled states support, so there should be no concern about breaking
existing OMAP4 CPUidle support.

So, with all of that background and excuses,  could you please pull this
into one of your late branches (or maybe a new arm-soc/late/pm branch) ?

Thanks,

Kevin

[1] https://lkml.org/lkml/2012/7/26/6


The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/pm/coupled-cpuidle

for you to fetch changes up to b93d70aeb8f3b5ed2d74643f5009239a55634e1d:

  ARM: OMAP4: CPUidle: Open broadcast clock-event device. (2012-07-25 16:06:08 -0700)

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: OMAP4: CPUidle: add synchronization for coupled idle states

Santosh Shilimkar (3):
      ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
      ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.
      ARM: OMAP4: CPUidle: Open broadcast clock-event device.

 arch/arm/mach-omap2/Kconfig       |    1 +
 arch/arm/mach-omap2/cpuidle44xx.c |  141 +++++++++++++++++++++++++------------
 arch/arm/mach-omap2/timer.c       |    4 +-
 3 files changed, 101 insertions(+), 45 deletions(-)
