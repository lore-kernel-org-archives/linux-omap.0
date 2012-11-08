From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 00/10] Support for AM33xx PWM Susbsytem
Date: Thu, 8 Nov 2012 13:23:07 +0530
Message-ID: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, "Philip,
 Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

In AM33xx PWM sub modules like ECAP, EHRPWM & EQEP are  integrated to
PWM subsystem. All these submodules shares the resources (clock) & has
a clock gating register in PWM Subsystem. This patch series creates a
parent PWM Subsystem driver to handle access synchronization of shared
resources & clock gating from PWM Subsystem configuration space.
Also Device tree nodes populated to support parent child relation
between PWMSS, ECAP & EHRPWM submodules.
In addition EHRPWM module requires explicit clock gating from control
module & is handled by patch #2 & 8.

Patch #4 & 5 submitted is a second revision as suggested by  Thierry
for handling clock gating with a global function . This requires config
space handling done independent from driver and is done at parent driver.
So the parent<->child relation adopted to handle
1. pm runtime synchronization
2. PWM subsystem common config space clock gating for PWM submodules.

Patches supports
- Driver support for parent child relation handled patch #1
- Optional EHRPWM tb clock in patch #2
- Parent child in HWMOD handled at patch #3
- Device tree binding support handled in patch #4, 6 &8
- pinctrl support in patch #5 & 7.
- DT node populated in patch #9 & 10.

This patch series based on linux-next/20121031 and tested on AM33xx.
It depends on [1]

1. https://lkml.org/lkml/2012/10/29/589
pwm: Device tree support for PWM polarity

Philip, Avinash (10):
  PWMSS: Add PWM Subsystem driver for parent<->child relationship
  ARM: am33xx: clk: Add optional clock for EHRPWM
  ARM: OMAP: AM33xx hwmod: Add parent-child relationship for PWM
    subsystem
  pwm: pwm-tiecap: Add device-tree binding support for APWM driver
  pwm: pwm-tiecap: pinctrl support
  pwm: pwm-tiehrpwm: Add device-tree binding support for EHRPWM driver
  pwm: pwm-tiehrpwm: pinctrl support
  pwm: pwm-tiehrpwm: Adding TBCLK gating support.
  ARM: dts: AM33XX: Add PWMSS device tree nodes
  ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm

 .../devicetree/bindings/pwm/pwm-tiecap.txt         |   22 +
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   25 ++
 Documentation/devicetree/bindings/pwm/tipwmss.txt  |   30 ++
 arch/arm/boot/dts/am335x-evm.dts                   |   21 +
 arch/arm/boot/dts/am33xx.dtsi                      |   90 +++++
 arch/arm/mach-omap2/clock33xx_data.c               |   37 ++
 arch/arm/mach-omap2/control.h                      |    8 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  419 +++++++++++++-------
 drivers/pwm/Kconfig                                |   11 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-tiecap.c                           |   54 +++-
 drivers/pwm/pwm-tiehrpwm.c                         |   75 ++++-
 drivers/pwm/tipwmss.c                              |  142 +++++++
 drivers/pwm/tipwmss.h                              |   30 ++
 14 files changed, 820 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/tipwmss.txt
 create mode 100644 drivers/pwm/tipwmss.c
 create mode 100644 drivers/pwm/tipwmss.h
