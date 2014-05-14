From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration when booted with device tree
Date: Tue, 13 May 2014 18:34:03 -0700
Message-ID: <1400031250-29542-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44515 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751191AbaENBeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 21:34:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Hi,

Here's an updated set of patches to enable low-power idle modes
for some omap3 boards when booted with device tree.

This series when applied on top of the patches in tread                                                                                                       
"[PATCH 00/11] Fixes for omap PM for making omap3 DT only",
or omap-for-v3.16/pm branch.

Lee, if these patches look OK to you, please feel free to 
pick them, preferrably to the immutable branch you already
have set up so I can also merge them in to be able to have
things working in my branch properly for PM.

Regards,

Tony


Tony Lindgren (7):
  mfd: twl4030-power: Fix hang on reboot if sleep configuration was
    loaded earlier
  mfd: twl4030-power: Fix some defines for SW_EVENTS
  mfd: twl4030-power: Add generic reset configuration
  mfd: twl4030-power: Add recommended idle configuration
  mfd: twl4030-power: Add support for board specific configuration
  mfd: twl4030power: Add a configuration to turn off oscillator during
    off-idle
  ARM: dts: Enable twl4030 off-idle configuration for selected omaps

 .../devicetree/bindings/mfd/twl4030-power.txt      |  17 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   6 +
 arch/arm/boot/dts/omap3-evm-common.dtsi            |   7 +
 arch/arm/boot/dts/omap3-n900.dts                   |   5 +
 drivers/mfd/twl4030-power.c                        | 269 +++++++++++++++++++--
 include/linux/i2c/twl.h                            |   4 +
 6 files changed, 284 insertions(+), 24 deletions(-)

-- 
1.8.1.1

