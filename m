From: Suman Anna <s-anna@ti.com>
Subject: [GIT PULL] move omap mailbox to drivers for v3.11
Date: Wed, 12 Jun 2013 16:58:26 -0500
Message-ID: <1371074306-57583-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52562 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779Ab3FLWD7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 18:03:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git@github.com:sumananna/mailbox.git tags/omap-mailbox-for-v3.11

for you to fetch changes up to c869c75c16b3d1ffcf64fb2fd63ba0c4a369071c:

  mailbox/omap: move the OMAP mailbox framework to drivers (2013-06-11 11:41:51 -0500)

----------------------------------------------------------------
Move OMAP Mailbox framework to drivers

The OMAP Mailbox driver framework is moved out of arch/arm folder
into drivers/mailbox folder, to re-enable building it and also serve
as a baseline for adapting to the new mailbox driver framework. The
changes mainly contain:
  - a minor bug fix and cleanup of mach-specific mailbox code
  - remove any header dependencies from plat-omap for multi-platform
    support
  - represent mailbox device data through platform data/hwmod attrs
  - move the omap mailbox code out of plat-omap/mach-omapX to
    drivers/mailbox folder.

----------------------------------------------------------------
Suman Anna (6):
      omap: mailbox: check iomem resource before dereferencing it
      omap: mailbox: call request_irq after mbox queues are allocated
      omap: mailbox: correct the argument type for irq ops
      ARM: OMAP2+: mbox: remove dependencies with soc.h
      ARM: OMAP2+: add user and fifo info to mailbox platform data
      mailbox/omap: move the OMAP mailbox framework to drivers

 arch/arm/configs/omap1_defconfig                   |   3 +-
 arch/arm/mach-omap1/Makefile                       |   4 -
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/devices.c                      |  13 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  13 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  13 +
 arch/arm/plat-omap/Kconfig                         |  16 --
 arch/arm/plat-omap/Makefile                        |   3 -
 drivers/mailbox/Kconfig                            |  34 +++
 drivers/mailbox/Makefile                           |   6 +
 .../mailbox.c => drivers/mailbox/mailbox-omap1.c   |  12 +-
 .../mailbox.c => drivers/mailbox/mailbox-omap2.c   | 276 ++++++++-------------
 .../mailbox.c => drivers/mailbox/omap-mailbox.c    |  54 +++-
 .../plat/mailbox.h => drivers/mailbox/omap-mbox.h  |  70 ++----
 drivers/remoteproc/Kconfig                         |   3 +-
 drivers/remoteproc/omap_remoteproc.c               |   2 +-
 drivers/staging/tidspbridge/Kconfig                |   3 +-
 .../tidspbridge/include/dspbridge/host_os.h        |   2 +-
 include/linux/omap-mailbox.h                       |  29 +++
 include/linux/platform_data/mailbox-omap.h         |  58 +++++
 21 files changed, 355 insertions(+), 276 deletions(-)
 rename arch/arm/mach-omap1/mailbox.c => drivers/mailbox/mailbox-omap1.c (94%)
 rename arch/arm/mach-omap2/mailbox.c => drivers/mailbox/mailbox-omap2.c (59%)
 rename arch/arm/plat-omap/mailbox.c => drivers/mailbox/omap-mailbox.c (92%)
 rename arch/arm/plat-omap/include/plat/mailbox.h => drivers/mailbox/omap-mbox.h (54%)
 create mode 100644 include/linux/omap-mailbox.h
 create mode 100644 include/linux/platform_data/mailbox-omap.h
