From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/3] Enable twl603x-GPADC for some OMAP4/OMAP5 boards and Palmas-RTC for OMAP5
Date: Tue,  5 Jan 2016 13:01:36 +0100
Message-ID: <cover.1451995297.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds DT nodes for:

twl6030-gpadc for omap4 based boards (Pandaboard ES)
twl6037-gpadc for omap5 based boards (OMAP5 EVM)
twl6037-rtc for omap5 based boards (OMAP5 EVM)


H. Nikolaus Schaller (3):
  ARM: dts: omap5-board-common: enable rtc and charging of backup
    battery
  ARM: dts: omap5-board-common: enable iio gpadc for Palmas
  ARM: dts: twl6030: add gpadc

 arch/arm/boot/dts/omap5-board-common.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/twl6030.dtsi            |  6 ++++++
 2 files changed, 24 insertions(+)

-- 
2.5.1
