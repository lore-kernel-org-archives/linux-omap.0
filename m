From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 0/3] input: tsc2007: Extend for pre-calibration, flipping and rotation
Date: Tue, 30 Sep 2014 22:17:31 +0200
Message-ID: <1412108254-19234-1-git-send-email-marek@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com
Cc: hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Following series add support to tsc2007 touchscreen driver for pre-calibration,
flipping and rotation. Added bindings are documented and used in gta04 device tree.

Marek Belisko (3):
  input: tsc2007: Add pre-calibration, flipping and rotation
  Documentation: dt: input: tsc2007: Document new parameters
  arm: dts: omap3-gta04: Extend touchscreen configs

 .../bindings/input/touchscreen/tsc2007.txt         | 17 ++++-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  6 ++
 drivers/input/touchscreen/tsc2007.c                | 89 +++++++++++++++++++++-
 include/linux/i2c/tsc2007.h                        |  6 ++
 4 files changed, 111 insertions(+), 7 deletions(-)

-- 
1.9.3

