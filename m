From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/5] ARM: OMAP2+: Add and enable operating-points-v2
Date: Mon, 6 Mar 2017 09:23:37 -0600
Message-ID: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lukasz Majewski <lukma@denx.de>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This series adds the necessary changes to get proper operating-points-v2 tables
for AM335x/AM437x/DRA7xx/AM57xx TI SoCs. Doing this enables the ti-cpufreq
driver and allows the platform to detect which CPU OPPs are valid for the
configuration in use and enable them.

This series adds complete tables for am335x and adds 1GHz support for all
beaglebone black boards and updates the already merged but unused am437x table
to match the finalized DT bindings. It also moves the existing dra7xx/am57xx
OPPs to OPPv2 but does not enable 1.5GHz yet as this requires multiregulator
support which will come at a later date.

Also, now that so many TI platforms will depend on the ti-cpufreq driver let's
add CONFIG_ARM_TI_CPUFREQ to omap2plus_defconfig to enable it as part of the
default configuration.

Pushed a branch containing these patches on top of v4.11-rc1 if anyone wants
to try it out [1].

Regards,
Dave

[1] https://github.com/dgerlach/linux-pm/tree/upstream/v4.11/ti-cpufreq-dts

Dave Gerlach (5):
  ARM: dts: am33xx: Add updated operating-points-v2 table for cpu
  ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
  ARM: dts: am4372: Update operating-points-v2 table for cpu
  ARM: dts: dra7: Add updated operating-points-v2 table for cpu
  ARM: omap2plus_defconfig: Enable support for ti-cpufreq

 arch/arm/boot/dts/am335x-boneblack.dts | 11 +++++
 arch/arm/boot/dts/am33xx.dtsi          | 87 +++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/am4372.dtsi          |  7 ++-
 arch/arm/boot/dts/dra7.dtsi            | 24 ++++++++--
 arch/arm/boot/dts/dra74x.dtsi          |  5 ++
 arch/arm/configs/omap2plus_defconfig   |  1 +
 6 files changed, 113 insertions(+), 22 deletions(-)

-- 
2.11.0
