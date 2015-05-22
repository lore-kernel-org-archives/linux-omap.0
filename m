From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 0/4] remoteproc: Introduce wkup_m3_rproc driver
Date: Fri, 22 May 2015 15:45:26 -0500
Message-ID: <1432327530-48032-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This patch series is v4 of the series to add a wkup_m3_rproc driver
for TI AM335xi and AM437x SoCs. This family of SoCs contains an ARM
Cortex M3 coprocessor that is responsible for low-level power tasks
that cannot be handled by the main ARM Cortex A8 so firmware running
from the CM3 can be used instead. This driver handles loading
of the firmware and reset of the CM3. Change info can be found
with each patch.

The previous version of this series can be found here [1].
I have pushed a branch based on v4.1-rc4 containing the entire
am335x suspend series along with WIP am437x suspend patches for
a higher level view of the entire series of patch sets here [2].

The driver expects to load firmware am335x-pm-firmware.elf from
/lib/firmware which is found here [3].

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg117611.html
[2] https://github.com/dgerlach/linux-pm/tree/pm-v4.1-rc4-amx3-suspend
[3] https://git.ti.com/ti-cm3-pm-firmware/amx3-cm3/commits/next-upstream


Dave Gerlach (3):
  remoteproc: introduce rproc_get_by_phandle API
  Documentation: dt: add bindings for TI Wakeup M3 processor
  remoteproc/wkup_m3: add a remoteproc driver for TI Wakeup M3

Suman Anna (1):
  remoteproc: add a rproc ops for performing address translation

 .../bindings/remoteproc/wkup_m3_rproc.txt          |  52 +++++
 Documentation/remoteproc.txt                       |   6 +
 drivers/remoteproc/Kconfig                         |  13 ++
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/remoteproc_core.c               |  81 ++++++-
 drivers/remoteproc/wkup_m3_rproc.c                 | 257 +++++++++++++++++++++
 include/linux/platform_data/wkup_m3.h              |  30 +++
 include/linux/remoteproc.h                         |   9 +-
 8 files changed, 440 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
 create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
 create mode 100644 include/linux/platform_data/wkup_m3.h

-- 
2.4.1
