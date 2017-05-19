From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 0/5] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
Date: Fri, 19 May 2017 15:04:33 -0500
Message-ID: <20170519200438.9502-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This series contains the remaining code to enable suspend to mem and standby on
am335x and am437x platforms. It depends on the ti-emif-sram series sent here
[1], and the first 3 patches in v1 found here [2] which have been queued for
merge already and dropped from this series. Apart from dropping the first three
patches, changes from v1 are to update the sram_exec_copy usage to treat the
return address as the proper callable pointer when copying functions and some
small cleanups to the assembly code in the first two patches. However, as no
review was done on v1 due to sram_exec_copy discussion I am including the
original cover letter below.

This code also depends on firmware for the wkup_m3 that is available here [3]
that can either be placed in /lib/firmware or built in to the kernel.

Patches 1 and 2 add the required low-level PM suspend code that is relocated to
SRAM for each platform.  Patch 3 and patch 4 serve as the split between code
that can live in drivers and code that must remain under mach-omap2. The idea
here was to maintain the minimal amount of ARM and OMAP specific code inside
mach-omap2 while providing ops that can be called into from a module that lives
in drivers and contains the bulk of the PM code. Patch 3 also contains
additions to the ARM asm-offsets file to allow us to automatically generate C
struct member offsets and sizes to be used by the assembly code introduced
earlier, more info can be seen in the changelog.  Patch 4 introduces the pm33xx
driver which makes use of the wkup_m3_ipc and ti-emif-sram drivers to enable PM
on the system.  Because pm33xx depends on modules it must be able to defer
probe so patch 5 creates a dummy pm33xx platform device to cause pm33xx to
probe initially but also defer if needed.

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
reviewed, until then all patches have been pushed here for use [4].

Regards,
Dave

[1] https://www.spinics.net/lists/arm-kernel/msg582278.html
[2] https://www.spinics.net/lists/arm-kernel/msg572535.html
[3] https://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware/blobs/7eb9c0856a9e8b3b42bf64f761da135852b8eea7/bin/am335x-pm-firmware.elf
[4] https://github.com/dgerlach/linux-pm/tree/upstream/v4.12/amx3-suspend-dev

Dave Gerlach (5):
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
 arch/arm/mach-omap2/pm.h             |   5 +
 arch/arm/mach-omap2/pm33xx-core.c    | 193 +++++++++++++++++
 arch/arm/mach-omap2/sleep33xx.S      | 221 ++++++++++++++++++++
 arch/arm/mach-omap2/sleep43xx.S      | 394 +++++++++++++++++++++++++++++++++++
 drivers/soc/ti/Kconfig               |   9 +
 drivers/soc/ti/Makefile              |   1 +
 drivers/soc/ti/pm33xx.c              | 337 ++++++++++++++++++++++++++++++
 include/linux/platform_data/pm33xx.h |  69 ++++++
 13 files changed, 1245 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep43xx.S
 create mode 100644 drivers/soc/ti/pm33xx.c
 create mode 100644 include/linux/platform_data/pm33xx.h

-- 
2.13.0
