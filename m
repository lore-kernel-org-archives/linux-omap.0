From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 0/5] Add support for PWMSS on DRA7
Date: Thu, 25 Feb 2016 16:36:31 -0600
Message-ID: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, tony@atomide.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds support for PWMSS on DRA7. The IP is same as that
present in AM33XX and AM43XX.

This is an updated version of the patch series originally sent by Vignesh.
The biggest difference is the removal of local clock gating support from
various drivers due to silicon issue.

Links to v2 series:
https://patchwork.ozlabs.org/patch/479933/ (already in mainline)
https://patchwork.ozlabs.org/patch/479932/
https://patchwork.ozlabs.org/patch/479931/
https://patchwork.ozlabs.org/patch/479930/
https://patchwork.ozlabs.org/patch/479929/

Franklin S Cooper Jr (1):
  pwms: pwm-ti*: Remove support for local clock gating

Vignesh R (4):
  ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
  ARM: dts: DRA7: Add TBCLK for PWMSS
  clk: ti: DRA7: Add tbclk data for ehrpwm
  ARM: dts: DRA7: Add dt nodes for PWMSS

 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   8 +
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        |  17 +-
 arch/arm/boot/dts/dra7.dtsi                        |  64 ++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  24 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 239 +++++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                           |   3 +
 drivers/pwm/pwm-tiecap.c                           |  28 ---
 drivers/pwm/pwm-tiehrpwm.c                         |  29 ---
 drivers/pwm/pwm-tipwmss.c                          |  49 -----
 drivers/pwm/pwm-tipwmss.h                          |  39 ----
 10 files changed, 354 insertions(+), 146 deletions(-)
 delete mode 100644 drivers/pwm/pwm-tipwmss.h

-- 
2.7.0
