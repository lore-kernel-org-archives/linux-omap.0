From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 00/14] ARM: OMAP5: hwmod, prm/cm data files and updates for 3.11
Date: Wed, 29 May 2013 12:38:00 -0400
Message-ID: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38750 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758214Ab3E2QjJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 May 2013 12:39:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony, Paul,

Here is another attempt to send the SOC data files for OMAP5 based devices.
As aligned on list, I have dropped clock data from the series.
That means for the boot, one clock data patch needs to be applied.
It is available on my git tree in 'out_of_tree/omap5_clk_data' branch.

With OMAP5 and AM33XX support is DT only, respective hwmod files are cleaned
up to remove iospace information and un-used hwmod. For 3.11 since OMAP4
is also targeted as DT only, its hwmod data files is also cleaned up.
Diffstat looks something like below.

27 files changed, 9013 insertions(+), 2764 deletions(-)

One can easily notice that the OMAP5 SOC data has significantly come down
becasue of iospace and rest of the hwmod clean-up.

Thanks to Sricharan, Vaibhav Bedia, Vaibhav H, Rajendra and Benoit for the
patches and testing.

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.11/omap5_data_files

for you to fetch changes up to 86b6a6dd106973df7f0c097fcb252e9e54b2f971:

  ARM: OMAP4: hwmod data: Clean up the data file (2013-05-29 11:51:30 -0400)

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

Sricharan R (1):
  ARM: OMAP4: hwmod data: Clean up the data file

Vaibhav Hiremath (1):
  ARM: AM33XX: hwmod data: irq, dma and addr info clean up

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
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    | 1067 ----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    | 1661 +--------------
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
 27 files changed, 9013 insertions(+), 2764 deletions(-)
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

