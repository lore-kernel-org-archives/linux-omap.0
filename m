From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 0/3] soc: ti: Introduce wkup_m3_ipc driver
Date: Fri, 17 Jul 2015 15:56:29 -0500
Message-ID: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series is version 2 of the code to introduce a wkup_m3_ipc driver
to handle communication between the MPU and Cortex M3 present on TI AM335x
and AM437x SoCs. v1 of this series can be found at [1]. Changes include:

- Buildable as a module
- Added am437x support
- Various cleanups and fixes based on comments on v1
- Ability to use mailbox in noirq mode for cpuidle on am335x

v2 contains an additional patch for the omap mailbox driver now to allow
us to set ti,mbox-send-noirq for the wkup_m3 mailbox to allow us to
support cpuidle on am335x. Although we can rely on interrupts during
the suspend path, we must send a message during the cpuidle path from
noirq context so we must have the ability to do this without using
an interrupt, so we introduce the flag to indicate this. The patch has
been included here with the wkup_m3_ipc patch so that the usage and
context is clear.

This series uses the wkup_m3_rproc driver which is merged as of v4.2-rc1,
but the required dt nodes are not yet merged and can be found here [2].
A full branch containing all necessary PM code for both am335x and am437x
has been pushed here [3] a big picture view of the plan for this series.

This driver relies on the firmware at [4] being present in /lib/firmware
in the rootfs or built in to the kernel.

Regards,
Dave

[1] http://www.spinics.net/lists/arm-kernel/msg387990.html
[2] http://www.spinics.net/lists/linux-omap/msg119973.html
[3] https://github.com/dgerlach/linux-pm/tree/pm-v4.2-rc2-amx3-suspend
[4] https://git.ti.com/ti-cm3-pm-firmware

Dave Gerlach (3):
  mailbox/omap: Add ti,mbox-send-noirq quirk to fix AM33xx CPU Idle
  Documentation: dt: add bindings for TI Wakeup M3 IPC device
  soc: ti: Add wkup_m3_ipc driver

 .../devicetree/bindings/mailbox/omap-mailbox.txt   |   8 +
 .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt     |  57 +++
 drivers/mailbox/omap-mailbox.c                     |  49 ++-
 drivers/soc/ti/Kconfig                             |  10 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/wkup_m3_ipc.c                       | 486 +++++++++++++++++++++
 include/linux/wkup_m3_ipc.h                        |  30 ++
 7 files changed, 637 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
 create mode 100644 drivers/soc/ti/wkup_m3_ipc.c
 create mode 100644 include/linux/wkup_m3_ipc.h

-- 
2.4.5
