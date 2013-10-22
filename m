From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 0/2] Add lp5523 DT support
Date: Tue, 22 Oct 2013 15:01:34 +0200
Message-ID: <1382446896-28436-1-git-send-email-sre@debian.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Linus Walleij <linus.walleij@linaro.org>, Milo Kim <milo.kim@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset adds device tree support for the enable-pin
of the lp55xx. The second part adds support for the LP5523
to the Nokia N900's DTS file.

I have tested the patchset only using DT boot, since
non-DT boot is currently broken for me.

-- Sebastian

Sebastian Reichel (2):
  leds: lp55xx: handle enable pin in driver
  DTS: ARM: OMAP3-N900: Add LP5523 support

 .../devicetree/bindings/leds/leds-lp55xx.txt       |  1 +
 arch/arm/boot/dts/omap3-n900.dts                   | 61 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c       | 20 +------
 arch/arm/mach-ux500/board-mop500.c                 |  2 +
 drivers/leds/leds-lp55xx-common.c                  | 25 ++++-----
 include/linux/platform_data/leds-lp55xx.h          |  6 +--
 6 files changed, 80 insertions(+), 35 deletions(-)

-- 
1.8.4.rc3

