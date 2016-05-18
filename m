From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/8] ARM: dts: Add operating-points-v2 tables for TI platforms
Date: Wed, 18 May 2016 18:36:25 -0500
Message-ID: <cover.1463606963.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This series adds operating-points-v2 tables for am335x, am437x, dra7xx,
and am57xx based platforms along with some support patches so that we
can enable more OPPs for the CPU on these platforms.

These patches rely on the ti-cpufreq series sent here [1] and provide
opp-supported-hw data for each OPP so that only the appropriate OPPs
for a specific piece of silicon get enabled.

Regards,
Dave

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1147940.html

Dave Gerlach (8):
  ARM: dts: am335x: Update MPU regulator range for TI boards
  ARM: dts: am33xx: Move to operating-points-v2 table and ti-cpufreq
    driver
  ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
  ARM: dts: am4372: Add operating-points-v2 table
  ARM: dts: am437x-gp-evm: Hook dcdc2 as the cpu0-supply
  ARM: dts: dra7: Add dt node for the syscon control module wkup
  ARM: dts: dra7: Move cpus node to parent dts for dra74x and dra72x
  ARM: dts: dra7: Move to operating-points-v2 table

 arch/arm/boot/dts/am335x-bone-common.dtsi |  2 +-
 arch/arm/boot/dts/am335x-boneblack.dts    | 11 ++++
 arch/arm/boot/dts/am335x-evm.dts          |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts        |  2 +-
 arch/arm/boot/dts/am33xx.dtsi             | 88 ++++++++++++++++++++++++++-----
 arch/arm/boot/dts/am4372.dtsi             | 39 ++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts       |  4 ++
 arch/arm/boot/dts/dra7.dtsi               | 48 +++++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi             | 16 ------
 arch/arm/boot/dts/dra74x.dtsi             | 25 +--------
 10 files changed, 181 insertions(+), 56 deletions(-)

-- 
2.7.3

