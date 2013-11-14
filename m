From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Various omap device tree usability fixes for v3.13 merge window
Date: Wed, 13 Nov 2013 18:35:29 -0800
Message-ID: <1384396537-3486-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46257 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751617Ab3KNCfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Nov 2013 21:35:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here are some patches to fix various issue for device tree based
booting for omaps that I've ran into recently while working on
removing legacy platform data for mach-omap2.

Regards,

Tony


Tony Lindgren (8):
  net: smc91x: Fix device tree based configuration so it's usable
  mmc: omap: Fix DMA configuration to not rely on device id
  mmc: omap: Fix I2C dependency and make driver usable with device tree
  i2c: omap: Fix missing device tree flags for omap2
  gpio: twl4030: Fix regression for twl gpio output
  gpio: twl4030: Fix passing of pdata in the device tree case
  ARM: OMAP2+: Fix GPMC and simplify bootloader timings for 8250 and
    smc91x
  ARM: dts: Fix omap2 specific dtsi files by adding the missing entries

 .../devicetree/bindings/net/smsc-lan91c111.txt     |  4 +
 arch/arm/boot/dts/omap-zoom-common.dtsi            |  2 +-
 arch/arm/boot/dts/omap2.dtsi                       | 96 ++++++++++++++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    | 23 ++++++
 arch/arm/boot/dts/omap2430.dtsi                    | 49 +++++++++++
 arch/arm/mach-omap2/gpmc.c                         | 58 +++++--------
 drivers/gpio/gpio-twl4030.c                        | 13 ++-
 drivers/i2c/busses/i2c-omap.c                      | 22 +++++
 drivers/mmc/host/omap.c                            | 42 +++++-----
 drivers/net/ethernet/smsc/smc91x.c                 | 52 +++++++++---
 10 files changed, 285 insertions(+), 76 deletions(-)

-- 
1.8.1.1

