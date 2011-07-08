From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fix for v3.0
Date: Fri, 8 Jul 2011 04:52:49 -0700
Message-ID: <20110708115249.GZ5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54341 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752189Ab1GHLwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 07:52:53 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Linus,

Please pull one fix from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

This fixes an embarassing segfault by dropping __initdata from data that
should not be marked __initdata.

Regards,

Tony


The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
  Linus Torvalds (1):
        Linux 3.0-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Janusz Krzysztofik (1):
      omap: drop __initdata tags from static struct platform_device declarations

 arch/arm/mach-omap1/board-ams-delta.c        |    8 ++++----
 arch/arm/mach-omap1/gpio15xx.c               |    4 ++--
 arch/arm/mach-omap1/gpio16xx.c               |   10 +++++-----
 arch/arm/mach-omap1/gpio7xx.c                |   14 +++++++-------
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)
