From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/8] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
Date: Tue, 28 Mar 2017 20:57:53 -0500
Message-ID: <20170329015801.22240-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This series contains the remaining code to enable suspend to mem and standby on
am335x and am437x platforms. It depends on the ti-emif-sram series sent here [1].

This code also depends on firmware for the wkup_m3 that is available here [2]
that can either be placed in /lib/firmware or built in to the kernel.

Patch 1,2,3 are straightforward support changes to enable PM. Patches 4 and 5
add the required low-level PM suspend code that is relocated to SRAM for each
platform.  Patch 6 and patch 7 serve as the split between code that can live in
drivers and code that must remain under mach-omap2. The idea here was to
maintain the minimal amount of ARM and OMAP specific code inside mach-omap2
while providing ops that can be called into from a module that lives in drivers
and contains the bulk of the PM code. Patch 6 also contains additions to the
ARM asm-offsets file to allow us to automatically generate C struct member
offsets and sizes to be used by the assembly code introduced earlier, more info
can be seen in the changelog.  Patch 7 introduces the pm33xx driver which makes
use of the wkup_m3_ipc and ti-emif-sram drivers to enable PM on the system.
Because pm33xx depends on modules it must be able to defer probe so patch 8
creates a dummy pm33xx platform device to cause pm33xx to probe initially but
also defer if needed.

As with the ti-emif-sram driver, which also contains relocatable SRAM code, we
can only get read-only exectuable memory regions from the mmio-sram driver so
we also provide a second region to the driver that is read/write to be used for
data during execution. This is the reason two sram regions are mapped and so
many offsets must be provided to the code section.

For testing the drivers required are:

CONFIG_MAILBOX
CONFIG_OMAP2PLUS_MBOX
CONFIG_WKUP_M3_RPROC
CONFIG_SOC_TI
CONFIG_WKUP_M3_IPC
CONFIG_TI_EMIF_SRAM
CONFIG_AMX3_PM

There is still a device tree patch series to follow that will completely enable
PM but I will wait to send that until this series and the emif series have been
reviewed, until then all patches have been pushed here for use [3].

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg136345.html
[2] https://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware/blobs/7eb9c0856a9e8b3b42bf64f761da135852b8eea7/bin/am335x-pm-firmware.elf
[3] https://github.com/dgerlach/linux-pm/tree/upstream/v4.11/amx3-suspend-dev

Dave Gerlach (8):
  ARM: OMAP: Wakeupgen: Add context save/restore for AM43XX
  ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
  ARM: OMAP2+: pm: Remove __init from omap_pm_clkdms_setup
  ARM: OMAP2+: Introduce low-level suspend code for AM33XX
  ARM: OMAP2+: Introduce low-level suspend code for AM43XX
  ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
  soc: ti: Add pm33xx driver for basic suspend support
  ARM: OMAP2+: Create dummy platform_device for pm33xx

 arch/arm/kernel/asm-offsets.c        |   2 +
 arch/arm/mach-omap2/Kconfig          |   1 +
 arch/arm/mach-omap2/Makefile         |   4 +
 arch/arm/mach-omap2/common.h         |   7 +
 arch/arm/mach-omap2/io.c             |   2 +
 arch/arm/mach-omap2/omap-wakeupgen.c |  68 +++++-
 arch/arm/mach-omap2/pm.c             |   2 +-
 arch/arm/mach-omap2/pm.h             |   5 +
 arch/arm/mach-omap2/pm33xx-core.c    | 193 +++++++++++++++++
 arch/arm/mach-omap2/sleep33xx.S      | 219 +++++++++++++++++++
 arch/arm/mach-omap2/sleep43xx.S      | 403 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/timer.c          |  28 +++
 drivers/soc/ti/Kconfig               |   9 +
 drivers/soc/ti/Makefile              |   1 +
 drivers/soc/ti/pm33xx.c              | 337 +++++++++++++++++++++++++++++
 include/linux/platform_data/pm33xx.h |  69 ++++++
 16 files changed, 1343 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep43xx.S
 create mode 100644 drivers/soc/ti/pm33xx.c
 create mode 100644 include/linux/platform_data/pm33xx.h

-- 
2.11.0
