From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.9-rc4
Date: Wed, 27 Mar 2013 11:44:04 -0700
Message-ID: <20130327184404.GD10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64466 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab3C0SoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 14:44:11 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9-rc3/fixes-signed

for you to fetch changes up to ff931c821bab6713a52b768b0cd7ee7e90713b36:

  ARM: OMAP: clocks: Delay clk inits atleast until slab is initialized (2013-03-26 22:06:20 -0700)

----------------------------------------------------------------
A clock regression fix that happened with the common clock
conversion, and few USB regression fixes.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: fix USB host on 1710

Grazvydas Ignotas (1):
      ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby for musb

Jon Hunter (1):
      ARM: OMAP4: clock data: lock USB DPLL on boot

Paul Walmsley (1):
      ARM: OMAP4: PM: fix PM regression introduced by recent clock cleanup

Rajendra Nayak (1):
      ARM: OMAP: clocks: Delay clk inits atleast until slab is initialized

Tony Lindgren (1):
      Merge tag 'omap-fixes-a-for-3.9-rc' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9-rc3/fixes

 arch/arm/mach-omap1/clock_data.c           | 12 +-----------
 arch/arm/mach-omap2/cclock44xx_data.c      | 20 ++++++++++++++++++++
 arch/arm/mach-omap2/common.h               |  3 +++
 arch/arm/mach-omap2/io.c                   | 18 ++++++++++++------
 arch/arm/mach-omap2/omap_hwmod.c           |  7 +++++--
 arch/arm/mach-omap2/omap_hwmod.h           |  9 +++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  6 ++++++
 arch/arm/mach-omap2/timer.c                |  4 ++++
 9 files changed, 64 insertions(+), 22 deletions(-)
