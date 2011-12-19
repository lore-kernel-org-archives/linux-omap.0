From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap prcm changes for v3.3 merge window
Date: Mon, 19 Dec 2011 12:00:46 -0800
Message-ID: <20111219200046.GS6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54168 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab1LSUAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 15:00:50 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap prcm changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap prcm

These changes adds support for PRCM (Power, Reset, Clock, Module)
chained interrupt handling. This will eventually allow us to start
making PM parts into driver modules and move them out of arch/arm.

These are also needed for the serial port runtime PM patches that
I'll post a pull request for after this.

Note that these have a slight dependency to the previously merged
omap4 branch so it would produce a minor merge conflict if based
on something earlier. However, the following uart branch has a
dependency to both omap4 branch and this branch, so I've based
this on omap4 branch also.

Regards,

Tony


The following changes since commit 4c89aad9f4803875f7065e825badc9ba61922091:
  Tony Lindgren (1):
        Merge branch 'for_3.3/pm/omap4-mpuss' of git://git.kernel.org/.../khilman/linux-omap-pm into omap4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap prcm

Govindraj R (1):
      ARM: OMAP2+: hwmod: Add API to enable IO ring wakeup

Paul Walmsley (2):
      ARM: OMAP2+: mux: add wakeup-capable hwmod mux entries to dynamic list
      ARM: OMAP3/4: PRM: add functions to read pending IRQs, PRM barrier

Rajendra Nayak (1):
      ARM: OMAP2+: hwmod: Add a new flag to handle hwmods left enabled at init

Tero Kristo (6):
      ARM: OMAP: PRCM: add support for chain interrupt handler
      ARM: OMAP: PRCM: add suspend prepare / finish support
      ARM: OMAP2+: mux: add support for PAD wakeup interrupts
      ARM: OMAP: hwmod: add support for selecting mpu_irq for each wakeup pad
      ARM: OMAP3: pm: use prcm chain handler
      ARM: OMAP4: PRM: use PRCM interrupt handler

Tony Lindgren (1):
      Merge branch 'tk_prm_chain_handler_devel_3.3' of git://git.pwsan.com/linux-2.6 into prcm

 arch/arm/mach-omap2/Makefile                 |    3 +-
 arch/arm/mach-omap2/mux.c                    |   89 +++++++-
 arch/arm/mach-omap2/omap_hwmod.c             |  125 ++++++++++-
 arch/arm/mach-omap2/pm34xx.c                 |  115 ++++------
 arch/arm/mach-omap2/prcm-common.h            |   75 ++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |   97 ++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    9 +-
 arch/arm/mach-omap2/prm44xx.c                |  116 ++++++++++
 arch/arm/mach-omap2/prm44xx.h                |    8 +-
 arch/arm/mach-omap2/prm_common.c             |  320 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +
 11 files changed, 884 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm_common.c
