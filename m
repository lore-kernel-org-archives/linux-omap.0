From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] part 2 of omap soc changes for v3.19
Date: Sat, 22 Nov 2014 16:44:49 -0800
Message-ID: <13849.5644358501$1416703523@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54917 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbaKWApI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2014 19:45:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 9889278181bcdbae882664d8cee5bb0e064397e4:

  Merge tag 'for-v3.19/omap-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.19/soc (2014-11-14 10:25:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/hwmod-and-defconfig

for you to fetch changes up to 374a735894fe2fb82ba07c6e6b7d326640c1c17f:

  ARM: omap2plus_defconfig: enable ECAP and EHRPWM (2014-11-21 16:30:28 -0800)

----------------------------------------------------------------
SoC related changes for omaps including hwmod clean-up for
DSS, and hwmod data for more UARTs and ADC. Also few defconfig
changes to enable devices found on am335x and am437x.

----------------------------------------------------------------
Ambresh K (1):
      ARM: DRA7: hwmod data: Add missing UART hwmod data

Dmitry Lifshitz (1):
      ARM: dts: cm-t3x30: add keypad support

Felipe Balbi (5):
      ARM: omap2plus_defconfig: remove unwanted ethernet drivers
      ARM: omap2plus_defconfig: enable EDT FT5X06 touchscreen
      ARM: omap2plus_defconfig: enable AM33XX SoC sound
      ARM: omap2plus_defconfig: enable XHCI
      ARM: omap2plus_defconfig: enable ECAP and EHRPWM

Paul Walmsley (2):
      Merge branch 'dra7xx-uart-hwmod-v3.19' into omap-b-for-v3.19
      Merge branch 'adc-support-v3.19' into omap-b-for-v3.19

Tomi Valkeinen (6):
      ARM: OMAP2+: hwmod: add parent_hwmod support
      ARM: OMAP5: hwmod: set DSS submodule parent hwmods
      ARM: OMAP4: hwmod: set DSS submodule parent hwmods
      ARM: OMAP4: hwmod: use MODULEMODE properly
      ARM: OMAP4: fix RFBI iclk
      ARM: dts: omap4.dtsi: remove dss_fck

Tony Lindgren (1):
      Merge tag 'for-v3.19/omap-b2' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.19/soc

Vignesh R (1):
      ARM: OMAP2+: hwmod: AM43x: add hwmod support for ADC on AM43xx

 arch/arm/boot/dts/omap3-cm-t3x30.dtsi      |  17 +++++
 arch/arm/boot/dts/omap4.dtsi               |   2 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi     |   8 ---
 arch/arm/configs/omap2plus_defconfig       |  22 +++++++
 arch/arm/mach-omap2/omap_hwmod.c           |  22 +++++++
 arch/arm/mach-omap2/omap_hwmod.h           |   8 +++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  39 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  25 +++++---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |   5 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 100 +++++++++++++++++++++++++++++
 10 files changed, 230 insertions(+), 18 deletions(-)
