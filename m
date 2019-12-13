From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/5] ARM: OMAP2+: Introduce cpuidle for am335x/am437x
Date: Thu, 12 Dec 2019 21:07:50 -0600
Message-ID: <20191213030755.16096-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This series adds support for cpuidle on am335x and am437x using the
cpuidle_arm driver. When testing on am335x-evm and am437x-gp-evm the
follow power consumption reductions are seen on v5.5-rc1 baseline:


Idling at command line, CPUFreq userspace governor to 300MHz:
  am335x-evm:
    VDD_MPU: 48 mW -> 5 mW

  am437x-gp-evm:
    VDD_MPU: 32 mW -> 3 mW


Idling at command line, CPUFreq userspace governor to 1GHz:
  am335x-evm:
    VDD_MPU: 313 mW -> 18 mW

  am437x-gp-evm:
    VDD_MPU: 208 mW -> 10 mW

A forthcoming series will add idle states to the device tree for each
am335x and am437x to add C1 state for MPU Gate which gates the clock to
the main CPU.  am335x makes use of the wkup_m3_ipc driver for this to
use the same wkup_m3 to gate the cpu clock that is used for suspend, so
the same firmware found here is required [1] to be placed in
/lib/firmware.

First patch adds dt-binding for enable-method for each SoC which is needed
for cpuidle-arm driver to probe, second patch adds platform code for cpuidle,
third patch modifies both platform code and pm33xx soc driver to add needed
flags and callback for idling, fourth patch actually enables cpuidle in the
soc pm33xx driver, and then that last patch enables the needed CONFIG options
in omap2plus_defconfig.

Regards,
Dave

[1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/tree/bin/am335x-pm-firmware.elf?h=ti-v4.1.y

Dave Gerlach (5):
  dt-bindings: arm: cpu: Add TI AM335x and AM437x enable method
  ARM: OMAP2+: pm33xx-core: Add cpuidle_ops for am335x/am437x
  ARM: OMAP2+: pm33xx-core: Extend platform_data ops for cpuidle
  soc: ti: pm33xx: Add base cpuidle support
  ARM: omap2plus_defconfig: Add CONFIG_ARM_CPUIDLE

 .../devicetree/bindings/arm/cpus.yaml         |   2 +
 arch/arm/configs/omap2plus_defconfig          |   2 +
 arch/arm/mach-omap2/pm33xx-core.c             | 137 +++++++++++++++++-
 drivers/soc/ti/pm33xx.c                       |  21 ++-
 include/linux/platform_data/pm33xx.h          |   6 +-
 5 files changed, 160 insertions(+), 8 deletions(-)

-- 
2.20.1
