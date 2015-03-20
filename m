From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] ARM: omap5/dra7/x15: Thermal dts patches
Date: Fri, 20 Mar 2015 14:47:38 -0500
Message-ID: <1426880861-9266-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Here are a few pending patches for DRA7/ OMAP5 and patch hooking the
GPIO fan to the thermal framework.

Tested on BeagleBoard-X15, uEVM with next-20150320. (just load up
cpufreq_dt and gpio_fan modules with omap2plus_defconfig, run cpuburn
to generate thermal and just wait for the fan to trigger - and it does-
we dont hit the frequency throttling temps)

The patches are based on
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
branch: omap-for-v4.1/dt-v2 10709c0858d8 ARM: dts: Update Nanobone dts file

The patch #3(gpio fan-thermal hookup) depends on 
(from linus master):
12ca7188468e thermal: Introduce dummy functions when thermal is not defined
and the following currently in linux-next(next-20150320) queued for future.
b5cf88e46bad (gpio-fan): Add thermal control hooks

Keerthy (1):
  ARM: dts: DRA7: Add bandgap and related thermal nodes

Nishanth Menon (1):
  ARM: dts: am57xx-beagle-x15: Add thermal map

Tero Kristo (1):
  ARM: dts: OMAP5+: separate the cpu thermal zone definition from omap4

 arch/arm/boot/dts/am57xx-beagle-x15.dts  |   49 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi              |   12 ++++++++
 arch/arm/boot/dts/dra72x.dtsi            |    9 ++++++
 arch/arm/boot/dts/dra74x.dtsi            |    9 ++++++
 arch/arm/boot/dts/omap5-cpu-thermal.dtsi |   41 +++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi             |    2 +-
 6 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/omap5-cpu-thermal.dtsi

Regards,
Nishanth Menon
-- 
1.7.9.5
