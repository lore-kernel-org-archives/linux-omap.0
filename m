From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 0/4] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
Date: Tue, 25 Jul 2017 09:44:10 -0500
Message-ID: <20170725144414.7129-1-d-gerlach@ti.com>
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
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,
This series contains the remaining code to enable suspend to mem and standby on
am335x and am437x platforms. It depends on the ti-emif-sram series sent here
[1]. Changes are based on comments given for V2 of this series which can
be found here [2].

This code also depends on firmware for the wkup_m3 that is available here [3]
that can either be placed in /lib/firmware or built in to the kernel.

Changes from v2 are described in the patches but summary is:
* Squash patch 5 into patch 3 since they touch the same platform
  code and don't need to be two patches.
* Fix small ASM bug to program EMIF for self refresh then save context
  so that we save the exact state of the emif before suspending.
* Add missing of_node_put in patch 4
* Avoid extern definition for asm-offsets definition and use a stub instead
  of defining out in asm-offsets.
* Use dev_err and friends in pm33xx driver for PM messages.
* General code cleanups.

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

[1] https://www.spinics.net/lists/linux-omap/msg138314.html
[2] https://www.spinics.net/lists/arm-kernel/msg582309.html
[3] https://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware/blobs/7eb9c0856a9e8b3b42bf64f761da135852b8eea7/bin/am335x-pm-firmware.elf
[4] https://github.com/dgerlach/linux-pm/tree/upstream/v4.13/amx3-suspend-v3

Dave Gerlach (4):
  ARM: OMAP2+: Introduce low-level suspend code for AM33XX
  ARM: OMAP2+: Introduce low-level suspend code for AM43XX
  ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
  soc: ti: Add pm33xx driver for basic suspend support

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  16 +
 arch/arm/kernel/asm-offsets.c                      |   2 +
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |   4 +
 arch/arm/mach-omap2/common.h                       |   7 +
 arch/arm/mach-omap2/io.c                           |   2 +
 arch/arm/mach-omap2/pm.h                           |   3 +
 arch/arm/mach-omap2/pm33xx-core.c                  | 197 +++++++++++
 arch/arm/mach-omap2/sleep33xx.S                    | 221 ++++++++++++
 arch/arm/mach-omap2/sleep43xx.S                    | 394 +++++++++++++++++++++
 drivers/soc/ti/Kconfig                             |   9 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/pm33xx.c                            | 357 +++++++++++++++++++
 include/linux/platform_data/pm33xx.h               |  74 ++++
 14 files changed, 1288 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep43xx.S
 create mode 100644 drivers/soc/ti/pm33xx.c
 create mode 100644 include/linux/platform_data/pm33xx.h

-- 
2.13.0
