From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 0/3] ocp2scp: add non-dt support
Date: Fri, 2 Nov 2012 13:44:45 +0530
Message-ID: <1351844088-27059-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, kishon@ti.com, arnd@arndb.de, olof@lixom.net, rdunlap@xenotime.net, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch series allows ocp2scp driver to create its child devices
from the platform data.

In omap platforms, usb phy is connected to ocp2scp and usb phy is needed
for MUSB to be functional. When ocp2scp driver was added, it had only dt
support which means it wont create usb phy devices for non-dt boot.

This patch series adds non-dt support to ocp2scp and this series is needed
for getting MUSB functional in non-dt boot.

Changes from v3:
used PLATFORM_DEVID_AUTO while creating a device using platform_device_alloc

Changes from v2:
*if cpu is not 44xx, dont create ocp2scp device in mach-omap2/devices.c

Changes from v1:
* Fixed Sergei's comments on memory leaks

Kishon Vijay Abraham I (3):
  drivers: bus: ocp2scp: add pdata support
  ARM: OMAP4: add _dev_attr_ to ocp2scp for representing usb_phy
  ARM: OMAP: ocp2scp: create omap device for ocp2scp

 arch/arm/mach-omap2/devices.c              |   79 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++
 drivers/bus/omap-ocp2scp.c                 |   68 ++++++++++++++++++++++--
 include/linux/platform_data/omap_ocp2scp.h |   31 +++++++++++
 4 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/platform_data/omap_ocp2scp.h

-- 
1.7.9.5
