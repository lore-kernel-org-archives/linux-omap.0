From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] omap SoC related late changes for v3.9 merge window
Date: Tue, 12 Feb 2013 10:11:01 -0800
Message-ID: <42288.5107495405$1360692696@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18665 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933332Ab3BLSLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 13:11:07 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/soc-signed

for you to fetch changes up to 5af044f472501c8e9bd6bb274fb3d71d07a038cd:

  ARM: OMAP2: AM33XX: id: Add support for AM335x PG2.0 (2013-02-01 14:53:39 -0800)

----------------------------------------------------------------
am33xx specific updates for restart and revision detection.
Also get rid of OMAP_32K_TIMER_HZ as that no longer is needed.

----------------------------------------------------------------
AnilKumar Ch (1):
      ARM: OMAP2: AM33XX: id: Add support for AM335x PG2.0

Jean-Sebastien A. Beaudry (1):
      ARM: OMAP2+: AM33xx: Add SoC specific restart hook

Santosh Shilimkar (1):
      ARM: OMAP2+: Get rid of custom OMAP_32K_TIMER_HZ

 arch/arm/Kconfig                        |  1 -
 arch/arm/mach-omap2/Makefile            |  1 +
 arch/arm/mach-omap2/am33xx-restart.c    | 34 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c     |  1 +
 arch/arm/mach-omap2/common.h            |  8 ++++++++
 arch/arm/mach-omap2/id.c                | 14 ++++++++++++--
 arch/arm/mach-omap2/soc.h               |  1 +
 arch/arm/plat-omap/Kconfig              |  9 ---------
 arch/arm/plat-omap/include/plat/timex.h |  8 --------
 9 files changed, 57 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-omap2/am33xx-restart.c
