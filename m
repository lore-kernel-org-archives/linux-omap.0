From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 00/11] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Thu, 10 Jul 2014 21:55:38 -0500
Message-ID: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60053 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaGKC4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jul 2014 22:56:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>

Hello,

This series adds suspend/resume support for am335x. Version 3 of this
series can be found at [1]. I apologize for the large delay between this
and the previous revision. This code has been heavily refined
since the last version based on the various comments received for v3. The
major change from previous version is moving all wkup_m3 code into a
remoteproc based driver. The new driver handles all IPC and fw loading
and exposes a small API to be used by PM code to achieve low power states.

Firmware that can be used for testing this can be found at [2] on branch
pm-remote-proc-v3, using am335x-pm-firmware.elf found in bin directory.
Please note this has changed from all previous versions and is no longer
the .bin file. Firmware can be built into kernel or placed in /lib/firmware
in rootfs for automatic loading during boot.

This series has several dependencies. The wkup_m3_rproc utilizes a mailbox
to communicate with the cm3 and depends on Suman's series for omap mbox
support [3], which has several dependencies of it's own, listed in the
cover letter. Also, a few changes to remoteproc itself were needed and
have been provided by Suman here [4]. The edma patch included in this
series was previously submitted by Daniel Mack and after discussion with
him we agreed to include an updated version with this series as resume
has a direct dependency on it due to hangs in mmc without it.

Because of the high number of dependencies I have pushed a branch for
testing here [6] if anyone desires to try it out on branch pm-ds0-v3.16.

As is this series will only suspend and resume one time and then
fail to resume afterwards due to the removal of direct PM code control
of hwmods that do not properly assert their MSTANDBY signal after a context
loss, discussed here [7]. In particular it is due to the usb_otg_hs hwmod
that currently has no driver controlling it in the kernel. The main
cause of the issue is that the SYSCONFIG register present within
the IP must be reprogrammed after every suspend cycle and this
only happens at boot if no driver is present. Work is in progress to
allow suspend to function with or without drivers for the troublesome
hwmods (cpgmac, usb_otg_hs, and tptc1-3) and will be provided in a separate
future patch. The previous suggestion of allowing omap_device to handle
it proved to be too invasive into both omap_device and omap_hwmod and
the approach of allowing the firmware to handle it is not possible due
to the inability of the CM3 to access the IPs causing the issue. I'd
be happy to discuss this at length if anybody is interested.

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg95305.html
[2] https://github.com/dgerlach/am33x-cm3
[3] http://www.spinics.net/lists/linux-omap/msg108595.html
[4] http://www.spinics.net/lists/linux-omap/msg109173.html
[5] http://www.spinics.net/lists/linux-omap/msg100606.html
[6] https://github.com/dgerlach/linux-pm
[7] http://www.spinics.net/lists/linux-omap/msg95353.html

Daniel Mack (1):
  ARM: omap: edma: add suspend suspend/resume hooks

Dave Gerlach (8):
  memory: emif: Move EMIF register defines to include/linux/
  ARM: OMAP2+: Use pdata-quirks for wkup_m3 deassert_hardreset
  Documentation: dt: add ti,am3353_wkup_m3 bindings
  remoteproc: wkup_m3: Add wkup_m3 remote proc driver
  ARM: dts: am33xx: Update wkup_m3 node
  ARM: OMAP2+: AM33XX: Add assembly code for PM operations
  ARM: OMAP2+: AM33XX: Basic suspend resume support
  ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into OMAP builds

Vaibhav Bedia (2):
  ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
  ARM: OMAP2+: AM33XX: Reserve memory to comply with EMIF spec

 .../bindings/remoteproc/wkup_m3_rproc.txt          |  46 ++
 arch/arm/boot/dts/am33xx.dtsi                      |   9 +-
 arch/arm/common/edma.c                             |  86 +++-
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |   2 +
 arch/arm/mach-omap2/board-generic.c                |   2 +-
 arch/arm/mach-omap2/common.c                       |  32 ++
 arch/arm/mach-omap2/common.h                       |  13 +
 arch/arm/mach-omap2/io.c                           |   2 +
 arch/arm/mach-omap2/pdata-quirks.c                 |  12 +
 arch/arm/mach-omap2/pm.h                           |   5 +
 arch/arm/mach-omap2/pm33xx.c                       | 346 +++++++++++++
 arch/arm/mach-omap2/pm33xx.h                       |  64 +++
 arch/arm/mach-omap2/sleep33xx.S                    | 380 ++++++++++++++
 arch/arm/mach-omap2/sram.c                         |  10 +-
 arch/arm/mach-omap2/sram.h                         |   2 +
 arch/arm/mach-omap2/timer.c                        |  28 ++
 drivers/memory/emif.h                              | 543 +-------------------
 drivers/remoteproc/Kconfig                         |  15 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/wkup_m3_rproc.c                 | 512 +++++++++++++++++++
 include/linux/platform_data/wkup_m3.h              |  17 +
 include/linux/ti_emif.h                            | 558 +++++++++++++++++++++
 include/linux/wkup_m3.h                            |  71 +++
 24 files changed, 2209 insertions(+), 548 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
 create mode 100644 arch/arm/mach-omap2/pm33xx.c
 create mode 100644 arch/arm/mach-omap2/pm33xx.h
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
 create mode 100644 include/linux/platform_data/wkup_m3.h
 create mode 100644 include/linux/ti_emif.h
 create mode 100644 include/linux/wkup_m3.h

-- 
1.9.0

