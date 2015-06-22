From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/6] ARM: AM437x: Add IO wake up support
Date: Mon, 22 Jun 2015 11:52:50 +0530
Message-ID: <1434954176-9605-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: galak@codeaurora.org, t-kristo@ti.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, paul@pwsan.com, bcousson@baylibre.com, linux-clk@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The patch series adds IO wake up support for AM437x series
making use of the existing OMAP4 support. Adds the AM437x
specifics.

The series is boot tested on OMAP4 panda, DAR7 evm and AM437x evms.
I do not have OMAP3 boards so not able to test on OMAP3.

Keerthy (6):
  ARM: OMAP4: PRM: Remove hardcoding of PRM_IO_PMCTRL_OFFSET register
  ARM: AM43xx: Add the PRM IRQ register offsets
  ARM: dts: AM4372: Add PRCM IRQ entry
  ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2 and
    IRQSTATUS_MPU_2 register offsets
  ARM: OMAP4+: PRM: Add AM437x specific data
  ARM: PRM: AM437x: Enable IO wakeup feature

 arch/arm/boot/dts/am4372.dtsi     |  1 +
 arch/arm/mach-omap2/prcm-common.h |  9 +++---
 arch/arm/mach-omap2/prcm43xx.h    |  5 +++
 arch/arm/mach-omap2/prm3xxx.c     | 20 ++++++------
 arch/arm/mach-omap2/prm44xx.c     | 65 +++++++++++++++++++++++----------------
 arch/arm/mach-omap2/prm_common.c  |  6 ++--
 6 files changed, 63 insertions(+), 43 deletions(-)

-- 
1.9.1
