From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 00/12] ARM: OMAP5: hwmod, prm/cm data files and updates for 3.10
Date: Thu, 4 Apr 2013 15:50:47 +0530
Message-ID: <1365070859-21790-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55938 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758078Ab3DDKTD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 06:19:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Pual,

Here is the series which updates the minor updates you suggested.
As aligned on list with Tony, I have dropped clock data from the
series. That means for the boot, one clock data patch needs to be applied.
It is available on my git tree in 'out_of_tree/omap5_clk_data' branch.

Alsot, you will notice hwmod data loc has come down from ~6000 lines to
~2000 lines because of removal of iospace, irq, dma data as well as
unused hwmods. Few hwmods for which dt conversion is pending are
not added as well but those would add max ~400 loc in future.

Series has been tested boot on OMAP4 and OMAP5 devices and compile
tested for all the OMAP2/3/4/5 specific configs. For OMAP5 testing,
I have to pull in Tony's arm-soc pull requests, benoit's dt branch
and hence ended up creating a 'testing/3.10/omap5_int_rebuild' branch.

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap5_data_files_v2

for you to fetch changes up to f97c560324a0e3c0607d57089930493db6ad7435:

  ARM: OMAP5: Enable build and frameowrk initialisations (2013-04-04 14:00:52 +0530)

----------------------------------------------------------------

Benoit Cousson (7):
  ARM: OMAP5: PRM: Add OMAP54XX register and bitfield files
  ARM: OMAP5: CM: Add OMAP54XX register and bitfield files
  ARM: OMAP5: PRCM: Add OMAP54XX local MPU PRCM registers
  ARM: OMAP5: SCRM: Add OMAP54XX header file.
  ARM: OMAP5: clockdomain data: Add OMAP54XX data and update the header
  ARM: OMAP5: powerdomain data: Add OMAP54XX data and update the header
  ARM: OMAP5: hwmod data: Create initial OMAP5 SOC hwmod data

Santosh Shilimkar (5):
  ARM: OMAP4+: PRM: Move function prototypes to common header for
    re-use
  ARM: OMAP4+: CM: Move function prototypes to common header for re-use
  ARM: OMAP4+: PRCM MPU: Move function prototypes to common header for
    re-use
  ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data
  ARM: OMAP5: Enable build and frameowrk initialisations

 arch/arm/mach-omap2/Makefile                  |    4 +
 arch/arm/mach-omap2/clockdomain.h             |    1 +
 arch/arm/mach-omap2/clockdomains54xx_data.c   |  464 +++++
 arch/arm/mach-omap2/cm-regbits-54xx.h         | 1737 ++++++++++++++++
 arch/arm/mach-omap2/cm1_44xx.h                |    7 +-
 arch/arm/mach-omap2/cm1_54xx.h                |  218 ++
 arch/arm/mach-omap2/cm2_44xx.h                |    7 +-
 arch/arm/mach-omap2/cm2_54xx.h                |  394 ++++
 arch/arm/mach-omap2/cm_44xx_54xx.h            |   36 +
 arch/arm/mach-omap2/io.c                      |    7 +
 arch/arm/mach-omap2/omap_hwmod.h              |    1 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    | 2151 ++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |    1 +
 arch/arm/mach-omap2/powerdomains54xx_data.c   |  331 +++
 arch/arm/mach-omap2/prcm44xx.h                |    6 +
 arch/arm/mach-omap2/prcm_mpu44xx.h            |   14 +-
 arch/arm/mach-omap2/prcm_mpu54xx.h            |   87 +
 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h      |   36 +
 arch/arm/mach-omap2/prm-regbits-54xx.h        | 2701 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h                 |   33 +-
 arch/arm/mach-omap2/prm44xx_54xx.h            |   58 +
 arch/arm/mach-omap2/prm54xx.h                 |  421 ++++
 arch/arm/mach-omap2/scrm54xx.h                |  231 +++
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains54xx_data.c |  102 +
 25 files changed, 8994 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_54xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_54xx.h
 create mode 100644 arch/arm/mach-omap2/cm_44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_54xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu54xx.h
 create mode 100644 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/prm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/prm44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/prm54xx.h
 create mode 100644 arch/arm/mach-omap2/scrm54xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains54xx_data.c

-- 
1.7.9.5

