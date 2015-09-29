From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Tue, 29 Sep 2015 15:43:55 -0500
Message-ID: <1443559446-26969-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

the following patches de-obfuscate arch/arm/mach-omap2/timer.c
and start moving code to drivers/clocksource. So far only counter32k
has been moved over.

Note that we can't get rid of all the code (yet) because there are
still platforms relying to legacy boot and because of the strong
coupling with OMAP's hwmod layer.

This is, for now, an RFC and has be written on top of [1]. Boot tested
with AM335x and AM437x.

[1] http://marc.info/?l=linux-omap&m=144354336924308&w=2

ps: if anybody has a good idea on how to get rid of
register_persistent_clock(), please let me know

Felipe Balbi (11):
  arm: omap2: timer: get rid of obfuscating macros
  arm: omap2: timer: add a gptimer argument to sync32k_timer_init()
  arm: omap2: timer: remove __omap_gptimer_init()
  arm: omap2: timer: provide generic sync32k_timer_init function
  arm: omap2: timer: move realtime_counter_init() around
  arm: omap2: timer: always call clocksource_of_init() when DT
  arm: omap2: timer: remove omap4_local_timer_init
  arm: omap2: timer: rename omap_sync32k_timer_init()
  clocksource: add TI 32.768 Hz counter driver
  arm: omap2: timer: limit hwmod usage to non-DT boots
  arm: boot: dts: omap: add missing default status for 32k counter

 arch/arm/boot/dts/am4372.dtsi         |   1 +
 arch/arm/boot/dts/am437x-gp-evm.dts   |   4 +
 arch/arm/boot/dts/am437x-idk-evm.dts  |   4 +
 arch/arm/boot/dts/am437x-sk-evm.dts   |   4 +
 arch/arm/boot/dts/am43x-epos-evm.dts  |   4 +
 arch/arm/boot/dts/dra7.dtsi           |   1 +
 arch/arm/boot/dts/omap2420-h4.dts     |   4 +
 arch/arm/boot/dts/omap2420.dtsi       |   1 +
 arch/arm/boot/dts/omap2430.dtsi       |   1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts |   4 +
 arch/arm/boot/dts/omap3-beagle.dts    |   4 +
 arch/arm/boot/dts/omap3-ldp.dts       |   4 +
 arch/arm/boot/dts/omap3-n900.dts      |   4 +
 arch/arm/boot/dts/omap3.dtsi          |   1 +
 arch/arm/boot/dts/omap3430-sdp.dts    |   4 +
 arch/arm/boot/dts/omap4-sdp.dts       |   4 +
 arch/arm/boot/dts/omap4.dtsi          |   1 +
 arch/arm/boot/dts/omap5-cm-t54.dts    |   4 +
 arch/arm/boot/dts/omap5-uevm.dts      |   4 +
 arch/arm/boot/dts/omap5.dtsi          |   1 +
 arch/arm/mach-omap2/board-generic.c   |  14 ++--
 arch/arm/mach-omap2/board-ldp.c       |   2 +-
 arch/arm/mach-omap2/board-rx51.c      |   2 +-
 arch/arm/mach-omap2/common.h          |   4 +-
 arch/arm/mach-omap2/timer.c           | 138 ++++++++++++++--------------------
 drivers/clocksource/Kconfig           |   8 ++
 drivers/clocksource/Makefile          |   1 +
 drivers/clocksource/timer-ti-32k.c    | 121 +++++++++++++++++++++++++++++
 28 files changed, 255 insertions(+), 94 deletions(-)
 create mode 100644 drivers/clocksource/timer-ti-32k.c

-- 
2.5.3
