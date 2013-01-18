From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 00/10] ARM: OMAP5: hwmod, clock and prm data files
Date: Fri, 18 Jan 2013 20:57:26 +0530
Message-ID: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60551 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab3ARP04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 10:26:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Series contains the hwmod, clock and prm data files for OMAP54xx SOCs.
This data was kept out of tree to be validated on es2.0 silicon version
and also to avoid the es1.0/es2.0 differences which are many.

Benoit Cousson, Rajendra Nayak, Paul Walmesly and Mike have all contributed
to get the autogen scripts in shape for OMAP5.

>From various discussion on the list, the clock data files are suppose
to be moved to drivers/clk/. Once the direction is clear, patch 8
can be updated accordingly.

Patches are tested on OMAP5 sEVM and uEVM. For testing few additional patches
are needed. Same tree can be fetched from here [1]

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://github.com/SantoshShilimkar/linux.git for_3.9/omap5_data_files

for you to fetch changes up to 7f534e1ebeb2bc64250b56fe00eb7d4dfa585e8e:

  ARM: OMAP5: Enable build and frameowrk initialisations (2013-01-18 19:45:48 +0530)

----------------------------------------------------------------

Benoit Cousson (7):
  ARM: OMAP5: PRM: Add OMAP54XX register and bitfield files
  ARM: OMAP5: CM: Add OMAP54XX register and bitfield files
  ARM: OMAP5: PRCM: Add OMAP54XX local MPU PRCM registers
  ARM: OMAP5: SCRM: Add OMAP54XX header file.
  ARM: OMAP2+: clockdomain data: Add OMAP54XX data and update the
    header
  ARM: OMAP5: powerdomain data: Add OMAP54XX data and update the header
  ARM: OMAP5: hwmod data: Create initial OMAP5 SOC hwmod data

Rajendra Nayak (1):
  ARM: OMAP5: clock data: Add OMAP54XX full clock tree and headers

Santosh Shilimkar (2):
  ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data
  ARM: OMAP5: Enable build and frameowrk initialisations

 arch/arm/mach-omap2/Makefile                  |    6 +-
 arch/arm/mach-omap2/cclock54xx_data.c         | 1794 ++++++++
 arch/arm/mach-omap2/clock.h                   |   23 +-
 arch/arm/mach-omap2/clock54xx.h               |   12 +
 arch/arm/mach-omap2/clock_common_data.c       |  139 +-
 arch/arm/mach-omap2/clockdomain.h             |    1 +
 arch/arm/mach-omap2/clockdomains54xx_data.c   |  464 ++
 arch/arm/mach-omap2/cm-regbits-54xx.h         | 1737 +++++++
 arch/arm/mach-omap2/cm1_54xx.h                |  216 +
 arch/arm/mach-omap2/cm2_54xx.h                |  392 ++
 arch/arm/mach-omap2/io.c                      |    9 +
 arch/arm/mach-omap2/omap_hwmod.h              |    1 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    | 5988 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |    1 +
 arch/arm/mach-omap2/powerdomains54xx_data.c   |  331 ++
 arch/arm/mach-omap2/prcm44xx.h                |    6 +
 arch/arm/mach-omap2/prcm_mpu54xx.h            |   92 +
 arch/arm/mach-omap2/prm-regbits-54xx.h        | 2701 +++++++++++
 arch/arm/mach-omap2/prm54xx.h                 |  447 ++
 arch/arm/mach-omap2/scrm54xx.h                |  231 +
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains54xx_data.c |  102 +
 22 files changed, 14656 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cclock54xx_data.c
 create mode 100644 arch/arm/mach-omap2/clock54xx.h
 create mode 100644 arch/arm/mach-omap2/clockdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_54xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_54xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_54xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu54xx.h
 create mode 100644 arch/arm/mach-omap2/prm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/prm54xx.h
 create mode 100644 arch/arm/mach-omap2/scrm54xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains54xx_data.c

Regards,
Santosh

[1] OMAP5-Test brach
git://github.com/SantoshShilimkar/linux.git 3.9/omap5-testing

-- 
1.7.9.5

