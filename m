From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 0/5] OMAP3: convert opp-v1 to opp-v2 and read speed binned / 720MHz grade bits
Date: Mon,  2 Sep 2019 12:55:46 +0200
Message-ID: <cover.1567421750.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patch set converts the opp tables to opp-v2 format
and extends the ti-cpufreq to support omap3.

It adds 720 MHz (omap34xx) and 1 GHz (omap36xx) OPPs but
tells the ti-cpufreq driver to disable them if the speed
binned / 720MHz grade eFuse bits indicate that the chip
is not rated for that speed. 

It has been tested (for chip variant detection, not reliability
of high speed OPPs) on:
* BeagleBoard C2 (omap3430 600MHz)
* BeagleBoard XM B (dm3730 800MHz)
* GTA04A4 (dm3730 800MHz)
* GTA04A5 (dm3730 1GHz)


H. Nikolaus Schaller (5):
  cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
  ARM: dts: add support for opp-v2 for omap34xx and omap36xx
  ARM: dts: omap3-evm-37xx: fix compatible from omap3630 to omap36xx
  ARM: dts: omap3-n950-n9: remove opp-v1 table
  ARM: dts: omap3-beagle: make explicitly compatible to ti,omap34xx

 arch/arm/boot/dts/omap3-beagle.dts   |  2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi |  7 ---
 arch/arm/boot/dts/omap34xx.dtsi      | 59 ++++++++++++++++---
 arch/arm/boot/dts/omap36xx.dtsi      | 47 ++++++++++++---
 drivers/cpufreq/cpufreq-dt-platdev.c |  2 +-
 drivers/cpufreq/ti-cpufreq.c         | 86 +++++++++++++++++++++++++++-
 7 files changed, 176 insertions(+), 29 deletions(-)

-- 
2.19.1
