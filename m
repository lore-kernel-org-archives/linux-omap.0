From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 0/4] Add N900 powerbutton DT support
Date: Tue, 22 Oct 2013 14:55:00 +0200
Message-ID: <1382446504-27837-1-git-send-email-sre@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, linux-input@vger.kernel.org
Cc: =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

This patchset adds support for the Nokia N900
powerbutton.

Currently non-DT boot crashes for me very early,
so I was not able to check this patch using non-DT
boot.

It would be nice if somebody can check if the first
patch works using non-DT boot. It should be enough
to test it with any omap3 board using the twl4030
power button.

Sebastian Reichel (4):
  Input: twl4030-pwrbutton - add device tree support
  Input: twl4030-pwrbutton: use dev_err for errors
  Input: twl4030-pwrbutton: simplify driver using devm_*
  ARM: dts: twl4030: Add power button support

 arch/arm/boot/dts/twl4030.dtsi         |  5 +++++
 drivers/input/misc/twl4030-pwrbutton.c | 33 ++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

-- 
1.8.4.rc3

