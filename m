From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.11 merge window
Date: Wed, 10 Jul 2013 01:02:41 -0700
Message-ID: <20130710080241.GN5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63261 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3GJICr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 04:02:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit ddcf6600b133697adbafd96e080818bdc0dfd028:

  Merge tag 'hwmon-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2013-07-03 19:56:35 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/fixes-for-merge-window

for you to fetch changes up to c24a6ae18abde53b048372b066b93b71b1b91154:

  ARM: OMAP2+: omap2plus_defconfig: Enable appended DTB support (2013-07-04 05:11:57 -0700)

----------------------------------------------------------------
Omap fixes and minor defconfig updates that would be good to
get in before -rc1.

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: OMAP2+: timer: initialize before using oh_name

Eduardo Valentin (2):
      ARM: OMAP2+: omap2plus_defconfig: enable TI bandgap driver
      ARM: OMAP2+: omap2plus_defconfig: enable DRA752 thermal support by default

Enric Balletbo i Serra (1):
      ARM: OMAP3: igep0020: Set DSS pins in correct mux mode.

Joel Fernandes (1):
      ARM: OMAP2+: Enable TI_EDMA in omap2plus_defconfig

Nishanth Menon (2):
      ARM: OMAP4: sleep: build OMAP4 specific functions only for OMAP4
      ARM: scu: provide inline dummy functions when SCU is not present

Paul Bolle (1):
      ARM: OMAP2+: Remove obsolete Makefile line

Pavel Machek (1):
      ARM: OMAP2+: N900: enable N900-specific drivers even if device tree is enabled

Santosh Shilimkar (1):
      ARM: OMAP5: Enable Cortex A15 errata 798181

Thomas Meyer (1):
      ARM: OMAP2+: Cocci spatch "ptr_ret.spatch"

Tom Rini (1):
      ARM: OMAP2+: omap2plus_defconfig: Enable appended DTB support

Wei Yongjun (1):
      ARM: OMAP2+: devices: remove duplicated include from devices.c

 arch/arm/configs/omap2plus_defconfig   | 15 +++++++++++++++
 arch/arm/include/asm/smp_scu.h         | 13 ++++++++++++-
 arch/arm/mach-omap2/Kconfig            |  1 +
 arch/arm/mach-omap2/Makefile           |  4 ----
 arch/arm/mach-omap2/board-igep0020.c   | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51-video.c |  2 +-
 arch/arm/mach-omap2/devices.c          |  5 ++---
 arch/arm/mach-omap2/fb.c               |  5 +----
 arch/arm/mach-omap2/gpmc.c             |  2 +-
 arch/arm/mach-omap2/pmu.c              |  5 +----
 arch/arm/mach-omap2/sleep44xx.S        |  6 +++++-
 arch/arm/mach-omap2/timer.c            |  2 +-
 sound/soc/omap/rx51.c                  |  2 +-
 13 files changed, 72 insertions(+), 21 deletions(-)
