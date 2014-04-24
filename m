From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] mfd: twl4030-power: Enable off-idle configuration when booted with device tree
Date: Wed, 23 Apr 2014 17:40:26 -0700
Message-ID: <1398300030-7386-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19664 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaDXAkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 20:40:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>

Hi all,

One of the major blockers for making omap3 to boot in device tree
mode has been the fact that power management has not been working
as well as when booted in legacy mode.

This series when applied on top of the patches in tread
"[PATCH 00/11] Fixes for omap PM for making omap3 DT only".

This series makes the twl4030 PMIC configurations generic
so that most boards can just use one of the configurations
based on the compatible flag alone. This allows us to drop
all the related platform data once omap3 boots in device
tree only mode.

Lee, if these patches look OK to you, please feel free to
pick them, preferrably to the immutable branch you already
have set up so I can also merge them in to be able to have
things working in my branch properly for PM.

Regards,

Tony

Tony Lindgren (4):
  mfd: twl4030-power: Add recommended idle configuration
  mfd: twl4030-power: Add support for board specific configuration
  mfd: twl4030power: Add a configuration to turn off oscillator during
    off-idle
  ARM: dts: Enable twl4030 off-idle configuration for selected omaps

 .../devicetree/bindings/mfd/twl4030-power.txt      |  10 +
 arch/arm/boot/dts/omap3-evm-common.dtsi            |   7 +
 arch/arm/boot/dts/omap3-n900.dts                   |   5 +
 drivers/mfd/twl4030-power.c                        | 205 +++++++++++++++++++++
 include/linux/i2c/twl.h                            |   1 +
 5 files changed, 228 insertions(+)

-- 
1.8.1.1

