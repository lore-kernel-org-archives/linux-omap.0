From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/6] ARM: AM437x: Add IO wake up support
Date: Wed, 8 Jul 2015 11:12:22 +0530
Message-ID: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com, paul@pwsan.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The patch series adds IO wake up support for AM437x series
making use of the existing OMAP4 support. Adds the AM437x
specifics.

The series is boot tested on OMAP4 panda, DAR7 evm and AM437x evms.

Changes in v2:

Removed inefficient way of using arrays for irq ack and masks.

Keerthy (6):
  ARM: OMAP4: PRM: Remove hardcoding of PRM_IO_PMCTRL_OFFSET register
  ARM: AM43xx: Add the PRM IRQ register offsets
  ARM: dts: AM4372: Add PRCM IRQ entry
  ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2 and
    IRQSTATUS_MPU_2 register offsets
  ARM: OMAP4+: PRM: Add AM437x specific data
  ARM: PRM: AM437x: Enable IO wakeup feature

 arch/arm/boot/dts/am4372.dtsi     |  1 +
 arch/arm/mach-omap2/prcm-common.h |  1 +
 arch/arm/mach-omap2/prcm43xx.h    |  5 ++++
 arch/arm/mach-omap2/prm44xx.c     | 58 +++++++++++++++++++++++----------------
 arch/arm/mach-omap2/prm_common.c  |  1 +
 5 files changed, 42 insertions(+), 24 deletions(-)

-- 
1.9.1
