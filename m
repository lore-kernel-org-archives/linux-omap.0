From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v6 0/7] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Fri, 22 Apr 2016 11:40:31 -0500
Message-ID: <1461343238-29274-1-git-send-email-fcooper@ti.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: thierry.reding@gmail.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds support for PWM for DRA7. The IP is the same as the
one present in AM33XX and AM437XX.

However, before doing so remove unnecessary hwmod entries for eCAP, ePWM
and eQEP.

The following are the biggest changes from v5 to v6:
* Created two new bindings to allow ECAP and PWM to grab their functional
clock from DT rather than depending on PWMSS parent.
* Pull in a couple of patches from the "Correct PWM bindings" series. This
makes it a bit easier to understand.

>From the two patchsets a handful of patches have already been pulled in by
maintainers and have already made it to linux-next. Therefore, this
patch series is built ontop of the latest linux-next.

Tested on:
AM335x, AM437x and X15 + lcd w/backlight

This series has been verified to be backwards compatible with old dtbs.

Franklin S Cooper Jr (6):
  clk: ti: am335x/am4372: Add tbclk to pwm node
  pwm: pwm-tiehrpwm: Update dt binding document to use generic node name
  ARM: dts: am437x/am33xx/da850: Add new ECAP and EPWM bindings
  pwms: pwm-ti*: Get the clock from the PWMSS parent when using old
    bindings
  ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP and EPWM nodes
  ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and eCAP hwmod entries

Vignesh R (1):
  ARM: dts: DRA7: Add dt nodes for PWMSS

 .../devicetree/bindings/pwm/pwm-tiecap.txt         | 24 ++++--
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       | 28 ++++---
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
 arch/arm/boot/dts/am33xx.dtsi                      | 36 ++++++---
 arch/arm/boot/dts/am4372.dtsi                      | 61 +++++++++++----
 arch/arm/boot/dts/da850.dtsi                       | 15 ++--
 arch/arm/boot/dts/dra7.dtsi                        | 90 ++++++++++++++++++++++
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  | 18 -----
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 64 ---------------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 84 --------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  9 ---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 54 -------------
 drivers/clk/ti/clk-33xx.c                          |  3 +
 drivers/clk/ti/clk-43xx.c                          |  6 ++
 drivers/pwm/pwm-tiecap.c                           |  7 ++
 drivers/pwm/pwm-tiehrpwm.c                         |  7 ++
 16 files changed, 242 insertions(+), 279 deletions(-)

-- 
2.7.0

