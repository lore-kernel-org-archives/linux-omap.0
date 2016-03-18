From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 0/3] ARM: am335x/am437x: Correct PWM bindings
Date: Thu, 17 Mar 2016 20:15:20 -0500
Message-ID: <1458263723-25770-1-git-send-email-fcooper@ti.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Unlike the majority of other SOCs the PWM node uses ehrpwm instead of
the generic pwm node name. This patch series switches to the pwm node
name and while at it fix some other minor binding documentation issues.

This patch series also includes a patch to insure ABI compatibility.

This series was tested on AM335x and AM437x GP evm. I also validated that
ABI compatibility was maintained.

V3 changes:
Update am335x-shc.dts

V2 changes:
Dropped patches related to the ranges property.

Franklin S Cooper Jr (3):
  clk: ti: am335x/am4372: Add tbclk to pwm node
  ARM: DTS: da850/am4372/am33xx: Use generic node name for ehrpwm
  pwm: pwm-tiehrpwm: Update dt binding document to use generic node name

 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt |  4 ++--
 arch/arm/boot/dts/am335x-shc.dts                       |  2 +-
 arch/arm/boot/dts/am33xx.dtsi                          |  6 +++---
 arch/arm/boot/dts/am4372.dtsi                          | 12 ++++++------
 arch/arm/boot/dts/da850.dtsi                           |  4 ++--
 drivers/clk/ti/clk-33xx.c                              |  3 +++
 drivers/clk/ti/clk-43xx.c                              |  6 ++++++
 7 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.7.0
