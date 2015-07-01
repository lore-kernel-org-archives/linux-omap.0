From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] remoteproc for 4.2
Date: Wed, 1 Jul 2015 17:14:48 +0300
Message-ID: <CAK=Wgba9Jst3xJ_EQf+zenZSqedzhvSw8ZVMZ_YmsQM70mMbPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Anna, Suman" <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-4.2

for you to fetch changes up to 8de3dbd0895bebe52d069a82feae8e3fb51c1bdf:

  remoteproc: fix !CONFIG_OF build breakage (2015-06-18 11:44:41 +0300)

----------------------------------------------------------------
- remoteproc fixes/cleanups from Suman Anna
- new remoteproc TI Wakeup M3 driver from Dave Gerlach
- remoteproc core support for TI's Wakeup M3 driver from both Dave and Suman
- tiny remoteproc build fix from myself

----------------------------------------------------------------
Dave Gerlach (3):
      remoteproc: introduce rproc_get_by_phandle API
      Documentation: dt: add bindings for TI Wakeup M3 processor
      remoteproc/wkup_m3: add a remoteproc driver for TI Wakeup M3

Ohad Ben-Cohen (1):
      remoteproc: fix !CONFIG_OF build breakage

Suman Anna (4):
      remoteproc/ste: add blank lines after declarations
      remoteproc/davinci: fix quoted split string checkpatch warning
      remoteproc: fix various checkpatch warnings
      remoteproc: add a rproc ops for performing address translation

 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt |  52
++++++++++++++++++++++
 Documentation/remoteproc.txt                                   |   6 +++
 drivers/remoteproc/Kconfig                                     |  13 ++++++
 drivers/remoteproc/Makefile                                    |   1 +
 drivers/remoteproc/da8xx_remoteproc.c                          |   3 +-
 drivers/remoteproc/remoteproc_core.c                           | 115
+++++++++++++++++++++++++++++++++++++----------
 drivers/remoteproc/remoteproc_internal.h                       |   2 +-
 drivers/remoteproc/ste_modem_rproc.c                           |   4 +-
 drivers/remoteproc/wkup_m3_rproc.c                             | 257
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/wkup_m3.h                          |  30
+++++++++++++
 include/linux/remoteproc.h                                     |   9 ++--
 11 files changed, 460 insertions(+), 32 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
 create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
 create mode 100644 include/linux/platform_data/wkup_m3.h
