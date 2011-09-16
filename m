From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP PM cleanup for v3.2
Date: Fri, 16 Sep 2011 09:50:18 -0700
Message-ID: <87y5xoqvn9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:48570 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753405Ab1IPQuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 12:50:25 -0400
Received: by mail-yx0-f170.google.com with SMTP id 13so3171201yxi.15
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 09:50:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull the following PM cleanups for v3.2

Kevin


The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://gitorious.org/khilman/linux-omap-pm.git for_3.2/pm-cleanup

Johan Hovold (2):
      OMAP2+: PM: fix typos in misc. comment and error messages
      OMAP2+: PM: clean up error messages: replace printk with pr_err.

Kevin Hilman (1):
      OMAP3: PM: fix UART handling when using no_console_suspend

Michael Jones (1):
      OMAP2: PM debug: remove leftover debug code

 arch/arm/mach-omap2/pm.c     |   22 ++++++++++------------
 arch/arm/mach-omap2/pm24xx.c |   27 ---------------------------
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 3 files changed, 11 insertions(+), 40 deletions(-)
