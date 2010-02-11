From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fix for 2.6.33-rc7
Date: Thu, 11 Feb 2010 14:26:07 -0800
Message-ID: <20100211222607.GL21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58921 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab0BKWZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 17:25:29 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Linus,

Please pull one omap fix from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 80e1e823989ec44d8e35bdfddadbddcffec90424:
  Linus Torvalds (1):
        Fix race in tty_fasync() properly

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Aaro Koskinen (1):
      OMAP: hsmmc: fix memory leak

 arch/arm/mach-omap2/mmc-twl4030.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)
