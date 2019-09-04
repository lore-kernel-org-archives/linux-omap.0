From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC v2 0/3] OMAP3: convert opp-v1 to opp-v2 and read speed binned / 720MHz grade bits
Date: Wed,  4 Sep 2019 10:53:38 +0200
Message-ID: <cover.1567587220.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Changes V2:
* merge separate patch to remove opp-v1 table from n950-n9 into
  the general omap3xxx.dtsi patch
* add legacy compatibility to ti,omap3430 and ti,omap3630 for
  the ti-cpufreq driver
* make driver and omap3xxx.dtsi patches pass checkpatch
* add bulk patch to explicitly define compatibility to ti,omap3430
  and ti,omap36xx in addition to ti,omap3 of all in-tree boards
  where it was missing

RFC V1 2019-09-02 12:55:55:

This patch set converts the opp tables to opp-v2 format
and extends the ti-cpufreq to support omap3.

It adds 720 MHz (omap34xx) and 1 GHz (omap36xx) OPPs but
tells the ti-cpufreq driver to disable them if the speed
binned / 720MHz grade eFuse bits indicate that the chip
is not rated for that speed. 

It has been tested (for chip variant detection, not reliability
of the high speed OPPs) on:

* BeagleBoard C2 (omap3430 600MHz)
* BeagleBoard XM B (dm3730 800MHz)
* GTA04A4 (dm3730 800MHz)
* GTA04A5 (dm3730 1GHz)


H. Nikolaus Schaller (3):
  cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
  ARM: dts: replace opp-v1 tables by opp-v2 for omap34xx and omap36xx
  ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430
    or ti,omap36xx

 arch/arm/boot/dts/am3517_mt_ventoux.dts       |  2 +-
 .../boot/dts/logicpd-som-lv-35xx-devkit.dts   |  2 +-
 .../boot/dts/logicpd-som-lv-37xx-devkit.dts   |  2 +-
 .../boot/dts/logicpd-torpedo-35xx-devkit.dts  |  2 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit.dts  |  2 +-
 arch/arm/boot/dts/omap3-beagle.dts            |  2 +-
 arch/arm/boot/dts/omap3-cm-t3530.dts          |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts  |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts  |  2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts        |  2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts          |  2 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts            |  2 +-
 arch/arm/boot/dts/omap3-ha.dts                |  2 +-
 arch/arm/boot/dts/omap3-ldp.dts               |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi          |  7 --
 arch/arm/boot/dts/omap3-sbc-t3530.dts         |  2 +-
 arch/arm/boot/dts/omap3-thunder.dts           |  2 +-
 arch/arm/boot/dts/omap3430-sdp.dts            |  2 +-
 arch/arm/boot/dts/omap34xx.dtsi               | 65 ++++++++++++--
 arch/arm/boot/dts/omap36xx.dtsi               | 53 +++++++++--
 drivers/cpufreq/cpufreq-dt-platdev.c          |  2 +-
 drivers/cpufreq/ti-cpufreq.c                  | 87 ++++++++++++++++++-
 22 files changed, 204 insertions(+), 44 deletions(-)

-- 
2.19.1
