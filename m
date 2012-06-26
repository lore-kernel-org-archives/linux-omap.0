From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP PM: move SmartReflex driver to drivers/avs
Date: Tue, 26 Jun 2012 07:38:55 -0500
Message-ID: <87zk7qdz8g.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:53856 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755417Ab2FZMiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 08:38:50 -0400
Received: by ghbf1 with SMTP id f1so3710981ghb.9
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 05:38:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>

Tony,

Please pull this series that move the SmartReflex driver out to
drivers/avs.  The series includes some minimal cleanups necessary to
cleanly do the move.

The drivers/* change has been Acked by Rafael and we agreed to merge it
through the OMAP tree because of all the arch/arm/mach-omap2 changes
in this series.

Kevin


The following changes since commit cdd3a354a05b0c33fe33ab11a0fb0838396cad19:

  Merge tag 'pm' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-05-22 09:41:01 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/pm/sr-move

for you to fetch changes up to 21ff63ad131218048525fbd37d065ce61f03bcbd:

  ARM: OMAP: SmartReflex: Move smartreflex driver to drivers/ (2012-05-31 16:36:30 -0700)

----------------------------------------------------------------
J Keerthy (1):
      ARM: OMAP2+: Voltage: Move the omap_volt_data structure to plat

Jean Pihet (9):
      ARM: OMAP2+: SmartReflex: move the smartreflex header to include/linux/power
      ARM: OMAP3+: SmartReflex: class drivers should use struct omap_sr *
      ARM: OMAP2+: smartreflex: Use the names from hwmod data instead of voltage domains.
      ARM: OMAP3: hwmod: rename the smartreflex entries
      ARM: OMAP2+: SmartReflex: introduce a busy loop condition test macro
      ARM: OMAP2+: SmartReflex: Use per-OPP data structure
      ARM: OMAP2+: SmartReflex: Create per-opp debugfs node for errminlimit
      ARM: OMAP2+: SmartReflex: add POWER_AVS Kconfig options
      ARM: OMAP: SmartReflex: Move smartreflex driver to drivers/

 arch/arm/mach-omap2/Makefile                       |    5 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   12 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    3 +-
 arch/arm/mach-omap2/pm.h                           |    2 +-
 arch/arm/mach-omap2/smartreflex-class3.c           |   29 ++--
 arch/arm/mach-omap2/sr_device.c                    |   39 ++++-
 arch/arm/mach-omap2/voltage.h                      |   21 +--
 arch/arm/plat-omap/Kconfig                         |   31 ++--
 arch/arm/plat-omap/include/plat/voltage.h          |   21 ++-
 drivers/power/Kconfig                              |    2 +
 drivers/power/Makefile                             |    1 +
 drivers/power/avs/Kconfig                          |   12 ++
 drivers/power/avs/Makefile                         |    1 +
 .../mach-omap2 => drivers/power/avs}/smartreflex.c |  161 ++++++++------------
 .../linux/power}/smartreflex.h                     |   74 +++++++--
 15 files changed, 235 insertions(+), 179 deletions(-)
 create mode 100644 drivers/power/avs/Kconfig
 create mode 100644 drivers/power/avs/Makefile
 rename {arch/arm/mach-omap2 => drivers/power/avs}/smartreflex.c (90%)
 rename {arch/arm/mach-omap2 => include/linux/power}/smartreflex.h (79%)
