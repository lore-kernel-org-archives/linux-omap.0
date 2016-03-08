From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v5 0/6] ARM: am335x/am437x/dra7: Add PWM support for DRA7
Date: Mon,  7 Mar 2016 19:23:38 -0600
Message-ID: <1457400224-24797-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds support for PWM for DRA7. The IP is same as that
present in AM33XX and AM437XX.

However, before doing so remove unnecessary hwmod entries for eCAP, ePWM
and eQEP.

This series is almost identical to v4. Only difference is the addition of
eCAP DT nodes in the dra7.dtsi file.

This series was tested on AM335x GP, AM437x GP and X15 + LCD screen for
PWM based backlight.

This series was also verified to be backwards compatible with old dtbs.

This series depends on the below patch series for PWM bindings cleanup:
https://patchwork.ozlabs.org/patch/593171/
https://patchwork.ozlabs.org/patch/593168/
https://patchwork.ozlabs.org/patch/593165/
https://patchwork.ozlabs.org/patch/593166/
https://patchwork.ozlabs.org/patch/593169/

V3 series:
https://patchwork.ozlabs.org/patch/588432/
https://patchwork.ozlabs.org/patch/588434/
https://patchwork.ozlabs.org/patch/588433/
https://patchwork.ozlabs.org/patch/588429/
https://patchwork.ozlabs.org/patch/588431/


Franklin S Cooper Jr (3):
  pwms: pwm-ti*: Get the clock from the PWMSS (parent)
  ARM: dts: am437x/am33xx: Remove eCAP and ePWM hwmod properties
  ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and eCAP hwmod entries

Vignesh R (3):
  ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
  ARM: dts: DRA7: Add TBCLK for PWMSS
  ARM: dts: DRA7: Add dt nodes for PWMSS

 .../devicetree/bindings/pwm/pwm-tiecap.txt         | 10 ++-
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       | 16 ++++-
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
 arch/arm/boot/dts/am33xx.dtsi                      | 12 ++--
 arch/arm/boot/dts/am4372.dtsi                      | 21 +++---
 arch/arm/boot/dts/dra7.dtsi                        | 84 ++++++++++++++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi               | 24 +++++++
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  | 18 -----
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 64 -----------------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 84 ----------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  9 ---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 54 --------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 83 +++++++++++++++++++++
 drivers/pwm/pwm-tiecap.c                           |  2 +-
 drivers/pwm/pwm-tiehrpwm.c                         |  2 +-
 15 files changed, 247 insertions(+), 251 deletions(-)

-- 
2.7.0
