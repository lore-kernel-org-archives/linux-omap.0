From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] Fixes for omap PM for making omap3 DT only
Date: Thu, 10 Apr 2014 16:47:08 -0700
Message-ID: <1397173639-29587-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48808 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbaDJXrW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 19:47:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

As we're planning to make omap3 device tree only soon, I was poking
around and noticed that PM is not working properly. As we're planning
to drop about 20k lines of code, I just had to try to fix this so we
know what is going on and don't have to go back. I was pretty bummed
out to find that we've had non-working PM code in mainline for
really long time.

Anyways, I got the voltage scaling and N900 debug leds working, so
with those we can notice any future regressions immediately :)

These are against v3.14, then you might want to also apply the
following two patches:

[PATCH] of/platform: Fix no irq domain found errors when populating interrupts
https://lkml.org/lkml/2014/4/10/620

[PATCH] serial: omap: Fix missing pm_runtime_resume handling by simplifying code
http://www.spinics.net/lists/linux-omap/msg104782.html

Note that for the actual voltage scaling to happen, the twl4030
PMIC scripts are also needed. I have some uncleaned patches to
load those based on the compatible flag, will post those
separately. This series alone fixes the idle state signaling to
the PMIC, so we can monitor sys_clkreq and sys_off_idle pins
properly.

Please review, comment and test,

Tony

Tero Kristo (1):
  ARM: OMAP3: PM: remove access to PRM_VOLTCTRL register

Tony Lindgren (10):
  ARM: OMAP3: Fix idle mode signaling for sys_clkreq and sys_off_mode
  ARM: OMAP3: Disable broken omap3_set_off_timings function
  ARM: OMAP3: Fix voltage control for deeper idle states
  ARM: dts: Configure omap3 twl4030 I2C4 pins by default
  ARM: OMAP2+: Fix voltage scaling init for device tree
  ARM: dts: Enable N900 keybaord sleep leds by default
  ARM: dts: Fix omap serial wake-up when booted with device tree
  ARM: OMAP2+: Enable CPUidle in omap2plus_defconfig
  mfd: twl-core: Fix idle mode signaling for omaps when booted with
    device tree
  pinctrl: single: Clear pin interrupts enabled by bootloader

 arch/arm/boot/dts/omap3-evm-37xx.dts      |   9 ++
 arch/arm/boot/dts/omap3-n900.dts          |  19 +++
 arch/arm/boot/dts/omap3.dtsi              |   6 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |  15 +++
 arch/arm/boot/dts/omap4-sdp.dts           |   6 +
 arch/arm/boot/dts/omap4.dtsi              |   6 +-
 arch/arm/boot/dts/twl4030_omap3.dtsi      |  19 ++-
 arch/arm/configs/omap2plus_defconfig      |   7 +
 arch/arm/mach-omap2/omap_twl.c            |  60 ---------
 arch/arm/mach-omap2/pm.c                  |  28 ++--
 arch/arm/mach-omap2/pm34xx.c              |   6 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h    |  11 +-
 arch/arm/mach-omap2/vc.c                  | 212 +++++++++++++++++++-----------
 arch/arm/mach-omap2/vc.h                  |   2 +
 drivers/mfd/twl-core.c                    |  15 +++
 drivers/pinctrl/pinctrl-single.c          |  13 ++
 include/dt-bindings/pinctrl/omap.h        |  12 ++
 17 files changed, 281 insertions(+), 165 deletions(-)

-- 
1.8.1.1

