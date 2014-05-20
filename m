From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap pm changes for v3.16 merge window, resend
Date: Mon, 19 May 2014 19:11:52 -0700
Message-ID: <20140520021151.GL15793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14267 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaETCL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 22:11:56 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/pm-signed

for you to fetch changes up to 57b05572267581c2320462e9b606709fa6da4c5a:

  ARM: OMAP2+: Enable CPUidle in omap2plus_defconfig (2014-05-06 15:45:15 -0700)

----------------------------------------------------------------
PM related fixes for omap3 that were discovered during omap3
conversion to device tree. This series sets up the PMIC signaling
in a way where we can test for PM regressions easily by
looking at state of the the sys_clkreq and sys_off_mode pins.

Note that this series alone does not make omap3 PM to cut
off core voltage during off-idle, changes to twl4030-power.c
configurations are still needed. Those will be posted
separately.

----------------------------------------------------------------
Tony Lindgren (10):
      mfd: twl-core: Fix idle mode signaling for omaps when booted with device tree
      Merge tag 'ib-mfd-omap-3.16' of git://git.kernel.org/.../lee/mfd into omap-for-v3.16/pm
      ARM: dts: Fix omap serial wake-up when booted with device tree
      ARM: OMAP3: Fix idle mode signaling for sys_clkreq and sys_off_mode
      ARM: OMAP3: Disable broken omap3_set_off_timings function
      ARM: OMAP3: Fix voltage control for deeper idle states
      ARM: dts: Configure omap3 twl4030 I2C4 pins by default
      ARM: OMAP2+: Fix voltage scaling init for device tree
      ARM: dts: Enable N900 keyboard sleep leds by default
      ARM: OMAP2+: Enable CPUidle in omap2plus_defconfig

 arch/arm/boot/dts/omap3-evm-37xx.dts      |   9 ++
 arch/arm/boot/dts/omap3-ldp.dts           |   4 +
 arch/arm/boot/dts/omap3-n900.dts          |  19 +++
 arch/arm/boot/dts/omap3.dtsi              |   6 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |  15 ++
 arch/arm/boot/dts/omap4-sdp.dts           |   6 +
 arch/arm/boot/dts/omap4.dtsi              |   6 +-
 arch/arm/boot/dts/twl4030_omap3.dtsi      |  19 ++-
 arch/arm/configs/omap2plus_defconfig      |   8 ++
 arch/arm/mach-omap2/omap_twl.c            |  60 --------
 arch/arm/mach-omap2/pm.c                  |  28 ++--
 arch/arm/mach-omap2/pm34xx.c              |   4 +
 arch/arm/mach-omap2/prm-regbits-34xx.h    |  11 +-
 arch/arm/mach-omap2/vc.c                  | 232 ++++++++++++++++++++----------
 arch/arm/mach-omap2/vc.h                  |   3 +
 drivers/mfd/twl-core.c                    |  15 ++
 include/dt-bindings/pinctrl/omap.h        |  12 ++
 17 files changed, 296 insertions(+), 161 deletions(-)
