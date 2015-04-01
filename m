From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 0/4] remoteproc: Introduce wkup_m3_rproc driver
Date: Wed, 1 Apr 2015 14:37:15 -0500
Message-ID: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This patch series is version three of the series to add a
wkup_m3_rproc driver for TI AM335x SoCs. This family of SoCs
contains an ARM Cortex M3 coprocessor that is responsible for
low-level power tasks that cannot be handled by the main ARM
Cortex A8 so firmware running from the CM3 can be used instead.
This driver handles loading of the firmware and reset of the CM3
once it is booted.

The previous version of this series can be found here [1].
I have pushed a branch based on v4.0-rc5 containing the entire
am335x suspend series here for a higher level view of the entire
series of patch sets here [2]. This series depends on "remoteproc:
add IOMMU hardware capability flag" which is currently queued
here [3].

Based on comments on the DT node included in the "ARM: OMAP2+:
wkup_m3_rproc support patches" series (v3 of that will immediately
follow this series) the DT node moved under a different parent
node so some changes to the driver were necessary to calculate proper
device addresses for firmware loading.

This series also now includes a patch to introduce an
rproc_get_by_phandle API to the remoteproc core so that users of
this wkup_m3_rproc driver are able to get a handle to the rproc
and boot it as the rproc must be booted directly by the user.
An example user, wkup_m3_ipc, can be seen in previously mentioned
branch at [2].

v2 -> v3:
-Modify wkup_m3_rproc driver to properly handle device address
 based on new DT location in l4_wkup node.
-In binding doc, change ti,am3352-wkup-m3 from am3353-wkup_m3 to match
 other am3352 compats
-General cleanup of address representation in wkup_m3_rproc driver
-Includes rproc_get_by_phandle patch now

The driver expects to load firmware am335x-pm-firmware.elf from
/lib/firmware which is found here [4].

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg116364.html
[2] https://github.com/dgerlach/linux-pm/tree/pm-v4.0-rc5-am335x-suspend
[3] https://git.kernel.org/cgit/linux/kernel/git/ohad/remoteproc.git/commit/?h=for-next&id=315491e5d6ee66838a18a8ca0c14e6ffb376e48c
[4] https://git.ti.com/ti-cm3-pm-firmware/amx3-cm3/commits/next-upstream

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
 drivers/remoteproc/remoteproc_core.c               | 114 +++++++++-
 drivers/remoteproc/wkup_m3_rproc.c                 | 249 +++++++++++++++++++++
 include/linux/platform_data/wkup_m3.h              |  30 +++
 include/linux/remoteproc.h                         |   4 +
 8 files changed, 463 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
 create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
 create mode 100644 include/linux/platform_data/wkup_m3.h

-- 
2.3.0
