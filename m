From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Remaining omap fixes for 2.6.37-r7
Date: Mon, 7 Mar 2011 10:47:33 -0800
Message-ID: <20110307184733.GA23877@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

This contains the remaining PM related fixes that were missing from the
last pull request and one new fix for a mailbox hang.

Regards,

Tony


The following changes since commit dd9c1549edef02290edced639f67b54a25abbe0e:

  Linux 2.6.38-rc7 (2011-03-01 13:55:12 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Aaro Koskinen (1):
      arm: mach-omap2: smartreflex: fix another memory leak

Hari Kanigeri (1):
      omap: mailbox: resolve hang issue

Shweta Gulati (1):
      OMAP2+: PM: SmartReflex: fix memory leaks in Smartreflex driver

Tony Lindgren (1):
      Merge branch 'for_2.6.38/pm-fixes' of ssh://master.kernel.org/.../khilman/linux-omap-pm into devel-fixes

 arch/arm/mach-omap2/mailbox.c     |   10 ++++++----
 arch/arm/mach-omap2/smartreflex.c |   33 +++++++++++++++------------------
 2 files changed, 21 insertions(+), 22 deletions(-)
